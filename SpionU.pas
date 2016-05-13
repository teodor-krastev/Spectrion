unit SpionU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, Menus, ExtCtrls, IniFiles, TabNotbk, StdCtrls, ImgList,
  Series, TeeProcs, Chart, Spin, Variants, Clipbrd, Vcl.HtmlHelpViewer;

type
  TfrmSpion = class(TForm)
    MainMenu1: TMainMenu;
    mFile: TMenuItem;
    MOpen: TMenuItem;
    N5: TMenuItem;
    mNew: TMenuItem;
    mSaveAs: TMenuItem;
    N1: TMenuItem;
    mExit: TMenuItem;
    mEdit: TMenuItem;
    mCut: TMenuItem;
    mCopy: TMenuItem;
    mPaste: TMenuItem;
    N4: TMenuItem;
    mOptions: TMenuItem;
    mView: TMenuItem;
    mCmdCentre: TMenuItem;
    N2: TMenuItem;
    mRefresh: TMenuItem;
    mHelp: TMenuItem;
    mContents: TMenuItem;
    N3: TMenuItem;
    mAbout: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    mCmdDocked: TMenuItem;
    N6: TMenuItem;
    mCmdLeft: TMenuItem;
    mCmdRight: TMenuItem;
    mRun: TMenuItem;
    mExamScan1: TMenuItem;
    mDevices: TMenuItem;
    mDvcDocked: TMenuItem;
    mAlwaysVis: TMenuItem;
    mPlots: TMenuItem;
    mTabbedPlots: TMenuItem;
    mFloatPlots: TMenuItem;
    N7: TMenuItem;
    mCmdPaged: TMenuItem;
    mCmdTiled: TMenuItem;
    mSave: TMenuItem;
    mClose: TMenuItem;
    N8: TMenuItem;
    mClearAll: TMenuItem;
    N9: TMenuItem;
    mTile: TMenuItem;
    mCascade: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    tbOpen: TToolButton;
    mUniScan: TMenuItem;
    ToolBar2: TToolBar;
    tbOscilo: TToolButton;
    N10: TMenuItem;
    mAutoTune: TMenuItem;
    tbPCA: TToolButton;
    tbAutoTune: TToolButton;
    ToolBar3: TToolBar;
    mNewGCMS: TMenuItem;
    mNewMS: TMenuItem;
    tbAcquire: TToolButton;
    mSmartCopy: TMenuItem;
    N12: TMenuItem;
    splComCentre: TSplitter;
    mPCA: TMenuItem;
    mFromTemplate: TMenuItem;
    N11: TMenuItem;
    OpenDialog2: TOpenDialog;
    mOscilo: TMenuItem;
    mAcquire: TMenuItem;
    mMinMax: TMenuItem;
    tbSaveAs: TToolButton;
    ToolButton1: TToolButton;
    procedure mSimpleScanClick(Sender: TObject);
    procedure mAlwaysVisClick(Sender: TObject);
    procedure mCmdDockedClick(Sender: TObject);
    procedure mCmdLeftClick(Sender: TObject);
    procedure mCmdRightClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mRefreshClick(Sender: TObject);
    procedure mDvcDockedClick(Sender: TObject);
    procedure mTabbedPlotsClick(Sender: TObject);
    procedure mFloatPlotsClick(Sender: TObject);
    procedure mCmdPagedClick(Sender: TObject);
    procedure mCmdTiledClick(Sender: TObject);
    procedure mCloseClick(Sender: TObject);
    procedure mTileClick(Sender: TObject);
    procedure mCascadeClick(Sender: TObject);
    procedure mOptionsClick(Sender: TObject);
    procedure DisplayHint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MOpenClick(Sender: TObject);
    procedure tbOsciloClick(Sender: TObject);
    procedure mClearAllClick(Sender: TObject);
    procedure mExitClick(Sender: TObject);
    procedure mUniScanClick(Sender: TObject);
    procedure mAboutClick(Sender: TObject);
    procedure mAutoTuneClick(Sender: TObject);
    procedure mContentsClick(Sender: TObject);
    procedure mCutClick(Sender: TObject);
    procedure mCopyClick(Sender: TObject);
    procedure mPasteClick(Sender: TObject);
    procedure mNewGCMSClick(Sender: TObject);
    procedure mNewMSClick(Sender: TObject);
    procedure tbAcquireClick(Sender: TObject);
    procedure mSaveAsClick(Sender: TObject);
    procedure mFromTemplateClick(Sender: TObject);
    procedure mOsciloClick(Sender: TObject);
    procedure mAcquireClick(Sender: TObject);
    procedure mMinMaxClick(Sender: TObject);
    procedure mSmartCopyClick(Sender: TObject);
    procedure mPCAClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
    DesktopIni: TIniFile;
    DvcVis: TStrings;
    procedure OpenDesktop;
    procedure SaveDesktop;
    function CheckForAcq(tb: TToolButton): boolean;
  public
    { Public declarations }
    procedure SetForms;
  end;

