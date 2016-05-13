unit CtrlDevice2U;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CtrlDeviceU, ComCtrls, Buttons, ExtCtrls, StdCtrls, Spin, BMDSpinEdit,
  Vcl.ImgList;

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
    function Rel2Abs(iChn: byte; RelP: double): integer;
    function Abs2Rel(iChn: byte; AbsP: integer): double;


    function GetAbsPos(iChn: byte): integer; override; // get required position
    procedure SetAbsPos(iChn: byte; Value: integer); override; // set position
    function GetRelPos(iChn: byte): double; override;  // measured position
    procedure SetRelPos(iChn: byte; Value: double); override; // set pos throu calibr.

    function DvcLck(Lck: boolean): boolean; override;
  public
    { Public declarations }

    function IniSet: boolean; override;
  end;
{var
  ctrlDevice2: TctrlDevice2;}

implementation
{$R *.DFM}
uses DeviceU;

function TctrlDevice1.IniSet: boolean;
var i: integer;
begin inherited Initialize;
DftChn:= 1; MaxEnChn:= 3;
for i:=1 to MaxNChn do
    with Chn[i] do
         begin Dim:= ''; Tol:= 1; APos:= 1;
         end;
end;

function TctrlDevice1.Rel2Abs(iChn: byte; RelP: double): integer;
begin Result:= round(RelP/2);
end;

function TctrlDevice1.Abs2Rel(iChn: byte; AbsP: integer): double;
begin Result:= 2*AbsP;
end;

function TctrlDevice1.GetAbsPos(iChn: byte): integer;
begin if (iChn<1) or (iChn>MaxNChn) then exit;
Result:= Chn[iChn].APos;
end;

procedure TctrlDevice1.SetAbsPos(iChn: byte; Value: integer);
begin if (iChn<1) or (iChn>MaxNChn) then exit;
Chn[iChn].APos:= Value; // really set ext. device
if iChn=1 then
   begin seAbs1.Tag:= 1; seAbs1.Value:= Value; seAbs1.Tag:= 0;
   fseRel1.Tag:= 1; fseRel1.Value:= Abs2Rel(1,Value); fseRel1.Tag:= 0;
   end;
if iChn=2 then
   begin seAbs2.Tag:= 1; seAbs2.Value:= Value; seAbs2.Tag:= 0;
   fseRel2.Tag:= 1; fseRel2.Value:= Abs2Rel(2,Value); fseRel2.Tag:= 0;
   end;
end;

function TctrlDevice1.GetRelPos(iChn: byte): double;
begin if (iChn<1) or (iChn>MaxNChn) then exit;
Result:= Abs2Rel(iChn,Chn[iChn].APos)+random;  // really measurement
end;

procedure TctrlDevice1.SetRelPos(iChn: byte; Value: double);
begin if (iChn<1) or (iChn>MaxNChn) then exit;
AbsPos[iChn]:= Rel2Abs(iChn,Value);
if iChn=1 then
   begin fseRel1.Tag:= 1; fseRel1.Value:= Value; fseRel1.Tag:= 0;
   end;
if iChn=2 then
   begin fseRel2.Tag:= 1; fseRel2.Value:= Value; fseRel2.Tag:= 0;
   end;
end;

function TctrlDevice1.DvcLck(Lck: boolean): boolean;
begin Result:= false; Locked:= Lck;
Result:= true;
end;

///////////////////////////////////////////////////////////////////////////
procedure TctrlDevice1.fseRel1Change(Sender: TObject);
begin
  inherited;
if fseRel1.Tag=1 then exit;
RelPos[1]:= fseRel1.Value;
end;

procedure TctrlDevice1.seAbs1Change(Sender: TObject);
begin inherited;
if seAbs1.Tag=1 then exit;
AbsPos[1]:= seAbs1.Value;
end;

procedure TctrlDevice1.fseRel2Change(Sender: TObject);
begin inherited;
if fseRel2.Tag=1 then exit;
RelPos[2]:= fseRel2.Value;
end;

procedure TctrlDevice1.seAbs2Change(Sender: TObject);
begin inherited;
if seAbs2.Tag=1 then exit;
AbsPos[2]:= seAbs2.Value;
end;

procedure TctrlDevice1.Timer1Timer(Sender: TObject);
begin inherited;
if DevState<>csRunning then exit;
lbMChn1.Caption:= FloatToStrF(fseRel1.Value-1/6+random/3,ffGeneral,7,4);
lbMChn2.Caption:= FloatToStrF(fseRel2.Value-1/6+random/3,ffGeneral,7,4);
end;

end.
