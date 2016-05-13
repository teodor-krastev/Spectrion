unit CmdShellU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmCmdShell = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCmdShell: TfrmCmdShell;

implementation

{$R *.DFM}

procedure TfrmCmdShell.FormShow(Sender: TObject);
begin
  Align := alLeft;
  Align := alNone;
end;

end.
