program SPCNclient;

uses
  Forms,
  ActiveX,
  ComObj,
  SPCNclientU in 'SPCNclientU.pas' {frmSpcnClient},
  Spcn_COM in 'Spcn_COM.pas',
  DeviceU in '..\Devices\DeviceU.pas' {dDevice: TFrame};

{$R *.res}

begin
  CoInitFlags:= COINIT_MULTITHREADED;	
  Application.Initialize;
  Application.CreateForm(TfrmSpcnClient, frmSpcnClient);
  Application.Run;
end.
