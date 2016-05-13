unit PlotU;

interface

{$H+}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs,
  TeEngine, Series, ComCtrls, TeeProcs, Chart, ExtCtrls, ImgList, ToolWin,
  StdCtrls, Buttons, ArrowCha, Grids, Spin, SpecU, TeeShape, Clipbrd, SpOptU,
  FileCtrl, vChartU, ActnList, TeeComma, TeeSurfa, TeeEdit, TeeTools,
  TeePageNumTool, TeeStore, CandleCh, Menus, Controls, Vcl.Mask, BMDSpinEdit;

type
  tWhatVis = (wvChrom, wvMass, wvBoth);

  TfrmPlot = class(TFrame)
    PropToolBar: TToolBar;
    ImageList1: TImageList;
    tbChrom: TToolButton;
    tbCommon: TToolButton;
    tbMass: TToolButton;
    pcCommon: TPageControl;
    tsProps: TTabSheet;
    ColorDialog1: TColorDialog;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    tsFiles: TTabSheet;
    GroupBox5: TGroupBox;
    gbAsTemplate: TGroupBox;
    bbOpenData: TBitBtn;
    bbSaveAsData: TBitBtn;
    bbOpenTml: TBitBtn;
    bbSaveAsTml: TBitBtn;
    ActionList1: TActionList;
    actDataTableChrom: TAction;
    actSmoothChrom: TAction;
    actBLineChrom: TAction;
    actPeaksChrom: TAction;
    actDataTableMass: TAction;
    actSmoothMass: TAction;
    actBLineMass: TAction;
    actPeaksMass: TAction;
    pcDimentions: TPageControl;
    ts2D: TTabSheet;
    ts3D: TTabSheet;
    pnlCommon: TPanel;
    Splitter1: TSplitter;
    pnlChrom: TPanel;
    pcChrom: TPageControl;
    tsVisualChrom: TTabSheet;
    rgShowChrom: TRadioGroup;
    rgXUnitsChrom: TRadioGroup;
    tsSmoothChrom: TTabSheet;
    GroupBox2: TGroupBox;
    chkOSSmoothChrom: TCheckBox;
    tsBLineChrom: TTabSheet;
    GroupBox4: TGroupBox;
    chkAutoTSChrom: TCheckBox;
    tsPeakChrom: TTabSheet;
    chkOSPeakChrom: TCheckBox;
    pcPeakMethodChrom: TPageControl;
    SPTabChrom: TTabSheet;
    Label5: TLabel;
    FDTabChrom: TTabSheet;
    chkSeeFDChrom: TCheckBox;
    Panel4: TPanel;
    GroupBox9: TGroupBox;
    GroupBox11: TGroupBox;
    tsRetTimes: TTabSheet;
    sgRangesChrom: TStringGrid;
    Panel2: TPanel;
    bbClearRangesChrom: TBitBtn;
    bbUpdateRangesChrom: TBitBtn;
    tsStatsChrom: TTabSheet;
    chrChrom: TvChart;
    pnlMass: TPanel;
    chr3D: TChart;
    TeeCommander1: TTeeCommander;
    ChartEditorChrom: TChartEditor;
    ChartTool1: TPageNumTool;
    chkSaveTemplate: TCheckBox;
    Label12: TLabel;
    lbTotalChrom: TLabel;
    lbNPointsChrom: TLabel;
    GroupBox7: TGroupBox;
    chkDimTabs: TCheckBox;
    rgDims: TRadioGroup;
    tsMyTab: TTabSheet;
    Memo1: TMemo;
    sgFiles: TStringGrid;
    Panel5: TPanel;
    chkAcqMode: TCheckBox;
    chkMassMode: TCheckBox;
    btnClear: TButton;
    PopupMenu1: TPopupMenu;
    pmMassOnly: TMenuItem;
    N1: TMenuItem;
    pmClear: TMenuItem;
    pmFill: TMenuItem;
    SplitterChrom: TSplitter;
    Panel6: TPanel;
    bbEditorChrom: TBitBtn;
    Label14: TLabel;
    chkSaveChartChrom: TCheckBox;
    pcMass: TPageControl;
    tsVisualMass: TTabSheet;
    rgShowMass: TRadioGroup;
    tsSmoothMass: TTabSheet;
    GroupBox1: TGroupBox;
    chkOSSmoothMass: TCheckBox;
    tsBLineMass: TTabSheet;
    chkOSBlineMass: TCheckBox;
    GroupBox3: TGroupBox;
    chkAutoTSMass: TCheckBox;
    tsPeakMass: TTabSheet;
    chkOSPeakMass: TCheckBox;
    pcPeakMethodMass: TPageControl;
    tsStdMethod: TTabSheet;
    Label10: TLabel;
    ts1DivMethod: TTabSheet;
    chkSeeFDMass: TCheckBox;
    tsAdaptMethod: TTabSheet;
    Label11: TLabel;
    Panel3: TPanel;
    gbPeakParamMass: TGroupBox;
    gbPeakSensivMass: TGroupBox;
    tsSIC: TTabSheet;
    sgRangesMass: TStringGrid;
    Panel1: TPanel;
    bbClearRangesMass: TBitBtn;
    bbUpdateRangesMass: TBitBtn;
    tsStatsMass: TTabSheet;
    lbRetTime: TLabel;
    lbNPointsMass: TLabel;
    lbFromMass: TLabel;
    lbToMass: TLabel;
    lbNPeaksMass: TLabel;
    chrMass: TvChart;
    SplitterMass: TSplitter;
    OpenDialog2: TOpenDialog;
    ChartEditorMass: TChartEditor;
    btnSimulGCMS: TButton;
    rgChromatogram: TRadioGroup;
    Panel7: TPanel;
    lbTotalMass: TLabel;
    Panel8: TPanel;
    Label13: TLabel;
    chkSaveChartMass: TCheckBox;
    bbEditorMass: TBitBtn;
    chkCasheOn: TCheckBox;
    Image1: TImage;
    grpOpenMass: TGroupBox;
    bbOpenSMass: TBitBtn;
    bbPasteSMass: TBitBtn;
    Panel9: TPanel;
    chkOSBlineChrom: TCheckBox;
    chrBHistoChrom: TChart;
    srsHistoChrom: TLineSeries;
    ChartTool2: TCursorTool;
    rgXUnitsMass: TRadioGroup;
    srs3D: TWaterFallSeries;
    GroupBox6: TGroupBox;
    chkFixYChrom: TCheckBox;
    rbAbsYChrom: TRadioButton;
    rbPercYChrom: TRadioButton;
    GroupBox8: TGroupBox;
    chkFixYMass: TCheckBox;
    rbAbsYMass: TRadioButton;
    rbPercYMass: TRadioButton;
    btnForcedCashe: TButton;
    SaveDialog2: TSaveDialog;
    sePeakHeightMass: TBMDSpinEdit;
    seTSBlineMass: TBMDSpinEdit;
    sePeakAreaChrom: TBMDSpinEdit;
    sePeakHeightChrom: TBMDSpinEdit;
    seTSBlineChrom: TBMDSpinEdit;
    sePeakDistChrom: TBMDSpinEdit;
    sePeakDistMass: TBMDSpinEdit;
    seSGDegreeChrom: TSpinEdit;
    seSGDegreeMass: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    sePeakSenseChrom: TSpinEdit;
    sePeakSenseMass: TSpinEdit;
    sePeakAreaMass: TBMDSpinEdit;
    procedure tbChromClick(Sender: TObject);
    procedure tbCommonClick(Sender: TObject);
    procedure tbMassClick(Sender: TObject);
    procedure PropToolBarResize(Sender: TObject);
    procedure tbMassMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbChromMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FrameResize(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure bbEditorChromClick(Sender: TObject);
    procedure bbEditorMassClick(Sender: TObject);
    procedure bbUpdateRangesMassClick(Sender: TObject);
    procedure bbClearRangesMassClick(Sender: TObject);
    procedure bbClearRangesChromClick(Sender: TObject);
    procedure bbUpdateRangesChromClick(Sender: TObject);
    procedure chkAutoTSMassClick(Sender: TObject);
    procedure chkAutoTSChromClick(Sender: TObject);
    procedure srsMassGetMarkText(Sender: TChartSeries; ValueIndex: Integer;
      var MarkText: String);
    procedure btnClearClick(Sender: TObject);
    procedure chkAcqModeClick(Sender: TObject);
    procedure chkMassModeClick(Sender: TObject);
    procedure sgRangesChromKeyPress(Sender: TObject; var Key: Char);
    procedure sgRangesMassKeyPress(Sender: TObject; var Key: Char);
    procedure actBLineChromExecute(Sender: TObject);
    procedure actSmoothChromExecute(Sender: TObject);
    procedure actPeaksChromExecute(Sender: TObject);
    procedure actSmoothMassExecute(Sender: TObject);
    procedure actBLineMassExecute(Sender: TObject);
    procedure actPeaksMassExecute(Sender: TObject);
    procedure actDataTableChromExecute(Sender: TObject);
    procedure actDataTableMassExecute(Sender: TObject);
    procedure chrChromtbDataTableMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chrMasstbDataTableMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure seSGDegreeChromChange(Sender: TObject);
    procedure seSGDegreeMassChange(Sender: TObject);
    procedure sgRangesChromSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure pcDimentionsChange(Sender: TObject);
    procedure chkDimTabsClick(Sender: TObject);
    procedure rgDimsClick(Sender: TObject);
    procedure rgXUnitsChromClick(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure chrChromtbAutoYClick(Sender: TObject);
    procedure chrMasstbAutoYClick(Sender: TObject);
    procedure chrMasschrChartMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chrMasschrChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bbSaveAsTmlClick(Sender: TObject);
    procedure bbSaveAsDataClick(Sender: TObject);
    procedure chrChromchrChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bbOpenDataClick(Sender: TObject);
    procedure bbOpenTmlClick(Sender: TObject);
    procedure pmClearClick(Sender: TObject);
    procedure pmMassOnlyClick(Sender: TObject);
    procedure pmFillClick(Sender: TObject);
    procedure chrChromtbZoomModeClick(Sender: TObject);
    procedure chrMasstbZoomModeClick(Sender: TObject);
    procedure rgYUnitsMassClick(Sender: TObject);
    procedure rgChromatogramClick(Sender: TObject);
    procedure chrMasstlbrManipMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chkCasheOnClick(Sender: TObject);
    procedure bbPasteSMassClick(Sender: TObject);
    procedure rgXUnitsMassClick(Sender: TObject);
    procedure chkFixYChromClick(Sender: TObject);
    procedure chkFixYMassClick(Sender: TObject);
    procedure btnForcedCasheClick(Sender: TObject);
  private
    { Private declarations }
    fDocked: Boolean;
    fTmplName: string;
    fWhatVis: tWhatVis;
    VisRatio: byte; // in percents
    fGardeRatio: Boolean;
    fAcqMode: Boolean;

    fMassOnly: Boolean;
    fNumber: Integer;
    fCaption: string;
    CGTimeMark: real;
    fSpOpt: tSpOpt;
    srsT1, srsT2, srsTR: TChartSeries;

    function GetCMass: tXYarray;
    procedure SetCMass(Value: tXYarray);
    procedure SetGardeRatio(Value: Boolean);
    procedure SetAcqMode(Value: Boolean);
    procedure SetMassOnly(Value: Boolean);
    procedure SetDocked(Value: Boolean);
    procedure SetWhatVis(Value: tWhatVis);
    function GetNumber: Integer;
    procedure SetNumber(Value: Integer);
    procedure SetCaption(Value: string);
    function ProcSMass(InXY: tXYarray; var OutXY: tXYarray): Boolean;
    function AccumulSMass(var OutXY: tXYarray): Boolean;
    function ProcChrom(InXY: tXYarray; var OutXY: tXYarray): Boolean;
    function AccumulChrom(var OutXY: tXYarray): Boolean;
    function ShowTIC: Boolean;
    procedure UpdateOptions(CM: Boolean);
    procedure SetChromVisual;
    procedure SetMassVisual;
    procedure MarksAdjusting;
    procedure AdaptivePeaking;
    procedure SetSpOpt(Value: tSpOpt);
    function GetTmplName: string;

    procedure OnSelectChrom(Sender: TObject; Idx: Integer);
    procedure OnSelectMass(Sender: TObject; Idx: Integer);

  public
    { Public declarations }
    Spec: TSpec; // internal raw data buffer
    srsChrom: TLineSeries;
    srsMass: TVolumeSeries;
    LastMassIdx: Integer; // current mass-spec index
    DockedPlace: TWinControl;
    PlotShell: TForm;
    DataStmN: Integer; // index of synchro data stream
    tbDataStream: TToolButton;
    // the way to uncheck the tbOscilo button when Data channel is cut

    property SpOpt: tSpOpt read fSpOpt write SetSpOpt; // template options
    property TmplName: string read GetTmplName;
    property CMass: tXYarray read GetCMass // give out current raw mass-spec;
      write SetCMass; // or accept external mass-spec in MassOnly mode
    property Number: Integer read GetNumber write SetNumber default -1;
    // = PlotShell.Tag
    property Caption: string read fCaption write SetCaption;
    property GardeRatio: Boolean read fGardeRatio write SetGardeRatio
      default true;
    // keep ratio Chrom/Mass panel when resize
    property Docked: Boolean read fDocked write SetDocked;
    property WhatVis: tWhatVis read fWhatVis write SetWhatVis;
    // what panel(s) is visible
    property AcqMode: Boolean read fAcqMode write SetAcqMode default false;
    // acquisition mode - no processing
    property MassOnly: Boolean read fMassOnly write SetMassOnly default false;

    function Initialise(tml: string): Boolean;
    procedure SetIniPos; // initialize spec cursors
    procedure UpdateFromOptions;
    function IsEmpty: Boolean; // check if it is empty
    function OpenData(iFilename: string): Boolean;
    function SaveData(iFilename: string): Boolean;
    function AddSrsSpec(Rt: double; srsIn: TChartSeries): Boolean;
    // Rt is ALWAYS in sec.
    function AddArrSpec(Rt: double; arrIn: tXYarray): Boolean;
    function ShowSMass(Idx: Integer): Boolean;
    procedure RefreshPlot;
    procedure Clear;
    destructor Destroy; override;
  end;

procedure Register;

implementation

{$R *.DFM}

uses SpMathU, PeakU, AboutU;

function TfrmPlot.GetCMass: tXYarray;
begin
  if fMassOnly then
    Result := Spec.CMass
  else
  begin
    if (LastMassIdx < 0) or (LastMassIdx > Spec.NSpec) then
      exit;
    Result := Spec.Mass[LastMassIdx];
  end;
end;

procedure TfrmPlot.SetCMass(Value: tXYarray);
// create a copy of Value in fCMass
var
  i, j: Integer;
begin
  if not fMassOnly then
    exit;
  SetLength(Spec.CMass, length(Value));
  for i := 0 to length(Value) - 1 do
    Spec.CMass[i] := Value[i];
  if MassOnly then
    ShowSMass(-1);
end;

procedure TfrmPlot.SetGardeRatio(Value: Boolean);
begin
  fGardeRatio := Value;
  if (fWhatVis <> wvBoth) or not Value then
    exit;
  pnlChrom.Height := round(Height * VisRatio / 100);
end;

procedure TfrmPlot.SetAcqMode(Value: Boolean);
var
  bb: Boolean;
begin
  bb := fAcqMode;
  fAcqMode := Value;
  if not bb and Value then
    Clear; // switching from proc. to acq. clear
  if bb and not Value then
    SetIniPos; // switching from acq. to proc.
  if fAcqMode then
  begin
    pcChrom.Visible := false;
    pcMass.Visible := false;
    pcCommon.Visible := false;
  end;
  chrChrom.AcqMode := fAcqMode;
  chrMass.AcqMode := fAcqMode;
  chrMass.ChartCursor.Active := false;
  chrMass.tbRangeMode.Enabled := not fAcqMode and not MassOnly;
  PropToolBar.Visible := not fAcqMode;
  chrMass.ctlNearest.Active := not fAcqMode;
  if tbDataStream <> nil then
    tbDataStream.Down := fAcqMode;
end; { TfrmPlot.SetAcqMode }

procedure TfrmPlot.SetMassOnly(Value: Boolean);
var
  XY: tXYarray;
begin
  if Value = fMassOnly then
    exit; // chrMass.ctlNearest.Active:= false;
  if Value and not fMassOnly then
    XY := CMass;
  Clear;
  fMassOnly := Value;
  if fMassOnly then
    WhatVis := wvMass
  else
    WhatVis := wvBoth;
  tbChrom.Enabled := not fMassOnly;
  Splitter1.Visible := not fMassOnly;
  chrMass.tbRangeMode.Enabled := not fMassOnly;
  bbClearRangesMass.Enabled := not fMassOnly;
  bbUpdateRangesMass.Enabled := not fMassOnly;
  grpOpenMass.Visible := fMassOnly;
  Spec.MassOnly := fMassOnly;
  SpOpt.MassOnly := fMassOnly;
  tbChrom.Marked := false;
  pmMassOnly.Checked := fMassOnly;
  if not fMassOnly then
    pcCommon.Visible := false;
  if length(XY) > 1 then
  begin
    CMass := XY;
    RefreshPlot;
    chrMass.ctlNearest.Active := not AcqMode;
  end;
end; { TfrmPlot.SetMassOnly }

function TfrmPlot.Initialise(tml: string): Boolean;
// tml='' then get defaults
var
  i: Integer;
  ss, st, sq, stml: string;
begin
  Result := false;
  LastMassIdx := -1; // chrMass.ctlNearest.Active:= false;
  // data/spec buffers
  if not Assigned(Spec) then
  begin
    Spec := TSpec.Create;
    Spec.Initialise;
    Spec.Number := Number;
  end;
  DecimalSeparator := '.';
  srsChrom := TLineSeries(chrChrom.chrChart.Series[0]);
  srsMass := TVolumeSeries(chrMass.chrChart.Series[1]);
  srsChrom.OnGetMarkText := srsMassGetMarkText;
  srsMass.OnGetMarkText := srsMassGetMarkText;
  if Assigned(Spec) then
  begin
    Spec.RefreshPlot := RefreshPlot;
    Spec.AutoRefresh := true;
  end;
  // set charts
  chrChrom.sgRanges := sgRangesChrom;
  chrMass.sgRanges := sgRangesMass;
  chrChrom.srsSpec := srsChrom;
  chrMass.srsSpec := srsMass;
  chrChrom.Initialise(true);
  chrMass.Initialise(false);
  chrChrom.OnSelect := OnSelectChrom;
  chrMass.OnSelect := OnSelectMass;
  pcChrom.ActivePageIndex := 0;
  pcMass.ActivePageIndex := 0;
  SetChromVisual;
  SetMassVisual;

  fWhatVis := wvBoth;
  VisRatio := 40;
  GardeRatio := true;

  ts2D.TabVisible := false;
  ts3D.TabVisible := false;
  with sgRangesChrom do
  begin
    ColWidths[2] := 22;
    Cells[2, 0] := 'W';
  end;
  with sgRangesMass do
  begin
    ColWidths[2] := 22;
    Cells[0, 0] := 'Start m/z';
    Cells[1, 0] := 'End m/z';
    Cells[2, 0] := 'W';
  end;

  pcDimentions.ActivePageIndex := 0;
  // ini file dealing
  if (tml = '') or (tml = '<none>') or
    (LowerCase(ExtractFileName(tml)) = 'empty.tml') then
    st := '<none>'
  else
  begin
    stml := tml;
    if ExtractFileExt(tml) = '' then
      sq := ChangeFileExt(stml, '.tml')
    else
      sq := stml;
    if ExtractFilePath(tml) <> '' then
      st := sq
    else
      st := GetConfigPath + sq;
  end;
  if Assigned(fSpOpt) then
    fSpOpt.Free;
  if st = '<none>' then
    fSpOpt := tSpOpt.Create(GetConfigPath + 'empty.tml')
  else
    fSpOpt := tSpOpt.Create(st);
  fSpOpt.Open(nil);
  UpdateFromOptions;
  chrChrom.SpOpt := fSpOpt;
  chrMass.SpOpt := fSpOpt;
  chrChrom.ZoomMode := true;
  chrMass.ZoomMode := true;
  if MyPriority then
  begin
    chrChrom.tlbrManip.PopupMenu := PopupMenu1;
    chrMass.tlbrManip.PopupMenu := PopupMenu1;
  end;
  gbAsTemplate.Caption := ' Base Template (' + ExtractFileName(st) + ')';
  rgChromatogram.ItemIndex := 0;
  if st = '<none>' then
    fTmplName := ''
  else
    fTmplName := st;
  AcqMode := false;
  DataStmN := -1;
  Result := true;
end; { TfrmPlot.Initialise }

procedure TfrmPlot.SetIniPos;
var
  i, j: Integer;
  m: double;
begin
  if not MassOnly then
    ShowTIC;
  j := 0;
  m := 0;
  for i := 0 to Spec.NSpec - 1 do
    if Spec.Chrom[i, Y] > m then
    begin
      m := Spec.Chrom[i, Y];
      j := i;
    end;
  ShowSMass(j);
  if not chrChrom.IsEmpty then
    chrChrom.ChartCursor.XValue := srsChrom.XValue[j];
  Application.ProcessMessages;
  chrMass.chrChart.UndoZoom;
  Application.ProcessMessages;
end;

function TfrmPlot.IsEmpty: Boolean;
begin
  Result := chrChrom.IsEmpty and chrMass.IsEmpty;
end;

procedure TfrmPlot.Clear;
begin
  bbClearRangesChromClick(nil);
  bbClearRangesMassClick(nil);
  Spec.Clear;
  LastMassIdx := -1;
  with chrChrom do
  begin
    Peaks.Clear;
    srsSpec.Clear;
    chrChart.Title.Text.Clear;
    chrChart.SubTitle.Text.Clear;
  end;
  with chrMass do
  begin
    Peaks.Clear;
    ctlNearest.Active := false;
    srsSpec.Clear;
    chrChart.Title.Text.Clear;
    chrChart.SubTitle.Text.Clear;
  end;
end;

destructor TfrmPlot.Destroy;
begin
  if chkSaveTemplate.Checked then
  begin
    if chkSaveChartChrom.Checked then
    begin
      if chkSaveChartChrom.Checked then
      begin
        if SpOpt.oChrom.Visual.TeeFile = '' then
          SpOpt.oChrom.Visual.TeeFile := ChangeFileExt(SpOpt.FileName, '.cvw');
        chrChrom.SaveToTemplate(SpOpt.oChrom.Visual.TeeFile);
      end;
      if chkSaveChartMass.Checked then
      begin
        if SpOpt.oMass.Visual.TeeFile = '' then
          SpOpt.oMass.Visual.TeeFile := ChangeFileExt(SpOpt.FileName, '.mvw');
        chrMass.SaveToTemplate(SpOpt.oMass.Visual.TeeFile);
      end;
    end;
    if ExtractFileName(SpOpt.FileName) <> 'empty.tml' then
      SpOpt.Save;
  end;
  chrChrom.Peaks.Free;
  chrMass.Peaks.Free;
  Spec.Clear;
  Spec.Free;
  SpOpt.Free;
  inherited Destroy;
end; { TfrmPlot.Destroy }

function TfrmPlot.AddSrsSpec(Rt: double; srsIn: TChartSeries): Boolean;
var
  i, j: Integer;
  arr: tXYarray;
begin
  Result := false;
  j := srsIn.Count;
  SetLength(arr, j);
  for i := 0 to j - 1 do
  begin
    arr[i, X] := srsIn.XValue[i];
    arr[i, Y] := srsIn.YValue[i];
  end;
  Result := AddArrSpec(Rt, arr);
end;

function TfrmPlot.AddArrSpec(Rt: double; arrIn: tXYarray): Boolean;
var
  i, j: Integer;
  a: double;
begin
  a := 0;
  j := Spec.NSpec;
  for i := low(arrIn) to high(arrIn) do
    a := a + arrIn[i, Y]; // TIC
  Result := Spec.AddSSpec(Rt, a, arrIn) = j;
end;

procedure TfrmPlot.RefreshPlot;
begin
  if not Spec.AutoRefresh then
    exit;
  if not fMassOnly then
    ShowTIC;
  ShowSMass(-1);
  chrMass.ctlNearest.Active := not AcqMode;
end;

procedure TfrmPlot.OnSelectChrom(Sender: TObject; Idx: Integer);
begin
  ShowSMass(Idx);
  if (LastMassIdx < 0) or (not chrChrom.ZoomMode) or (Idx < 0) then
    chrChrom.Hint := ''
  else
    chrChrom.Hint := '|GC ret.time [s] = ' + srsChrom.GetHorizAxis.LabelValue
      (Spec.Chrom[Idx, X]);
end;

procedure TfrmPlot.OnSelectMass(Sender: TObject; Idx: Integer);
begin
  if not Assigned(SpOpt) then
    exit;
  ShowTIC;
  if SpOpt.oMass.Peak.Enabled and (SpOpt.oMass.Peak.Method = 2) then
  begin
    Application.ProcessMessages;
    AdaptivePeaking;
    Application.ProcessMessages;
  end;
end;

/// ////////////////////////////////////////////////////////////////////////
procedure TfrmPlot.MarksAdjusting;
var
  i, j, hg, pxl, pxr, pyu, pyd: Integer;
begin
  if chrMass.Peaks.Count < 2 then
    exit;
  for i := 0 to srsMass.Marks.Positions.Count - 1 do
  begin
    srsMass.Marks.Positions.Automatic(i);
    if srsMass.Marks.Positions[i] <> nil then
      srsMass.Marks.Positions[i].Custom := false;
  end;
  chrMass.Repaint;
  for i := 1 to chrMass.Peaks.Count - 1 do
  begin
    if (srsMass.Marks.Positions[chrMass.Peaks[i - 1].Index] = nil) or
      (srsMass.Marks.Positions[chrMass.Peaks[i].Index] = nil) then
      continue;
    with srsMass.Marks.Positions[chrMass.Peaks[i - 1].Index] do
    begin
      hg := srsMass.Marks.Positions[chrMass.Peaks[i - 1].Index].Height;
      pxl := LeftTop.X;
      pxr := LeftTop.X + Width;
      pyu := LeftTop.Y;
      pyd := LeftTop.Y + hg;
    end;
    with srsMass.Marks.Positions[chrMass.Peaks[i].Index] do
      if (LeftTop.X < pxr) then
      begin
        if (LeftTop.Y < pyd) and (LeftTop.Y > pyu) then
        begin
          Custom := true;
          LeftTop.Y := LeftTop.Y + hg;
          ArrowTo.Y := ArrowTo.Y + hg;
        end;
        if ((LeftTop.Y + hg) <= pyd) and ((LeftTop.Y + hg) >= pyu) then
        begin
          Custom := true;
          LeftTop.Y := LeftTop.Y - hg;
          ArrowTo.Y := ArrowTo.Y - hg;
        end;
      end;
  end;
end; { TfrmPlot.MarksAdjusting }

procedure TfrmPlot.AdaptivePeaking;
var
  i, j, k, l, m, n, Idx, fnt, pidx, px, py, fc, szx, szy: Integer;
  wPeak: tPeak;
  a, b, c: double;
begin
  chrMass.Peaks.Clear;
  chrMass.Repaint;
  i := -1;
  Idx := i;
  l := i;
  if srsMass.Count = 0 then
    exit;
  szx := 6 * srsMass.Marks.Font.Size;
  szy := 2 * srsMass.Marks.Font.Size;
  a := -9999;
  with srsMass do // the first peak
  begin
    repeat
      if i = (Count - 1) then
        break
      else
        inc(i);
      j := CalcXSizeValue(abs(XValues[l] - XValues[i]));
      if YValues[i] > a then
      begin
        Idx := i;
        a := YValues[i];
      end;
    until (j > (szx / 2)); // half mark
    wPeak.Index := Idx;
    wPeak.X := XValues[Idx];
    wPeak.Y := YValues[Idx];
    chrMass.Peaks.Add(wPeak);
    pidx := Idx; //
  end;
  a := -9999; // Memo1.Lines.Add(inttostr(i)+'===');
  with srsMass do
    while i < Count - 1 do
    begin
      l := Idx + 1;
      a := -9999;
      if CalcXSizeValue(abs(XValues[i + 1] - XValues[i])) > (szx / 1.5) then
      begin
        Idx := i + 1;
        wPeak.Index := Idx;
        wPeak.X := XValues[Idx];
        wPeak.Y := YValues[Idx];
        chrMass.Peaks.Add(wPeak);
        pidx := Idx;
        inc(i);
        continue;
      end;
      repeat
        if i = (Count - 1) then
          break
        else
          inc(i);
        if YValues[i] > a then
        begin
          Idx := i;
          a := YValues[i];
        end;
        j := CalcXSizeValue(abs(XValues[l] - XValues[i])); // skip half mark
      until (j > (szx / 1.5));
      if CalcYSizeValue(abs(YValues[pidx] - YValues[Idx])) > szy then
      begin
        wPeak.Index := Idx;
        wPeak.X := XValues[Idx];
        wPeak.Y := YValues[Idx];
        chrMass.Peaks.Add(wPeak);
        pidx := Idx;
        // Memo1.Lines.Add(inttostr(l)+'/'+inttostr(i)+' in'); continue;
      end;
      l := i;
      repeat
        if i = (Count - 1) then
          break
        else
          inc(i);
        if YValues[i] > a then
        begin
          Idx := i;
          a := YValues[i];
        end;
        j := CalcXSizeValue(abs(XValues[l] - XValues[i]));
        // condition for the next mark/peak
      until (j > szx);
      dec(i); // Memo1.Lines.Add(inttostr(j));

      wPeak.Index := Idx;
      wPeak.X := XValues[Idx];
      wPeak.Y := YValues[Idx];
      chrMass.Peaks.Add(wPeak);
      pidx := Idx;
      inc(i);
    end;
end; { TfrmPlot.AdaptivePeaking }

function TfrmPlot.ProcSMass(InXY: tXYarray; var OutXY: tXYarray): Boolean;
var
  i, j, k, m, sz: Integer;
  XY: array [0 .. 10] of tXYarray;
  ss: string;
begin
  XY[0] := InXY;
  k := 0;
  Result := false;
  ss := '';
  if SpOpt.oMass.Smooth.Enabled then
  begin
    Smoothing(XY[k], false, SpOpt, XY[k + 1]);
    inc(k);
    ss := ss + 'S';
  end;
  if SpOpt.oMass.BLine.Enabled then
  begin
    BLine(XY[k], false, SpOpt, XY[k + 1]);
    inc(k);
    ss := ss + 'B';
  end;
  if SpOpt.oMass.Visual.XUnits = 1 then
  begin
    ToNomMass(XY[k], XY[k + 1]);
    inc(k);
    ss := ss + 'N';
  end;
  if SpOpt.oMass.Peak.Enabled then
  begin
    ss := ss + 'P';
    if SpOpt.oMass.Peak.Method <> 2 then
      Peaking(XY[k], false, SpOpt, chrMass.Peaks, XY[k + 1]);
    if chkSeeFDMass.Checked and (SpOpt.oMass.Peak.Method = 1) then
      inc(k);
    m := round(LowerOrder(srsMass.YValues.MaxValue) / 100);
    if m > 0 then
      sePeakHeightMass.Increment := m;
    sePeakAreaMass.Increment := sePeakHeightMass.Increment;
  end;
  chrMass.lbAcq.Caption := ss;
  sz := length(XY[k]);
  SetLength(OutXY, sz);
  for i := 0 to sz - 1 do
    OutXY[i] := XY[k][i];
  Result := true;
end; { TfrmPlot.ProcSMass }

function TfrmPlot.AccumulSMass(var OutXY: tXYarray): Boolean;
var
  i, j, k, m, sz, lb, rb, rn: Integer;
  sa, wMass: tXYarray;
begin
  k := 0;
  lb := 9999;
  rb := 0;
  Result := false;
  if chrChrom.RangeNumber > 0 then
    for j := 0 to srsChrom.Count - 1 do // boundaries
    begin
      rn := chrChrom.IsInside(srsChrom.XValues[j]);
      if rn > 0 then
      begin
        wMass := Spec.Mass[j];
        SetLength(sa, length(sa) + 1);
        sa[k, X] := j;
        val(sgRangesChrom.Cells[2, rn], sa[k, Y], i);
        if i > 0 then
          sa[k, Y] := 1;
        inc(k);
        i := low(wMass);
        m := round(wMass[i, X]);
        if m < lb then
          lb := m;
        i := high(wMass);
        m := round(wMass[i, X]);
        if m > rb then
          rb := m;
      end;
    end;
  if (lb = 9999) and (rb = 0) then // in a case nothing found
  begin
    lb := low(Spec.Mass[0]);
    rb := high(Spec.Mass[0]);
  end;

  sz := rb - lb + 1;
  if k = 0 then
    sz := 100; // redim OutXY
  SetLength(OutXY, sz);
  for i := 0 to sz - 1 do
  begin
    OutXY[i, Y] := 0;
    OutXY[i, X] := lb + i;
  end;
  if k = 0 then
    exit;
  for j := low(sa) to high(sa) do
  begin
    k := round(sa[j, X]);
    wMass := Spec.Mass[k];
    for i := low(wMass) to high(wMass) do
    begin
      m := round(wMass[i, X]) - lb;
      OutXY[m, Y] := OutXY[m, Y] + wMass[i, Y] * sa[j, Y];
      if OutXY[m, Y] < 0 then
        OutXY[m, Y] := 0;
    end;
  end;
  Result := true;
end; { TfrmPlot.AccumulSMass }

function TfrmPlot.ShowSMass(Idx: Integer): Boolean; // Idx=-1 gets last used idx
var
  i, j, k, m, n, ns: Integer;
  XY0, XY: tXYarray;
  mm, mn: real;
  wSrs: TChartSeries;
  nss: string;
begin
  Result := false;
  if Idx = -1 then
  begin
    if AcqMode then
      k := Spec.NSpec - 1
    else
      k := LastMassIdx
  end
  else
    k := Idx;
  if ((k < 0) or (k > (Spec.NSpec - 1))) and not MassOnly then
    exit;
  LastMassIdx := k;
  Screen.Cursor := crHourGlass;
  if MassOnly then
  begin
    if Spec.SplitOn = 0 then
    begin
      XY0 := Spec.CMass; // normal way
      if chrMass.chrChart.SeriesCount > 1 then
      begin
        FreeAndNil(srsT1);
        FreeAndNil(srsT2);
        FreeAndNil(srsTR);
        chrMass.chrChart.FreeAllSeries(TFastLineSeries);
      end;
    end
    else
    begin
      nss := IntToStr(Spec.SplitOn); // splitted way
      if length(nss) = 1 then
        nss := '00' + nss;
      if length(nss) = 2 then
        nss := '0' + nss;
      ns := 0;
      for i := 1 to 3 do
        if nss[i] = '1' then
          inc(ns);
      m := round(length(Spec.CMass) / ns);
      if ns = 0 then
      begin
        FreeAndNil(srsT1);
        FreeAndNil(srsT2);
        FreeAndNil(srsTR);
        chrMass.chrChart.FreeAllSeries(TFastLineSeries);
        exit;
      end;
      if srsMass.Count > 0 then
        srsMass.Clear;
      i := 0;
      if nss[3] = '1' then
      begin
        if not Assigned(srsT1) then
        begin
          srsT1 := chrMass.chrChart.AddSeries(TVolumeSeries);
          srsT1.SeriesColor := clRed;
        end;
        srsT1.BeginUpdate;
        srsT1.Clear;
        for j := i * m to (i + 1) * m - 1 do
          if (Spec.CMass[j, X] <> 0) or (Spec.CMass[j, Y] <> 0) then
            srsT1.AddXY(Spec.CMass[j, X], Spec.CMass[j, Y]);
        inc(i);
        srsT1.EndUpdate;
      end
      else if Assigned(srsT1) then
      begin
        chrMass.chrChart.RemoveSeries(srsT1);
        FreeAndNil(srsT1);
      end;
      if nss[2] = '1' then
      begin
        if not Assigned(srsT2) then
        begin
          srsT2 := chrMass.chrChart.AddSeries(TVolumeSeries);
          srsT2.SeriesColor := clNavy;
        end;
        srsT2.BeginUpdate;
        srsT2.Clear;
        for j := i * m to (i + 1) * m - 1 do
          if (Spec.CMass[j, X] <> 0) or (Spec.CMass[j, Y] <> 0) then
            srsT2.AddXY(Spec.CMass[j, X], Spec.CMass[j, Y]);
        inc(i);
        srsT2.EndUpdate;
      end
      else if Assigned(srsT2) then
      begin
        chrMass.chrChart.RemoveSeries(srsT2);
        FreeAndNil(srsT2);
      end;
      if nss[1] = '1' then
      begin
        if not Assigned(srsTR) then
        begin
          srsTR := chrMass.chrChart.AddSeries(TVolumeSeries);
          srsTR.SeriesColor := clGreen;
        end;
        srsTR.BeginUpdate;
        srsTR.Clear;
        for j := i * m to (i + 1) * m - 1 do
          if (Spec.CMass[j, X] <> 0) or (Spec.CMass[j, Y] <> 0) then
            srsTR.AddXY(Spec.CMass[j, X], Spec.CMass[j, Y]);
        inc(i);
        srsTR.EndUpdate;
      end
      else if Assigned(srsTR) then
      begin
        chrMass.chrChart.RemoveSeries(srsTR);
        FreeAndNil(srsTR);
      end;
      Result := true;
      Screen.Cursor := crDefault;
      exit;
    end;
  end
  else
  begin // chrom mode
    if chrChrom.ZoomMode then
      XY0 := Spec.Mass[k]
    else
    begin
      AccumulSMass(XY0);
      if not MassOnly then
        Spec.CMass := XY0;
    end;
  end;
  if fAcqMode then
    XY := XY0
  else
    ProcSMass(XY0, XY);
  if SpOpt.oMass.BLine.AutoTS and SpOpt.oMass.BLine.Enabled then
    seTSBlineMass.Value := SpOpt.oMass.BLine.Threshold;
  srsMass.Marks.Visible := SpOpt.oMass.Peak.Enabled;
  if length(XY) = 0 then
  begin
    srsMass.Clear;
    srsMass.AddXY(0, 0);
    srsMass.AddXY(1, 0);
    if (rgShowMass.ItemIndex > 0) and not fAcqMode then
      chrMass.UpdateDataTable;
    Result := true;
    Screen.Cursor := crDefault;
    exit;
  end;
  srsMass.BeginUpdate;
  srsMass.Clear;
  mm := -9999;
  mn := 9999;
  if SpOpt.oMass.Visual.YUnits then
    for i := low(XY) to high(XY) do
    begin
      if XY[i, Y] < mn then
        mn := XY[i, Y];
      if XY[i, Y] > mm then
        mm := XY[i, Y];
    end;
  for i := low(XY) to high(XY) do
    if SpOpt.oMass.Visual.YUnits then
    begin
      if mm = mn then
        srsMass.AddXY(XY[i, X], mm)
      else
        srsMass.AddXY(XY[i, X], 100 * XY[i, Y] / mm);
    end
    else
      srsMass.AddXY(XY[i, X], XY[i, Y]);
  srsMass.EndUpdate;
  if (rgShowMass.ItemIndex > 0) and not fAcqMode then
    chrMass.UpdateDataTable;
  if not MassOnly then
  begin
    if chrChrom.tbZoomMode.Down then
      lbRetTime.Caption := 'Ret.Time= ' +
        MyFloatToStr(Spec.Chrom[LastMassIdx, X])
    else
      lbRetTime.Caption := 'Ret.Time= <multi-range>';
  end;
  if not fAcqMode then
  begin // chrMass.ctlNearest.Active:= false;
    lbNPointsMass.Caption := 'N.Points= ' + IntToStr(length(XY));
    lbFromMass.Caption := 'From ' +
      MyFloatToStr(round(srsMass.XValues.MinValue * 10) / 10);
    lbToMass.Caption := 'To ' + MyFloatToStr
      (round(srsMass.XValues.MaxValue * 10) / 10) + ' [m/z]';
    chrMass.ZoomMode := chrMass.ZoomMode;
    if (SpOpt.oMass.Peak.Method = 2) and SpOpt.oMass.Peak.Enabled then
    begin
      AdaptivePeaking;
      srsMass.Repaint; // MarksAdjusting;
    end;
    lbTotalMass.Caption := 'Total= ' + MyFloatToStr(srsMass.YValues.Total);
    lbNPeaksMass.Caption := 'N.Peaks= ' + IntToStr(chrMass.Peaks.Count);
  end;
  Result := true;
  Screen.Cursor := crDefault;
end; { TfrmPlot.ShowSMass }

function TfrmPlot.ProcChrom(InXY: tXYarray; var OutXY: tXYarray): Boolean;
var
  i, j, k, sz, m: Integer;
  XY: array [0 .. 10] of tXYarray;
  ss: string;
begin
  XY[0] := InXY;
  k := 0;
  ss := '';
  if SpOpt.oChrom.Smooth.Enabled then
  begin
    Smoothing(XY[k], true, SpOpt, XY[k + 1]);
    inc(k);
    ss := ss + 'S';
  end;
  if SpOpt.oChrom.BLine.Enabled then
  begin
    BLine(XY[k], true, SpOpt, XY[k + 1]);
    inc(k);
    ss := ss + 'B';
  end;
  if SpOpt.oChrom.Peak.Enabled then
  begin
    Peaking(XY[k], true, SpOpt, chrChrom.Peaks, XY[k + 1]);
    ss := ss + 'P';
    if chkSeeFDChrom.Checked and (SpOpt.oChrom.Peak.Method = 1) then
      inc(k);
    m := round(LowerOrder(srsChrom.YValues.MaxValue) / 100);
    if m > 0 then
      sePeakHeightChrom.Increment := m;
    sePeakAreaChrom.Increment := sePeakHeightChrom.Increment;
  end;
  chrChrom.lbAcq.Caption := ss;
  sz := length(XY[k]);
  SetLength(OutXY, sz);
  for i := 0 to sz - 1 do
    OutXY[i] := XY[k][i];
end; { TfrmPlot.ProcChrom }

function TfrmPlot.AccumulChrom(var OutXY: tXYarray): Boolean;
var
  i, j, k, l, sz, rn: Integer;
  sa, wMass: tXYarray;
  a, lf, Rt: single;
begin
  sz := length(Spec.Chrom);
  rn := 0;
  lf := 0;
  Rt := 0;
  SetLength(OutXY, sz);
  for i := 0 to sz - 1 do
  begin
    OutXY[i, X] := Spec.Chrom[i, X];
    OutXY[i, Y] := 0;
  end;
  if chrMass.RangeNumber = 0 then
    exit;
  for i := 0 to sz - 1 do
  begin
    wMass := Spec.Mass[i];
    for j := 0 to length(wMass) - 1 do
    begin
      rn := chrMass.IsInside(wMass[j, X]);
      if rn > 0 then
      begin
        val(sgRangesMass.Cells[2, rn], a, k);
        if k > 0 then
          a := 1;
        OutXY[i, Y] := OutXY[i, Y] + wMass[j, Y] * a;
        if OutXY[i, Y] < 0 then
          OutXY[i, Y] := 0;
      end;
    end;
  end;
end; { TfrmPlot.AccumulChrom }

function TfrmPlot.ShowTIC: Boolean;
var
  i, j, k: Integer;
  XY0, XY: tXYarray;
  a: real;
begin
  Result := false;
  try
    if Spec = nil then
      exit;
    if Spec.NSpec = 0 then
      exit;
    Screen.Cursor := crHourGlass;
    if chrMass.tbZoomMode.Down then
    begin
      SetLength(XY0, Spec.NSpec);
      for i := 0 to Spec.NSpec - 1 do
        XY0[i, X] := Spec.Chrom[i, X];
      for i := 0 to Spec.NSpec - 1 do
        if rgChromatogram.ItemIndex = 0 then
          XY0[i, Y] := Spec.Chrom[i, Y]
        else
        begin
          a := -9999;
          for j := low(Spec.Mass[i]) to high(Spec.Mass[i]) do
            if a < Spec.Mass[i][j, Y] then
              a := Spec.Mass[i][j, Y];
          XY0[i, Y] := a;
        end;
    end
    else
      AccumulChrom(XY0);
    if SpOpt.oChrom.Visual.YUnits then
    begin
      a := MaxXYarray(Spec.Chrom)[Y];
      if a = 0 then
        exit;
      for i := 0 to Spec.NSpec - 1 do
        XY0[i, Y] := 100 * XY0[i, Y] / a;
    end;
    if AcqMode then
      XY := XY0
    else
      ProcChrom(XY0, XY);
    if SpOpt.oChrom.BLine.AutoTS and SpOpt.oChrom.BLine.Enabled then
      seTSBlineChrom.Value := SpOpt.oChrom.BLine.Threshold;
    srsChrom.Marks.Visible := SpOpt.oChrom.Peak.Enabled;
    srsChrom.BeginUpdate;
    srsChrom.Clear;
    for i := 0 to Spec.NSpec - 1 do
      case SpOpt.oChrom.Visual.XUnits of
        0:
          srsChrom.AddXY(i, XY[i, Y]);
        1:
          srsChrom.AddXY(XY[i, X], XY[i, Y]);
        2:
          srsChrom.AddXY(XY[i, X] / 60, XY[i, Y]);
      end;
    srsChrom.EndUpdate;
    if rgShowChrom.ItemIndex > 0 then
      chrChrom.UpdateDataTable;
    chrChrom.Repaint;
    chrChrom.ZoomMode := chrChrom.ZoomMode;
    lbTotalChrom.Caption := 'Total= ' + MyFloatToStr(srsChrom.YValues.Total);
    lbNPointsChrom.Caption := 'N.Points= ' + IntToStr(srsChrom.Count - 1);
    Result := true;
    Screen.Cursor := crDefault;
  except
    on EmathError do
      XY2file(Spec.Chrom, 'exception2.txt');
  end;
end; { TfrmPlot.ShowTIC }

// ============== OPTIONS ===================
procedure TfrmPlot.SetSpOpt(Value: tSpOpt); // change the base template
begin
  fSpOpt.Assign(Value);
  UpdateFromOptions;
  fTmplName := fSpOpt.FileName;
  gbAsTemplate.Caption := 'Template (' + ExtractFileName(fTmplName) + ')';
end;

function TfrmPlot.GetTmplName: string;
begin
  if UpperCase(ChangeFileExt(ExtractFileName(fTmplName), '')) = 'EMPTY' then
    Result := ''
  else
    Result := fTmplName;
end;

procedure TfrmPlot.UpdateOptions(CM: Boolean);
begin
  if fSpOpt.Locked then
    exit;
  fSpOpt.MassOnly := MassOnly;
  if CM then
    with fSpOpt.oChrom do
    begin
      Visual.AutoY := chrChrom.tbAutoY.Down;
      Visual.FixY := chkFixYChrom.Checked;
      Visual.XUnits := rgXUnitsChrom.ItemIndex;
      Visual.YUnits := rbPercYChrom.Checked;
      Smooth.SGDegree := seSGDegreeChrom.Value;
      Smooth.Enabled := chkOSSmoothChrom.Checked;
      BLine.AutoTS := chkAutoTSChrom.Checked;
      BLine.Threshold := seTSBlineChrom.Value;
      BLine.Enabled := chkOSBlineChrom.Checked;
      Peak.Method := pcPeakMethodChrom.ActivePageIndex;
      Peak.Sensiv := sePeakSenseChrom.Value;
      Peak.MinHeight := sePeakHeightChrom.Value;
      Peak.MinDist := sePeakDistChrom.Value;
      Peak.MinArea := sePeakAreaChrom.Value;
      Peak.Enabled := chkOSPeakChrom.Checked;
    end
  else
    with fSpOpt.oMass do
    begin
      Visual.AutoY := chrMass.tbAutoY.Down;
      Visual.FixY := chkFixYMass.Checked;
      Visual.XUnits := rgXUnitsMass.ItemIndex;
      Visual.YUnits := (rbPercYMass.Checked);
      Smooth.SGDegree := seSGDegreeMass.Value;
      Smooth.Enabled := chkOSSmoothMass.Checked;
      BLine.AutoTS := chkAutoTSMass.Checked;
      BLine.Threshold := seTSBlineMass.Value;
      BLine.Enabled := chkOSBlineMass.Checked;
      Peak.Method := pcPeakMethodMass.ActivePageIndex;
      Peak.Sensiv := sePeakSenseMass.Value;
      Peak.MinHeight := sePeakHeightMass.Value;
      Peak.MinDist := sePeakDistMass.Value;
      Peak.MinArea := sePeakAreaMass.Value;
      Peak.Enabled := chkOSPeakMass.Checked;

      sePeakSenseMass.Enabled := (Peak.Method <> 2);
      sePeakHeightMass.Enabled := (Peak.Method <> 2);
      sePeakDistMass.Enabled := (Peak.Method <> 2);
    end;
end; { TfrmPlot.UpdateOptions }

procedure TfrmPlot.UpdateFromOptions;
begin
  SpOpt.Locked := true;
  gbAsTemplate.Caption := ' Base Template (' +
    ExtractFileName(fSpOpt.FileName) + ')';
  MassOnly := fSpOpt.MassOnly;
  with fSpOpt.oChrom do
  begin
    rgXUnitsChrom.ItemIndex := Visual.XUnits;
    if Visual.TeeFile <> '' then
      chrChrom.LoadFromTemplate(Visual.TeeFile);
    chrChrom.tbAutoY.Down := Visual.AutoY;
    chrChrom.tbAutoY.Click;
    chkFixYChrom.Checked := Visual.FixY;
    chkFixYChromClick(nil);
    rbPercYChrom.Checked := Visual.YUnits;
    seSGDegreeChrom.Value := Smooth.SGDegree;
    chkOSSmoothChrom.Checked := Smooth.Enabled;
    chkAutoTSChrom.Checked := BLine.AutoTS;
    seTSBlineChrom.Value := BLine.Threshold;
    chkOSBlineChrom.Checked := BLine.Enabled;
    pcPeakMethodChrom.ActivePageIndex := Peak.Method;
    sePeakSenseChrom.Value := Peak.Sensiv;
    sePeakHeightChrom.Value := Peak.MinHeight;
    sePeakDistChrom.Value := Peak.MinDist;
    sePeakAreaChrom.Value := Peak.MinArea;
    chkOSPeakChrom.Checked := Peak.Enabled;
  end;
  with fSpOpt.oMass do
  begin
    if Visual.TeeFile <> '' then
      chrMass.LoadFromTemplate(Visual.TeeFile);
    rbPercYMass.Checked := Visual.YUnits;
    chrMass.tbAutoY.Down := Visual.AutoY;
    chrMass.tbAutoY.Click;
    chkFixYMass.Checked := Visual.FixY;
    chkFixYMassClick(nil);
    seSGDegreeMass.Value := Smooth.SGDegree;
    chkOSSmoothMass.Checked := Smooth.Enabled;
    chkAutoTSMass.Checked := BLine.AutoTS;
    seTSBlineMass.Value := BLine.Threshold;
    chkOSBlineMass.Checked := BLine.Enabled;
    pcPeakMethodMass.ActivePageIndex := Peak.Method;
    sePeakSenseMass.Value := Peak.Sensiv;
    sePeakHeightMass.Value := Peak.MinHeight;
    sePeakDistMass.Value := Peak.MinDist;
    sePeakAreaMass.Value := Peak.MinArea;
    chkOSPeakMass.Checked := Peak.Enabled;

    sePeakSenseMass.Enabled := (Peak.Method <> 2);
    sePeakHeightMass.Enabled := (Peak.Method <> 2);
    sePeakDistMass.Enabled := (Peak.Method <> 2);
  end;
  fSpOpt.Locked := false;
end; { TfrmPlot.UpdateFromOptions }

/// ///////////////////////////////////////////////////////////////////
procedure TfrmPlot.SetDocked(Value: Boolean);
begin
  fDocked := Value;
  if fDocked then
  begin
    if DockedPlace = nil then
      Parent := Application.MainForm
    else
      Parent := DockedPlace;
    if PlotShell <> nil then // clear afterwards
    begin
      PlotShell.FormStyle := fsNormal;
      PlotShell.Release;
      PlotShell := nil;
    end;
  end
  else
  begin
    PlotShell := TForm.Create(self);
    PlotShell.FormStyle := fsMDIChild;
    Number := fNumber;
    Parent := PlotShell;
    PlotShell.Caption := fCaption;
    PlotShell.Show;
    Show;
  end;
end; { TfrmPlot.SetDocked }

procedure TfrmPlot.SetWhatVis(Value: tWhatVis);
var
  sz, szc: Integer;
begin
  sz := Height;
  szc := ClientHeight;
  pnlMass.Visible := (Value = wvMass) or (Value = wvBoth);
  tbMass.Marked := not pnlMass.Visible;
  pnlChrom.Visible := (Value = wvChrom) or (Value = wvBoth);
  tbChrom.Marked := not pnlChrom.Visible;
  fWhatVis := Value;
  if pnlMass.Visible then
  begin
    pnlChrom.Align := alTop;
    if (VisRatio <= 0) or (VisRatio > 100) then
      VisRatio := 33;
    pnlChrom.Height := round(szc * 33 / 100);
    pnlMass.Height := szc - pnlChrom.Height - Splitter1.Height;
    Splitter1.Top := pnlMass.Height + 4;
  end
  else
    pnlChrom.Align := alClient;
  chrMass.Align := alClient;
end; { TfrmPlot.SetWhatVis }

procedure TfrmPlot.SetNumber(Value: Integer);
begin
  fNumber := Value;
  if PlotShell <> nil then
    PlotShell.Tag := fNumber;
  if Assigned(Spec) then
    Spec.Number := Value;
end;

function TfrmPlot.GetNumber: Integer;
begin
  Result := fNumber;
  if PlotShell <> nil then
    Result := PlotShell.Tag;
end;

procedure TfrmPlot.SetCaption(Value: string);
begin
  fCaption := Value;
  if PlotShell <> nil then
    PlotShell.Caption := fCaption
  else
  begin
    if MassOnly then
    begin
      chrMass.chrChart.Title.Text.Clear;
      chrMass.chrChart.Title.Text.Add(Value);
    end
    else
    begin
      chrChrom.chrChart.Title.Text.Clear;
      chrChrom.chrChart.Title.Text.Add(Value);
    end;
  end;
end; { TfrmPlot.SetCaption }
// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

procedure TfrmPlot.tbChromClick(Sender: TObject);
begin
  if WhatVis = wvMass then
    exit;
  pcChrom.Visible := not pcChrom.Visible;
  SplitterChrom.Visible := pcChrom.Visible;
  // frmCmdCentre.HomeProc(pcChrom);
end;

procedure TfrmPlot.tbCommonClick(Sender: TObject);
begin
  pcCommon.Visible := not pcCommon.Visible;
  if pcCommon.Visible then
    PropToolBar.Left := pcCommon.Left - 10;
  tsProps.TabVisible := not MassOnly;
  tsMyTab.TabVisible := MyPriority;
end;

procedure TfrmPlot.tbMassClick(Sender: TObject);
begin
  if WhatVis = wvChrom then
    exit;
  pcMass.Visible := not pcMass.Visible;
  SplitterMass.Visible := pcMass.Visible;
end;

procedure TfrmPlot.PropToolBarResize(Sender: TObject);
begin
  with PropToolBar do
    ButtonHeight := round(Height / 3) - 3;
  if SpOpt.oMass.Peak.Enabled and (SpOpt.oMass.Peak.Method = 2) then
    AdaptivePeaking;
end;

procedure TfrmPlot.tbMassMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button <> mbRight) then
    exit;
  case fWhatVis of
    wvChrom:
      WhatVis := wvBoth;
    wvBoth:
      WhatVis := wvChrom;
  end;
end;

procedure TfrmPlot.tbChromMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button <> mbRight) then
    exit;
  case fWhatVis of
    wvMass:
      WhatVis := wvBoth;
    wvBoth:
      WhatVis := wvMass;
  end;
