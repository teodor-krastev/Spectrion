unit MsrDeviceU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DeviceU, ComCtrls, Buttons, ExtCtrls, TeEngine, SpecU, Series, TeeProcs,
  Chart, Vcl.ImgList;

type
  TmsrDevice = class(TdDevice)
  private
    { Private declarations }
  protected
    FOnTick: TNotifyEvent;
  public
    { Public declarations }
    MultiChannel: boolean; // package mode
    Synchro: boolean;
    Spec: TSpec;
    SynchroArr: array [-MinNChn .. MaxNChn] of boolean;
    Specs: array [-MinNChn .. MaxNChn] of TSpec;
    property OnTick: TNotifyEvent read FOnTick write FOnTick;
    // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    // Set default channel of current spectrum to N
    function DftSet(N: integer): boolean; virtual; abstract;

    // Measure and return the value of ChnIdx channel
    function ChnGet(ChnIdx: integer; var Chn: double): boolean;
      virtual; abstract;

    // Measure and put measured spectrum in the spectrum buffer - "wXY".
    // zChn specifies z-channel and it is valid only for 3D multi-channel
    // measurement device, otherwise is ignored
    // script syntax - without "srsM"
    function SpcGet(zChn: integer; var wXY: tXYarray): boolean;
      virtual; abstract;

    // turn one cicle of measurement in Syncho mode
    function DSmGet: boolean; virtual; abstract;

    // Set DataChannel if Synchro then seft-refreshing else waits for DChGet
    // if srsC=nil and srsM=nil then close DataChannel
    function DSmSet(Synchro: boolean; wSpec: TSpec): boolean; virtual; abstract;

    // Return units of measurement, for multi-channel device and you input Dim="Abs"
    // the command returns for abscissa units (along the spectrum).
    // For multi-channel device N is zChn, otherwise N is a channel number
    // That is one way to check if certain MD is multi-channel,
    // when you ask the device for abscise units, multi-channel device
    // will return something, but single-channel one will reply with error message.
    function DimGet(N: integer; var Dim: string): boolean; virtual; abstract;

    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.DFM}

constructor TmsrDevice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fdKind := dkMsr;
end;

end.
