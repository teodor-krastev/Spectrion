unit CtrlDeviceU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DeviceU, ComCtrls, Buttons, ExtCtrls, ImgList;

type
  TctrlDevice = class(TdDevice)
  private
    { Private declarations }
  protected
    fLocked: boolean;
    Chn: array [MinNChn .. MaxNChn] of
      record
      Name, Dim: string;
      Tol: real; // error which is concidered out of range [in percents]
      APos: integer;
      CalibrOn: boolean;
      end;
    function GetAbsPos(iChn: integer): integer; virtual; abstract;
    // get Abs required position
    procedure SetAbsPos(iChn: integer; Value: integer); virtual; abstract;
    // set Abs position
    function GetRelPos(iChn: integer): double; virtual; abstract;
    // measured position
    procedure SetRelPos(iChn: integer; Value: double); virtual; abstract;
    // set pos throu calibr.
    function GetMsrPos(iChn: integer): double; virtual; abstract;
    // measured position

  public
    { Public declarations }
    property AbsPos[iChn: integer]: integer read GetAbsPos write SetAbsPos;
    // absolute demanded position
    property RelPos[iChn: integer]: double read GetRelPos write SetRelPos;
    // relative demanded position
    property MsrPos[iChn: integer]: double read GetMsrPos;
    // measured position
    // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    // Set default channel N
    function DftSet(N: integer): boolean; virtual; abstract;

    // Gets back the last demander absolute position
    function AbsGet(var ChnV: integer; ChnIdx: integer = -999): boolean;
      virtual; abstract;

    // Gets back the last demander relative position
    function RelGet(var ChnV: double; ChnIdx: integer = -999): boolean;
      virtual; abstract;
// comparing these two will give you the accuracy of your parameter
    // Measure and gets back relative position
    function MsrGet(var ChnV: double; ChnIdx: integer = -999): boolean;
      virtual; abstract;

    // Jump on position AP in absolute units
    function AJpSet(var AP: integer; ChnIdx: integer = -999): boolean;
      virtual; abstract;

    // Jump on position RP in relative units
    function RJpSet(var RP: double; ChnIdx: integer = -999): boolean;
      virtual; abstract;

    // Move AP absolute units forwards(+)/backwards(-)
    function AMvSet(var AP: integer; ChnIdx: integer = -999): boolean;
      virtual; abstract;

    // Move R relative or absolute units forwards(+)/backwards(-)
    function RMvSet(var RP: double; ChnIdx: integer = -999): boolean;
      virtual; abstract;

    // Return N-channel name and [dimention units]
    function DimGet(N: integer; var ChnDim: string): boolean; virtual; abstract;

    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.DFM}

constructor TctrlDevice.Create(AOwner: TComponent);
begin
  inherited;
  fdKind := dkCtrl;
end;

end.

(*
  function TctrlIOP.GetAbsPos(iChn: integer): integer;
  // get required position
  begin
  end;

  procedure TctrlIOP.SetAbsPos(iChn: integer; Value: integer);
  // set position
  begin
  end;

  function TctrlIOP.GetRelPos(iChn: integer): double;
  // required relat. position
  begin
  end;

  procedure TctrlIOP.SetRelPos(iChn: integer; Value: double);
  // set pos throu calibr.
  begin
  end;

  function TctrlIOP.GetMsrPos(iChn: integer): double;
  // measured position
  begin
  end;

  function TctrlIOP.IniSet: boolean;
  begin
  end;

  function TctrlIOP.EnbGet(RunIt: boolean): boolean;
  begin
  end;

  function TctrlIOP.ClsSet: boolean;
  begin
  end;

  function TctrlIOP.DvcLck(Lck: boolean): boolean;
  begin
  end;

  function TctrlIOP.DftSet(N: integer): boolean;
  begin
  end;

  function TctrlIOP.AbsGet(var ChnV: integer; ChnIdx: integer = 0): boolean;
  begin
  end;

  function TctrlIOP.RelGet(var ChnV: double; ChnIdx: integer = 0): boolean;
  begin
  end;

  function TctrlIOP.MsrGet(var ChnV: double; ChnIdx: integer = 0): boolean;
  begin
  end;

  function TctrlIOP.AJpSet(var AP: integer; ChnIdx: integer = 0): boolean;
  begin
  end;

  function TctrlIOP.RJpSet(var RP: double; ChnIdx: integer = 0): boolean;
  begin
  end;

  function TctrlIOP.AMvSet(var AP: integer; ChnIdx: integer = 0): boolean;
  begin
  end;

  function TctrlIOP.RMvSet(var RP: double; ChnIdx: integer = 0): boolean;
  begin
  end;

  function TctrlIOP.DimGet(N: integer; var ChnDim: string): boolean;
  begin
  end;

  function TctrlIOP.SetLod(var FileName: string): boolean;
  begin
  end;

  function TctrlIOP.SetSav(var FileName: string): boolean;
  begin
  end;

*)
