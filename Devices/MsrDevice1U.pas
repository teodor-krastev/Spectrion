unit MsrDevice1U;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IniFiles, MsrDeviceU, ComCtrls, ExtCtrls, Buttons, StdCtrls, Spin, Grids,
  Chart, TeEngine, SpecU, Series, TeeProcs, DeviceU, ImgList;

type

  TmsrThread = class(TThread)
  private
    SpcGet: function(zChn: integer; var wXY: tXYarray): boolean;
  protected
    procedure MsrChannel;
    procedure Execute; override;
  end;

  TmsrDevice1 = class(TmsrDevice)
    sgPeaks: TStringGrid;
    Label1: TLabel;
    chkNoise: TCheckBox;
    seNoise: TSpinEdit;
    bFill: TButton;
    lbCount: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    nsSpeed: TSpinEdit;
    nsSplitOn: TSpinEdit;
    seDefaultChn: TSpinEdit;
    procedure bFillClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure nsSpeedChange(Sender: TObject);
    procedure nsSplitOnChange(Sender: TObject);
    procedure seDefaultChnChange(Sender: TObject);
  private
    { Private declarations }
    msrThread: TmsrThread;

    procedure MT1OnChangingState(OldSt, NewSt: tDevState);
    procedure MT1OnChangeState(OldSt, NewSt: tDevState);
  public
    { Public declarations }
    // (re)Initiate the device and return true/false for success
    function IniSet: boolean; override;

    // Close device
    function ClsSet: boolean; override;

    // Load from FileName Dvc settings
    function SetLod(var FileName: string): boolean; override;

    // Save into FileName current Dvc settings
    function SetSav(var FileName: string): boolean; override;

    // Set default channel of current spectrum to ChnIdx (2D device)
    function DftSet(ChnIdx: integer): boolean; override;

    // Measure and return the value of N channel of measured spectrum
    function ChnGet(ChnIdx: integer; var Chn: double): boolean; override;

    // Measure and put measured spectrum in the spectrum buffer - "wXY".
    // zChn specifies z-channel and it is valid only for 3D multi-channel
    // measurement device, otherwise is ignored
    function SpcGet(zChn: integer; var wXY: tXYarray): boolean; override;

    // turn one cicle of measurement in Syncho mode
    function DSmGet: boolean; override;
    // Set DataStream if Schr then seft-refreshing else wait for DSmGet
    // if srsC=nil and srsM=nil then close DataChannel
    // if Synchro=false but wSpec=nil switch in asynchro mode
    function DSmSet(Schr: boolean; wSpec: TSpec): boolean; override;

    /// ///////////////////////////////////////////////////////////////////////////
    // if B then lock current manual device change
    // else unlock current manual device change
    function DvcLck(Lck: boolean): boolean; override;

    // Return units of measurement, for multi-channel device and you input Dim="Abs"
    // the command returns for abscissa units (along the spectrum).
    // For multi-channel device N is zChn, otherwise N is a channel number
    // That is one way to check if certain MD is multi-channel,
    // when you ask the device for abscise units, multi-channel device
    // will return something, but single-channel one will reply with error message.
    function DimGet(N: integer; var Dim: string): boolean; override;

    // The device interprets this text Command and returns the result as text
    function CmdExe(var Cmd: string): boolean; override;

  end;

var
  msrDevice1, msrDevice2: TmsrDevice;

implementation
{$R *.DFM}

uses DvcRackU, AutoTuneSimulU, AboutU, Variants;
const
  LowestChn = 0; HighestChn = 1000;

var
  times: array [1 .. 4, 1 .. 10] of integer;
  TimeIdx: integer;

function Gauss(x, x0, sigma: real): real;
begin
  result := exp(-(sqr(x - x0) / (2 * sqr(sigma)))); // /sqrt(2*pi*sqr(sigma));
end;

procedure TmsrThread.MsrChannel;
begin
  msrDevice1.DSmGet;
end;

procedure TmsrThread.Execute;
var
  i, j: integer;
begin
  FreeOnTerminate := True;
  Priority := tpNormal;
  while not Terminated do
    Synchronize(MsrChannel);
end;

/// //////////////////////////////////////////////////////////////////
procedure TmsrDevice1.MT1OnChangingState(OldSt, NewSt: tDevState);
begin
end;

procedure TmsrDevice1.MT1OnChangeState(OldSt, NewSt: tDevState);
begin
end;

function TmsrDevice1.IniSet: boolean;
var
  i: integer;
  bb: boolean;
begin
  bb := Initialise;
  OnChangingState := MT1OnChangingState;
  OnChangeState := MT1OnChangeState;
  MultiChannel := True;
  sgPeaks.Cols[0].Add('#');
  for i := 1 to 19 do
    sgPeaks.Cols[0].Add(IntToStr(i));
  sgPeaks.Cells[1, 0] := 'Position';
  sgPeaks.Cells[2, 0] := 'Amplitude';
  bFillClick(nil);
  DevState := csOffline;
  result := bb;
  // if ExtSimul then AboutBox.Caption:= 'Simulation'
  // else AboutBox.Caption:= 'About';
end;

function TmsrDevice1.ClsSet: boolean;
begin
  result := EnbSet(false);
end;

function TmsrDevice1.DftSet(ChnIdx: integer): boolean;
begin
  DftSet := false;
  if (ChnIdx < LowestChn) then // if N is out of range
  begin
    DftChn := LowestChn;
    exit;
  end;
  if (ChnIdx > HighestChn) then // if N is out of range
  begin
    DftChn := HighestChn;
    exit;
  end;
  DftChn := ChnIdx;
  DftSet := True;
end;

function TmsrDevice1.ChnGet(ChnIdx: integer; var Chn: double): boolean;
var
  i, k, m: integer;
  cn, ns: real;
