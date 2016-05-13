unit DirPickU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, Buttons, ExtCtrls;

type
  TfrmDirPicker = class(TForm)
    Panel1: TPanel;
    DirectoryListBox1: TDirectoryListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DriveComboBox1: TDriveComboBox;
  private
    { Private declarations }
    function GetDirectory: string;
    procedure SetDirectory(Value: string);
  public
    { Public declarations }
    property Directory: string read GetDirectory write SetDirectory;
  end;

var frmDirPicker: TfrmDirPicker;

implementation
{$R *.DFM}
function TfrmDirPicker.GetDirectory: string;
begin Result:= DirectoryListBox1.Directory;
end;

procedure TfrmDirPicker.SetDirectory(Value: string);
begin DirectoryListBox1.Directory:= Value;
end;

end.
