unit AutoTuneU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProcU, Buttons, StdCtrls, Spin, ExtCtrls, ComCtrls,
  FileCtrl, IniFiles, Series, SpecU, FitEngU, Math, Vcl.Mask,
  BMDSpinEdit;

type
  TfmAutoTune = class(TfmProc)
    PageControl1: TPageControl;
    tsOptim: TTabSheet;
    rgMethod: TRadioGroup;
    PageControl2: TPageControl;
    tsCD1: TTabSheet;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lbStep1: TLabel;
    cbCD1name: TComboBox;
    seCD1chn: TSpinEdit;
    tsCD2: TTabSheet;
    Label2: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbStep2: TLabel;
    cbCD2name: TComboBox;
    seCD2chn: TSpinEdit;
    tsCD3: TTabSheet;
    Label3: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    lbStep3: TLabel;
    cbCD3name: TComboBox;
    seCD3chn: TSpinEdit;
    rgNumbCD: TRadioGroup;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    gbTotal: TRadioButton;
    rbPeak: TRadioButton;
    GroupBox1: TGroupBox;
    lbIntensWeight: TLabel;
    Label15: TLabel;
    tsVerif: TTabSheet;
    GroupBox3: TGroupBox;
    sbSave: TSpeedButton;
    sbOpen: TSpeedButton;
    cbTuneFiles: TComboBox;
    sbRefFile: TSpeedButton;
    lbRefFile: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    lbMsrDiff: TLabel;
    FileListBox1: TFileListBox;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    GroupBox5: TGroupBox;
    cbMDname: TComboBox;
    Label4: TLabel;
    seMDchn: TSpinEdit;
    Label13: TLabel;
    tsCalibr: TTabSheet;
    nsCD1From: TBMDSpinEdit;
    nsCD1To: TBMDSpinEdit;
    nsCD1Step: TBMDSpinEdit;
    nsCD2From: TBMDSpinEdit;
    nsCD2To: TBMDSpinEdit;
    nsCD2Step: TBMDSpinEdit;
    nsCD3From: TBMDSpinEdit;
    nsCD3To: TBMDSpinEdit;
    nsCD3Step: TBMDSpinEdit;
    nsPeakFrom: TBMDSpinEdit;
    nsPeakTo: TBMDSpinEdit;
    seResWeight: TSpinEdit;
    procedure rgNumbCDClick(Sender: TObject);
    procedure seResWeightChange(Sender: TObject);
    procedure bbRunClick(Sender: TObject);
    procedure rgMethodClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure sbOpenClick(Sender: TObject);
    procedure cbTuneFilesChange(Sender: TObject);
    procedure sbRefFileClick(Sender: TObject);
  private
    { Private declarations }
    XYrefFile: tXYarray; // norm.mass
    function OpenParam(Filename: string): boolean;
    function SaveParam(Filename: string): boolean;

    function TakeAShot(ret: double; init: boolean): double; // optimized value
    function SetControl(CDidx: integer; value: double): boolean;

  public
    { Public declarations }
    function Verification: double;
    function AutoCalibration: boolean;
    procedure RealNextInOut(var xa: glmma; nx: integer; var Msr: double;
      var StopFlag: boolean);

    procedure Execute(AutoRun, ShowUp: boolean; var TuneFile: string); override;
  end;

var
  SIE, SIER: double;
  TheLastRefFile: string;

implementation

{$R *.dfm}

uses CmdCentreU, DvcRackU, SynchroU, PlotCollectU, AboutU, SpMathU, TeEngine,
  OptionsU, DeviceU;

var
  CDs: array of tCDScan;
  srsFit, srsResol: TFastLineSeries;
  xbuff: array [0 .. 9] of glmma;
  lastplot, genI, NumCD: integer;
  AmplInit, ResolInit, NdS: double;
  LastVerification: double;
  LastCalibration: boolean;
  // RealNextInOut: tNextInOut;

procedure TfmAutoTune.Execute(AutoRun, ShowUp: boolean; var TuneFile: string);
var
  i, j: integer;
