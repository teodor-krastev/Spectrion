unit AutoTuneSimulU;

interface

uses
  Windows, Messages, SysUtils, Classes,  Controls, ComCtrls, ExtCtrls,
  StdCtrls, IniFiles, ShellAPI, Math, CtrlDeviceU;

type
  TAutoTuneSimul = class
  private
  public
    APos, APos2: integer;
    procedure OnCondChange(Sender: TObject);
    procedure OnCondChange2(Sender: TObject);
    function TuneCoeff: double;
  end;

  var AutoTuneSimul: TAutoTuneSimul;

implementation

function Gauss(x, x0, sigma: double): double;
begin
  result := exp(-(sqr(x - x0) / (2 * sqr(sigma)))); // /sqrt(2*pi*sqr(sigma));
end;

procedure TAutoTuneSimul.OnCondChange(Sender: TObject);
begin
  APos:= (Sender as TCtrlDevice).AbsPos[2];
end;

procedure TAutoTuneSimul.OnCondChange2(Sender: TObject);
begin
  APos2:= (Sender as TCtrlDevice).AbsPos[2];
end;

function TAutoTuneSimul.TuneCoeff: double;
begin
  Result:= gauss(APos,60,5)*gauss(APos2,30,5);
end;

initialization
  AutoTuneSimul:= TAutoTuneSimul.Create;
  AutoTuneSimul.APos:= 60; AutoTuneSimul.APos2:= 30;
finalization
  AutoTuneSimul.Free;
end.
