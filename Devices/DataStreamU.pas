unit DataStreamU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, MsrDeviceU, Series, Buttons, PlotU, StdCtrls, ComCtrls,
  ImgList;

type

  TfmDataStm = class(TFrame)
    pnlDCh: TPanel;
    bShoot: TSpeedButton;
    bAbort: TSpeedButton;
    cbSynchro: TCheckBox;
    Image1: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    procedure bAbortClick(Sender: TObject);
    procedure cbSynchroClick(Sender: TObject);
    procedure bShootClick(Sender: TObject);
  private
    { Private declarations }
    fSelfSynchro: boolean;
    msrDvc: TmsrDevice;
    sPlot: TfrmPlot;
    GenI: integer;
    FOpenCloseEvent: TNotifyEvent;
    procedure MsrTick(Sender: TObject);
    procedure SetSelfSynchro(Value: boolean);

  public
    { Public declarations }
    function Open(Schr: boolean; Numb: integer; mDvc: TmsrDevice;
      var wPlot: TfrmPlot): boolean;
    // if wPlot=nil then create one
    function GetData: boolean; // same as msrDvc.GetData
    procedure Stop;
    function Restart: boolean;
    function Close: boolean;

    property SelfSynchro: boolean read fSelfSynchro write SetSelfSynchro
      default false;
    property OpenCloseEvent: TNotifyEvent read FOpenCloseEvent write FOpenCloseEvent;
  end;

implementation
{$R *.DFM}
uses PlotCollectU, AboutU, DeviceU;

procedure TfmDataStm.SetSelfSynchro(Value: boolean);
begin // if fSelfSynchro=Value then exit;
  cbSynchro.Checked := Value;
  bShoot.Visible := not Value;
  Image1.Visible := Value;
  fSelfSynchro := Value;
end;

function TfmDataStm.Open(Schr: boolean; Numb: integer; mDvc: TmsrDevice;
  var wPlot: TfrmPlot): boolean;
var
  i: integer;
  ss: string;
  bb: boolean;
begin
  Result := false;
  if mDvc = nil then
    exit;
  if mDvc.DevState <> csRunning then
    exit;
  if wPlot = nil then
  begin
    i := Plots.Add('');
    if i = -1 then
      exit; // new plot
    sPlot := Plots[i];
    wPlot := sPlot;
  end
  else
    sPlot := wPlot; // existing plot
  msrDvc := mDvc;
  Visible := true;
  Enabled := true;
  pnlDCh.Caption := ' ' + msrDvc.Name + ' -> ' + sPlot.Name + ' Data stream #' +
  IntToStr(Numb);
  sPlot.AcqMode := true;
  bb := mDvc.DSmSet(Schr, sPlot.Spec);
  SelfSynchro := Schr;
  cbSynchro.Visible := Schr;
  mDvc.OnTick := MsrTick;
  GenI := 0;
  Result := bb;
  if bb and Assigned(OpenCloseEvent) then OpenCloseEvent(self);
end;

function TfmDataStm.GetData: boolean;
begin
  Result := msrDvc.DSmGet;
end;

procedure TfmDataStm.Stop;
begin
  msrDvc.DSmSet(false, sPlot.Spec);
end;

function TfmDataStm.Restart: boolean;
begin
  msrDvc.DSmSet(true, sPlot.Spec);
end;

function TfmDataStm.Close: boolean;
begin
  Result := false;
  Visible := false;
  if not Enabled then
    exit;
  if sPlot.Spec.SplitOn > 0 then
  begin
    sPlot.Spec.SplitOn := 0;
    sPlot.RefreshPlot;
  end;
  Enabled := false;
  msrDvc.DSmSet(false, nil);
  sPlot.AcqMode := false;
  if sPlot <> nil then
    sPlot.tbDataStream := nil;
  Result := true;
  if Assigned(OpenCloseEvent) then OpenCloseEvent(self);
end;

procedure TfmDataStm.MsrTick(Sender: TObject);
begin
  ImageList1.GetBitmap(GenI mod 4, Image1.Picture.Bitmap);
  Image1.Repaint;
  inc(GenI);
  Hint := '# ' + IntToStr(GenI) + '|Data Stream Counter = ' + IntToStr(GenI);
  if Sender = nil then
    Close;
end;

/// ///////////////////////////////////////////////////////////////////////////
procedure TfmDataStm.bAbortClick(Sender: TObject);
begin
  Close;
end;

procedure TfmDataStm.cbSynchroClick(Sender: TObject);
begin
  SelfSynchro := cbSynchro.Checked;
  if SelfSynchro then
  begin
    if Enabled then
      Restart;
  end
  else
    Stop;
end;

procedure TfmDataStm.bShootClick(Sender: TObject);
begin
  GetData;
end;

end.