begin // rgNumbCDClick(nil);
  seResWeightChange(nil);
  LastVerification := 0;
  LastCalibration := false;
  if FileExists(TheLastRefFile) then
    sbRefFileClick(nil);
  DvcList(cbCD1name.Items, dkCtrl);
  cbCD2name.Items.Assign(cbCD1name.Items);
  cbCD3name.Items.Assign(cbCD1name.Items);
  cbCD1name.ItemIndex := 0;
  cbCD2name.ItemIndex := 1;

  DvcList(cbMDname.Items, dkMsr);
  cbMDname.ItemIndex := 0;
  FileListBox1.Directory := RootPath + ScanPath;
  FileListBox1.Update;
  cbTuneFiles.Items.Assign(FileListBox1.Items);
  if TuneFile = '' then
    exit;
  for i := 0 to cbTuneFiles.Items.Count - 1 do
    if UpperCase(TuneFile) = UpperCase(RootPath + ScanPath +
      cbTuneFiles.Items[i]) then
    begin
      OpenParam(TuneFile);
      PageControl1.ActivePage := tsOptim;
    end;
  if SameText('MODE=', copy(TuneFile, 1, 5)) then
  begin
    if SameText('VERIFICATION', copy(TuneFile, 6, 12)) then
      PageControl1.ActivePage := tsVerif;
    if SameText('CALIBRATION', copy(TuneFile, 6, 11)) then
      PageControl1.ActivePage := tsCalibr;
  end;
  if AutoRun then
  begin
    bbRunClick(nil);
    if PageControl1.ActivePage = tsOptim then
      Verification;
    case PageControl1.ActivePageIndex of
      0, 1:
        TuneFile := 'Check=' + FloatToStr(LastVerification);
      2:
        if LastCalibration then
          TuneFile := 'OK'
        else
          TuneFile := 'Error';
    end;
  end;
end; { TfmAutoTune.Execute }

procedure TfmAutoTune.rgNumbCDClick(Sender: TObject);
var
  i, j: integer;
begin
  j := rgNumbCD.ItemIndex;
  tsCD2.TabVisible := (j > 0);
  tsCD3.TabVisible := (j > 1);
end;

procedure TfmAutoTune.seResWeightChange(Sender: TObject);
begin
  lbIntensWeight.Caption := IntToStr(100 - seResWeight.value) + ' /';
end;

procedure TfmAutoTune.rgMethodClick(Sender: TObject);
var
  bb: boolean;
begin
  lbStep1.Enabled := (rgMethod.ItemIndex <> 2);
  nsCD1Step.Enabled := true;
  lbStep2.Enabled := lbStep1.Enabled;
  lbStep3.Enabled := lbStep1.Enabled;
  nsCD2Step.Enabled := lbStep1.Enabled;
  nsCD3Step.Enabled := lbStep1.Enabled;
  bb := (rgMethod.ItemIndex = 0);
  seResWeight.Enabled := not bb;
  if bb then
    gbTotal.Checked := true;
  rbPeak.Enabled := not bb;
  if lbStep1.Enabled then
    lbStep1.Caption := 'Step'
  else
    lbStep1.Caption := 'Y Toler.';
  lbStep1.Enabled := true;
end;

// =============== file oprations ====================
procedure TfmAutoTune.sbSaveClick(Sender: TObject);
var
  ss: string;
begin
  SaveDialog1.InitialDir := RootPath + ScanPath;
  if cbTuneFiles.Text = '' then
  begin
    if not SaveDialog1.Execute then
      exit;
  end
  else
    SaveDialog1.Filename := RootPath + ScanPath +
      ChangeFileExt(ExtractFileName(cbTuneFiles.Text), '.tun');
  SaveParam(SaveDialog1.Filename);
  FileListBox1.Update;
  cbTuneFiles.Items.Assign(FileListBox1.Items);
end;

procedure TfmAutoTune.sbOpenClick(Sender: TObject);
var
  ss: string;
begin
  ss := cbTuneFiles.Text;
  if OpenParam(RootPath + ScanPath + ChangeFileExt(ExtractFileName(ss), '.tun'))
  then
    sbOpen.Enabled := false;
end;

function TfmAutoTune.OpenParam(Filename: string): boolean;
var
  i, j: integer;
  ini: TIniFile;
  ss: string;
  bb: boolean;