begin // only for simulation purposes - the device units should not call each other
  if ChnIdx = 2 then
  begin
    Chn:= AutoTuneSimul.TuneCoeff;
    result := True;
    exit;
  end;

  if ChnIdx = -999 then
    cn := DftChn
  else
    cn := ChnIdx;
  Chn := 0;
  ns := 0;
  result := false;
  for i := 1 to 20 do
  begin
    k := StrToInt(sgPeaks.Cells[1, i]);
    m := StrToInt(sgPeaks.Cells[2, i]);
    Chn := Chn + m * Gauss(cn, k, 4);
  end;
  if chkNoise.Checked then
    ns := seNoise.Value * random;
  Chn := 10 * Chn + ns;
  result := True;
end; { TmsrDevice1.ChnGet }

function TmsrDevice1.SpcGet(zChn: integer; var wXY: tXYarray): boolean;
var
  i, j, sz: integer;
  a, s: double;
  massX, massY: OleVariant;
begin
  result := false;
  if not MultiChannel then
    exit;
  sz := 1000;
  SetLength(wXY, sz);
  s := 0;
  for i := 0 to sz - 1 do
  begin
    ChnGet(i, a);
    wXY[i, x] := (i + 10) / 10;
    if zChn=2 then wXY[i, Y] := AutoTuneSimul.TuneCoeff*a
      else wXY[i, Y] := a;
  end;
  result := True;
end;

function TmsrDevice1.DvcLck(Lck: boolean): boolean;
begin
  result := false;
  Locked := Lck;
  Enabled := not Lck;
  result := True;
end;

function TmsrDevice1.DimGet(N: integer; var Dim: string): boolean;
begin
  result := false;
  Dim := 'us';
  result := True;
end;

function TmsrDevice1.CmdExe(var Cmd: string): boolean;
begin
  bFill.Caption := 'OK';
end;

function TmsrDevice1.DSmGet: boolean; // later with idx
var
  i, j: integer;
  a, s: double;
  bb: boolean;
  wXY: tXYarray;
begin
  result := false;
  if (Spec = nil) then
    exit;
  // times[1,Timer1.Tag]:= GetTickCount;
  SpcGet(DftChn, wXY);
  s := 0;
  for i := 0 to length(wXY) - 1 do
    s := s + wXY[i, Y];
  // times[2,Timer1.Tag]:= GetTickCount;
  Spec.AutoRefresh := false;
  if (Spec = nil) then
    exit;
  Spec.AddSSpec(Spec.NSpec + 1, s, wXY);
  if (Spec = nil) then
    exit;
  // times[3,Timer1.Tag]:= GetTickCount;
  Spec.AutoRefresh := True;
  if (Spec = nil) then
    exit;
  if Assigned(FOnTick) then
    FOnTick(self);
  // times[4,Timer1.Tag]:= GetTickCount;
  // Spec.CMass:= wXY;
  result := True;
end;

function TmsrDevice1.DSmSet(Schr: boolean; wSpec: TSpec): boolean;
var
  i, j: integer;
  k: longint;
  a, b: double;
begin
  result := false;
  if DevRoundedState <> csRunning then
    exit;
  Synchro := Schr;
  if wSpec <> nil then
  begin
    bFill.Tag := GetTickCount;
    if not wSpec.MassOnly then
      wSpec.CreateHDFile(RootPath + TempPath + 'TempHD.R01');
    Timer1.Tag := 0; // start | restart
    // Application.ProcessMessages;
    // msrThread:= TmsrThread.Create(False);
  end
  else
  begin // stop | close
    // msrThread.Terminate;
    if not Spec.MassOnly then
      Spec.CloseHDFile;
    b := 1000 * Timer1.Tag / ((GetTickCount - bFill.Tag));
    lbCount.Caption := 'Speed = ' + FloatToStr(Round(b * 10) / 10) +
      ' spec/sec';
    if Assigned(FOnTick) then
      FOnTick(nil);
  end;
  Spec := wSpec;
  result := True;
end;

function TmsrDevice1.SetLod(var FileName: string): boolean;
begin
  result := false;
  FileName := PrepSetFile(FileName);
  Setting := TIniFile.Create(FileName);
  result := True;
end;

function TmsrDevice1.SetSav(var FileName: string): boolean;
begin
  result := false;
  Setting.Free;
  result := True;
end;

/// ////////////////////////////////////////////////////////////////////////////
procedure TmsrDevice1.bFillClick(Sender: TObject);
// fill in 0-1000 range with ampl. 0-100
var
  i, j: integer;
begin
  inherited;
  for i := 1 to 20 do
  begin
    sgPeaks.Cells[1, i] := IntToStr(random(1000));
    sgPeaks.Cells[2, i] := IntToStr(random(20));
  end;
end;

procedure TmsrDevice1.Timer1Timer(Sender: TObject);
begin
  inherited;
  if Synchro and (Spec <> nil) then
  begin // Application.ProcessMessages;
   // if Timer1.Tag < 10 then
      Timer1.Tag := Timer1.Tag + 1;
    lbCount.Caption := 'Count= ' + IntToStr(Timer1.Tag);
    DSmGet;
  end;
end;

procedure TmsrDevice1.nsSpeedChange(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := false;
  Timer1.Interval := nsSpeed.Value;
  Timer1.Enabled := True;
end;

procedure TmsrDevice1.nsSplitOnChange(Sender: TObject);
begin
  inherited;
  if Spec <> nil then
    Spec.SplitOn := nsSplitOn.Value;
end;

procedure TmsrDevice1.seDefaultChnChange(Sender: TObject);
begin
  inherited;
  DftChn:= seDefaultChn.Value;
end;

end.
