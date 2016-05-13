unit AboutU;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, StrUtils, ShellAPI, Vcl.Imaging.GIFImg;

const
  ConfigPath = 'Config\';  ScriptPath = 'Script\';
  ScanPath = 'Scan\';  DataPath = 'Data\';  TempPath = 'Temp\';

type
  TMessageError = procedure(const Msg: string) of object;

  TfrmAbout = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    Label1: TLabel;
    Label3: TLabel;
  private
    { Private declarations }
    FOnError: TMessageError;
  public
    { Public declarations }
    property OnError: TMessageError read FOnError write FOnError;
  end;

  function DesignTime: boolean;

  function RootPath: string;
  function ExePath: string;
  procedure Delay(DTime: LongInt); { delay DTime miliseconds }
  procedure ErrorMsg(Msg: string; in1: string = ''; in2: string = ''; in3: string = '');

var
  frmAbout: TfrmAbout;
  RemoteControl: boolean;
  ErrorMsgFile: TStrings;

implementation
{$R *.DFM}

function DesignTime: boolean;
begin
  Result := (DebugHook <> 0);
end;

function HyperLinkCall(Hyperlink: string): boolean;
begin
  Result := ShellExecute(GetDesktopWindow(), 'open', PChar(Hyperlink), nil, nil,
    SW_SHOWNORMAL) > 32;
end;

function ExePath: string;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

function RootPath: string;
var
  ss: string;
begin
  ss := ExePath;
  system.delete(ss, length(ss), 1);
  Result := ExtractFilePath(ss) + 'User\';
end;

/// //////////////////////////////////////////////////////////////////
procedure ErrorMsg(Msg: string; in1: string = ''; in2: string = '';
  in3: string = '');
var
  i, j: integer;
  ss: string;
begin
  val(Msg, i, j);
  if j = 0 then
    ss := ErrorMsgFile.Values['Msg']
  else
    ss := Msg;
  if ss = '' then
    ss := 'Internal error #' + Msg;
  j := pos('###', ss);
  if j > 0 then
  begin
    delete(ss, j, 3);
    insert(in1, ss, j);
  end;
  j := pos('###', ss);
  if j > 0 then
  begin
    delete(ss, j, 3);
    insert(in2, ss, j);
  end;
  j := pos('###', ss);
  if j > 0 then
  begin
    delete(ss, j, 3);
    insert(in3, ss, j);
  end;
  if RemoteControl then
  begin
    if frmAbout <> nil then
      if Assigned(frmAbout.OnError) then
        frmAbout.OnError(ss)
  end
  else
    Application.MessageBox(PChar(ss), 'Spcn Error Message');
end; { ErrorMsg }

procedure Delay(DTime: LongInt); { delay DTime miliseconds }
var
  L, DT: LongInt;
begin
  L := GetTickCount;
  DT := abs(DTime);
  While (abs(L - GetTickCount) < DT) do
    if DTime > 0 then
      Application.ProcessMessages;
end; { Delay }

end. { AboutU }