begin
  Result := false;
  if not FileExists(Filename) then
  begin
    ErrorMsg('File ' + Filename + ' cannot be found.');
    exit;
  end;
  ini := TIniFile.Create(Filename);
  rgMethod.ItemIndex := ini.ReadInteger('General', 'Method', 0);
  rgNumbCD.ItemIndex := ini.ReadInteger('General', 'NumbCD', 1) - 1;
  // CD1
  ss := ini.ReadString('CD1', 'Name', '');
  bb := false;
  for i := 0 to cbCD1name.Items.Count - 1 do
    if cbCD1name.Items[i] = ss then
    begin
      bb := true;
      cbCD1name.ItemIndex := i;
    end;
  if not bb then
  begin
    ErrorMsg('No such control device ->' + ss);
    exit;
  end;
  seCD1chn.value := ini.ReadInteger('CD1', 'Channel', 0);
  nsCD1From.value := ini.ReadFloat('CD1', 'From', 1);
  nsCD1To.value := ini.ReadFloat('CD1', 'To', 100);
  nsCD1Step.value := ini.ReadFloat('CD1', 'Step', 1);
  // CD2
  ss := ini.ReadString('CD2', 'Name', '');
  bb := false;
  for i := 0 to cbCD2name.Items.Count - 1 do
    if cbCD2name.Items[i] = ss then
    begin
      bb := true;
      cbCD2name.ItemIndex := i;
    end;
  if not bb and (rgNumbCD.ItemIndex > 0) then
  begin
    ErrorMsg('No such control device ->' + ss);
    exit;
  end;
  seCD2chn.value := ini.ReadInteger('CD2', 'Channel', 0);
  nsCD2From.value := ini.ReadFloat('CD2', 'From', 1);
  nsCD2To.value := ini.ReadFloat('CD2', 'To', 100);
  nsCD2Step.value := ini.ReadFloat('CD2', 'Step', 1);
  // CD3
  ss := ini.ReadString('CD3', 'Name', '');
  bb := false;
  for i := 0 to cbCD3name.Items.Count - 1 do
    if cbCD3name.Items[i] = ss then
    begin
      bb := true;
      cbCD3name.ItemIndex := i;
    end;
  if not bb and (rgNumbCD.ItemIndex > 1) then
  begin
    ErrorMsg('No such control device ->' + ss);
    exit;
  end;
  seCD3chn.value := ini.ReadInteger('CD3', 'Channel', 0);
  nsCD3From.value := ini.ReadFloat('CD3', 'From', 1);
  nsCD3To.value := ini.ReadFloat('CD3', 'To', 100);
  nsCD3Step.value := ini.ReadFloat('CD3', 'Step', 1);
  // MD
  ss := ini.ReadString('MD', 'Name', '');
  bb := false;
  for i := 0 to cbMDname.Items.Count - 1 do
    if cbMDname.Items[i] = ss then
    begin
      bb := true;
      cbMDname.ItemIndex := i;
    end;
  if not bb then
  begin
    ErrorMsg('No such control device ->' + ss);
    exit;
  end;
  seMDchn.value := ini.ReadInteger('MD', 'Channel', 0);
  nsPeakFrom.value := ini.ReadFloat('MD', 'PeakFrom', 0);
  nsPeakTo.value := ini.ReadFloat('MD', 'PeakTo', 0);
  gbTotal.Checked := ini.ReadBool('MD', 'TotalIntens', true);

  seResWeight.value := ini.ReadInteger('General', 'ResolWeight', 50);

  if length(ss) > 23 then
    ss := copy(ss, length(ss) - 23, 255);
  ss := '...' + ss;
  lbRefFile.Caption := ss;

  ini.free;
  Result := true;
end; { TfmAutoTune.OpenParam }

function TfmAutoTune.SaveParam(Filename: string): boolean;
var
  i, j: integer;
  ini: TIniFile;