end;

procedure TfrmPlot.FrameResize(Sender: TObject);
begin
  SetGardeRatio(fGardeRatio);
  // if TmplName='' then SetIniPos;
end;

procedure TfrmPlot.Splitter1Moved(Sender: TObject);
begin
  if fWhatVis <> wvBoth then
    exit;
  VisRatio := round(pnlChrom.Height * 100 / Height);
end;

procedure TfrmPlot.bbEditorChromClick(Sender: TObject);
var
  bb: Boolean;
begin
  bb := chrChrom.ChartCursor.Active;
  chrChrom.ChartCursor.Active := false;
  ChartEditorChrom.Execute; // chkSaveChartChrom.Checked:= true;
  chrChrom.ChartCursor.Active := bb;
end;

procedure TfrmPlot.bbEditorMassClick(Sender: TObject);
begin
  ChartEditorMass.Execute; // chkSaveChartMass.Checked:= true;
end;

procedure TfrmPlot.SetChromVisual;
begin
end;

procedure TfrmPlot.rgXUnitsChromClick(Sender: TObject);
begin
  SetChromVisual;
  UpdateOptions(true);
  if Sender = rgXUnitsChrom then
  begin
    bbClearRangesChrom.Click;
    case SpOpt.oChrom.Visual.XUnits of
      0:
        begin
          sgRangesChrom.Cells[0, 0] := 'Start idx';
          sgRangesChrom.Cells[1, 0] := 'End index';
        end;
      1, 2:
        begin
          sgRangesChrom.Cells[0, 0] := 'Start time';
          sgRangesChrom.Cells[1, 0] := 'End time';
        end;
    end;
  end;
  ShowTIC;
  if Showing then
  begin
    chrChrom.tbAutosize.Click;
    SetIniPos;
  end;