var
  frmSpion: TfrmSpion;

implementation

uses CmdCentreU, CmdShellU, DvcRackU, DvcShellU, PlotU, PlotCollectU,
  OptionsU, DataStreamU, SynchroU, SimpleScanU, UniScanU, vChartU, AboutU,
  AutoTuneU, SpecU, SpOPtU, PCAprocU, DelphiDeclarations;
{$R *.DFM}

const
  DemoVer = true;

var
  Plot: TfrmPlot;
  ts: TTabSheet;

procedure TfrmSpion.SetForms;
var
  i, j: integer;
begin
  MyPriority := false;

  Options := tOptions.Create(RootPath + ConfigPath + 'Defaults.ini');
  Options.Load;

  DesktopIni := TIniFile.Create(RootPath + ConfigPath + 'Desktop.ini');
  OpenDesktop;

  frmCmdCentre := TfrmCmdCentre.Create(self);
  with frmCmdCentre do
  begin
    Parent := self;
    frmCmdCentre.Visible := false; // forbid auto-reshow
    Docked := mCmdDocked.Checked;
    mCmdLeft.Enabled := mCmdDocked.Checked;
    mCmdRight.Enabled := mCmdDocked.Checked;
    LeftAlign := mCmdLeft.Checked;
    Visible := mAlwaysVis.Checked;
    Paged := mCmdPaged.Checked;
    AlwaysVis := mAlwaysVis.Checked;
    Reshow;
    RegProcs;
    if frmCmdCentre.Visible then
      splComCentre.Left := frmCmdCentre.Width + 3;
  end;

  frmDvcRack := TfrmDvcRack.Create(self);
  with frmDvcRack do
  begin
    Parent := self;
    for i := 1 to ParamCount do
      if LowerCase(ParamStr(i)) = '-r' then
        frmDvcRack.Enabled := false;
    mDevices.Enabled := frmDvcRack.Enabled;
    mUniScan.Enabled := frmDvcRack.Enabled;
    mAutoTune.Enabled := frmDvcRack.Enabled;
    Initialise;
    SetDevices;
    UpdateTabs(Options.UserTabs);
    Docked := mDvcDocked.Checked;
    Show;
  end;
  for i := 0 to DvcVis.Count - 1 do
    if DvcByName(DvcVis.Names[i]) <> nil then
    begin
      j := StrToInt(DvcVis.Values[DvcVis.Names[i]]);
      DvcByName(DvcVis.Names[i]).Maximed := (j <> 0);
      if j > 0 then
      begin
        DvcByName(DvcVis.Names[i]).PageControl1.ActivePageIndex := j - 1;
        DvcByName(DvcVis.Names[i]).PageControl1Change(nil);
      end;
    end;
  Plots := TPlots.Create(self);
  Plots.DataPath := Options.SpectraPath;
  with Plots do
    Docked := mTabbedPlots.Checked;

  mRefreshClick(nil);
  CoolBar1.Enabled := true;
end;

procedure TfrmSpion.mSimpleScanClick(Sender: TObject);
var
  ss: string;