begin
  if not FileExists(Filename) then
  begin
    if not SaveDialog1.Execute then
      exit;
  end
  else
    SaveDialog1.Filename := Filename;
  ini := TIniFile.Create(SaveDialog1.Filename);
  ini.WriteInteger('General', 'Method', rgMethod.ItemIndex);
  ini.WriteInteger('General', 'NumbCD', rgNumbCD.ItemIndex + 1);

  ini.WriteString('CD1', 'Name', cbCD1name.Text);
  ini.WriteInteger('CD1', 'Channel', seCD1chn.value);
  ini.WriteFloat('CD1', 'From', nsCD1From.value);
  ini.WriteFloat('CD1', 'To', nsCD1To.value);
  ini.WriteFloat('CD1', 'Step', nsCD1Step.value);

  ini.WriteString('CD2', 'Name', cbCD2name.Text);
  ini.WriteInteger('CD2', 'Channel', seCD2chn.value);
  ini.WriteFloat('CD2', 'From', nsCD2From.value);
  ini.WriteFloat('CD2', 'To', nsCD2To.value);
  ini.WriteFloat('CD2', 'Step', nsCD2Step.value);

  ini.WriteString('CD3', 'Name', cbCD3name.Text);
  ini.WriteInteger('CD3', 'Channel', seCD3chn.value);
  ini.WriteFloat('CD3', 'From', nsCD3From.value);
  ini.WriteFloat('CD3', 'To', nsCD3To.value);
  ini.WriteFloat('CD3', 'Step', nsCD3Step.value);

  ini.WriteString('MD', 'Name', cbMDname.Text);
  ini.WriteInteger('MD', 'Channel', seMDchn.value);
  ini.WriteFloat('MD', 'PeakFrom', nsPeakFrom.value);
  ini.WriteFloat('MD', 'PeakTo', nsPeakTo.value);
  ini.WriteBool('MD', 'TotalIntens', gbTotal.Checked);

  ini.WriteInteger('General', 'ResolWeight', seResWeight.value);
  ini.free;
end; { TfmAutoTune.SaveParam }

PROCEDURE ExtFuncs1(x: real; a: glnparam; VAR y: real; VAR dyda: glnparam;
  na: integer);
var
  i: integer;
  function Func(x: real; a: glnparam): real;
  // a[1] abs. position, a[2] - sigma, a[3] - ampl.
  begin // exp(-(sqr(x-x0)/(2*sqr(sigma))))/(sqrt(2*pi)*sigma));
    Result := a[3] * exp(-(sqr(x - a[1]) / (2 * sqr(a[2]))));
    // /(sqrt(2*pi)*a[2]);
  end;

  function fDyDa(x: real; a: glnparam; ia: integer): real;
  const
    delta = 0.001;
  var
    a1, a2: glnparam;
  begin
    a1 := a;
    a2 := a;
    a1[ia] := a1[ia] - delta / 2;
    a2[ia] := a2[ia] + delta / 2;
    Result := (Func(x, a2) - Func(x, a1)) / delta
  end;

begin
  y := Func(x, a);
  for i := 1 to na do
    dyda[i] := fDyDa(x, a, i);
end; { ExtFuncs1 }

function FitGauss(x, y: glndata; npt: integer; var a: glmma): boolean;
const
  spread = 0.001;
  SideNpt = 3;
var
  glinext, glinextp: integer;
  gliset: integer;
  glgset: real;
  alamda, chisq, ochisq, tx, ty: real;
  glma: ARRAY [1 .. 55] OF real;
  lista: gllista;
  gues: glmma;
  covar, alpha: glcovar;
  i, j, jj, k, mfit, itst: integer;
  sig: glndata;
  tdyda: glnparam;
begin
  funcs := ExtFuncs1;
  mfit := 3;
  FOR i := 1 to mfit DO
    lista[i] := i;
  alamda := -1;
  for i := 1 to npt do
    sig[i] := 1;
  mrqmin(x, y, sig, npt, a, mma, lista, mfit, covar, alpha, mma, chisq, alamda);
  k := 1;
  itst := 0;
  repeat
    k := k + 1;
    ochisq := chisq;
    mrqmin(x, y, sig, npt, a, mma, lista, mfit, covar, alpha, mma,
      chisq, alamda);
    IF (chisq > ochisq) THEN
    BEGIN
      itst := 0
    END
    ELSE
    BEGIN
      IF (abs(ochisq - chisq) < 0.01) THEN
        itst := itst + 1
      else
        itst := 0
    END;
  until (itst >= 2);
  alamda := 0.0;
  mrqmin(x, y, sig, npt, a, mma, lista, mfit, covar, alpha, mma, chisq, alamda);
end; { FitGauss }

/// /////////////////////////////////////////////////////////////////

