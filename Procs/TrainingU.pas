unit TrainingU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, inifiles, ExtCtrls, Spin, ComCtrls, ShellCtrls, StrUtils,
  PCAmathU, Math, PlotU, BMDSpinEdit;

type
  TTraining = class(TMemIniFile)
  private
    { Private declarations }
  public
    { Public declarations }
    Locked, Calculated: boolean;
    Normalize: boolean;
    DefaultTml, Compound: string;
    IncSens, PPID, PNID: real;
    LoadedSpec: TStrings;
    NLoadings, PrecPower, LowBound, HighBound: integer;

    Xvals: adouble;
    Loadings, MahalMat: aadouble;
    RcM, RMSG: double;

    procedure Open;
    procedure Save(Update: boolean);
    function DirName: string;
    function Preproc(pl0, plX: TfrmPlot): adouble;
  end;

  TfrmOpts = class(TForm)
    Panel1: TPanel;
    reOptions: TRichEdit;
    Panel2: TPanel;
    bbOK: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    eComp: TEdit;
    neNLoadings: TSpinEdit;
    nePNID: TBMDSpinEdit;
    nePPID: TBMDSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure bbOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Training: TTraining;
  end;

var
  frmOpts: TfrmOpts;

implementation

{$R *.DFM}

uses SpecU, SpMathU, AboutU;

