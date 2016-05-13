unit PCAmainU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ToolWin, ComCtrls, PlotU, StdCtrls, ImgList,
  Grids, Buttons, TeeProcs, TeEngine, Chart, Series, CandleCh,
  Spin, clipbrd, IniFiles, ValEdit, Math, PCAmathU, TrainingU, PCAprocU,
  BMDSpinEdit;

type
  TfrmPCAprep = class(TForm)
    MainMenu1: TMainMenu;
    ToolBar1: TToolBar;
    mFile: TMenuItem;
    ImageList1: TImageList;
    mOpenSpec: TMenuItem;
    mPCA: TMenuItem;
    mCalculate: TMenuItem;
    N1: TMenuItem;
    mExit: TMenuItem;
    mHelp: TMenuItem;
    mCloseSpec: TMenuItem;
    OpenDialog1: TOpenDialog;
    mEdit: TMenuItem;
    mCopyImage: TMenuItem;
    N3: TMenuItem;
    mOptions: TMenuItem;
    mCloseActiveSpec: TMenuItem;
    mCloseAllSpec: TMenuItem;
    StatusBar1: TStatusBar;
    mHelpContents: TMenuItem;
    mTopicSearch: TMenuItem;
    N4: TMenuItem;
    mAbout: TMenuItem;
    tbOpenSpec: TToolButton;
    tbOpenTraining: TToolButton;
    ToolButton3: TToolButton;
    tbCalculate: TToolButton;
    tbSaveTraining: TToolButton;
    ImageList2: TImageList;
    N6: TMenuItem;
    mOpimizing: TMenuItem;
    N2: TMenuItem;
    mOpenTraining: TMenuItem;
    mSaveTraining: TMenuItem;
    ToolButton1: TToolButton;
    pnlMain: TPanel;
    pnlUpper: TPanel;
    pnlUpLeft: TPanel;
    pnlLower: TPanel;
    pnlLowRight: TPanel;
    pnlUpRight: TPanel;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    chkNormalize: TCheckBox;
    pnlLowLeft: TPanel;
    SplitterLeft: TSplitter;
    mNewTraning: TMenuItem;
    pcChartCtrl: TPageControl;
    tsLoadings: TTabSheet;
    tsRebuild: TTabSheet;
    tsMDist: TTabSheet;
    Chart1: TChart;
    srsBars1: TVolumeSeries;
    Panel2: TPanel;
    seLoadings: TSpinEdit;
    Label5: TLabel;
    Panel3: TPanel;
    Label6: TLabel;
    seRebuildSp: TSpinEdit;
    Label7: TLabel;
    seNFactors: TSpinEdit;
    rgErrors: TRadioGroup;
    Chart2: TChart;
    srsBars2: TVolumeSeries;
    srsLine2: TLineSeries;
    Chart3: TChart;
    Panel4: TPanel;
    srsPoints3: TPointSeries;
    tsEigenValues: TTabSheet;
    tsScores: TTabSheet;
    Chart4: TChart;
    srsPoints4: TPointSeries;
    Panel5: TPanel;
    Chart5: TChart;
    srsPoints5: TPointSeries;
    Label8: TLabel;
    seMDFactor: TSpinEdit;
    Label9: TLabel;
    Label10: TLabel;
    seXFactor: TSpinEdit;
    seYFactor: TSpinEdit;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Panel6: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    lRecomFactN: TLabel;
    GroupBox2: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    mCopyData: TMenuItem;
    SaveDialog1: TSaveDialog;
    bbRetrieve: TBitBtn;
    chkInclSp: TCheckBox;
    TabSheet1: TTabSheet;
    Chart6: TChart;
    srsPoints6: TPointSeries;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    tsSurvey: TTabSheet;
    pnlCommand: TPanel;
    gbOptim: TGroupBox;
    sbOptim: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbOptimWhat: TComboBox;
    mmScript: TMemo;
    Panel1: TPanel;
    mSurvey: TMenuItem;
    fseFrom: TBMDSpinEdit;
    fseTo: TBMDSpinEdit;
    fseStep: TBMDSpinEdit;
    fseIncSens: TBMDSpinEdit;
    seLowBound: TSpinEdit;
    seHighBound: TSpinEdit;
    seNLoadings: TSpinEdit;
    sePrecPower: TSpinEdit;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mOpenSpecClick(Sender: TObject);
    procedure mExitClick(Sender: TObject);
    procedure mCalculateClick(Sender: TObject);
    procedure mCloseAllSpecClick(Sender: TObject);
    procedure mAboutClick(Sender: TObject);
    procedure mCloseActiveSpecClick(Sender: TObject);
    procedure mOpimizingClick(Sender: TObject);
    procedure mOpenTrainingClick(Sender: TObject);
    procedure mSaveTrainingClick(Sender: TObject);
    procedure seLoadingsChange(Sender: TObject);
    procedure mNewTraningClick(Sender: TObject);
    procedure seRebuildSpChange(Sender: TObject);
    procedure pcChartCtrlChange(Sender: TObject);
    procedure seXFactorChange(Sender: TObject);
    procedure seVarLevelChange(Sender: TObject);
    procedure seMDFactorChange(Sender: TObject);
    procedure mCopyImageClick(Sender: TObject);
    procedure mCopyDataClick(Sender: TObject);

    procedure mOptionsClick(Sender: TObject);
    procedure mFileClick(Sender: TObject);
    procedure bbRetrieveClick(Sender: TObject);
    procedure srsPoints5DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure mSurveyClick(Sender: TObject);
  private
    { Private declarations }
    Charts: array [0 .. 5] of TChart;
    IniSet: TMemIniFile;
    Training: TTraining;
    procedure Options2VisComp(InclSp: boolean);
    procedure VisComp2Options;

    procedure SetBoundaries(Renew: boolean);
    function CheckBoundaries: boolean;

    function CookMD(Excluded, f: Integer): double;
    procedure ClearResults;
  public
    { Public declarations }
    // Xvalues: adouble;
    procedure DisplayHint(Sender: TObject);
    function Interpret(var Command: string): boolean;
  end;