function TfmAutoTune.TakeAShot(ret: double; init: boolean): double;
// optimized value
// gen<0 initialization of AmplInit & ResolInit
var
  sum, mx,my, ax, ay: real;
  i, j, k: integer;
  a: glmma;
  xa, ya: glndata;
  npt: integer;
  dyda: glnparam;
  ss: string;
begin
  ss := cbMDname.Text + '.SpcGet(' + IntToStr(seMDchn.value) + ')';
  Interprt(ss);
  mx := 0;
  my := 0;
  npt := 0;
  sum := 0;
  for i := 0 to length(buffXY) - 1 do
  begin
    if gbTotal.Checked then
      sum := sum + buffXY[i, y];
    if (buffXY[i, x] < nsPeakFrom.value) or (buffXY[i, x] > nsPeakTo.value) then
      continue;
    inc(npt);
    if rbPeak.Checked then
      sum := sum + buffXY[i, y];
    xa[npt] := buffXY[i, x];
    ya[npt] := buffXY[i, y];
    if my < buffXY[i, y] then // max seek
    begin
      mx := buffXY[i, x]; //i;
      my := buffXY[i, y];
    end;
  end;
  if (rgMethod.ItemIndex > 0) and (seResWeight.value > 0) and rbPeak.Checked then
  begin
    a[1] := mx;
    a[2] := abs(nsPeakFrom.value - nsPeakTo.value) / 10;
    a[3] := my;
    FitGauss(xa, ya, npt, a);
    if ret >= 0 then
    begin
      srsFit.ParentChart := Plots[lastplot].chrMass.chrChart;
      srsFit.Clear;
      srsResol.ParentChart := Plots[lastplot].chrChrom.chrChart;
      srsResol.AddXY(ret, a[2]);
    end;
    for i := 1 to npt do
    begin
      ax := xa[i];
      ExtFuncs1(ax, a, ay, dyda, 3);
      if ret > 0 then
        srsFit.AddXY(ax, ay);
    end;
  end;
  if AmplInit = 0 then
    AmplInit := sum + 1;
  if ResolInit = 0 then
    ResolInit := a[2] + 1;
  if seResWeight.value = 0 then
    my := sum
  else
    my := (sum / AmplInit) * (100 - seResWeight.value) - (a[2] / ResolInit) *
      seResWeight.value;
  if not init then
  begin
    inc(genI);
    Plots[lastplot].Spec.AddSSpec(ret, my, buffXY);
    Plots[lastplot].RefreshPlot;
  end;
  Result := my;
end; { TakeAShot }

function TfmAutoTune.SetControl(CDidx: integer; value: double): boolean;
var
  ss: string;
begin // InterprtD(CDs[CDidx].DName+'.DftSet('+IntToStr(CDs[CdIdx].Channel)+')');
  InterprtD(CDs[CDidx].DName + '.RJpSet(' + FloatToStrF(value, ffGeneral, 4, 3)
    + ',' + IntToStr(CDs[CDidx].Channel) + ')');
  ss := 'Snh.SnhGet(0)';
  Result := Interprt(ss);
end;

procedure TfmAutoTune.RealNextInOut(var xa: glmma; nx: integer; var Msr: double;
  var StopFlag: boolean);
var
  i, j, k: integer;
  ss: string;
begin
  for i := 1 to nx do
  begin
    j := genI mod 10;
    ss := InterprtD(CDs[i].DName + '.RelGet(' + IntToStr(i) + ')');
    xbuff[j][i] := StrToFloat(ss);
  end;
  k := 0;
  for i := 1 to nx do
    for j := 1 to 9 do
      k := k + round(abs(xbuff[0][i] - xbuff[j][i]));
  if k = 0 then
    StopFlag := true;
  for i := 1 to nx do
  begin
    if xa[i] < CDs[i].Start then
      xa[i] := CDs[i].Start;
    if xa[i] > CDs[i].Finish then
      xa[i] := CDs[i].Finish;
    StopFlag := StopFlag or not SetControl(i, xa[i]);
  end;
  Msr := -TakeAShot(genI, false);
  if genI > 500 then
    StopFlag := true;
end; { RealNextInOut }

function TfmAutoTune.Verification: double;
var
  i, j: integer;
  ss: string;
  wXY, rXY: tXYarray;
  swXY, srXY: TChartSeries;
