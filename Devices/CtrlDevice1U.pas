unit CtrlDevice1U;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CtrlDeviceU, ComCtrls, Buttons, ExtCtrls, StdCtrls, Spin, BMDSpinEdit,
  Vcl.ImgList, IniFiles;

type
  TctrlDevice1 = class(TctrlDevice)
    GroupBox1: TGroupBox;
    lbMChn1: TLabel;
    seAbs1: TSpinEdit;
    GroupBox2: TGroupBox;
    lbMChn2: TLabel;
    seAbs2: TSpinEdit;
    Timer1: TTimer;
    fseRel1: TBMDSpinEdit;
    fseRel2: TBMDSpinEdit;
    procedure fseRel1Change(Sender: TObject);
    procedure seAbs1Change(Sender: TObject);
    procedure fseRel2Change(Sender: TObject);
    procedure seAbs2Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FOnCondChange: TNotifyEvent;

    function DftSet(ChnIdx: integer): boolean; override;

    function Rel2Abs(iChn: integer; RelP: double): integer;
    function Abs2Rel(iChn: integer; AbsP: integer): double;

    function GetAbsPos(iChn: integer): integer; override;
    // get required position
    procedure SetAbsPos(iChn: integer; Value: integer); override;
    // set position

    function GetRelPos(iChn: integer): double; override; // measured position
    procedure SetRelPos(iChn: integer; Value: double); override;
    // set pos throu calibr.

    function DvcLck(Lck: boolean): boolean; override;
    // Close device
    function ClsSet: boolean; override;

  public
    { Public declarations }
    // Load from FileName Dvc settings
    function SetLod(var FileName: string): boolean; override;

    // Save into FileName current Dvc settings
    function SetSav(var FileName: string): boolean; override;

    // Jump on position AP in absolute units
    function AJpSet(var AP: integer; ChnIdx: integer = -999): boolean; override;

    // Jump on position RP in relative units
    function RJpSet(var RP: double; ChnIdx: integer = -999): boolean; override;

    // Gets back the last demander relative position
    function RelGet(var ChnV: double; ChnIdx: integer = -999): boolean; override;

    function MsrGet(var ChnV: double; ChnIdx: integer = -999): boolean; override;

    function IniSet: boolean; override;

    property OnCondChange: TNotifyEvent read FOnCondChange write FOnCondChange;
  end;
  { var
    ctrlDevice2: TctrlDevice2; }

implementation
{$R *.DFM}
uses DeviceU, AutoTuneSimulU;
const
  LowestChn = 0; HighestChn = 1000;

function TctrlDevice1.IniSet: boolean;
var
  i: integer;
begin
  inherited Initialise;
  DftChn := 1;
  MaxEnChn := 3;
  for i := 1 to MaxNChn do
    with Chn[i] do
    begin
      Dim := '';
      Tol := 1;
      APos := 1;
    end;
end;

function TctrlDevice1.DftSet(ChnIdx: integer): boolean;
begin
  Result := false;
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
  Result := True;
end;

function TctrlDevice1.SetLod(var FileName: string): boolean;
begin
  Result := false;
  FileName := PrepSetFile(FileName);
  Setting := TIniFile.Create(FileName);
  Result := true;
end;

function TctrlDevice1.SetSav(var FileName: string): boolean;
begin
  Result := false;
  Setting.Free;
  Result := true;
end;

function TctrlDevice1.Rel2Abs(iChn: integer; RelP: double): integer;
begin
  Result := round(RelP / 2);
end;

function TctrlDevice1.Abs2Rel(iChn: integer; AbsP: integer): double;
begin
  Result := 2 * AbsP;
end;

function TctrlDevice1.GetAbsPos(iChn: integer): integer;
begin
  if iChn=0 then Result := Chn[DftChn].APos;
  if (iChn < 1) or (iChn > MaxNChn) then
    exit;
  Result := Chn[iChn].APos;
end;