procedure TTraining.Open;
var
  ss: string;
  i, j, k, np, nl: integer;
  arr: adouble;

  function Str2Arr(InStr: string): adouble;
  var
    i, j, k, m: integer;
    ss: string;
    a: double;
  begin
    ss := InStr;
    if length(ss) = 0 then
      exit;
    SetLength(Result, np);
    m := 0;
    for i := 0 to np - 1 do
    begin
      j := pos(#9, ss);
      val(LeftStr(ss, j - 1), a, k);
      if k = 0 then
      begin
        Result[m] := a;
        inc(m);
      end;
      delete(ss, 1, j);
    end;
  end;

begin
  Locked := false;
  if Assigned(LoadedSpec) then
    LoadedSpec.Free;
  LoadedSpec := TStringList.Create;
  DefaultTml := ReadString('General', 'DefaultTml', '');
  Compound := ReadString('General', 'Compound', '');
  NLoadings := ReadInteger('General', 'NLoadings', 0);
  Calculated := ReadBool('General', 'Calculated', false);
  PPID := ReadFloat('General', 'PositID', 1);
  PNID := ReadFloat('General', 'PossibID', 3);
  PrecPower := ReadInteger('General', 'PrecPower', 0);
  LowBound := ReadInteger('Preprocess', 'LowBound', 0);
  HighBound := ReadInteger('Preprocess', 'HighBound', 0);
  Normalize := ReadBool('Preprocess', 'Normalize', Normalize);
  IncSens := ReadFloat('Preprocess', 'IncSens', IncSens);
  for i := 0 to 35 do
  begin
    ss := ReadString('LoadedSpec', IntToStr(i + 1), '');
    if ss <> '' then
      LoadedSpec.Add(ss);
  end;
  if Calculated then
  begin
    np := ReadInteger('PCA', 'NPoints', 0);
    if np = 0 then
      exit;
    RMSG := ReadFloat('PCA', 'RMSG', 1);
    RcM := ReadFloat('PCA', 'RcM', 0);
    Xvals := Str2Arr(ReadString('PCA', 'Xvals', ''));
    Calculated:= NLoadings>0;
    if not Calculated then exit;
    SetLength(Loadings, NLoadings);
    for i := 0 to NLoadings - 1 do
    begin
      Loadings[i] := Str2Arr(ReadString('PCA', 'Loading[' + IntToStr(i + 1) +']', ''));
      Calculated := length(Loadings[i])>0;
      if not Calculated then exit;
    end;
    k := 0;
    SetLength(MahalMat, NLoadings + 1);
    arr := Str2Arr(ReadString('PCA', 'MahalMat', ''));
    Calculated:= length(arr)>0;
    if not Calculated then exit;
    for i := 0 to length(MahalMat) - 1 do
    begin
      SetLength(MahalMat[i], NLoadings + 1);
      for j := 0 to length(MahalMat[i]) - 1 do
      begin
        MahalMat[i, j] := arr[k];
        inc(k);
      end;
    end;
  end;
end; { TfrmMOpts.Open }

procedure TTraining.Save(Update: boolean);
var
  ss: string;
  i, j, k: integer;
  arr: adouble;

  function Arr2Str(arr: adouble): string;
  var
    i, j: integer;
    ss: string;
  begin
    ss := '';
    for i := 0 to length(arr) - 1 do
      ss := ss + FloatToStrF(arr[i], ffGeneral, 12, 4) + #9;
    delete(ss, length(ss), 1);
    Result := ss;
  end;

begin
  Clear;
  WriteString('General', 'DefaultTml', DefaultTml);
  WriteString('General', 'Compound', Compound);
  if length(Loadings) < NLoadings then
    NLoadings := length(Loadings);
  WriteInteger('General', 'NLoadings', NLoadings);
  Calculated := Calculated and (NLoadings>0) and (length(MahalMat)>0);
  WriteBool('General', 'Calculated', Calculated);
  WriteFloat('General', 'PositID', PPID);
  WriteFloat('General', 'PossibID', PNID);
  WriteInteger('General', 'PrecPower', PrecPower);
  WriteInteger('Preprocess', 'LowBound', LowBound);
  WriteInteger('Preprocess', 'HighBound', HighBound);
  WriteBool('Preprocess', 'Normalize', Normalize);
  WriteFloat('Preprocess', 'IncSens', round((IncSens * 10)) / 10);
  for i := 0 to LoadedSpec.Count - 1 do
    WriteString('LoadedSpec', IntToStr(i + 1), LoadedSpec[i]);
  if Calculated then
  begin
    WriteInteger('PCA', 'NPoints', length(Xvals));
    WriteFloat('PCA', 'RMSG', RMSG);
    WriteFloat('PCA', 'RcM', RcM);
    WriteString('PCA', 'Xvals', Arr2Str(Xvals));
    for i := 0 to NLoadings - 1 do
      WriteString('PCA', 'Loading[' + IntToStr(i + 1) + ']',
        Arr2Str(Loadings[i]));
    k := 0;
    for i := 0 to length(MahalMat) - 1 do
      for j := 0 to length(MahalMat[i]) - 1 do
      begin
        SetLength(arr, k + 1);
        arr[k] := MahalMat[i, j];
        inc(k);
      end;
    WriteString('PCA', 'MahalMat', Arr2Str(arr));
    Finalize(arr);
  end;
  if Update then UpdateFile;
end; { TfrmMOpts.Save }

function TTraining.DirName: string;
begin
  Result := IncludeTrailingBackslash(ExtractFileDir(Filename));
end;

function TTraining.Preproc(pl0, plX: TfrmPlot): adouble;
var
  i, j, sz: integer;
  arr01, arr02, arr1, arr2: tXYarray;
  t0, t, a: double;
begin
  if pl0.IsEmpty or plX.IsEmpty then
    exit;
  plX.SpOpt := pl0.SpOpt;
  IntEquidistant(plX.Spec.CMass, arr1);
  zap(arr1, LowBound, HighBound, arr2);
  sz := length(arr2);
  SetLength(Result, sz);
  SetLength(Xvals, sz);
  for i := 0 to sz - 1 do
    Xvals[i] := arr2[i, X];
  if Normalize then
  begin
    IntEquidistant(pl0.Spec.CMass, arr01);
    zap(arr01, LowBound, HighBound, arr02);
    t0 := 0;
    for i := 0 to length(arr02) - 1 do
      t0 := t0 + arr02[i, Y];
    t := 0;
    for i := 0 to length(arr2) - 1 do
      t := t + arr2[i, Y];
    a := t0 / t;
  end
  else
    a := 1;
  for i := 0 to length(arr2) - 1 do
    if IncSens = 0 then
      Result[i] := a * arr2[i, Y]
    else
      Result[i] := a * arr2[i, Y] * Power(abs(Xvals[i]), IncSens);
  Finalize(arr01);
  Finalize(arr02);
  Finalize(arr1);
  Finalize(arr1);
end; { TfrmPCAprep.Preproc }

/// //////////////////////////////////////////////////////////////
procedure TfrmOpts.FormShow(Sender: TObject);
begin
  Caption := 'PCA Options ' + Training.Filename;
  if not Training.Calculated then
  begin
    ErrorMsg('PC''s are not calculated yet.');
    exit;
  end;
  with reOptions, Training do
  begin
    Lines.Clear;
    if Compound <> '' then
      eComp.Text := Compound
    else
      eComp.Text := ChangeFileExt(ExtractFilename(Filename), '');
    if PPID > 0 then
      nePPID.Value := PPID;
    if PNID > 0 then
      nePNID.Value := PNID;
    if Normalize then
      Lines.Add('Normalized = YES')
    else
      Lines.Add('Normalized = NO');
    if IncSens > 0 then
      Lines.Add('Increased Sensitivity = ' + FloatToStr(IncSens))
    else
      Lines.Add('Increased Sensitivity = NO');
    Lines.Add('Calculation Precision = 1E-' + IntToStr(PrecPower));
    Lines.Add('Low Mass Boundary = ' + FloatToStr(LowBound));
    Lines.Add('High Mass Boundary = ' + FloatToStr(HighBound));
    neNLoadings.Value := NLoadings;
    Lines.Add('');
    Lines.Add('Proceeded spectra:');
    Lines.AddStrings(LoadedSpec);
  end;
end; { TfrmOpts.FormShow }

procedure TfrmOpts.bbOKClick(Sender: TObject);
begin
  with Training do
  begin
    PPID := nePPID.Value;
    PNID := nePNID.Value;
    NLoadings := neNLoadings.Value;
    Compound := eComp.Text;
    if Compound = '' then
    begin
      ErrorMsg('The field compound must be filled in.');
      ModalResult := mrCancel;
    end;
  end;
end;

end.