begin
  Result := -1;
  ss := cbMDname.Text + '.SpcGet(1)';
  if not Interprt(ss) then
    exit;
  // Plots.Add(''); ActivePlot.MassOnly:= true; ActivePlot.AddArrSpec(0,buffXY);
  // Plots.Add(''); ActivePlot.MassOnly:= true; ActivePlot.AddArrSpec(0,XYrefFile);
  IntEquidistant(buffXY, wXY);
  IntEquidistant(XYrefFile, rXY);
  swXY := TChartSeries.Create(self);
  AssignXY2srs(wXY, swXY);
  srXY := TChartSeries.Create(self);
  AssignXY2srs(rXY, srXY);
  Result := (1 - Euclidean(swXY, srXY, true)) * 100;
end; { TfmAutoTune.Verification }

function TfmAutoTune.AutoCalibration: boolean;
begin
  Result := (InterprtD('SMN.CmdExe("Calibration")') = 'OK');
end;

procedure TfmAutoTune.bbRunClick(Sender: TObject);

  function RunTheMachine: boolean;
  begin
    if not StrToBool(InterprtD('Itr.EnbGet')) then
      InterprtD('Itr.EnbSet(TRUE)');
    Result:= true;
  end;

  procedure StopTheMachine;
  begin
  end;

const
  IniEstimN = 50; // with Simul up to 2 differ.
var
  i, j, m, k, mmi: integer;
  a, mm: double;
  NewPos: glmma;
  b: double;
  wXY: tXYarray;
  StopFlag: boolean;
  ss: string;
  arr, mari: array [1 .. 3] of double;
  Data: array of double;

