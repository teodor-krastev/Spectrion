unit DvcRackU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, StdCtrls, MsrDeviceU, CtrlDeviceU, Menus,
  DeviceU, {Simul_TLB,} SpecU, Vcl.ImgList;

const
  MaxNDvc = 10;

type
  TfrmDvcRack = class(TFrame)
    TabControl1: TTabControl;
    ScrollBox1: TScrollBox;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    tbStopStart: TToolButton;
    tbExtended: TToolButton;
    tbLock: TToolButton;
    tbNormal: TToolButton;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    tbSetting: TToolButton;
    ToolButton2: TToolButton;
    tbOptions: TToolButton;
    FontDialog1: TFontDialog;
    tbOpenSetting: TToolButton;
    tbSaveSetting: TToolButton;
    ToolButton3: TToolButton;
    PopupMenu1: TPopupMenu;
    pmFont: TMenuItem;
    pmSynchro: TMenuItem;
    ToolBar2: TToolBar;
    ImageList2: TImageList;
    mUpdate: TMenuItem;
    procedure ScrollBox1Resize(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure tbLockClick(Sender: TObject);
    procedure tbNormalClick(Sender: TObject);
    procedure tbStopStartClick(Sender: TObject);
    procedure tbOpenSettingClick(Sender: TObject);
    procedure tbSaveSettingClick(Sender: TObject);
    procedure pmFontClick(Sender: TObject);
    procedure pmSynchroClick(Sender: TObject);
    procedure mUpdateClick(Sender: TObject);
  private
    { Private declarations }
    fDocked: boolean;
    fLocked: boolean;
    fMainSwitch: boolean;
    UTabs: TStrings;
    procedure OrderDvcs;
    procedure SetDocked(Value: boolean);
    procedure SetMainSwitch(Value: boolean);
    procedure SetLocked(Value: boolean);
  public
    { Public declarations }
    property Docked: boolean read fDocked write SetDocked;
    property MainSwitch: boolean read fMainSwitch write SetMainSwitch
      default false;
    property Locked: boolean read fLocked write SetLocked;

    function AddDvc(ADvc: TdDevice; DName: string): integer;
    function AddMsr(AMsr: TmsrDevice; DName: string): integer;
    function AddCtrl(ACtrl: TctrlDevice; DName: string): integer;
    function SetDevices: boolean;
    function Initialise: boolean;
    function Closure: boolean;
    procedure UpdateTabs(inTabs: TStrings);
  end;

function DvcByName(DName: string): TdDevice;
function MDByName(MName: string): TmsrDevice;
function CDByName(MName: string): TctrlDevice;

procedure DvcList(dList: TStrings; DvcKind: tDvcKind; HeaderOn: boolean = false);

var
  frmDvcRack: TfrmDvcRack;
  msrDvcs: array of TmsrDevice;
  ctrlDvcs: array of TctrlDevice;
  allDvcs: array of TdDevice;

  buffXY: tXYarray; // general data buffer

  // Simul: TCOMsimul;

implementation

uses DvcShellU, MsrDevice1U, CtrlDevice1U, DataStreamU, OptionsU,
  PlotCollectU, SynchroU, CmdCentreU, AboutU, AutoTuneSimulU;
{$R *.DFM}

function DvcByName(DName: string): TdDevice;
var
  i: byte;
begin
  Result := nil;
  if allDvcs = nil then
    exit;
  for i := low(allDvcs) to high(allDvcs) do
    if SameText(DName,allDvcs[i].Name) then
    begin
      Result := allDvcs[i];
      exit;
    end;
end;

function MDByName(MName: string): TmsrDevice;
var
  i: byte;
begin
  Result := nil;
  if msrDvcs = nil then
    exit;
  for i := low(msrDvcs) to high(msrDvcs) do
    if SameText(MName,msrDvcs[i].Name) then
    begin
      Result := msrDvcs[i];
      exit;
    end;
end;

function CDByName(MName: string): TctrlDevice;
var
  i: byte;
begin
  Result := nil;
  if ctrlDvcs = nil then
    exit;
  for i := low(ctrlDvcs) to high(ctrlDvcs) do
    if SameText(MName,ctrlDvcs[i].Name) then
    begin
      Result := ctrlDvcs[i];
      exit;
    end;
end;

procedure DvcList(dList: TStrings; DvcKind: tDvcKind; HeaderOn: boolean = false);
var i: byte;
begin
  dList.Clear;
  case DvcKind of
    dkCtrl:begin
      for i:= 0 to length(ctrlDvcs)-1 do
        if HeaderOn then dList.Add(ctrlDvcs[i].Header)
          else dList.Add(ctrlDvcs[i].Name);
    end;
    dkMsr:begin
      for i:= 0 to length(msrDvcs)-1 do
        if HeaderOn then dList.Add(msrDvcs[i].Header)
          else dList.Add(msrDvcs[i].Name);
    end;
  end;
end;

procedure TfrmDvcRack.SetDocked(Value: boolean);
begin
  fDocked := Value;
  if not Visible then
    exit;
  if fDocked then
  begin
    Parent := Application.MainForm;
    frmDvcShell.Hide;
    Align := alRight;
    Width := DvcWidth;
  end
  else
  begin
    Parent := frmDvcShell;
    frmDvcShell.Show;
    Align := alClient;
  end;
end;

procedure TfrmDvcRack.OrderDvcs;
var
  i, j, k, m: integer;
  ls: TStrings;
  wdn: string;
begin
  ls := TStringList.Create;
  for m := 0 to length(allDvcs) - 1 do
  begin
    k := 100;
    wdn := '';
    for i := 0 to length(allDvcs) - 1 do
    begin
      if not allDvcs[i].Visible then
        continue;
      if ls.IndexOf(allDvcs[i].Name) > -1 then
        continue;
      j := Options.CheckDvcOrder(allDvcs[i].Name);
      if j = -1 then
        continue;
      if j < k then
      begin
        wdn := allDvcs[i].Name;
        k := j;
      end;
    end;
    if wdn <> '' then
      ls.Add(wdn);
  end;
  j := 0;
  for i := 0 to ls.Count - 1 do
  begin
    DvcByName(ls[i]).Top := j;
    j := j + DvcByName(ls[i]).Height;
  end;
  ls.Free;
end;

procedure TfrmDvcRack.SetMainSwitch(Value: boolean);
var
  i, j: integer;
  ds: TDevState;
begin
  if not Enabled then
  begin
    fMainSwitch := false;
    exit;
  end;
  if fMainSwitch = Value then
    exit;
  fMainSwitch := Value;
  if Value then
    tbStopStart.ImageIndex := 1
  else
    tbStopStart.ImageIndex := 0;
  for i := low(allDvcs) to high(allDvcs) do
  begin
    allDvcs[i].MainSwitch := Value;
    if allDvcs[i].DevRoundedState <> csOffLine then
      allDvcs[i].RefreshSwitchState;
  end;
end;

procedure TfrmDvcRack.SetLocked(Value: boolean);
var
  i: byte;
begin
  fLocked := Value;
  tbLock.Down := fLocked;
  for i := low(ctrlDvcs) to high(ctrlDvcs) do
    ctrlDvcs[i].Locked := Value;
  for i := low(msrDvcs) to high(msrDvcs) do
    msrDvcs[i].Locked := Value;
end;

function TfrmDvcRack.AddDvc(ADvc: TdDevice; DName: string): integer;
var
  i, j: integer;
begin
  SetLength(allDvcs, length(allDvcs) + 1);
  i := high(allDvcs);
  allDvcs[i] := ADvc;
  allDvcs[i].Parent := ScrollBox1;
  allDvcs[i].Show;
  allDvcs[i].OnResize := ScrollBox1Resize;
  allDvcs[i].Name := DName;
  allDvcs[i].MainSwitch := MainSwitch;
  allDvcs[i].Maximed := Options.CheckDvcMax(DName);
  allDvcs[i].IniSet;
  Result := i;
end;

function TfrmDvcRack.AddMsr(AMsr: TmsrDevice; DName: string): integer;
var
  i, j: integer;
begin
  AddDvc(TdDevice(AMsr), DName);
  SetLength(msrDvcs, length(msrDvcs) + 1);
  i := high(msrDvcs);
  msrDvcs[i] := AMsr;
  Result := i;
end;

function TfrmDvcRack.AddCtrl(ACtrl: TctrlDevice; DName: string): integer;
var
  i, j: integer;
begin
  AddDvc(TdDevice(ACtrl), DName);
  SetLength(ctrlDvcs, length(ctrlDvcs) + 1);
  i := high(ctrlDvcs);
  ctrlDvcs[i] := ACtrl;
  Result := i;
end;

function TfrmDvcRack.SetDevices: boolean;
var
  i, j: integer;
  bb: boolean;
  ss: string;
begin
  CoolBar1.Align := alTop;
  bb := true;
  if not Enabled then
    exit;
  fmSynchro := TfmSynchro.Create(self);
  fmSynchro.Parent := self;
  fmSynchro.Align := alTop;
  fmSynchro.Top := CoolBar1.Height + 5;
  fmSynchro.ModSet('DLY=100');
  // Msr's
  ss := 'MT1'; // decice name
  if Options.CheckDvcExist(ss) then
  begin
    j := AddMsr(TmsrDevice1.Create(self), ss);
    msrDvcs[j].Header := 'Measurement Simulation Device';
    if Options.CheckDvcEnabled(ss) then
      bb := bb and msrDvcs[j].EnbSet(false);
  end;
  ss := 'MT2'; // decice name
  if Options.CheckDvcExist(ss) then
  begin
    j := AddMsr(TmsrDevice1.Create(self), ss);
    msrDvcs[j].Header := 'Another Msr Simul Device';
    if Options.CheckDvcEnabled(ss) then
      bb := bb and msrDvcs[j].EnbSet(false);
  end;
  // Ctrl's
  ss := 'CT1'; // device name
  if Options.CheckDvcExist(ss) then
  begin
    j := AddCtrl(TctrlDevice1.Create(self), ss);
    ctrlDvcs[j].Header := 'Control Simulation Device';
    (ctrlDvcs[j] as TctrlDevice1).OnCondChange:= AutoTuneSimul.OnCondChange;
    if Options.CheckDvcEnabled(ss) then
      bb := bb and ctrlDvcs[j].EnbSet(false);
  end;
  ss := 'CT2'; // device name
  if Options.CheckDvcExist(ss) then
  begin
    j := AddCtrl(TctrlDevice1.Create(self), ss);
    ctrlDvcs[j].Header := 'Another Ctrl Simul Device';
    (ctrlDvcs[j] as TctrlDevice1).OnCondChange:= AutoTuneSimul.OnCondChange2;
    if Options.CheckDvcEnabled(ss) then
      bb := bb and ctrlDvcs[j].EnbSet(false);
  end;
  { if Options.CheckDvcExist('SMN') or Options.CheckDvcExist('IOP') or
    Options.CheckDvcExist('MAB') then
    begin HDVM:= THDVM.Create(self); //HDVM.LoadRunName(ExePath+'Default.r');
    ss:= 'SMN'; // decice name
    if Options.CheckDvcExist(ss) then
    begin j:= AddMsr(TmsrSMN.Create(self),ss);
    msrDvcs[j].Header:= 'Spectral Machine';
    if Options.CheckDvcEnabled(ss) then
    bb:= bb and msrDvcs[j].EnbSet(false);
    end;
    ss:= 'IOP'; // decice name
    if Options.CheckDvcExist(ss) then
    begin j:= AddCtrl(TctrlIOP.Create(self),ss);
    ctrlDvcs[j].Header:= 'Ion Optics';
    if Options.CheckDvcEnabled(ss) then
    bb:= bb and ctrlDvcs[j].EnbSet(false);
    end;
    ss:= 'MAB'; // decice name
    if Options.CheckDvcExist(ss) then
    begin j:= AddCtrl(TctrlMAB.Create(self),ss);
    ctrlDvcs[j].Header:= 'MAB Source';
    if Options.CheckDvcEnabled(ss) then
    bb:= bb and ctrlDvcs[j].EnbSet(false);
    end;
    end;
    ss:= 'PRL'; // decice name
    if Options.CheckDvcExist(ss) then
    begin j:= AddCtrl(TctrlPrl.Create(self),ss);
    ctrlDvcs[j].Header:= 'Pyrolyzer';
    if Options.CheckDvcEnabled(ss) then
    bb:= bb and ctrlDvcs[j].EnbSet(false);
    end;
    ss:= 'SMA'; // decice name
    if Options.CheckDvcExist(ss) then
    begin j:= AddCtrl(TctrlSMA.Create(self),ss);
    ctrlDvcs[j].Header:= 'Auto-Pyrolyzer';
    if Options.CheckDvcEnabled(ss) then
    bb:= bb and ctrlDvcs[j].EnbSet(false);
    end;
    ss:= 'GCH'; // decice name
    if Options.CheckDvcExist(ss) then
    begin j:= AddCtrl(TctrlGCh.Create(self),ss);
    ctrlDvcs[j].Header:= 'Gas-Chrom';
    if Options.CheckDvcEnabled(ss) then
    bb:= bb and ctrlDvcs[j].EnbSet(false);
    end;
    ss:= 'PAL'; // decice name
    if Options.CheckDvcExist(ss) then
    begin j:= AddCtrl(TctrlPal.Create(self),ss);
    ctrlDvcs[j].Header:= 'CTC PAL';
    if Options.CheckDvcEnabled(ss) then
    bb:= bb and ctrlDvcs[j].EnbSet(false);
    end;
    ss:= 'APC'; // decice name
    if Options.CheckDvcExist(ss) then
    begin j:= AddCtrl(TctrlAP.Create(self),ss);
    ctrlDvcs[j].Header:= 'AutoProbe';
    if Options.CheckDvcEnabled(ss) then
    bb:= bb and ctrlDvcs[j].EnbSet(false);
    end; }
  OrderDvcs;
  if Options.AutoRunScript <> '' then
    RunScript(Options.AutoRunScript);
  // if (Simul=nil) and ExtSimul then Simul:= TCOMsimul.Create(self);
  Result := bb;
end; { TfrmDvcRack.SetDevices }

function TfrmDvcRack.Initialise: boolean;
begin
  Result := true;
  fMainSwitch := false;
end;

procedure TfrmDvcRack.mUpdateClick(Sender: TObject);
begin
  Refresh;
end;

function TfrmDvcRack.Closure: boolean;
var
  i, j: integer;
  bb: boolean;
  h: HWND;
  ss: string;
begin
  bb := true;
  MainSwitch := false;
  for i := low(allDvcs) to high(allDvcs) do
  begin
    ss := '';
    if Options.AutoSave then
      allDvcs[i].SetSav(ss);
    bb := bb and allDvcs[i].ClsSet;
  end;
  Result := bb;
end;

procedure TfrmDvcRack.UpdateTabs(inTabs: TStrings);
var
  i, j: integer;
  ss: string;
begin
  if Assigned(inTabs) then
    UTabs := inTabs;
  ss := TabControl1.Tabs[TabControl1.TabIndex];
  with TabControl1.Tabs do
  begin
    Clear;
    Add('Ctrl Dvcs');
    Add('Msr Dvcs');
    Add('All Dvcs');
    if Assigned(inTabs) then
      for i := 0 to UTabs.Count - 1 do
        Add(UTabs.Names[i]);
    j := TabControl1.Tabs.IndexOf(ss);
    if j = -1 then
      TabControl1.TabIndex := 2
    else
      TabControl1.TabIndex := j;
    TabControl1Change(nil);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////
procedure TfrmDvcRack.ScrollBox1Resize(Sender: TObject);
var
  i, j: integer;
begin
  with ScrollBox1 do
  begin
    j := 0;
    for i := 0 to ControlCount - 1 do
      if Controls[i].Visible then
        j := j + Controls[i].Height;
    if j > ClientHeight then
      VertScrollBar.Range := j
    else
      VertScrollBar.Range := ClientHeight + 1;
  end;
  ToolBar1.Width:= CoolBar1.Width-tbStopStart.Width-37;
end;

procedure TfrmDvcRack.TabControl1Change(Sender: TObject);
var
  i, j: byte;
  b0, b1: boolean;
begin
  j := TabControl1.TabIndex;
  if j < 3 then
  begin
    b0 := (j = 1) or (j = 2);
    b1 := (j = 0) or (j = 2);
    if length(ctrlDvcs) > 0 then
      for i := high(ctrlDvcs) downto low(ctrlDvcs) do
      begin
        ctrlDvcs[i].Visible := b1 or Options.OnlyMin;
        if Options.OnlyMin then
          ctrlDvcs[i].Maximed := b1
        else
          ctrlDvcs[i].Maximed := true;
      end;
    if length(msrDvcs) > 0 then
      for i := high(msrDvcs) downto low(msrDvcs) do
      begin
        msrDvcs[i].Visible := b0 or Options.OnlyMin;
        if Options.OnlyMin then
          msrDvcs[i].Maximed := b0
        else
          msrDvcs[i].Maximed := true;
      end;
  end
  else
  begin
    if length(allDvcs) > 0 then
      for i := high(allDvcs) downto low(allDvcs) do
      begin
        b0 := Options.CheckUserTab(UTabs.Names[j - 3], allDvcs[i].Name);
        allDvcs[i].Visible := b0 or Options.OnlyMin;
        if Options.OnlyMin then
          allDvcs[i].Maximed := b0
        else
          allDvcs[i].Maximed := true;
      end;
  end;
  ScrollBox1Resize(nil);
  OrderDvcs;
end; { TfrmDvcRack.TabControl1Change }

procedure TfrmDvcRack.tbLockClick(Sender: TObject);
begin // tbLock.Down:= not tbLock.Down;
  Locked := tbLock.Down;
end;

procedure TfrmDvcRack.tbNormalClick(Sender: TObject);
var
  i, j: integer;
begin
  if Sender is TToolButton then
    j := (Sender as TToolButton).Tag
  else
    j := -1;
  for i := low(allDvcs) to high(allDvcs) do
  begin
    if j > -1 then
      allDvcs[i].PageControl1.ActivePageIndex := j;
    allDvcs[i].PageControl1Change(allDvcs[i].PageControl1);
  end;
end;

procedure TfrmDvcRack.tbStopStartClick(Sender: TObject);
begin
  MainSwitch := not fMainSwitch;
end;

procedure TfrmDvcRack.tbOpenSettingClick(Sender: TObject);
var
  ss: string;
begin
  if InputQuery('Open collective setting', 'Root filename', ss) then
    if ss <> '' then
      InterprtD('itr.setlod(' + ss + ')');
end;

procedure TfrmDvcRack.tbSaveSettingClick(Sender: TObject);
var
  ss: string;
begin
  if InputQuery('Save collective setting', 'Root filename', ss) then
    if ss <> '' then
      InterprtD('itr.setsav(' + ss + ')');
end;

procedure TfrmDvcRack.pmFontClick(Sender: TObject);
begin
  if FontDialog1.Execute then
    ScrollBox1.Font := FontDialog1.Font;
end;

procedure TfrmDvcRack.pmSynchroClick(Sender: TObject);
begin
  fmSynchro.pnlDCh0.Visible := pmSynchro.Checked;
end;

end.
