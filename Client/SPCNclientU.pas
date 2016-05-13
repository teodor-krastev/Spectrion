unit SPCNclientU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SPCN_TLB, StdCtrls, Buttons, ComObj, ActiveX, ExtCtrls;

type
  TEventSink = class;

  TfrmSpcnClient = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    mmConv: TMemo;
    eCommand: TEdit;
    bbSend: TBitBtn;
    eParam: TEdit;
    bOpenParam: TButton;
    Label1: TLabel;
    Label2: TLabel;
    bbAbort: TBitBtn;
    cbProcName: TComboBox;
    bbRunProc: TBitBtn;
    OpenDialog1: TOpenDialog;
    bbGetSpec: TBitBtn;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure bbSendClick(Sender: TObject);
    procedure bOpenParamClick(Sender: TObject);
    procedure bbRunProcClick(Sender: TObject);
    procedure bbAbortClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbGetSpecClick(Sender: TObject);
  private
    { Private declarations }
    SPCN: ICOM_SPCN;
    FEventSink: TEventSink;
    FCookie: Integer;
    procedure OnCommand(const Cmd,Reply: string);
    procedure OnDvcState(const DvcName: string; const OldSt,NewSt: integer);
    //procedure StartSPCNproc;
  public
    { Public declarations }
  end;

 TEventSink = class(TObject, IUnknown, IDispatch)
  private
    FController: TfrmSPCNclient;
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IDispatch }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  public
    constructor Create(Controller: TfrmSPCNclient);
  end;

var
  frmSPCNclient: TfrmSPCNclient;

implementation
{$R *.dfm}

procedure TfrmSPCNclient.FormCreate(Sender: TObject);
begin
SPCN:= CoCOM_SPCN.Create;
  FEventSink := TEventSink.Create(Self);
  InterfaceConnect(SPCN, ICOM_SPCNEvents, FEventSink, FCookie);
end;

procedure TfrmSPCNclient.FormDestroy(Sender: TObject);
begin
  InterfaceDisconnect(FEventSink, ICOM_SPCNEvents, FCookie);
  FEventSink.Free;
end;

procedure RunSPCNcmd;
var cmd: WideString; suc: WordBool;
begin cmd:= WideString(frmSPCNclient.eCommand.Text); if cmd='' then exit;
frmSPCNclient.mmConv.Lines.Add(frmSPCNclient.eCommand.Text);
frmSPCNclient.SPCN.Command(cmd,suc);
if suc then frmSPCNclient.mmConv.Lines.Add(cmd)
       else frmSPCNclient.mmConv.Lines.Add('Error');
end;

procedure TfrmSPCNclient.bbSendClick(Sender: TObject);
var thr : THandle; thrID : DWORD;
begin
thr:= CreateThread(nil, 0, @RunSPCNcmd, nil, 0, thrID);
if (thr = 0) then ShowMessage('Thread not created');
end;

procedure TfrmSPCNclient.bOpenParamClick(Sender: TObject);
begin
if OpenDialog1.Execute then eParam.Text:= 'file:\\'+OpenDialog1.Filename
                       else eParam.Text:= '';
end;

procedure StartSPCN;
begin frmSPCNclient.SPCN.AbortExe;
end;

procedure StartSPCNproc;
var ProcName,ProcParamIn,ProcParamOut: WideString; suc: WordBool;
begin
ProcName:=  WideString(frmSPCNclient.cbProcName.Text);
ProcParamIn:= WideString(frmSPCNclient.eParam.Text);
ProcParamOut:= ProcParamIn;
frmSPCNclient.SPCN.Procedur(ProcName,ProcParamOut,suc);
if Suc
   then begin frmSPCNclient.mmConv.Lines.Add('Run Proc= '+ProcName);
   frmSPCNclient.mmConv.Lines.Add('ProcParam= '+ProcParamIn);
   frmSPCNclient.mmConv.Lines.Add('Out: '+ProcParamOut);
   end
   else frmSPCNclient.mmConv.Lines.Add('Error');
end;

procedure TfrmSPCNclient.bbRunProcClick(Sender: TObject);
var thr : THandle; thrID : DWORD;
begin
thr:=CreateThread(nil, 0, @StartSPCNproc, nil, 0, thrID);
if (thr = 0) then ShowMessage('Thread not created');
end;

procedure TfrmSPCNclient.bbGetSpecClick(Sender: TObject);
var i,j: integer; a,s: double; massX,massY: OleVariant;
begin SPCN.GetSpec(-1,massX,massY); mmConv.Lines.Add('');
for i:= VarArrayLowBound(massX,1) to VarArrayHighBound(massX,1) do
    begin a:= massX[i]; s:= massY[i];
    mmConv.Lines.Add(FloatToStr(a)+#9+FloatToStr(s));
    end;
end;

procedure TfrmSPCNclient.bbAbortClick(Sender: TObject);
begin SPCN.AbortExe;
end;
//////////////////////////////////////////////////////////////////////////
procedure TfrmSPCNclient.OnCommand(const Cmd,Reply: string);
begin mmConv.Lines.Add(':'+Cmd); mmConv.Lines.Add('>'+Reply);
end;

procedure TfrmSPCNclient.OnDvcState(const DvcName: string; const OldSt,NewSt: integer);
begin mmConv.Lines.Add('<'+DvcName+'> from '+IntToStr(OldSt)+' to '+IntToStr(NewSt));
end;

{ TEventSink }

constructor TEventSink.Create(Controller: TfrmSPCNclient);
begin
  FController := Controller;
  inherited Create;
end;

{ TEventSink.IUnknown }

function TEventSink._AddRef: Integer;
begin
  // No need to implement, since lifetime is tied to client
  Result := 1;
end;

function TEventSink._Release: Integer;
begin
  // No need to implement, since lifetime is tied to client
  Result := 1;
end;

function TEventSink.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  // First look for my own implementation of an interface
  // (I implement IUnknown and IDispatch).
  if GetInterface(IID, Obj) then
    Result := S_OK
  // Next, if they are looking for outgoing interface, recurse to return
  // our IDispatch pointer.
  else if IsEqualIID(IID, ICOM_SPCNEvents) then
    Result := QueryInterface(IDispatch, Obj)
  // For everything else, return an error.
  else
    Result := E_NOINTERFACE;
end;

{ TEventSink.IDispatch }

function TEventSink.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TEventSink.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TEventSink.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK;
end;

function TEventSink.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
var
  V,U,W: OleVariant;
begin
  Result := S_OK;
  case DispID of
    1:begin
        // parameters in reverce order
        V := OleVariant(TDispParams(Params).rgvarg^[1]);
        W := OleVariant(TDispParams(Params).rgvarg^[0]);
        FController.OnCommand(string(V),string(W));
      end;
    2:begin
        V := OleVariant(TDispParams(Params).rgvarg^[2]);
        W := OleVariant(TDispParams(Params).rgvarg^[1]);
        U := OleVariant(TDispParams(Params).rgvarg^[0]);
        FController.OnDvcState(string(V),integer(W),integer(U));
      end;  
  end;
end;

end.