begin
  ss := '';
  CallProc('SimpleScan', false, true, ss);
  mRefreshClick(nil);
end;

procedure TfrmSpion.mSmartCopyClick(Sender: TObject);
var
  ss: string;
begin
  ss := '';
  CallProc('SmartCopy', false, true, ss);
  mRefreshClick(nil);
end;

procedure TfrmSpion.mUniScanClick(Sender: TObject);
var
  ss: string;
begin
  ss := '';
  CallProc('UniScan', false, true, ss);
  mRefreshClick(nil);
end;

procedure TfrmSpion.OpenDesktop;
begin
  with DesktopIni do
  begin
    mAlwaysVis.Checked := ReadBool('CmdCentre', 'AlwaysVis', true);
    mCmdDocked.Checked := ReadBool('CmdCentre', 'Docked', true);
    mCmdLeft.Checked := ReadBool('CmdCentre', 'LeftAlign', true);
    mCmdRight.Checked := not mCmdLeft.Checked;
    mCmdPaged.Checked := ReadBool('CmdCentre', 'Paged', true);
    mCmdTiled.Checked := not mCmdPaged.Checked;
    mDvcDocked.Checked := ReadBool('Devices', 'Docked', false);
    mFloatPlots.Checked := ReadBool('Plots', 'Floated', true);
    mTabbedPlots.Checked := not mFloatPlots.Checked;
    mTile.Enabled := mFloatPlots.Checked;
    mCascade.Enabled := mFloatPlots.Checked;
    TheLastTrainingList:= ReadString('PCA','LastTraining','');
    TheLastRefFile := ReadString('AutoTune', 'LastRefFile', '');

    DvcVis := TStringList.Create;
    ReadSectionValues('Devices', DvcVis);
  end;
end;

procedure TfrmSpion.SaveDesktop;
var
  i, j: integer;
begin
  with DesktopIni do
  begin
    WriteBool('CmdCentre', 'AlwaysVis', mAlwaysVis.Checked);
    WriteBool('CmdCentre', 'Docked', mCmdDocked.Checked);
    WriteBool('CmdCentre', 'LeftAlign', mCmdLeft.Checked);
    WriteBool('CmdCentre', 'Paged', mCmdPaged.Checked);
    WriteBool('Devices', 'Docked', mDvcDocked.Checked);
    WriteBool('Plots', 'Floated', mFloatPlots.Checked);
    WriteString('PCA','LastTraining',TheLastTrainingList);
    WriteString('AutoTune', 'LastRefFile', TheLastRefFile);
    for i := 0 to length(allDvcs) - 1 do
    begin
      j := allDvcs[i].PageControl1.ActivePageIndex + 1;
      if not allDvcs[i].Maximed then
        j := 0;
      WriteInteger('Devices', UpperCase(allDvcs[i].Name), j);
    end;
  end;
end;

procedure TfrmSpion.mAlwaysVisClick(Sender: TObject);
var
  bb: boolean;
begin
  bb := frmCmdShell.Visible;
  mAlwaysVis.Checked := not mAlwaysVis.Checked;
  frmCmdCentre.AlwaysVis := mAlwaysVis.Checked;
  if frmCmdShell.Visible <> bb then
    mRefreshClick(nil);
end;

procedure TfrmSpion.mCmdDockedClick(Sender: TObject);
begin
  mCmdDocked.Checked := not mCmdDocked.Checked;
  frmCmdCentre.Docked := mCmdDocked.Checked;
  mCmdLeft.Enabled := mCmdDocked.Checked;
  mCmdRight.Enabled := mCmdDocked.Checked;
  mRefreshClick(nil);
end;

procedure TfrmSpion.mCmdLeftClick(Sender: TObject);
begin
  mCmdLeft.Checked := true;
  frmCmdCentre.LeftAlign := true;
  mRefreshClick(nil);
end;

procedure TfrmSpion.mCmdRightClick(Sender: TObject);
begin
  mCmdRight.Checked := true;
  frmCmdCentre.LeftAlign := false;
  mRefreshClick(nil);
