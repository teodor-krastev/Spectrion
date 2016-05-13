unit DvcShellU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus;

type
  TfrmDvcShell = class(TForm)
    PopupMenu1: TPopupMenu;
    pmHide: TMenuItem;
    procedure FormResize(Sender: TObject);
    procedure pmHideClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDvcShell: TfrmDvcShell;

implementation

{$R *.DFM}

uses DeviceU;

procedure TfrmDvcShell.FormResize(Sender: TObject);
begin
  ClientWidth := DvcWidth;
  if WindowState = wsMaximized then
  begin
    WindowState := wsNormal;
    Align := alRight;
    Align := alNone;
  end;
end;

procedure TfrmDvcShell.pmHideClick(Sender: TObject);
begin
  Hide;
end;

end.