end;

procedure TfrmPlot.SetMassVisual;
begin
end;

procedure TfrmPlot.rgXUnitsMassClick(Sender: TObject);
begin
  SetMassVisual;
  UpdateOptions(false);
  if Sender = rgXUnitsMass then
    bbClearRangesMass.Click;
  ShowSMass(-1);
  exit;
  if Showing then
  begin
    chrMass.tbAutosize.Click;
    SetIniPos;
  end;
end;

procedure TfrmPlot.rgYUnitsMassClick(Sender: TObject);
begin
  SetMassVisual;
  UpdateOptions(false);
  bbClearRangesMass.Click;
  ShowSMass(-1);
  if Showing then
  begin
    chrMass.tbAutosize.Click;
    SetIniPos;
  end;
end;

function TfrmPlot.OpenData(iFilename: string): Boolean;
var
  i, j, n, k, m, l: Integer;
  ss, iFN: string;
begin
  Clear;
  Result := false;
  if not DirectoryExists(ExtractFilePath(iFilename)) then
    iFN := SpOpt.DataPath + ExtractFileName(iFilename)
  else
    iFN := iFilename;
  if not FileExists(iFN) and not(iFilename = '') then
    raise Exception.Create('File <' + iFN + '> does not exist.');
  OpenDialog1.InitialDir := SpOpt.DataPath;
  if MassOnly then
    OpenDialog1.FilterIndex := 1
  else
    OpenDialog1.FilterIndex := 2;
  if iFilename = '' then
    if OpenDialog1.Execute then
      iFN := OpenDialog1.FileName
    else
      exit;
  MassOnly := (CheckFileKind(iFN) = fkTxt);
  Result := Spec.OpenFile(iFN);
  if MassOnly then
  begin
    ShowSMass(-1);
  end
  else
  begin
    SetIniPos;
    with Spec, sgFiles do
      if FileKind = fkNetCDF then
      begin
        ColWidths[0] := 75;
        sgFiles.Visible := true;
        Cells[0, 0] := ' Param.';
        Cells[1, 0] := ' Value';
        Cells[0, 1] := 'instr.name';
        Cells[1, 1] := netCDF.instrument_name;
        Cells[0, 2] := 'instr.id';
        Cells[1, 2] := netCDF.instrument_id;
        Cells[0, 3] := 'instr.mfr';
        Cells[1, 3] := netCDF.instrument_mfr;
        Cells[0, 4] := 'instr.model';
        Cells[1, 4] := netCDF.instrument_model;
        Cells[0, 5] := 'instr.os_ver.';
        Cells[1, 5] := netCDF.instrument_os_version;
        Cells[0, 6] := 'instr.sw_ver.';
        Cells[1, 6] := netCDF.instrument_sw_version;
      end;
    chrChrom.chrChart.Title.Text.Clear;
    chrChrom.chrChart.Title.Text.Add(iFN);
    // chrMass.chrChart.Title.Text.Clear;  chrMass.chrChart.Title.Text.Add(iFN);
  end;
  Caption := iFN + ' (' + Name + ')';
  // SpOpt.DataPath:= OpenDialog1.InitialDir;