end;

procedure TfrmSpion.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i, j: integer;
begin
  for i := 0 to Plots.Count - 1 do
    if Plots[i].AcqMode then
    begin
      if MessageDlg('There is still acquisition running. Exit anyway?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        if tbOscilo.Down or tbAcquire.Down then
          fmSynchro.DataStm[Plots[i].DataStmN].Close;
        Plots[i].AcqMode := false;
        Plots[i].Spec.AutoRefresh := false;
        fmSynchro.AbortClick := true;
        Application.ProcessMessages;
      end
      else
      begin
        Action := caNone;
        exit;
      end;
    end;
  if frmCmdCentre.Visible then
    frmCmdCentre.FreeProc;
  if frmOptions.rgSaveOptions.ItemIndex = 0 then
    Options.Save;
  SaveDesktop;
  DesktopIni.Free;
  if Plots <> nil then
    Plots.Clear;
  // if Plots.Count>1 then Plots.Docked:= false;
  frmDvcRack.Closure;
end;

procedure TfrmSpion.mRefreshClick(Sender: TObject);
begin
  Width := Screen.Width;
  Left := 0;
  splComCentre.Visible:= frmCmdCentre.Visible and not frmCmdShell.Visible;
  if splComCentre.Visible then
  begin
    splComCentre.Align:= frmCmdCentre.Align;
    if splComCentre.Align=alLeft then splComCentre.Left:= frmCmdCentre.Width+10
      else splComCentre.Left:= width - frmCmdCentre.Width-10;
  end;
  frmDvcShell.Visible := frmDvcRack.Enabled;
  if frmCmdShell.Visible then
  begin
    frmCmdShell.Align := alLeft;
    Width := Width - frmCmdShell.Width;
    Left := frmCmdShell.Width;
    Refresh;
  end;
  if frmDvcShell.Visible then
  begin
    frmDvcShell.Align := alRight;
    Width := Width - frmDvcShell.Width;
    Refresh;
  end;
  Top := 0;
  Align := alClient;
  Refresh;
  Align := alNone;
  frmCmdShell.Align := alNone;
  frmDvcShell.Align := alNone;
end;

procedure TfrmSpion.mDvcDockedClick(Sender: TObject);
begin
  mDvcDocked.Checked := not mDvcDocked.Checked;
  frmDvcRack.Docked := mDvcDocked.Checked;

  mRefreshClick(nil);
end;

procedure TfrmSpion.mFloatPlotsClick(Sender: TObject);
begin
  mFloatPlots.Checked := true;
  Plots.Docked := false;
  mTile.Enabled := true;
  mCascade.Enabled := true;
end;

procedure TfrmSpion.mTabbedPlotsClick(Sender: TObject);
begin
  mTabbedPlots.Checked := true;
  Plots.Docked := true;
  mTile.Enabled := false;
  mCascade.Enabled := false;
end;

procedure TfrmSpion.mCmdPagedClick(Sender: TObject);
begin
  mCmdPaged.Checked := true;
  frmCmdCentre.Paged := mCmdPaged.Checked;
end;

procedure TfrmSpion.mCmdTiledClick(Sender: TObject);
begin
  mCmdTiled.Checked := true;
  frmCmdCentre.Paged := mCmdPaged.Checked;
end;

procedure TfrmSpion.mCloseClick(Sender: TObject);
begin
  if Plots.Count > 0 then
    if Plots[Plots.Active].AcqMode then
      ErrorMsg('There is still acquisition running.')
    else
      Plots.Delete(Plots.Active);
end;

procedure TfrmSpion.mClearAllClick(Sender: TObject);
var
  i, j: integer;
begin
  if Plots.Count = 0 then
    exit;
  for i := Plots.Count - 1 downto 0 do
  begin
    Plots.Active := i;
    mCloseClick(nil);
  end;
end;

procedure TfrmSpion.mTileClick(Sender: TObject);
begin
  Tile;
end;

procedure TfrmSpion.mCascadeClick(Sender: TObject);
begin
  Cascade;
end;

procedure TfrmSpion.mOptionsClick(Sender: TObject);
begin
  frmOptions.Execute;
end;

procedure TfrmSpion.DisplayHint(Sender: TObject);
var
  ss: string;
begin
  ss := Application.Hint;
  StatusBar1.Panels[1].Text := ' ' + GetLongHint(ss);
end;

procedure TfrmSpion.FormCreate(Sender: TObject);
begin // Randomize;
  Application.HelpFile := ExePath + 'spectrion.chm';
  Application.OnHint := DisplayHint;
  if not DirectoryExists(RootPath + TempPath) then
    CreateDir(RootPath + TempPath);
end;

procedure TfrmSpion.MOpenClick(Sender: TObject);
var
  i, j, k: integer;
  Prs: TParser;
  FStm: TStringStream;
  ss, st: string;
begin
  OpenDialog1.InitialDir := Options.SpectraPath + '\';
  if not OpenDialog1.Execute then
    exit;
  if OpenDialog1.Files.Count > (Plots.MaxNPlots - Plots.Count - 1) then
    j := Plots.MaxNPlots - Plots.Count - 1
  else
    j := OpenDialog1.Files.Count;
  for k := 0 to j - 1 do
  begin
    i := Plots.Add(Options.Templates[2]);
    Plots[i].OpenData(OpenDialog1.Files[k]);
  end;
end;

function TfrmSpion.CheckForAcq(tb: TToolButton): boolean;
// true - good ; false - bad
var dvc: string;
begin
  Result := true;
  try
    if StrToBool(InterprtD('Itr.BusGet')) then
    begin
      ErrorMsg('Device rack is busy !');
      tb.Down := false;
      exit;
    end;
    if not StrToBool(InterprtD('Itr.EnbGet')) then
    begin
      ErrorMsg('Main switch is OFF !');
      tb.Down := false;
      exit;
    end;
    if tb=tbOscilo then Dvc:= Options.OsciloDvc;
    if tb=tbAcquire then Dvc:= Options.AcquireDvc;
    if not StrToBool(InterprtD(dvc+'.EnbGet')) then
    begin
      ErrorMsg('Spectral simulation machine ('+dvc+') is OFF !');
      tb.Down := false;
      exit;
    end;
  finally
    Result := tb.Down;
  end;
end;

procedure TfrmSpion.tbOsciloClick(Sender: TObject);
var
  i, j: integer;
  ss: string;
  bb: boolean;
begin
  if tbOscilo.Down then
  begin
    i := -1;
    if not CheckForAcq(tbOscilo) then
      exit;
    if (Plots.Count = 0) or not Options.Oscilo then
      i := Plots.Add('')
    else
      i := Plots.Active;
    Plots[i].MassOnly := true;
    ss := 'snh.sdsopn('+Options.OsciloDvc+',' + PlotAbrv + GetPlotSymbol(i + 1) + ')';
    bb := Interprt(ss);
    tbOscilo.Down := bb;
    tbOscilo.Tag := Plots[i].DataStmN;
    Plots[i].tbDataStream := tbOscilo;
  end
  else
    fmSynchro.DataStm[tbOscilo.Tag].Close;
end;

procedure TfrmSpion.ToolButton1Click(Sender: TObject);
var wp: PAnsiChar;
begin
//wp:= PAnsiChar();
Showmessage(nc_inq_libvers);
end;



procedure TfrmSpion.tbAcquireClick(Sender: TObject);
var
  i, j: integer;
  ss: string;
  bb: boolean;
begin
  if tbAcquire.Down then
  begin
    i := -1;
    if not CheckForAcq(tbAcquire) then
      exit;
    if Plots.Count = 0 then
      i := Plots.Add('')
    else
    begin
      for j := 0 to Plots.Count - 1 do
        if Plots[j].tbDataStream = tbAcquire then
        begin
          i := j;
          break;
        end;
    end;
    if i = -1 then
      i := Plots.Add('');
    if i = -1 then
      exit;
    Plots.Active := i;
    Plots[i].MassOnly := false;
    ss := 'snh.sdsopn('+Options.AcquireDvc+',' + PlotAbrv + GetPlotSymbol(i + 1) + ')';
    bb := Interprt(ss);
    tbAcquire.Down := bb;
    tbAcquire.Tag := Plots[i].DataStmN;
    Plots[i].tbDataStream := tbAcquire;
  end
  else
    InterprtD('snh.dsmcls(' + IntToStr(tbAcquire.Tag) + ')');
end;

procedure TfrmSpion.mExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSpion.mAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmSpion.mAutoTuneClick(Sender: TObject);
var
  ss: string;
begin
  ss := 'defaults.tun';
  CallProc('AutoTune', false, true, ss);
  mRefreshClick(nil);
end;

procedure TfrmSpion.mContentsClick(Sender: TObject);
begin
  Application.HelpContext(1000);
end;

procedure TfrmSpion.mCutClick(Sender: TObject);
begin
  if (ActiveControl is TCustomEdit) then
    TCustomEdit(ActiveControl).CutToClipboard;
  if (ActiveControl is TComboBox) then
  begin
    Clipboard.AsText := (ActiveControl as TComboBox).SelText;
    (ActiveControl as TComboBox).SelText := '';
  end;
end;

procedure TfrmSpion.mCopyClick(Sender: TObject);
begin
  if (ActiveControl is TCustomEdit) then
    TCustomEdit(ActiveControl).CopyToClipboard;
  if (ActiveControl is TComboBox) then
  begin
    Clipboard.AsText := (ActiveControl as TComboBox).SelText;
  end;
end;

procedure TfrmSpion.mPasteClick(Sender: TObject);
begin
  if (ActiveControl is TCustomEdit) then
    TCustomEdit(ActiveControl).PasteFromClipboard;
  if (ActiveControl is TComboBox) then
  begin
    (ActiveControl as TComboBox).SelText := Clipboard.AsText;
  end;
end;

procedure TfrmSpion.mPCAClick(Sender: TObject);
var
  ss: string;
begin
  ss := '';
  CallProc('PCAclass', false, true, ss);
  mRefreshClick(nil);
end;

procedure TfrmSpion.mNewGCMSClick(Sender: TObject);
var
  i, j: integer;
begin
  i := Plots.Add(Options.Templates[1]);
  if i > -1 then
    Plots[i].MassOnly := false;
end;

procedure TfrmSpion.mNewMSClick(Sender: TObject);
var
  i, j: integer;
begin
  i := Plots.Add(Options.Templates[1]);
  if i > -1 then
    Plots[i].MassOnly := true;
end;

procedure TfrmSpion.mSaveAsClick(Sender: TObject);
var
  i, j: integer;
  ss: string;
begin
  j := Plots.Active;
  if j < 0 then
    exit;
  if Sender = mSave then
    ss := Plots[j].Spec.Filename
  else
    ss := '';
  if Plots[j].IsEmpty then
    ErrorMsg('The plot is empty.')
  else
    Plots[j].SaveData(ss);
end;

procedure TfrmSpion.mFromTemplateClick(Sender: TObject);
var
  ss: string;
begin
  if OpenDialog2.Execute then
    ss := OpenDialog2.Filename
  else
    ss := '';
  Plots.Add(ss);
end;

procedure TfrmSpion.mOsciloClick(Sender: TObject);
begin
  tbOscilo.Down := not tbOscilo.Down;
  tbOsciloClick(nil);
end;

procedure TfrmSpion.mAcquireClick(Sender: TObject);
begin
  tbAcquire.Down := not tbAcquire.Down;
  tbAcquireClick(nil);
end;

procedure TfrmSpion.mMinMaxClick(Sender: TObject);
begin
  case WindowState of
    wsNormal:
      WindowState := wsMaximized;
    wsMaximized:
      WindowState := wsNormal;
  end;
end;

end.
