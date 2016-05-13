unit PeakU;

interface

uses Classes, Dialogs, Sysutils, Forms, Controls, StdCtrls, AboutU;

type
  tPeak = record
    X, Y, Left, Right, Area: single;
    Index: integer;
  end;

  tPeaks = class
  private
    bPeaks: array of tPeak;
    procedure SetPeaks(Index: integer; Value: tPeak); // not to use
    function GetPeaks(Index: integer): tPeak;
    function GetCount: integer;
  public
    property Items[Index: integer]: tPeak read GetPeaks write SetPeaks; default;
    property Count: integer read GetCount;
    function Add(wPeak: tPeak): integer;
    function Delete(Idx: integer): boolean;
    procedure Clear;
    function MinX: single;
    function MaxX: single;
    function MinY: single;
    function MaxY: single;
  end;

implementation

uses Math, Windows;

procedure tPeaks.SetPeaks(Index: integer; Value: tPeak);
begin
  if (Index < low(bPeaks)) or (Index > high(bPeaks)) then
    exit;
  bPeaks[Index] := Value;
end;

function tPeaks.GetPeaks(Index: integer): tPeak;
begin
  if (Index < low(bPeaks)) or (Index > high(bPeaks)) then
    raise Exception.Create('Wrong index');
  Result := bPeaks[Index];
end;

function tPeaks.GetCount: integer;
begin
  Result := length(bPeaks);
end;

function tPeaks.Add(wPeak: tPeak): integer;
begin
  Result := -1;
  SetLength(bPeaks, length(bPeaks) + 1);
  bPeaks[high(bPeaks)] := wPeak;
  Result := length(bPeaks);
end;

function tPeaks.Delete(Idx: integer): boolean;
var
  i: integer;
begin
  Result := false;
  if (Idx < low(bPeaks)) or (Idx > high(bPeaks)) then
    exit;
  for i := Idx to Count - 2 do
    bPeaks[i] := bPeaks[i + 1];
  SetLength(bPeaks, Count - 1);
  Result := true;
end;

procedure tPeaks.Clear;
begin
  SetLength(bPeaks, 0);
end;

function tPeaks.MinX: single;
var
  i: integer;
  a: double;
begin
  a := 1E99;
  for i := 0 to Count - 1 do
    a := min(a, bPeaks[i].X);
  Result := a;
end;

function tPeaks.MaxX: single;
var
  i: integer;
  a: double;
begin
  a := -1E99;
  for i := 0 to Count - 1 do
    a := max(a, bPeaks[i].X);
  Result := a;
end;

function tPeaks.MinY: single;
var
  i: integer;
  a: double;
begin
  a := 1E99;
  for i := 0 to Count - 1 do
    a := min(a, bPeaks[i].Y);
  Result := a;
end;

function tPeaks.MaxY: single;
var
  i: integer;
  a: double;
begin
  a := -1E99;
  for i := 0 to Count - 1 do
    a := max(a, bPeaks[i].Y);
  Result := a;
end;

end.
