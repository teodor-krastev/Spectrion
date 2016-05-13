unit SPCN_COM;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, AxCtrls, Classes, SPCN_TLB, StdVcl, SysUtils, Forms, Dialogs,
  Variants;

type
  TCOM_SPCN = class(TAutoObject, IConnectionPointContainer, ICOM_SPCN)
  private
    { Private declarations }
    FConnectionPoints: TConnectionPoints;
    FConnectionPoint: TConnectionPoint;
    FEvents: ICOM_SPCNEvents;
    { note: FEvents maintains a *single* event sink. For access to more
      than one event sink, use FConnectionPoint.SinkList, and iterate
      through the list of sinks. }
    procedure OnDvcSt(const DvcName: WideString; OldSt: Integer; NewSt: Integer);
    procedure OnCmdExe(const Cmd: WideString; const Reply: WideString);
  public
    procedure Initialize; override;
  protected
    { Protected declarations }
    property ConnectionPoints: TConnectionPoints read FConnectionPoints
      implements IConnectionPointContainer;
    procedure EventSinkChanged(const EventSink: IUnknown); override;

    procedure Command(var InOutText: WideString; out Success: WordBool);
      safecall;
    procedure Procedur(const WhichProc: WideString; var PrmList: WideString;
      var Suc: WordBool); safecall;
    function Get_ExePath: WideString; safecall;
    procedure AbortExe; safecall;
    procedure GetSpec(Num: Integer; var SpecX, SpecY: OleVariant); safecall;
  end;

implementation

uses ComServ, CmdCentreU, UniScanU, AutoTuneU, SynchroU, SpionU,
PlotCollectU, PlotU, SpecU, DvcRackU, AboutU;

procedure TCOM_SPCN.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as ICOM_SPCNEvents;
end;

procedure TCOM_SPCN.Initialize;
var i,j: integer;
begin
  inherited Initialize;
  FConnectionPoints := TConnectionPoints.Create(Self);
  if AutoFactory.EventTypeInfo <> nil then
    FConnectionPoint := FConnectionPoints.CreateConnectionPoint(
      AutoFactory.EventIID, ckSingle, EventConnect)
  else FConnectionPoint := nil;

for i:=0 to length(msrDvcs)-1 do
    msrDvcs[i].OnDvcStChange:= OnDvcSt;
for i:=0 to length(ctrlDvcs)-1 do
    ctrlDvcs[i].OnDvcStChange:= OnDvcSt;
frmCmdCentre.OnCommandExe:= OnCmdExe;
frmAbout.OnError:= frmCmdCentre.OnError;
RemoteControl:= true;
end;

procedure TCOM_SPCN.OnDvcSt(const DvcName: WideString; OldSt: Integer; NewSt: Integer);
begin
if FEvents <> nil then FEvents.EventDvcState(DvcName,OldSt,NewSt);
end;

procedure TCOM_SPCN.OnCmdExe(const Cmd: WideString; const Reply: WideString);
begin
if FEvents <> nil then FEvents.EventCommand(Cmd,Reply);
end;

procedure TCOM_SPCN.Command(var InOutText: WideString;
  out Success: WordBool);
var ss: string;
begin ss:= string(InOutText);
Success:= WordBool(Interprt(ss)); InOutText:= WideString(ss);
end;

procedure TCOM_SPCN.Procedur(const WhichProc: WideString;
  var PrmList: WideString; var Suc: WordBool);
var wp,pl: string;
begin wp:= UpperCase(string(WhichProc)); pl:= string(PrmList);
Suc:= WordBool(false);
CallProc(wp,true,true,pl); PrmList:= WideString(pl);
frmSpion.mRefreshClick(nil); Suc:= WordBool(true);
end;

function TCOM_SPCN.Get_ExePath: WideString;
begin Result:= WideString(RootPath);
end;

procedure TCOM_SPCN.AbortExe;
var i,j: integer;
begin
for i:=1 to 9 do
    if fmSynchro.DataStm[i].Enabled then fmSynchro.DataStm[i].Close;
fmSynchro.bAbort.Click;
end;

procedure TCOM_SPCN.GetSpec(Num: Integer; var SpecX, SpecY: OleVariant);
var i,j,sz: integer;
begin if (Num>=Plots.Count) then exit;
if Num>=0 then j:= Num
          else j:= Plots.Active;
if Plots[j]=nil then exit;
sz:= length(Plots[j].Spec.CMass);
SpecX:= VarArrayCreate([0,sz-1], varDouble);
SpecY:= VarArrayCreate([0,sz-1], varDouble);
for i:=0 to sz-1 do
    begin SpecX[i]:= Plots[j].Spec.CMass[i][X]; SpecY[i]:= Plots[j].Spec.CMass[i][Y];
    end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TCOM_SPCN, Class_COM_SPCN,
    ciSingleInstance, tmFree);
end.
