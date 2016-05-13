unit DeviceU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, ExtCtrls, StdCtrls, IniFiles, ShellAPI, Math, Vcl.ImgList;

const
  DvcWidth = 460;
  MinNChn = -10;
  MaxNChn = 16;

type
  TOnDvcStChange = procedure(const DvcName: WideString; OldSt: Integer;
    NewSt: Integer) of object;

  tDevState = (csNone, // undefined initial state
    csOffLine, // white, initialization did not pass or has not been done yet
    csStandby, // inactive caption, all tensions '0' and NO remotely access
    csRunning, // active caption, normal state
    csWarning, // as Running but with warning
    csDanger); // as Standby, but because of dangerous conditions
  TOnChangeState = procedure(OldSt, NewSt: tDevState) of object;
  TOnFireEvent = procedure(Dvc, Msg: string) of object;
  TOnDvcStEvent = procedure(Dvc: string; OldSt, NewSt: Integer; Msg: string)
    of object;

  tDvcKind = (dkCtrl, dkMsr);
  tPageState = (vsStandard, vsExtended, vsCalibr);

  TdDevice = class(TFrame)
    pnlHeader: TPanel;
    sbMinim: TSpeedButton;
    sbMaxim: TSpeedButton;
    sbStandBy: TSpeedButton;
    PageControl1: TPageControl;
    tsStandard: TTabSheet;
    tsExtended: TTabSheet;
    tsCalibr: TTabSheet;
    imgLocked: TImage;
    sbHelp: TSpeedButton;
    ImageList1: TImageList;
    procedure sbMinimClick(Sender: TObject);
    procedure sbMaximClick(Sender: TObject);
    procedure sbStandByClick(Sender: TObject);
    procedure pnlHeaderResize(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure pnlHeaderDblClick(Sender: TObject);
    procedure sbHelpClick(Sender: TObject);
  protected
    fLocked: boolean;
    fdKind: tDvcKind;
    fOnFireEvent: TOnFireEvent;
    FOnDvcStEvent: TOnDvcStEvent;
    fBusy: boolean;
    function IntEnbSet(Enb: boolean): boolean;
    function PrepSetFile(Filename: string): string;
  private
    { Private declarations }
    fMaximed: boolean;
    fDevState, OldState: tDevState;
    FOnDvcStChange: TOnDvcStChange;
    FOnChangeState, FOnChangingState: TOnChangeState;
    FOnChangePage: TNotifyEvent;

    procedure SetLocked(Value: boolean);
    procedure SetMaximed(Value: boolean);
    procedure SetDevState(Value: tDevState);
    procedure SetHeader(Value: string);
    function GetHeader: string;
    procedure ChangePageIndex; virtual; abstract;
    function GetErrorMessage: string;
    procedure SetErrorMessage(Value: string);
  public
    { Public declarations }
    Hyperlink: string;
    Setting: TIniFile;
    DftChn: Integer;
    MainSwitch, DvcSwitch, TempLock: boolean;
    MinEnChn, MaxEnChn: Integer;
    property DvcKind: tDvcKind read fdKind;
    property Locked: boolean read fLocked write SetLocked default false;
    // from manual control
    property Maximed: boolean read fMaximed write SetMaximed default true;
    property DevState: tDevState read fDevState write SetDevState
      default csOffLine;
    property Header: string read GetHeader write SetHeader;
    property ErrorMessage: string read GetErrorMessage write SetErrorMessage;

    property OnDvcStChange: TOnDvcStChange read FOnDvcStChange
      write FOnDvcStChange;
    property OnChangingState: TOnChangeState read FOnChangingState
      write FOnChangingState;
    property OnChangeState: TOnChangeState read FOnChangeState
      write FOnChangeState;
    property OnChangePage: TNotifyEvent read FOnChangePage write FOnChangePage;
    property OnFireEvent: TOnFireEvent read fOnFireEvent write fOnFireEvent;
    property OnDvcStEvent: TOnDvcStEvent read FOnDvcStEvent write FOnDvcStEvent;

    function DevRoundedState: tDevState;
    function CheckChn(var ChN: Integer): boolean;
    procedure RefreshSwitchState;

    function Initialise: boolean; virtual;

    // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    // (re)Initiate the device and return true/false for success
    function IniSet: boolean; virtual; abstract;

    // Check the device availability (is it connected, switched on and not StandBy)
    // and return true/false
    function EnbGet: boolean; virtual;

    // switch device on/off
    function EnbSet(Enb: boolean): boolean; virtual;

    // Check if the device is busy and return true/false
    function BusGet: boolean; virtual; abstract;

    // close whatever needs to be closed inside instrument
    function ClsSet: boolean; virtual; abstract;

    // if B then lock current manual device change
    // esle unlock current manual device change
    function DvcLck(Lck: boolean): boolean; virtual; abstract;

    // Load from FileName Dvc settings
    function SetLod(var Filename: string): boolean; virtual; abstract;

    // Save into FileName current Dvc settings
    function SetSav(var Filename: string): boolean; virtual; abstract;

    // Get back FileName of current Dvc settings
    function SetGet(var Filename: string): boolean;

    // The device interprets this text Command and returns the result as text
    function CmdExe(var Cmd: string): boolean; virtual; abstract;
  end;

function MyFloatToStr(a: double): string;

implementation
{$R *.DFM}
{$R Device.res}
uses AboutU;
const
  StdSize = 170;  ExtSize = 250;  CalSize = 350;

function MyFloatToStr(a: double): string;
begin
  Result := FloatToStrF(a, ffGeneral, 6, 3);
end;

function TdDevice.CheckChn(var ChN: Integer): boolean;
begin
  if ChN = 0 then
    ChN := DftChn;
  Result := (ChN >= MinEnChn) and (ChN <= MaxEnChn);
end;

function TdDevice.Initialise: boolean;
begin // spare initializing on a base level
  TempLock := false;
  DvcSwitch := true;
  Result := true;
  ErrorMessage := '';
  fBusy := false;
  PageControl1.ActivePageIndex := 0;
  tsStandard.Enabled := false;
  tsExtended.Enabled := false;
end;

function TdDevice.EnbGet: boolean;
begin
  Result := (DevRoundedState = csRunning);
end;

function TdDevice.EnbSet(Enb: boolean): boolean;
begin
  Result := false;
  if MainSwitch or not Enb then
    Result := IntEnbSet(Enb);
end;

function TdDevice.IntEnbSet(Enb: boolean): boolean;
begin
  Result := false;
  tsStandard.Enabled := true;
  tsExtended.Enabled := true;
  if Enb then
    DevState := csRunning
  else
    DevState := csStandby;
  Result := ((DevRoundedState = csRunning) and Enb) or
    ((DevRoundedState = csStandby) and not Enb);
end;

function TdDevice.SetGet(var Filename: string): boolean;
begin
  Result := true;
  if Setting = nil then
    Filename := '<none>'
  else
    Filename := Setting.Filename;
end;

procedure TdDevice.RefreshSwitchState; // after switches change
begin
  if MainSwitch then
    EnbSet(DvcSwitch)
  else
    EnbSet(false);
end;

procedure TdDevice.SetDevState(Value: tDevState); // only visual and events
var
  nm: WideString;
  bb: boolean;
  ss: string;
begin
  OldState := fDevState;
  fDevState := Value;
  { if MainSwitch then fDevState:= Value
    else begin
    if (DevRoundedState=csRunning) and
    ((Value=csRunning) or (Value=csWarning))
    then fDevState:= csStandBy
    else fDevState:= Value;    // fDevState takes the new state
    end; }
  ss := Name;
  if (DevState = csWarning) or (DevState = csDanger) then
    ss := ss + ':' + ErrorMessage;
  nm := WideString(ss);
  if Assigned(FOnDvcStChange) then
    FOnDvcStChange(nm, ord(OldState), ord(fDevState));
  if Assigned(FOnChangingState) then
    FOnChangingState(OldState, fDevState);
  bb := (OldState = csDanger) and (fDevState = csRunning);
  if bb then
    IniSet; // reini if the user is trying to remove danger conditions
  case fDevState of
    csRunning:
      begin
        pnlHeader.Color := $00758642;
        pnlHeader.Font.Color := clWhite;
        sbStandBy.Glyph.LoadFromResourceName(HInstance, 'RUNNING');
        sbStandBy.Hint := 'ON|The ' + Name + ' device is ON.';
      end;
    csDanger:
      begin
        pnlHeader.Color := clRed;
        pnlHeader.Font.Color := clBlack;
        if not MainSwitch and DvcSwitch then
          sbStandBy.Glyph.LoadFromResourceName(HInstance, 'STANDOFF')
        else
          sbStandBy.Glyph.LoadFromResourceName(HInstance, 'STANDBY');
        sbStandBy.Hint := 'Danger !!!|The ' + Name +
          ' device is OFF, because of dangrous conditions.';
      end;
    csWarning:
      begin
        pnlHeader.Color := clYellow;
        pnlHeader.Font.Color := clBlack;
        sbStandBy.Glyph.LoadFromResourceName(HInstance, 'RUNNING');
        sbStandBy.Hint := 'Warning !|The ' + Name +
          ' device is ON, but some parameters are out of normal range';
      end;
    csStandby:
      begin
        pnlHeader.Color := clGray;
        pnlHeader.Font.Color := clWhite;
        if not MainSwitch and DvcSwitch then
          sbStandBy.Glyph.LoadFromResourceName(HInstance, 'STANDOFF')
        else
          sbStandBy.Glyph.LoadFromResourceName(HInstance, 'STANDBY');
        sbStandBy.Hint := 'StandBy|The ' + Name + ' device is in StandBy.';
      end;
    csOffLine:
      begin
        pnlHeader.Color := clCream;
        pnlHeader.Font.Color := clBlack;
        sbStandBy.Glyph.LoadFromResourceName(HInstance, 'LIGHTIT');
        sbStandBy.Hint := 'Disconnected|The ' + Name +
          ' device is off-line, it has not been initialized yet.';
      end;
  end;
  if Assigned(FOnChangeState) and (OldState <> fDevState) then
    FOnChangeState(OldState, fDevState);
  if (fDevState = csWarning) or (fDevState = csDanger) then
    ss := ErrorMessage
  else
    ss := '';
  if Assigned(FOnDvcStEvent) and (OldState <> fDevState) then
    FOnDvcStEvent(name, ord(OldState), ord(fDevState), ss);
end; { TdDevice.SetDevState }

function TdDevice.DevRoundedState: tDevState;
begin
  case fDevState of
    csNone, csOffLine:
      Result := csOffLine;
    csRunning, csWarning:
      Result := csRunning;
    csStandby, csDanger:
      Result := csStandby;
  end;
end;

procedure TdDevice.SetLocked(Value: boolean);
begin
  fLocked := Value;
  imgLocked.Visible := Value;
  tsStandard.Enabled := not Value;
  tsExtended.Enabled := not Value;
  tsCalibr.Enabled := not Value;
  sbStandBy.Enabled := not Value;
end;

procedure TdDevice.SetMaximed(Value: boolean);
begin
  fMaximed := Value;
  PageControl1.Visible := fMaximed;
  if fMaximed then
    PageControl1Change(PageControl1)
  else
    ClientHeight := pnlHeader.Height;
  sbMaxim.Down := fMaximed;
  sbMinim.Down := not fMaximed;
end;

procedure TdDevice.sbMinimClick(Sender: TObject);
begin
  Maximed := not sbMinim.Down;
end;

procedure TdDevice.sbMaximClick(Sender: TObject);
begin
  Maximed := sbMaxim.Down;
end;

procedure TdDevice.pnlHeaderDblClick(Sender: TObject);
begin
  Maximed := not Maximed;
end;

procedure TdDevice.sbStandByClick(Sender: TObject);
begin
  case DevRoundedState of
    csOffLine:
      DvcSwitch := false;
  else
    DvcSwitch := not DvcSwitch;
  end;
  RefreshSwitchState;
end;

procedure TdDevice.pnlHeaderResize(Sender: TObject);
begin
  sbHelp.Left := pnlHeader.Width - 106;
  sbMinim.Left := sbHelp.Left + sbHelp.Width + 4;
  sbMaxim.Left := sbMinim.Left + sbMinim.Width;
  sbStandBy.Left := sbMaxim.Left + sbMaxim.Width + 4;
end;

procedure TdDevice.SetHeader(Value: string);
begin
  pnlHeader.Caption := ' ' + Value + ' (' + Name + ')';
end;

function TdDevice.GetHeader: string;
begin
  Result := pnlHeader.Caption;
end;

function TdDevice.GetErrorMessage: string;
var
  i, j: Integer;
  ss: string;
begin
  ss := pnlHeader.Hint;
  i := pos(':', ss);
  if i > 0 then
    delete(ss, 1, i);
  Result := ss;
end;

procedure TdDevice.SetErrorMessage(Value: string);
var
  ss: string;
begin
  ss := Value;
  if DevState = csWarning then
    ss := 'Warning: ' + ss;
  if DevState = csDanger then
    ss := 'Danger: ' + ss;
  pnlHeader.Hint := ss;
end;

function TdDevice.PrepSetFile(Filename: string): string;
var
  dr, fn: string;
begin
  dr := ExtractFileDir(fn);
  if Filename = '' then
    fn := 'Defaults'
  else
    fn := ExtractFilename(Filename);
  fn := ChangeFileExt(fn, '.' + Name);
  if (dr = '') or not DirectoryExists(dr) then
    dr := RootPath + ConfigPath;
  Result := dr + fn;
end;

procedure TdDevice.PageControl1Change(Sender: TObject);
var
  i, j, k, l, m: Integer; ts: TTabSheet;
begin
  if Assigned(FOnChangePage) then
    FOnChangePage(nil);
  if Sender = nil then
    Sender := PageControl1;
  if not(Sender is TPageControl) then
    exit;
  case (Sender as TPageControl).ActivePageIndex of
    0:
      ts := tsStandard;
    1:
      ts := tsExtended;
    2:
      ts := tsCalibr;
  end;
  j := 0;
  for i := 0 to ts.ControlCount - 1 do
  begin
    if ts.Controls[i].Visible then
      k := ts.Controls[i].Height + ts.Controls[i].Top;
    if k > j then
      j := k;
  end;
  if (ts.ControlCount = 0) and Maximed then
    j := 50;
  if (j > 0) and Maximed then
  begin
    ClientHeight := j + 37;
  end;
  if (ClientHeight < 225) and Maximed then
  begin
    tsStandard.Caption := '';
    tsExtended.Caption := '';
    tsCalibr.Caption := '';
  end
  else
  begin
    tsStandard.Caption := 'Normal';
    tsExtended.Caption := 'Extd.';
    tsCalibr.Caption := 'Setting';
  end;
end; { TdDevice.PageControl1Change }

procedure TdDevice.sbHelpClick(Sender: TObject);
begin
  if Hyperlink <> '' then
    ShellExecute(GetDesktopWindow(), 'open', PChar(Hyperlink), nil, nil,
      SW_SHOWNORMAL);
end;

end.