begin
  try
    if rbPeak.Checked and (abs(nsPeakFrom.Value)<0.001) and (abs(nsPeakTo.Value)<0.001) then
      raise Exception.Create('Error: wrong peak limits.');
    if not RunTheMachine then
    begin
      ErrorMsg('Cannot run machine');
      exit;
    end;
    case PageControl1.ActivePageIndex of
      1:
        begin
          lbMsrDiff.Caption := 'Difference = ' + FormatFloat('###0.00',
            Verification) + ' %';
          exit;
        end;
      2:
        begin
          LastCalibration := AutoCalibration;
          exit;
        end;
    end;
    StopFlag := false; // main   A U T O T U N E
    for i := 1 to NDataStm do // reset data streams
      if fmSynchro.DataStm[i].Enabled then
        fmSynchro.DataStm[i].Close;
    tsOptim.Enabled := false;
    NumCD := rgNumbCD.ItemIndex + 1;
    SetLength(CDs, 4);
    CDs[1].DName := cbCD1name.Text;
    CDs[2].DName := cbCD2name.Text;
    CDs[3].DName := cbCD3name.Text;
    CDs[1].Start := nsCD1From.value;
    CDs[2].Start := nsCD2From.value;
    CDs[3].Start := nsCD3From.value;
    CDs[1].Finish := nsCD1To.value;
    CDs[2].Finish := nsCD2To.value;
    CDs[3].Finish := nsCD3To.value;
    CDs[1].Step := nsCD1Step.value;
    CDs[2].Step := nsCD2Step.value;
    CDs[3].Step := nsCD3Step.value;
    CDs[1].Channel := seCD1chn.value;
    CDs[2].Channel := seCD2chn.value;
    CDs[3].Channel := seCD3chn.value;
    for i := 1 to NumCD do
      StopFlag := StopFlag or (CDs[i].Start >= CDs[i].Finish) or
        (CDs[i].Step <= 0);
    if StopFlag then
    begin
      ErrorMsg('Wrong Ctrl device parameter.');
      exit;
    end;
    InterprtD('Itr.LckSet(TRUE)');
    InterprtD('itr.busset(TRUE)');
    InterprtD('Sp#.ClrAll');
    AmplInit := 0;
    ResolInit := 0;
    genI := 0;
    if srsFit = nil then
      srsFit := TFastLineSeries.Create(self);
    if srsResol = nil then
      srsResol := TFastLineSeries.Create(self);
    case rgMethod.ItemIndex of
      0: // Initial seek (in blind)
        begin
          j := 1;
          mm := -9.9E99;
          for i := 1 to NumCD do
          begin
            mari[i] := mm;
            j := j * round((CDs[1].Finish - CDs[1].Start) / CDs[1].Step);
          end;
          if j > 1000 then
          begin
            ErrorMsg('Too many (' + IntToStr(j) + ') combinations to scan.');
            exit;
          end;
          ss := 'Sp#.NewSet("' + Options.Templates[3] + '")';
          Interprt(ss);
          lastplot := StrToInt(ss);
          Plots[lastplot].AcqMode := true;
          TakeAShot(-1, true);
          genI := 0;
          arr[1] := CDs[1].Start; // CD1
          while (arr[1] <= CDs[1].Finish) and not StopFlag do
          begin
            StopFlag := StopFlag or not SetControl(1, arr[1]);
            arr[2] := CDs[2].Start; // CD2
            while (arr[2] <= CDs[2].Finish) and not StopFlag and (NumCD > 1) do
            begin
              StopFlag := StopFlag or not SetControl(2, arr[2]);
              arr[3] := CDs[3].Start; // CD3
              while (arr[3] <= CDs[3].Finish) and not StopFlag and
                (NumCD > 2) do
              begin
                StopFlag := StopFlag or not SetControl(3, arr[3]);
                b := TakeAShot(genI, false);
                if b > mm then
                begin
                  mm := b;
                  mari[1] := arr[1];
                  mari[2] := arr[2];
                  mari[3] := arr[3];
                end;
                arr[3] := arr[3] + CDs[3].Step;
              end; // CD3
              if NumCD = 2 then
              begin
                b := TakeAShot(genI, false);
                if b > mm then
                begin
                  mm := b;
                  mari[1] := arr[1];
                  mari[2] := arr[2];
                  InterprtD('// Temp.max/idx = ' + FloatToStr(mm) + ' ' +
                    IntToStr(genI));
                  InterprtD('// CD1= ' + FloatToStr(arr[1]));
                  InterprtD('// CD2= ' + FloatToStr(arr[2]));
                end;
              end;
              arr[2] := arr[2] + CDs[2].Step;
            end; // CD2
            if NumCD = 1 then
            begin
              b := TakeAShot(genI, false);
              if b > mm then
              begin
                mm := b;
                mari[1] := arr[1];
                InterprtD('// Temp.max/idx = ' + FloatToStr(mm) + ' ' +
                  IntToStr(genI));
                InterprtD('// CD1= ' + FloatToStr(arr[1]));
              end;
            end;
            arr[1] := arr[1] + CDs[1].Step;
          end; // CD1
          for i := 1 to NumCD do
          begin
            InterprtD(CDs[i].DName + '.DftSet(' + IntToStr(CDs[i].Channel) + ')');
            InterprtD(CDs[i].DName + '.RJpSet(' + FloatToStr(mari[i]) + ')');
          end;
          Plots[lastplot].AcqMode := false;
        end;
      1: // Consecutive scanning
        begin
          for m := 1 to NumCD do
          begin
            PageControl2.ActivePageIndex := m - 1;
            ss := 'Sp#.NewSet("' + Options.Templates[3] + '")';
            Interprt(ss);
            lastplot := StrToInt(ss);
            Plots[lastplot].AcqMode := true;
            a := CDs[m].Start;
            AmplInit := 0;
            ResolInit := 0;
            TakeAShot(-1, true);
            InterprtD(CDs[m].DName + '.DftSet(' +
              IntToStr(CDs[m].Channel) + ')');
            while (a <= CDs[m].Finish) and not StopFlag do
            begin
              StopFlag := StopFlag or not SetControl(m,a);
              b := TakeAShot(a, false);
              a := a + CDs[m].Step;
            end;
            if StopFlag then
              break;
            Plots[lastplot].AcqMode := false;
            srsResol.Clear;
            Application.ProcessMessages;
            mm := -9.9E99;
            mmi := -1;
            with Plots[lastplot].srsChrom do
            begin
              for i := 0 to Count - 1 do
                if YValues[i] > mm then
                begin
                  mmi := i;
                  mm := YValues[i];
                end;
              InterprtD(CDs[m].DName + '.RJpSet(' +
                FloatToStr(XValues[mmi]) + ')');
            end;
          end;
          Plots[lastplot].AcqMode := false;
        end;
      2: // Simplex optimization
        begin
          NextInOut := RealNextInOut;
          ss := 'Sp#.NewSet("' + Options.Templates[3] + '")';
          Interprt(ss);
          lastplot := StrToInt(ss);
          Plots[lastplot].AcqMode := true;
          AmplInit := 0;
          ResolInit := 0;
          TakeAShot(-1, true);
          for i := 0 to IniEstimN - 1 do
            TakeAShot(genI, false);
          { Plots[lastplot].Spec.AddSSpec(IniEstimN,0,wXY);
            k:= length(Plots[lastplot].Spec.Mass[0]);
            for i:=0 to k-1 do
            begin a:= 0;
            for j:=0 to IniEstimN-1 do
            a:= a+Plots[lastplot].Spec.Mass[j,i,Y]; // aver spec.
            Plots[lastplot].Spec.AddMass(Plots[lastplot].Spec.Mass[0,i,X],a/5,5);
            end; b:= 0;
            NdS:= 0;
            for i:=0 to k-1 do
            begin a:= 0;
            for j:=0 to IniEstimN-1 do
            begin a:= a+sqr(Plots[lastplot].Spec.Mass[j,i,Y]
            -Plots[lastplot].Spec.Mass[IniEstimN,i,Y]);
            end;
            NdS:= NdS+sqrt(a/IniEstimN);
            end;
            NdS:= NdS/k; }
          SetLength(Data, Plots[lastplot].Spec.NSpec);
          for j := 0 to IniEstimN - 1 do
            Data[j] := Plots[lastplot].Spec.Chrom[j, y];
          { b:= b/IniEstimN; SIE:= 0;                // aver. TIC
            for j:=0 to IniEstimN-1 do
            SIE:= SIE+sqr(b-Plots[lastplot].Spec.Chrom[j,Y]);
            SIE:= SIE/(IniEstimN-1); // signal (TIC) initial estimation
            SIER:= SIE/b; }// relative SIE

          MeanAndStdDev(Data, b, SIE);
          SIER := SIE / b;
          rgMethod.Items[2] := 'Simplex (N/S=' + FloatToStrF(SIER * 100,
            ffGeneral, 4, 3) + '%)';
          Plots[lastplot].Clear;
          genI := 0;
          AmplInit := 0;
          ResolInit := 0;
          TakeAShot(-1, true);
          // findsimplex(CDs,numCD,NewPos);
          SimplexNR(CDs, NumCD, NewPos);
          Plots[lastplot].AcqMode := false;
          // for i:=1 to NumCD do SetControl(i,NewPos[i]);
        end;
    end;
  finally
    sbRun.Down := false;
    tsOptim.Enabled := true;
    FreeAndNil(srsFit);
    FreeAndNil(srsResol);
    InterprtD('itr.busset(FALSE)');
    InterprtD('Itr.LckSet(FALSE)');
    StopTheMachine;
  end;
