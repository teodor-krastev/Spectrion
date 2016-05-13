unit ProcU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, comctrls, ExtCtrls, IniFiles;

type
  tCDScan = record
    DName: string; // device name
    Start, Finish, Step: double;
    AbsUnits: boolean; // true -> abs. units
    Channel: integer;
  end;

  tMDScan = record
    DName: string; // device name
    MultiChannel, DStream: boolean;
    Channel: word;
  end;

  TfmProc = class(TFrame)
    sttHeader: TStaticText;
    pnlButtons: TPanel;
    bbHelp: TBitBtn;
    sbRun: TSpeedButton;
    sbClose: TSpeedButton;
  private
    { Private declarations }
    FbbCancelOnClick, FOnFreeProc: TNotifyEvent;
  protected
    DefaultHeight: integer;
  public
    { Public declarations }
    Resizable: boolean;
    Ini: TMemIniFile;
    procedure LoadOpt; dynamic;
    function Hyperlink: integer;
    procedure Execute(AutoRun, ShowUp: boolean; var InOut: string);
      virtual; abstract;
    property OnFreeProc: TNotifyEvent read FOnFreeProc write FOnFreeProc;
  end;

implementation
{$R *.DFM}

function TfmProc.Hyperlink: integer;
begin
  Result := bbHelp.Tag;
end;

procedure TfmProc.LoadOpt;
begin
  Resizable := true;
end;

end.