end; { TfrmPlot.OpenData }

function TfrmPlot.SaveData(iFilename: string): Boolean;
var
  ts: TStrings;
  i, j, n: Integer;
  ss, fn: string;
begin
  Result := false;
  if iFilename = '' // save as ...
  then
  begin
    SaveDialog1.InitialDir := SpOpt.DataPath;
    SaveDialog1.FilterIndex := ord(Spec.FileKind);
    if SaveDialog1.Execute then
    begin
      fn := SaveDialog1.FileName;
      Application.ProcessMessages;
      case SaveDialog1.FilterIndex of
        1:
          ss := 'txt';
        2:
          ss := 'cdf';
        3:
          ss := 'R01';
      end;
      if ExtractFileExt(fn) = '' then
        fn := ChangeFileExt(fn, '.' + ss);
      Result := Spec.SaveFile(fn);
    end;
    SpOpt.DataPath := SaveDialog1.InitialDir;
  end
  else
  begin // save under the same name
    if FileExists(iFilename) then
      if MessageDlg('File already exists. Overwrite ?', mtConfirmation,
        [mbYes, mbNo], 0) = mrNo then
        exit;
    ss := ExtractFileDir(iFilename);
    fn := ExtractFileName(iFilename);
    if ss = '' then
      ss := SpOpt.DataPath;
    if not DirectoryExists(ss) then
    begin
      ErrorMsg('Directory does not exist.');
      exit;
    end;
    Result := Spec.SaveFile(ss + '\' + fn);
  end;
end; { TfrmPlot.SaveData }

procedure TfrmPlot.bbSaveAsDataClick(Sender: TObject);
begin
  SaveData('');
end;

// zZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZ

procedure TfrmPlot.bbUpdateRangesMassClick(Sender: TObject);
begin
  chrMass.UpdateFromTable;
  ShowTIC;
end;

procedure TfrmPlot.bbClearRangesMassClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to sgRangesMass.RowCount - 1 do
    sgRangesMass.Cells[0, i] := '';
  bbUpdateRangesMassClick(nil);
end;

procedure TfrmPlot.bbUpdateRangesChromClick(Sender: TObject);
begin
  chrChrom.UpdateFromTable;
  ShowSMass(-1);
end;

procedure TfrmPlot.bbClearRangesChromClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to sgRangesChrom.RowCount - 1 do
    sgRangesChrom.Cells[0, i] := '';
  bbUpdateRangesChromClick(nil);
end;
// zZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZzZ

procedure TfrmPlot.chkAutoTSChromClick(Sender: TObject);
begin
  SpOpt.oChrom.BLine.AutoTS := chkAutoTSChrom.Checked;
  // chrBHistoChrom.Visible:= SpOpt.oChrom.BLine.AutoTS and SpOpt.oChrom.BLine.Enabled;
  if SpOpt.oChrom.BLine.Enabled then
    ShowTIC;
  if SpOpt.oChrom.BLine.AutoTS then
    seTSBlineChrom.Value := SpOpt.oChrom.BLine.Threshold;
end;

procedure TfrmPlot.chkAutoTSMassClick(Sender: TObject);
begin
  SpOpt.oMass.BLine.AutoTS := chkAutoTSMass.Checked;
  if SpOpt.oMass.BLine.Enabled then
    ShowSMass(-1);
  if SpOpt.oMass.BLine.AutoTS then
    seTSBlineMass.Value := SpOpt.oMass.BLine.Threshold;
end;

procedure TfrmPlot.srsMassGetMarkText(Sender: TChartSeries; ValueIndex: Integer;
  var MarkText: String);
var
  i, j: Integer;
  wP: tPeaks;
  sgW: TStringGrid;
  pnt: TPoint;
begin
  MarkText := '';
  if AcqMode or IsEmpty then
    exit;
  if Sender = srsMass then
  begin
    wP := chrMass.Peaks;
    sgW := sgRangesMass;
  end;
  if Sender = srsChrom then
  begin
    wP := chrChrom.Peaks;
    sgW := sgRangesChrom;
  end;
  for i := 0 to wP.Count - 1 do
    if ValueIndex = wP[i].Index then
    begin
      MarkText := MyFloatToStr(round(wP[i].X * 10) / 10);
      if (Sender as TChartSeries).Marks.Positions[ValueIndex] = nil then
        exit;
      with (Sender as TChartSeries).Marks.Positions[ValueIndex] do
      begin
        // if i=sgW.Selection.Top-1 then BackColor:= clYellow;
        // else BackColor:= clWhite;
        // Positions.Position[i]. := 23;
      end;
      exit;
    end;
end; { TfrmPlot.srsMassGetMarkText }

procedure TfrmPlot.sgRangesChromKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    chrChrom.UpdateFromTable;
    Key := #0;
  end;
end;

procedure TfrmPlot.sgRangesMassKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    chrMass.UpdateFromTable;
    Key := #0;
  end;
end;

/// /////////// Actions ////////////////////////////////////

procedure TfrmPlot.actDataTableChromExecute(Sender: TObject);
var
  i, j: Integer;
  ss: string;
  a: real;
begin
  if Sender = rgShowChrom then
    actDataTableChrom.Checked := (rgShowChrom.ItemIndex = 1)
  else
  begin
    actDataTableChrom.Checked := not actDataTableChrom.Checked;
    if actDataTableChrom.Checked then
      rgShowChrom.ItemIndex := 1
    else
      rgShowChrom.ItemIndex := 0;
  end;
  chrChrom.ChartVis := (rgShowChrom.ItemIndex = 0);
  if chrChrom.ChartVis then
  begin
    ss := chrChrom.sgData.Cells[0, chrChrom.sgData.Row];
    val(ss, a, j);
    if j = 0 then
    begin
      chrChrom.ChartCursor.XValue := a;
      ShowSMass(chrChrom.GetClosestPoint(a));
    end;
  end
  else
  begin
    chrChrom.UpdateDataTable;
    j := chrChrom.GetClosestPoint(chrChrom.ChartCursor.XValue) + 1;
    if j < chrChrom.sgData.RowCount then
      chrChrom.sgData.Row := j;
    ShowSMass(chrChrom.sgData.Row);
    chrChrom.tbZoomMode.Click;
  end;
  chrChrom.tbRangeMode.Enabled := chrChrom.ChartVis;
end; { TfrmPlot.actDataTableChromExecute }

procedure TfrmPlot.actSmoothChromExecute(Sender: TObject);
begin
  actSmoothChrom.Checked := not actSmoothChrom.Checked;
  UpdateOptions(true);
  ShowTIC;
end;

procedure TfrmPlot.actBLineChromExecute(Sender: TObject);
begin
  actBLineChrom.Checked := not actBLineChrom.Checked;
  UpdateOptions(true);
  ShowTIC;
  // chrBHistoChrom.Visible:= SpOpt.oChrom.BLine.AutoTS and SpOpt.oChrom.BLine.Enabled;
end;

procedure TfrmPlot.actPeaksChromExecute(Sender: TObject);
begin
  actPeaksChrom.Checked := not actPeaksChrom.Checked;
  UpdateOptions(true);
  ShowTIC;
end;

procedure TfrmPlot.actDataTableMassExecute(Sender: TObject);
begin
  if Sender = rgShowMass then
    actDataTableMass.Checked := (rgShowMass.ItemIndex = 1)
  else
  begin
    actDataTableMass.Checked := not actDataTableMass.Checked;
    if actDataTableMass.Checked then
      rgShowMass.ItemIndex := 1
    else
      rgShowMass.ItemIndex := 0;
  end;
  chrMass.ChartVis := (rgShowMass.ItemIndex = 0);
  if not chrMass.ChartVis then
    chrMass.UpdateDataTable;
end;

procedure TfrmPlot.actSmoothMassExecute(Sender: TObject);
begin
  actSmoothMass.Checked := not actSmoothMass.Checked;
  UpdateOptions(false);
  ShowSMass(-1);
end;

procedure TfrmPlot.actBLineMassExecute(Sender: TObject);
begin
  actBLineMass.Checked := not actBLineMass.Checked;
  UpdateOptions(false);
  ShowSMass(-1);
end;

procedure TfrmPlot.actPeaksMassExecute(Sender: TObject);
begin
  actPeaksMass.Checked := not actPeaksMass.Checked;
  UpdateOptions(false);
  ShowSMass(-1);
end;

procedure TfrmPlot.chrChromtbDataTableMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbRight then
    exit;
  pcChrom.Visible := not pcChrom.Visible; // (Sender as TToolButton).Click;
  pcChrom.ActivePageIndex := (Sender as TToolButton).Tag;
end;

procedure TfrmPlot.chrMasstbDataTableMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbRight then
    exit;
  pcMass.Visible := true;
  pcMass.ActivePageIndex := (Sender as TToolButton).Tag;
end;

procedure TfrmPlot.seSGDegreeChromChange(Sender: TObject);
begin
  UpdateOptions(true);
  ShowTIC;
end;

procedure TfrmPlot.seSGDegreeMassChange(Sender: TObject);
begin
  UpdateOptions(false);
  ShowSMass(-1);
end;

procedure TfrmPlot.Label14Click(Sender: TObject);
begin
  chkSaveChartChrom.Checked := not chkSaveChartChrom.Checked;
end;

procedure TfrmPlot.Label13Click(Sender: TObject);
begin
  chkSaveChartMass.Checked := not chkSaveChartMass.Checked;
end;

/// //////////////// D U S T /////////////////////////////////
procedure TfrmPlot.btnClearClick(Sender: TObject);
begin
  Clear;
end;

procedure TfrmPlot.chkAcqModeClick(Sender: TObject);
begin
  AcqMode := chkAcqMode.Checked;
end;

procedure TfrmPlot.chkMassModeClick(Sender: TObject);
begin
  MassOnly := chkMassMode.Checked;
end;

procedure TfrmPlot.sgRangesChromSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if Sender = sgRangesChrom then
    chrChrom.SelectMark(ARow)
  else
    chrMass.SelectMark(ARow);
end;

procedure TfrmPlot.pcDimentionsChange(Sender: TObject);
var
  i, j, k: Integer;
  wXY: tXYarray;
begin
  if pcDimentions.ActivePageIndex = 1 then
  begin
    srs3D.Clear;
    k := 1;
    Cursor := crHourGlass;
    if Spec.NSpec > 20 then
      k := Spec.NSpec div 20;
    for i := 0 to Spec.NSpec - 1 do
    begin
      if (i mod k) > 0 then
        continue;
      wXY := Spec.Mass[i];
      for j := low(wXY) to high(wXY) do
        srs3D.AddXYZ(wXY[j, X], wXY[j, Y], i { Spec.Chrom[i,X] } );
    end;
    Cursor := crDefault;
  end
  else
    srs3D.Clear;
  tbChrom.Enabled := (pcDimentions.ActivePageIndex = 0);
  tbMass.Enabled := tbChrom.Enabled;
end; { TfrmPlot.pcDimentionsChange }

procedure TfrmPlot.chkDimTabsClick(Sender: TObject);
var
  bb: Boolean;
  i: Integer;
begin
  bb := chkDimTabs.Checked;
  i := pcDimentions.ActivePageIndex;
  ts2D.TabVisible := bb;
  ts3D.TabVisible := bb;
  rgDims.Enabled := not bb;
  pcDimentions.ActivePageIndex := i;
  rgDims.ItemIndex := i;
end;

procedure TfrmPlot.rgDimsClick(Sender: TObject);
begin
  pcDimentions.ActivePageIndex := rgDims.ItemIndex;
  pcDimentionsChange(nil);
end;

procedure TfrmPlot.chrChromtbAutoYClick(Sender: TObject);
begin
  chrChrom.tbAutoYClick(Sender); // intern
  UpdateOptions(true);
end;

procedure TfrmPlot.chrMasstbAutoYClick(Sender: TObject);
begin
  chrMass.tbAutoYClick(Sender); // intern
  UpdateOptions(false);
end;

procedure TfrmPlot.bbSaveAsTmlClick(Sender: TObject);
var
  so: tSpOpt;
begin
  if not SaveDialog2.Execute then
    exit;
  so := tSpOpt.Create(SaveDialog2.FileName);
  so.Assign(SpOpt);
  so.Save;
  so.Free;
end;

procedure TfrmPlot.chrMasschrChartMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  chrMass.chrChartMouseUp(Sender, Button, Shift, X, Y);
  if (SpOpt.oMass.Peak.Method = 2) and SpOpt.oMass.Peak.Enabled then
  begin
    srsMass.Marks.Visible := true;
    srsMass.Marks.Repaint;
    AdaptivePeaking;
    srsMass.Marks.Repaint; // MarksAdjusting;
  end;
end;

procedure TfrmPlot.chrMasschrChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  if ssCtrl in Shift then
    bbClearRangesMassClick(nil);
  chrMass.chrChartMouseDown(Sender, Button, Shift, X, Y);
  if (SpOpt.oMass.Peak.Method = 2) and SpOpt.oMass.Peak.Enabled then
  begin
    for i := 0 to srsMass.Marks.Positions.Count - 1 do
      srsMass.Marks.Positions.Automatic(i);
    chrMass.Repaint;
    srsMass.Marks.Visible := false;
  end;
end;

procedure TfrmPlot.chrChromchrChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ssCtrl in Shift then
    bbClearRangesChromClick(nil);
  chrChrom.chrChartMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TfrmPlot.bbOpenDataClick(Sender: TObject);
begin
  if Sender = bbOpenSMass then
    MassOnly := true;
  OpenData('');
end;

procedure TfrmPlot.bbPasteSMassClick(Sender: TObject);
var
  i, j, n, l, k, m: Integer;
  ts: TStringList;
  inix, cx, cy: real;
  ss: string;
  bprn: Boolean;
begin
  MassOnly := true;
  ts := TStringList.Create;
  ts.Text := Clipboard.AsText;
  n := ts.Count;
  if n = 0 then
  begin
    ErrorMsg('Empty/incorrect data.');
    FreeAndNil(ts);
    exit;
  end;
  SetLength(Spec.CMass, n);
  l := 0;
  bprn := false;
  k := 0;
  for i := 0 to n - 1 do
  begin
    ss := ts[i];
    if length(ss) > 0 then
    begin
      if (ss[1] = '''') then
        continue;
      if (ss[1] = ';') then
        if not bprn then
          if copy(ss, 1, 4) = ';fm=' then
          begin
            bprn := true;
            val(copy(ss, 5, 255), inix, j);
            if j <> 0 then
            begin
              ErrorMsg('Wrong first mass.');
              FreeAndNil(ts);
              exit;
            end;
            continue;
          end;
    end;
    j := system.pos(#9, ss);
    if (j = 0) and not bprn then
    begin
      ss := InputBox('Input Box', 'First mass', '1');
      val(ss, inix, j);
      if j <> 0 then
      begin
        ErrorMsg('Wrong first mass.');
        FreeAndNil(ts);
        exit;
      end;
      bprn := true;
    end;
    if not bprn then
      val(copy(ss, 1, j - 1), cx, k);
    val(copy(ss, j + 1, 255), cy, m);
    if (k <> 0) or (m <> 0) then
      if MessageDlg('Error: Wrong number syntax, line (' + IntToStr(i) + ')' +
        'Continue ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        continue
      else
      begin
        FreeAndNil(ts);
        exit;
      end;
    if bprn then
      CMass[l, X] := inix
    else
      CMass[l, X] := cx;
    Spec.CMass[l, Y] := cy;
    inc(l);
    inix := inix + 1;
  end;
  dec(l);
  SetLength(Spec.CMass, l);
  RefreshPlot;
  FreeAndNil(ts);
end; { TfrmPlot.bbPasteSMassClick }

procedure TfrmPlot.bbOpenTmlClick(Sender: TObject);
var
  wSpOpt: tSpOpt;
begin
  OpenDialog2.FilterIndex := 3;
  OpenDialog2.InitialDir := GetConfigPath;
  if OpenDialog2.Execute then
  begin
    wSpOpt := tSpOpt.Create(OpenDialog2.FileName);

    if wSpOpt.Open(SpOpt) then
      SpOpt.Assign(wSpOpt);
    wSpOpt.Free;
    UpdateFromOptions;
  end;
end;

procedure TfrmPlot.pmClearClick(Sender: TObject);
begin
  Clear;
end;

procedure TfrmPlot.pmMassOnlyClick(Sender: TObject);
begin
  pmMassOnly.Checked := not pmMassOnly.Checked;
  MassOnly := pmMassOnly.Checked;
end;

procedure TfrmPlot.pmFillClick(Sender: TObject);
begin
  Clear;
  Spec.FillSampleValues(200);
  SetIniPos;
end;

procedure TfrmPlot.chrChromtbZoomModeClick(Sender: TObject);
begin
  chrChrom.chrChartZoom(Sender);
  bbClearRangesChrom.Enabled := not chrChrom.ZoomMode;
  bbUpdateRangesChrom.Enabled := not chrChrom.ZoomMode;
  ShowSMass(-1);
end;

procedure TfrmPlot.chrMasstbZoomModeClick(Sender: TObject);
begin
  chrMass.chrChartZoom(Sender);
  bbClearRangesMass.Enabled := not chrMass.ZoomMode;
  bbUpdateRangesMass.Enabled := not chrMass.ZoomMode;
  if not chrMass.ZoomMode then
    rgChromatogram.ItemIndex := 0;
  rgChromatogram.Enabled := chrMass.ZoomMode;
end;

procedure TfrmPlot.rgChromatogramClick(Sender: TObject);
begin
  if IsEmpty then
    exit;
  RefreshPlot;
end;

procedure Register;
begin
  RegisterComponents('Samples', [TfrmPlot]);
end;

procedure TfrmPlot.chrMasstlbrManipMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  s, p: TPoint;
begin
  s.X := X;
  s.Y := Y;
  p := chrChrom.tlbrManip.ClientToScreen(s);
  if Button = mbRight then
    PopupMenu1.Popup(p.X, p.Y);
end;

procedure TfrmPlot.chkCasheOnClick(Sender: TObject);
begin
  Spec.CasheOn := chkCasheOn.Checked;
end;

procedure TfrmPlot.chkFixYChromClick(Sender: TObject);
begin
  chrChrom.FixY := chkFixYChrom.Checked;
end;

procedure TfrmPlot.chkFixYMassClick(Sender: TObject);
begin
  chrMass.FixY := chkFixYMass.Checked;
end;

procedure TfrmPlot.btnForcedCasheClick(Sender: TObject);
begin
  Spec.CasheOn := true;
end;

end. { PlotU }

(* maybe faster series charge ?
  //
  With srsMass.XValues do
  begin
  Value:= TChartValues(XY[X]);  { <-- the array }
  Count:= length(XY[X]);        { <-- number of points }
  Modified:= True;              { <-- recalculate min and max }
  end;

  { set our Y array }
  With srsMass.YValues do
  begin
  Value:= TChartValues(XY[Y]);
  Count:= length(XY[X]);
  Modified:= True;
  end;
  { Show data }
  srsMass.Repaint;
  //
*)