var
  frmPCAprep: TfrmPCAprep;
  fmPCAproc: TfmPCAproc;

implementation
{$R *.DFM}
uses DirPickU, PlotCollectU, AboutU, SpecU, SpOptU;
const AppTitle = 'PCA detective v2.1';
var
  mat, resid, evec, score: aadouble;
  evl: adouble;

procedure TfrmPCAprep.Options2VisComp(InclSp: boolean);
var
  i, j: Integer;
begin
  Training.Locked := true;
  OpenDialog1.InitialDir := Training.DirName;
  seLowBound.Value := Training.LowBound;
  seHighBound.Value := Training.HighBound;
  chkNormalize.Checked := Training.Normalize;
  fseIncSens.Value := Training.IncSens;
  seNLoadings.Value := Training.NLoadings;
  sePrecPower.Value := Training.PrecPower;
  if InclSp then
  begin
    Plots.Clear;
    for i := 0 to Training.LoadedSpec.Count - 1 do
    begin
      j := Plots.Add(Training.DefaultTml);
      Plots[j].MassOnly := true;
      Plots[j].OpenData(Training.DirName + Training.LoadedSpec[i]);
      if Plots[j].IsEmpty then
        Plots.Delete(j)
      else
        Plots[j].chrMass.chrChart.Title.Visible := true;
    end;
  end;
  mOpenSpec.Enabled := true;
  tbOpenSpec.Enabled := true;
  mCloseSpec.Enabled := (Plots.Count > 0);
  mPCA.Enabled := (Plots.Count > 2);
  Caption := AppTitle + ' - ' + Training.Filename;
  Training.Locked := false;