procedure TctrlDevice1.SetAbsPos(iChn: integer; Value: integer);
var iCh: integer;
begin
  if iChn=0 then iCh:= DftChn
    else iCh:= iChn;
  if (iCh < 1) or (iCh > MaxNChn) then
    exit;
  Chn[iCh].APos := Value; // really set ext. device
  if iCh = 1 then
  begin
    seAbs1.Tag := 1;
    seAbs1.Value := Value;
    seAbs1.Tag := 0;
    fseRel1.Tag := 1;
    fseRel1.Value := Abs2Rel(1, Value);
    fseRel1.Tag := 0;
  end;
  if iCh = 2 then
  begin
    seAbs2.Tag := 1;
    seAbs2.Value := Value;
    seAbs2.Tag := 0;
    fseRel2.Tag := 1;
    fseRel2.Value := Abs2Rel(2, Value);
    fseRel2.Tag := 0;
    if Assigned(OnCondChange) then OnCondChange(self);
  end;
end;

function TctrlDevice1.AJpSet(var AP: integer; ChnIdx: integer = -999): boolean;
begin
  Result:= true;
  SetAbsPos(ChnIdx,AP);
end;

function TctrlDevice1.RJpSet(var RP: double; ChnIdx: integer = -999): boolean;
begin
  Result:= true;
  SetRelPos(ChnIdx,RP);
end;

function TctrlDevice1.RelGet(var ChnV: double; ChnIdx: integer = -999): boolean;
begin
  Result:= true;
  ChnV:= GetRelPos(ChnIdx);
end;

function TctrlDevice1.MsrGet(var ChnV: double; ChnIdx: integer = -999): boolean;
begin
  Result:= true;
  ChnV:= GetRelPos(ChnIdx);
end;

function TctrlDevice1.GetRelPos(iChn: integer): double;
var iCh: integer;
begin
  if iChn=0 then iCh:= DftChn
    else iCh:= iChn;
  if (iCh < 1) or (iCh > MaxNChn) then
    exit;
  Result := Abs2Rel(iCh, Chn[iCh].APos) + random; // simul measurement
end;

procedure TctrlDevice1.SetRelPos(iChn: integer; Value: double);
var iCh: integer;
begin
  if iChn=0 then iCh:= DftChn
    else iCh:= iChn;
  if (iCh < 1) or (iCh > MaxNChn) then
    exit;
  AbsPos[iCh] := Rel2Abs(iCh, Value);
  if iCh = 1 then
  begin
    fseRel1.Tag := 1;
    fseRel1.Value := Value;
    fseRel1.Tag := 0;
  end;
  if iCh = 2 then
  begin
    fseRel2.Tag := 1;
    fseRel2.Value := Value;
    fseRel2.Tag := 0;
  end;
end;

function TctrlDevice1.DvcLck(Lck: boolean): boolean;
begin
  Result := false;
  Locked := Lck;
  Result := true;
end;

function TctrlDevice1.ClsSet: boolean;
begin
  Result := EnbSet(false);
end;

/// ////////////////////////////////////////////////////////////////////////
procedure TctrlDevice1.fseRel1Change(Sender: TObject);
begin
  inherited;
  if fseRel1.Tag = 1 then
    exit;
  RelPos[1] := fseRel1.Value;
end;

procedure TctrlDevice1.seAbs1Change(Sender: TObject);
begin
  inherited;
  if seAbs1.Tag = 1 then
    exit;
  AbsPos[1] := seAbs1.Value;
end;

procedure TctrlDevice1.fseRel2Change(Sender: TObject);
begin
  inherited;
  if fseRel2.Tag = 1 then
    exit;
  RelPos[2] := fseRel2.Value;
end;

procedure TctrlDevice1.seAbs2Change(Sender: TObject);
begin
  inherited;
  if seAbs2.Tag = 1 then
    exit;
  AbsPos[2] := seAbs2.Value;
end;

procedure TctrlDevice1.Timer1Timer(Sender: TObject);
begin
  inherited;
  if DevState <> csRunning then
    exit;
  lbMChn1.Caption := FloatToStrF(fseRel1.Value - 1 / 6 + random / 3,
    ffGeneral, 7, 4);
  lbMChn2.Caption := FloatToStrF(fseRel2.Value - 1 / 6 + random / 3,
    ffGeneral, 7, 4);
end;

end.