end; { TfmAutoTune.bbRunClick }

procedure TfmAutoTune.cbTuneFilesChange(Sender: TObject);
var
  i, j: integer;
  bb: boolean;
begin
  bb := false;
  if cbTuneFiles.Text = '' then
  begin
    sbOpen.Enabled := true;
    exit;
  end;
  with FileListBox1 do
    for i := 0 to Items.Count - 1 do
      bb := bb or (UpperCase(Items[i]) = UpperCase(cbTuneFiles.Text));
  sbOpen.Enabled := bb;
end; { TfmAutoTune.cbTuneFilesChange }

procedure TfmAutoTune.sbRefFileClick(Sender: TObject);
var
  ss: string;
  ws: TSpec;
begin
  inherited;
  if Sender <> nil then // local call
    if not OpenDialog1.Execute then
      exit
    else
    begin
      ss := OpenDialog1.Filename;
      TheLastRefFile := ss;
    end;
  ss := TheLastRefFile;
  if length(ss) > 23 then
    ss := copy(ss, length(ss) - 23, 255);
  ss := '...' + ss;
  lbRefFile.Caption := ss;
  ws := TSpec.Create;
  ws.OpenFile(TheLastRefFile);
  AssignXY2XY(ws.CMass, XYrefFile); // weighted
  ws.free;
end; { TfmAutoTune.sbRefFileClick }

end.