end; { TfrmPCAprep.Options2VisComp }

procedure TfrmPCAprep.VisComp2Options;
var
  i, j: Integer;
begin
  if Training.Locked then
    exit;
  if Plots.Count > 0 then
    Training.DefaultTml := Plots[0].TmplName;
  Training.LowBound := seLowBound.Value;
  Training.HighBound := seHighBound.Value;
  Training.Normalize := chkNormalize.Checked;
  Training.IncSens := fseIncSens.Value;
  Training.NLoadings := seNLoadings.Value;
  Training.PrecPower := sePrecPower.Value;
  if not Assigned(Training.LoadedSpec) then
    Training.LoadedSpec := TStringList.Create;
  Training.LoadedSpec.Clear;
  for i := 0 to Plots.Count - 1 do
    Training.LoadedSpec.Add(ExtractFilename(Plots[i].Spec.Filename));
end; { TfrmPCAprep.VisComp2Options }

procedure TfrmPCAprep.DisplayHint(Sender: TObject);
begin
  StatusBar1.SimpleText := ' ' + GetLongHint(Application.Hint);
end;

procedure TfrmPCAprep.FormCreate(Sender: TObject);
var
  ss: string;  bb: boolean;  sl: TStringList;
begin
  Application.OnHint := DisplayHint;
  DecimalSeparator := '.';
  Plots := TPlots.Create(pnlUpLeft);
  Plots.Parent := pnlUpLeft;
  Plots.Docked := true;

  Charts[0] := Chart1; Charts[1] := Chart2; Charts[2] := Chart3;
  Charts[3] := Chart4; Charts[4] := Chart5; Charts[5] := Chart6;

  ss := RootPath + 'startup.ini';
  IniSet := TMemIniFile.Create(ss);
  ss := IniSet.ReadString('Target', 'Training', '');
  if not DirectoryExists(ExtractFileDir(ss)) then
    ss := RootPath + DataPath + ExtractFileName(ss);
  bb := FileExists(ss);
  Training := TTraining.Create(ss);
  if not bb then
  begin
    sl := TStringList.Create;
    IniSet.GetStrings(sl);
    Training.SetStrings(sl);
    Training.EraseSection('Training');
    sl.Free;
  end;
  Training.Open;
  Options2VisComp(true); SetBoundaries(false);

  mPCA.Enabled := (Plots.Count > 2);
  bbRetrieve.Caption := 'Retrieve params from ' + #10 + 'calculated training.';
end; { TfrmPCAprep.FormCreate }

procedure TfrmPCAprep.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: byte;  sl: TStringList;  ss: string;
begin
  Training.Save(false);
  sl := TStringList.Create;
  Training.GetStrings(sl);
  IniSet.SetStrings(sl);
  IniSet.EraseSection('PCA');
  IniSet.WriteString('Target', 'Training', Training.Filename);
  IniSet.UpdateFile;
  IniSet.Free;
  if Training.Calculated then
    Training.Save(true);
  Training.Free;
  sl.Free;
  Finalize(mat);
  Finalize(evl);
  Finalize(evec);
  Finalize(score);
end; { TfrmPCAprep.FormClose }

procedure TfrmPCAprep.mOpenSpecClick(Sender: TObject);
var
  ss: string;
begin
  ss := 'OpenSpec';
  Interpret(ss);
end;

procedure TfrmPCAprep.mCloseActiveSpecClick(Sender: TObject);
var
  i, j, k, m: Integer;
begin
  if Plots.Count > 0 then
  begin
    i := Plots.Active;
    k := Plots[i].Number;
    Plots.Delete(i);
    ClearResults;
  end;
end;

procedure TfrmPCAprep.mCloseAllSpecClick(Sender: TObject);
var
  ss: string;
begin
  ss := 'CloseSpec All';
  Interpret(ss);
end;

procedure TfrmPCAprep.mExitClick(Sender: TObject);
begin
  close;
