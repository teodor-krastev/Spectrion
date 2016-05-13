unit AboutU;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellAPI, Vcl.Imaging.GIFImg;
const
  BinPath='Bin\';   ConfigPath='Config\'; ScriptPath='Script\';
  ScanPath='Scan\'; DataPath='Data\';     TempPath='Temp\';

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Label4: TLabel;
    Label5: TLabel;
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function RootPath: string;
function ExePath: string;
procedure ErrorMsg(Msg: string; in1: string = ''; in2: string = ''; in3: string = '');

var AboutBox: TAboutBox;

implementation
{$R *.DFM}

procedure ErrorMsg(Msg: string; in1: string = ''; in2: string = '';
  in3: string = '');
var
  i, j: integer;
  ss: string;
begin
  val(Msg, i, j);
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
  Application.MessageBox(PChar(ss), 'Spectrion Error Message');
end; { ErrorMsg }

function HyperLinkCall(Hyperlink: string): boolean;
begin Result:= ShellExecute(GetDesktopWindow(),'open',PChar(Hyperlink),nil,nil,SW_SHOWNORMAL)>0;
end;

procedure TAboutBox.Label2Click(Sender: TObject);
begin
  HyperLinkCall('http://sicyon.com/survey/comment.html?sj=PCAprep');
end;
///////////////////////////////////////////////////////////////
function ExePath: string;
begin
  Result:= ExtractFilePath(Application.ExeName);
end;

function RootPath: string;
begin
  Result:= ExePath;
end;

end.