end;

function TfrmPCAprep.Interpret(var Command: string): boolean; // I/O only
var
  i, j, k: Integer;
  Prs: TParser;
  FStm: TStringStream;
  ss: string;
  OK: boolean;
  bb: boolean;
begin
  Result := true;
  OK := false;
  mmScript.Lines.Add(Command);
  if (Command[1] = '''') or (Command[1] = ';') then
    exit;
  while (mmScript.Lines.Count > 10000) do
    mmScript.Lines.Delete(0);
  FStm := TStringStream.Create(Command);
  Prs := TParser.Create(FStm);
  try
    if Prs.Token <> toSymbol then
    begin
      ShowMessage('Wrong command syntax.');
      exit;
    end;
    if Prs.TokenString = 'OpenSpec' then
    begin
      Prs.NextToken;
      if Prs.Token = toEOF then
      begin
        OpenDialog1.Title := 'Open XY Spec File(s) - multiselect';
        OpenDialog1.Filter := 'XY text (*.txt)|*.txt';
        OpenDialog1.DefaultExt := 'txt';
        OpenDialog1.InitialDir := Training.DirName;
        if not OpenDialog1.Execute then
          exit;
        if OpenDialog1.Files.Count > (Plots.MaxNPlots - Plots.Count - 1) then
          j := Plots.MaxNPlots - Plots.Count - 1
        else
          j := OpenDialog1.Files.Count;
        for k := 0 to j - 1 do
        begin
          if Plots.IdxByFilename(OpenDialog1.Files[k]) > -1 then
            if MessageDlg('The file "' + OpenDialog1.Files[k] + '"' + #10 +
              'has been already opened. Open another copy?', mtConfirmation,
              [mbYes, mbNo], 0) = mrNo then
              continue;
          i := Plots.Add(Training.DefaultTml);
          Plots[i].MassOnly := true;
          Plots[i].OpenData(OpenDialog1.Files[k]);
          if UpperCase(Training.DirName) <>
            UpperCase(ExtractFileDir(Plots[i].Spec.Filename)) then
          begin
            ShowMessage('All the spectra must be in the training directory !');
            Plots.Delete(i);
            exit;
          end;
          if Plots[i].IsEmpty then
            Plots.Delete(i)
          else
          begin
            Plots[i].chrMass.chrChart.Title.Visible := true;
            OK := true;
          end;
        end;
      end
      else
      begin
        ss := Command;
        system.Delete(ss, 1, 11);
        ss := trim(ss);
        if not FileExists(ss) then
        begin
          ShowMessage('File does not exist. ' + ss);
          exit;
        end;
        if UpperCase(Training.DirName) <> UpperCase(ExtractFileDir(ss)) then
        begin
          ShowMessage('All the spectra must be in the training directory !');
          exit;
        end;
        if Plots.IdxByFilename(ss) > -1 then
          if MessageDlg('The file "' + ss + '"' + #10 +
            'has been already opened. Open another copy?', mtConfirmation,
            [mbYes, mbNo], 0) = mrNo then
            exit;
        i := Plots.Add(Training.DefaultTml);
        Plots[i].MassOnly := true;
        Plots[i].OpenData(ss);
        if Plots[i].IsEmpty then
          Plots.Delete(i)
        else
        begin
          Plots[i].chrMass.chrChart.Title.Visible := true;
          OK := true;
        end;
      end;
    end;
    if Prs.TokenString = 'CloseSpec' then
    begin
      Prs.NextToken;
      if Prs.Token <> toSymbol then
      begin
        ShowMessage('Wrong command syntax.');
        exit;
      end;
      if Prs.TokenString = 'All' then
        for i := 0 to Plots.MaxNPlots - 1 do
          mCloseActiveSpecClick(nil);
      if Prs.TokenString = 'Active' then
        mCloseActiveSpecClick(nil);
      OK := true;
    end;
    if OK then
      mmScript.Lines.Add('>OK')
    else
      mmScript.Lines.Add('>Problem');
    SetBoundaries(true);
    ClearResults;
    mPCA.Enabled := (Plots.Count > 2);
    mCloseSpec.Enabled := (Plots.Count > 0);
    Result := OK;
  finally
    Prs.Destroy;
    FStm.Destroy;
  end;
end; { TfrmMatching.Interpret }

procedure TfrmPCAprep.mAboutClick(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TfrmPCAprep.mOpimizingClick(Sender: TObject);
begin
  mOpimizing.Checked := not mOpimizing.Checked;
  pnlCommand.Visible := mOpimizing.Checked;
end;

procedure TfrmPCAprep.mNewTraningClick(Sender: TObject);
begin
  pnlLower.Visible := false;
  mCloseAllSpecClick(nil);
  ClearResults;
  OpenDialog1.Title :=
    'Give a name for the new training file; all the spectra must be in the same dir';
  OpenDialog1.Filter := 'Training file (*.trn)|*.trn';
  OpenDialog1.DefaultExt := 'trn';
  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.Filename) then
      if MessageDlg('File' + OpenDialog1.Filename + ' exists.' + #10 +
        'Overwrite it ?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    if Assigned(Training) then
      FreeAndNil(Training);
    Training := TTraining.Create(OpenDialog1.Filename);
    Plots.Clear;
    VisComp2Options;
    Caption := AppTitle + ' - ' + Training.Filename;
    mCloseSpec.Enabled := false;
    mPCA.Enabled := false;
    tbSaveTraining.Enabled := false;
  end;
end; { TfrmPCAprep.mNewTraningClick }

procedure TfrmPCAprep.mOpenTrainingClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Open PCA training file';
  OpenDialog1.Filter := 'Training file (*.trn)|*.trn';
  OpenDialog1.DefaultExt := 'trn';
  if OpenDialog1.Execute then
  begin
    pnlLower.Visible := false;
    mCloseAllSpecClick(nil);
    ClearResults;
    Training.Free;
    Training := TTraining.Create(OpenDialog1.Filename);
    Training.Open;
    Options2VisComp(true);
  end;
end;

procedure TfrmPCAprep.mSaveTrainingClick(Sender: TObject);
var
  i, j: Integer;
  evc, score: aadouble;
  scoreM: adouble;
begin
  Training.Calculated := (length(mat) > 0);
  with Training do
    if Calculated then
    begin
      j := length(Plots[0].CMass);
      SetLength(Xvals, j);
      for i := 0 to j - 1 do
        Xvals[i] := Plots[0].CMass[i, X];
      Loadings := AssignMat(evec);

      MahalMatrix(mat, NLoadings, MahalMat, scoreM, RcM, RMSG);
    end;
  frmOpts.Training := Training;
  if frmOpts.ShowModal = mrOK then
  begin
    Training.Save(true);
    tbSaveTraining.Enabled := false;
  end;
end; { TfrmPCAprep.mSaveTrainingClick }

procedure TfrmPCAprep.SetBoundaries(Renew: boolean);
var
  i, j, k, l, lb, hb: Integer;
begin
  if Plots.Count = 0 then
    exit;
  if (Training.LowBound = 0) or Renew then
  begin
    lb := trunc(Plots[0].srsMass.XValues[0]);
    for j := 1 to Plots.Count - 1 do
      if lb < trunc(Plots[j].srsMass.XValues[0]) then
        lb := trunc(Plots[j].srsMass.XValues[0]);
  end
  else
    lb := Training.LowBound;
  if (Training.HighBound = 0) or Renew then
  begin
    hb := ceil(Plots[0].srsMass.XValues[Plots[0].srsMass.Count - 1]);
    for j := 1 to Plots.Count - 1 do
      if hb > ceil(Plots[j].srsMass.XValues[Plots[j].srsMass.Count - 1]) then
        hb := ceil(Plots[j].srsMass.XValues[Plots[j].srsMass.Count - 1]);
  end
  else
    hb := Training.HighBound;
  seLowBound.Value := lb;
  seHighBound.Value := hb;

  seNLoadings.MaxValue := Plots.Count;
  if Training.NLoadings < 2 then
    seNLoadings.Value := Plots.Count - 3;
end; { TfrmPCAprep.SetBoundaries }

function TfrmPCAprep.CheckBoundaries: boolean;
var
  i, j, k, l: Integer;
  a: real;
  ss: string;
  bb: boolean;
begin
  Result := false;
  for j := 0 to Plots.Count - 1 do
    if Training.LowBound < trunc(Plots[j].srsMass.XValues[0]) then
    begin
      ShowMessage('Problem with lower boundary of sp' + GetPlotSymbol(j));
      exit;
    end;
  for j := 0 to Plots.Count - 1 do
    if Training.HighBound >
      ceil(Plots[j].srsMass.XValues[Plots[j].srsMass.Count - 1]) then
    begin
      ShowMessage('Problem with higher boundary of sp' + GetPlotSymbol(j));
      exit;
    end;
  Result := true;
end; { TfrmPCAprep.CheckBoundaries }

procedure TfrmPCAprep.mCalculateClick(Sender: TObject);
var
  i, j, k, l, f: Integer;
  a: real;
  ss: string;
begin
  if Plots.Count < 2 then
    exit;
  ClearResults;
  if seNLoadings.Value < 2 then
    seNLoadings.Value := Plots.Count - 3;
  VisComp2Options;
  try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    if not CheckBoundaries then
      exit;
    SetLength(mat, Plots.Count);
    k := 0;
    for i := 0 to Plots.Count - 1 do
    begin
      if Plots[i].IsEmpty then
        continue;
      if Plots[i].chrMass.chrChart.Title.Text.Count > 0 then
        Plots[i].srsMass.Title := Plots[i].chrMass.chrChart.Title.Text[0];
      mat[k] := Training.Preproc(Plots[0], Plots[i]);
      inc(k);
    end;
    Application.OnHint := nil;
    f := seNLoadings.Value;
    CalcPrec := power(10, -Training.PrecPower);
    NIPALS(mat, resid, evl, evec, score, f); // PCA itself
    frmPCAprep.StatusBar1.SimpleText := 'PCA done';
    Application.OnHint := DisplayHint;

    seLoadings.MaxValue := length(evl);
    seLoadings.Value := 1;
    pcChartCtrl.ActivePageIndex := 0;
    seLoadingsChange(nil);
    seRebuildSp.MaxValue := Plots.Count;
    seRebuildSp.Value := 1;
    seNFactors.MaxValue := length(evl);
    seNFactors.Value := length(evl);
    seXFactor.MaxValue := length(evl);
    seYFactor.MaxValue := length(evl);
    pnlLower.Visible := true;
    SplitterLeft.Top := pnlLowLeft.Height + 3;
    seMDFactor.MaxValue := Training.NLoadings;
    seMDFactor.Value := Training.NLoadings;
    tbSaveTraining.Enabled := true;
    Training.Calculated := true;
  finally
    Screen.Cursor := crDefault;
  end;
end; { TfrmPCAprep.mCalculateClick }

procedure TfrmPCAprep.seLoadingsChange(Sender: TObject);
var
  i, j: Integer;
begin
  j := seLoadings.Value - 1;
  srsBars1.Clear;
  for i := 0 to length(evec[j]) - 1 do
    srsBars1.AddXY(Training.Xvals[i], evec[j, i] * sqrt(evl[j]));
end;

procedure TfrmPCAprep.seRebuildSpChange(Sender: TObject);
var
  i, j, k, l, f: Integer;
  a, b, c: real;
  arr: adouble;
begin
  if pcChartCtrl.ActivePageIndex <> 1 then
    exit;
  f := seNFactors.Value;
  j := seRebuildSp.Value - 1; { n }
  srsBars2.Clear;
  srsLine2.Clear;
  b := 0;
  arr := Training.Preproc(Plots[0], Plots[j]);
  for i := 0 to length(mat[j]) { p } - 1 do
  begin
    a := 0;
    for k := 0 to f - 1 do
      a := a + score[j, k] * evec[k, i];
    srsBars2.AddXY(Training.Xvals[i], a);
    c := a - arr[i];
    b := b + c * c;
    srsLine2.AddXY(Training.Xvals[i], c);
  end;
  Plots.Active := j;
  if Chart2.Title.Text.Count = 0 then
    Chart2.Title.Text.Add('');
  Chart2.Title.Text[0] := 'Euclidean Dist.= ' + FloatToStrF(sqrt(b),
    ffGeneral, 6, 3);
  srsLine2.ParentChart := Chart2;
  case rgErrors.ItemIndex of
    0:
      srsLine2.ParentChart := nil;
    1:
      srsLine2.VertAxis := aLeftAxis;
    2:
      srsLine2.VertAxis := aRightAxis;
  end;
end; { TfrmPCAprep.seRebuildSpChange }

function TfrmPCAprep.CookMD(Excluded, f: Integer): double;
var
  i, j, k: Integer;
  matD, mm, evecD, residD, scoreD: aadouble;
  excl, scoreU, evlD: adouble;
  a, RMSG, RcM: double;
begin
  try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    if (Excluded < 0) or (Excluded >= Plots.Count) then
      exit;
    if not CheckBoundaries then
    begin
      ShowMessage('Wrong boundaries');
      exit;
    end;
    SetLength(matD, Plots.Count - 1); // minus excluded
    k := 0;
    for j := 0 to Plots.Count - 1 do
      if (Plots[j].srsMass.Count = Plots[0].srsMass.Count) and (j <> Excluded)
      then
      begin
        SetLength(matD[k], Plots[j].srsMass.Count);
        inc(k);
      end;
    k := 0;
    a := Plots[0].srsMass.YValues.Total;
    for i := 0 to Plots.Count - 1 do
    begin
      if i = Excluded then
      begin
        excl := Training.Preproc(Plots[0], Plots[i]);
        continue;
      end;
      if Plots[i].IsEmpty then
        continue;
      if Plots[i].chrMass.chrChart.Title.Text.Count > 0 then
        Plots[i].srsMass.Title := Plots[i].chrMass.chrChart.Title.Text[0];
      matD[k] := Training.Preproc(Plots[0], Plots[i]);
      inc(k);
    end;
    Application.OnHint := nil; // SetLength(matD,k); // ??

    NIPALS(matD, residD, evlD, evecD, scoreD, f);
    MahalMatrix(matD, f, mm, scoreU, RcM, RMSG);
    DecompByEvec(f, k, excl, evecD, RcM, scoreU);

    Result := MahalDist(mm, f, scoreU, RMSG); // Mahalanobis Distance

    Application.OnHint := DisplayHint;
  finally
    Screen.Cursor := crDefault;
  end;
end; { TfrmPCAprep.CookMD }

procedure TfrmPCAprep.pcChartCtrlChange(Sender: TObject);
var
  i, j, n, f: Integer;
  a: real;
  arr: adouble;
begin
  Chart1.Title.Text.Clear;
  case pcChartCtrl.ActivePageIndex of
    0:
      seLoadingsChange(nil);
    1:
      seRebuildSpChange(nil);
    2:
      seMDFactorChange(nil);
    3:
      begin
        srsPoints4.Clear;
        seVarLevelChange(nil);
        for i := 0 to length(evl) { f } - 1 do
          srsPoints4.AddXY(i + 1, evl[i]);
      end;
    4:
      seXFactorChange(nil);
    5:
      begin
        n := length(mat);
        f := length(evec);
        for i := 1 to f do
        begin
          a := 0;
          for j := 0 to n - 1 do
            a := a + CookMD(j, i);
          srsPoints6.AddXY(i, a / n);
        end;
      end;
  end;
end; { TfrmPCAprep.pcChartCtrlChange }

procedure TfrmPCAprep.seXFactorChange(Sender: TObject);
var
  i, j, k, l: Integer;
begin
  srsPoints5.Clear;
  j := seXFactor.Value - 1;
  k := seYFactor.Value - 1;
  for i := 0 to length(score) { n } - 1 do
    srsPoints5.AddXY(score[i, j], score[i, k], GetPlotSymbol(i + 1));
end;

procedure TfrmPCAprep.seVarLevelChange(Sender: TObject);
var
  i, j: Integer;
  a, b: real;
begin
  a := 0;
  b := 0;
  for i := 0 to length(evl) - 1 do
    a := a + evl[i];
  for i := 0 to length(evl) - 1 do
  begin
    b := b + evl[i];
    // if (b/a)>(seVarLevel.Value/100) then break;
  end;
  if i = length(evl) then
    i := length(evl) - 1;
  lRecomFactN.Caption := IntToStr(i + 1);
end;

procedure TfrmPCAprep.seMDFactorChange(Sender: TObject);
var
  i, j: Integer;
begin
  srsPoints3.Clear;
  for i := 0 to Plots.Count - 1 do
    srsPoints3.AddXY(i, CookMD(i, seMDFactor.Value),
      GetPlotSymbol(Plots[i].Number + 1));
end;

procedure TfrmPCAprep.mCopyImageClick(Sender: TObject);
begin
  if not pnlLower.Visible then
    exit;
  Charts[pcChartCtrl.ActivePageIndex].CopyToClipboardMetafile(false);
end;

procedure TfrmPCAprep.mCopyDataClick(Sender: TObject);
var
  cs: TChartSeries;
  i, j: Integer;
  ss: string;
begin
  if not pnlLower.Visible then
    exit;
  if Charts[pcChartCtrl.ActivePageIndex].SeriesCount = 0 then
    exit;
  cs := Charts[pcChartCtrl.ActivePageIndex].Series[0];
  ss := '';
  for i := 0 to cs.Count - 1 do
    ss := ss + FloatToStr(cs.XValues[i]) + #9 + FloatToStr(cs.YValues[i]) + #10;
  Clipboard.AsText := ss;
end;

procedure TfrmPCAprep.mOptionsClick(Sender: TObject);
begin
  frmOpts.ShowModal;
end;

procedure TfrmPCAprep.mFileClick(Sender: TObject);
begin
  mSaveTraining.Enabled := tbSaveTraining.Enabled;
end;

procedure TfrmPCAprep.bbRetrieveClick(Sender: TObject);
begin
  Options2VisComp(chkInclSp.Checked);
end;

procedure TfrmPCAprep.srsPoints5DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ss: string;
begin
  ss := Sender.XLabel[ValueIndex];
  Plots.Active := CheckPlotSymbol(UpCase(ss[1])) - 1;
end;

procedure TfrmPCAprep.ClearResults;
var
  i, j: Integer;
begin
  for i := 0 to pcChartCtrl.PageCount - 1 do
    with Charts[i] do
      for j := 0 to SeriesCount - 1 do
        Series[j].Clear;
  pnlLower.Visible := false;
  tbSaveTraining.Enabled := false;
end; { TfrmPCAprep.ClearResults }

procedure TfrmPCAprep.mSurveyClick(Sender: TObject);
begin
  if fmPCAproc = nil then
    fmPCAproc := TfmPCAproc.Create(self);
  fmPCAproc.Parent := tsSurvey;
  PageControl1.Visible := true;
end;

end.
