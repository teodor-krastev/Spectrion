unit SpMathU;

interface

uses SpOptU, SpecU, TeEngine, PeakU;

type
  TBinSpec = array of double;

procedure AssignXY2XY(InXY: tXYarray; var OutXY: tXYarray);
procedure AssignSrs2XY(InSrs: TChartSeries; var OutXY: tXYarray);
procedure AssignXY2Srs(InXY: tXYarray; var OutSrs: TChartSeries);
function BinTranfer(InSrs: TChartSeries; var FirstMass: integer;
  var BinY: TBinSpec): boolean;
function Euclidean(Unknown, LibSpec: TChartSeries; AbsMode: boolean): double;

procedure IntEquidistant(InXY: tXYarray; var OutXY: tXYarray);
procedure ToNomMass(InXY: tXYarray; var OutXY: tXYarray);
procedure Zap(InXY: tXYarray; LowB, HighB: double; var OutXY: tXYarray);
function MaxXYarray(InXY: tXYarray): dPoint;
function YsumXY(InXY: tXYarray): double;
function SNratio(InXY: tXYarray): single;

function BLine(InXY: tXYarray; CM: boolean; SpOpt: tSpOpt;
  var OutXY: tXYarray): boolean;
function Smoothing(InXY: tXYarray; CM: boolean; SpOpt: tSpOpt;
  var OutXY: tXYarray): boolean;
function BSProcessing(InXY: tXYarray; CM: boolean; SpOpt: tSpOpt;
  var OutXY: tXYarray): boolean;
function Peaking(InXY: tXYarray; CM: boolean; SpOpt: tSpOpt; var Peaks: tPeaks;
  var FD: tXYarray): boolean;

var
  LastMathError: string;

implementation

uses Forms, Controls, Math;

procedure AssignXY2XY(InXY: tXYarray; var OutXY: tXYarray);
var
  i, j: integer;
begin
  j := length(InXY);
  SetLength(OutXY, j);
  for i := 0 to j - 1 do
  begin
    OutXY[i, X] := InXY[i, X];
    OutXY[i, Y] := InXY[i, Y];
  end;
end;

procedure AssignSrs2XY(InSrs: TChartSeries; var OutXY: tXYarray);
var
  i, j: integer;
begin
  j := InSrs.Count;
  SetLength(OutXY, j);
  for i := 0 to j - 1 do
  begin
    OutXY[i, X] := InSrs.XValue[i];
    OutXY[i, Y] := InSrs.YValue[i];
  end;
end;

procedure AssignXY2Srs(InXY: tXYarray; var OutSrs: TChartSeries);
var
  i: integer;
begin
  if OutSrs = nil then
    OutSrs := TChartSeries.Create(Application.MainForm);
  // should happend, it leaks
  OutSrs.Clear;
  for i := 0 to length(InXY) - 1 do
    OutSrs.AddXY(InXY[i, X], InXY[i, Y]);
end;

function BinTranfer(InSrs: TChartSeries; var FirstMass: integer;
  var BinY: TBinSpec): boolean;
var
  i, j, sz, m: integer;
  a: double;
begin
  Result := false;
  FirstMass := trunc(InSrs.XValue[0]);
  sz := ceil(InSrs.XValue[InSrs.Count - 1]) - FirstMass + 2;
  SetLength(BinY, sz);
  for i := 0 to sz - 1 do
    BinY[i] := 0;
  for i := 0 to sz - 1 do
    BinY[i] := 0;
  for i := 0 to InSrs.Count - 1 do
  begin
    a := frac(InSrs.XValue[i]);
    m := trunc(InSrs.XValue[i]);
    BinY[m - FirstMass] := BinY[m - FirstMass] + InSrs.YValue[i] * (1 - a);
    BinY[m - FirstMass + 1] := BinY[m - FirstMass + 1] + InSrs.YValue[i] * a;
  end;
  Result := true;
end; { BinTranfer }

function Euclidean(Unknown, LibSpec: TChartSeries; AbsMode: boolean): double;
var
  i, j, k, m, sz, szi, szj: integer;
  USpec, LSpec: TBinSpec;
  a, b, c: double;
begin
  Result := -1;
  if not BinTranfer(Unknown, i, USpec) then
    exit;
  if not BinTranfer(LibSpec, j, LSpec) then
    exit;
  k := max(i, j);
  szi := i + length(USpec) - 1;
  szj := j + length(LSpec) - 1;
  sz := min(szi, szj);
  a := 0;
  b := 0;
  c := 0;
  for m := k to sz do
  begin
    if (USpec[m - i] = 0) or (LSpec[m - j] = 0) then
      continue;
    if AbsMode // absolute distance
    then
    begin
      a := a + abs(USpec[m - i] - LSpec[m - j]);
      b := b + 1;
    end // Euclidean distance
    else
    begin
      a := a + (USpec[m - i] * LSpec[m - j]) * (USpec[m - i] * LSpec[m - j]);
      b := b + USpec[m - i] * USpec[m - i];
      c := c + LSpec[m - j] * LSpec[m - j];
    end;
  end;
  if AbsMode then
    Result := a / b
  else
    Result := 1 - sqrt(a) / (sqrt(b) * sqrt(c));
end; { Euclidean }

{ for i:=0 to dim do histo[i]:= 0;
  amax:= -1e12; amin:= 1e12;
  with sgTimes do
  begin
  for j:=1 to RowCount-1 do
  begin a:= StrToFloat(Cells[1,j]);
  amax:= max(amax,a); amin:= min(amin,a);
  end;
  step:= seTimeBin.Value/1000; n:= round((amax-amin)/step);
  if n>dim then n:= dim;
  for j:=1 to RowCount-1 do
  begin a:= StrToFloat(Cells[1,j]);
  for i:=0 to n do
  if (a>=(i*step+amin)) and (a<((i+1)*step+amin)) then
  begin histo[i]:= histo[i]+1; break;
  end;
  end;
  end; }

procedure Equidistant(InXY: tXYarray; var OutXY: tXYarray);
var
  i, j, k, m, sz: integer;
  a: double;
begin
  j := 0;
  sz := length(InXY);
  if sz = 0 then
    exit;
  SetLength(OutXY, MaxNArray);
  OutXY[0] := InXY[0];
  for i := 0 to sz - 2 do
  begin
    OutXY[j] := InXY[i];
    inc(j);
    a := InXY[i + 1, X] - InXY[i, X];
    if a > 1.5 then
    begin
      k := round(a);
      for m := 1 to k - 1 do
      begin
        OutXY[j, X] := InXY[i, X] + m * a / k;
        OutXY[j, Y] := 0;
        inc(j);
      end;
    end;
  end;
  OutXY[j] := InXY[sz - 1];
  sz := j + 1;
  SetLength(OutXY, sz);
end; { Equidistant }

procedure IntEquidistant(InXY: tXYarray; var OutXY: tXYarray);
var
  i, j, k, m, sz, i1, i2: integer;
  a: double;
begin
  j := 0;
  sz := length(InXY);
  if sz = 0 then
    exit;
  i1 := trunc(InXY[0, X]);
  i2 := ceil(InXY[sz - 1, X]);
  SetLength(OutXY, i2 - i1 + 2);
  for i := i1 to i2 + 1 do
  begin
    OutXY[i - i1, X] := i;
    OutXY[i - i1, Y] := 0;
  end;
  for i := 0 to sz - 1 do
  begin
    a := frac(InXY[i, X]);
    m := trunc(InXY[i, X]); // weigthed intens
    OutXY[m - i1, Y] := OutXY[m - i1, Y] + InXY[i, Y] * (1 - a);
    OutXY[m - i1 + 1, Y] := OutXY[m - i1 + 1, Y] + InXY[i, Y] * a;
  end;
end; { IntEquidistant }

procedure ToNomMass(InXY: tXYarray; var OutXY: tXYarray);
var
  i, j, k, m, sz, i1, i2: integer;
  a: double;
begin
  j := 0;
  sz := length(InXY);
  if sz = 0 then
    exit;
  i1 := floor(InXY[0, X]);
  i2 := ceil(InXY[sz - 1, X]);
  SetLength(OutXY, i2 - i1 + 1);
  for i := i1 to i2 do
  begin
    OutXY[i - i1][X] := i;
    OutXY[i - i1][Y] := 0;
  end;
  for i := 0 to sz - 1 do // integer rounded masses
  begin
    m := round(InXY[i, X]);
    OutXY[m - i1][Y] := OutXY[m - i1][Y] + InXY[i, Y];
  end;
  if sz = 0 then
    exit;
end;

procedure Zap(InXY: tXYarray; LowB, HighB: double; var OutXY: tXYarray);
var
  i, j, sz, szo: integer;
begin
  j := 0;
  sz := length(InXY);
  if (sz = 0) or (LowB >= HighB) then
    exit;
  szo := ceil(HighB) - trunc(LowB) + 1;
  SetLength(OutXY, szo);
  for i := 0 to sz - 1 do
    if (InXY[i, X] >= LowB) and (InXY[i, X] <= HighB) and (j < szo) then
    begin
      OutXY[j, X] := InXY[i, X];
      OutXY[j, Y] := InXY[i, Y];
      inc(j);
    end;
end; { Zap }

function MaxXYarray(InXY: tXYarray): dPoint;
var
  i, j: integer;
  a: real;
begin
  a := InXY[0, Y];
  for i := 0 to length(InXY) - 1 do
    if InXY[i, Y] > a then
    begin
      a := InXY[i, Y];
      Result[X] := InXY[i, X];
      Result[Y] := InXY[i, Y];
    end;
end;

function YsumXY(InXY: tXYarray): double;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to length(InXY) - 1 do
    Result := Result + InXY[i, Y];
end;

function NoiseLevel(InXY: tXYarray): single;
var
  i, j: integer;
  a, b: single;
begin
  Result := 0;
  a := 0;
  for i := low(InXY) to high(InXY) do // first approximation
    a := a + InXY[i, Y];
  b := 2 * a / (high(InXY) - low(InXY) + 1);
  a := 0;
  j := 0;
  for i := low(InXY) to high(InXY) do // second approximation
    if InXY[i, Y] < b then // without the peaks
    begin
      a := a + InXY[i, Y];
      inc(j);
    end;
  if j > 0 then
    Result := a / j;
end;

function SNratio(InXY: tXYarray): single;
var
  i, j: integer;
  a, b: single;
begin
  b := NoiseLevel(InXY);
  a := 0;
  j := 0;
  for i := low(InXY) to high(InXY) do
    if InXY[i, Y] > b then // only the peaks
    begin
      a := a + InXY[i, Y];
      inc(j);
    end;
  a := a / j;
  Result := a / b;
end;

/// ////////////////////////////////////////////////////////////////////////
function BLine(InXY: tXYarray; CM: boolean; SpOpt: tSpOpt;
  var OutXY: tXYarray): boolean;
var
  i, j, sz: integer;
  ts, a, b: double;
  bb: boolean;
begin
  sz := length(InXY);
  if sz = 0 then
    exit;
  Finalize(OutXY);
  SetLength(OutXY, sz);
  Result := false;
  if (CM and SpOpt.oChrom.BLine.AutoTS) or (not CM and SpOpt.oMass.BLine.AutoTS)
  then
  begin
    a := NoiseLevel(InXY);
    if CM then
      SpOpt.oChrom.BLine.Threshold := a
    else
      SpOpt.oMass.BLine.Threshold := a;
  end;
  if CM then
    ts := SpOpt.oChrom.BLine.Threshold
  else
    ts := SpOpt.oMass.BLine.Threshold;
  for i := 0 to sz - 1 do
  begin
    OutXY[i, X] := InXY[i, X];
    if InXY[i, Y] < ts then
      OutXY[i, Y] := 1
    else
      OutXY[i, Y] := InXY[i, Y] - ts;
  end;
  Result := true;
end; { BLine }

function Smoothing(InXY: tXYarray; CM: boolean; SpOpt: tSpOpt;
  var OutXY: tXYarray): boolean;
const
  SmCoeff: array [1 .. 10, 1 .. 13] of integer = ((131, 75, -30, 5, 0, 0, 0, 0,
    0, 0, 0, 0, 0), (179, 135, 30, -55, 15, 0, 0, 0, 0, 0, 0, 0, 0),
    (143, 120, 60, -10, -45, 18, 0, 0, 0, 0, 0, 0, 0),
    (677, 600, 390, 110, -160, -198, 110, 0, 0, 0, 0, 0, 0),
    (11053, 10125, 7500, 3755, -165, -2937, -2860, 2145, 0, 0, 0, 0, 0),
    (883, 825, 660, 415, 135, -117, -260, -195, 195, 0, 0, 0, 0),
    (1393, 1320, 1110, 790, 405, 18, -290, -420, -255, 340, 0, 0, 0),
    (44003, 42120, 36660, 28190, 17655, 6378, -3940, -11220, -13005, -6460,
    11628, 0, 0), (1011, 975, 870, 705, 495, 261, 30, -165, -285, -285, -114,
    285, 0), (4253, 4125, 3750, 3155, 2385, 1503, 590, -255, -915, -1255, -1122,
    -345, 1265));
  SmWeigh: array [1 .. 10] of integer = (231, 429, 429, 2431, 46189, 4199, 7429,
    260015, 6555, 30015);
var
  Factor, i, j, k, m, sz: integer;
  a: double;
  mXY: tXYarray;
begin
  Finalize(OutXY);
  Result := false;
  if CM then
    Factor := SpOpt.oChrom.Smooth.SGDegree
  else
    Factor := SpOpt.oMass.Smooth.SGDegree;
  sz := length(InXY);
  if sz = 0 then
    exit;
  if not CM and SpOpt.oMass.Smooth.FillNull then
  begin
    Equidistant(InXY, mXY);
    sz := length(mXY);
  end;
  SetLength(OutXY, sz);
  if sz <> length(mXY) then
  begin
    SetLength(mXY, sz);
    for i := 0 to sz - 1 do
      mXY[i] := InXY[i];
  end;
  for i := 0 to sz - 1 do
    OutXY[i] := mXY[i];
  if (Factor < 1) or (Factor > 10) then
  begin
    LastMathError := 'Smoothing/Wrong peak factor';
    exit;
  end;
  for i := Factor + 3 to sz - Factor - 3 do
  begin
    a := 0;
    for j := 1 to Factor + 2 do
      a := a + SmCoeff[Factor, j + 1] * (mXY[i - j, Y] + mXY[i + j, Y]);
    OutXY[i, Y] := (a + SmCoeff[Factor, 1] * mXY[i, Y]) / SmWeigh[Factor];
  end;
  Result := true;
end; { Smoothing }

function BSProcessing(InXY: tXYarray; CM: boolean; SpOpt: tSpOpt;
  var OutXY: tXYarray): boolean;
var
  mXY: tXYarray;
begin
  Result := Smoothing(InXY, CM, SpOpt, mXY);
  Result := Result and BLine(mXY, CM, SpOpt, OutXY);
  Finalize(mXY);
end;

function Peaking(InXY: tXYarray; CM: boolean; SpOpt: tSpOpt; var Peaks: tPeaks;
  var FD: tXYarray): boolean;
const
  DerCoeff: array [1 .. 11, 1 .. 12] of real = ((-8, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0), (-58, -67, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (-126, -193, -142, 86, 0, 0, 0, 0, 0, 0, 0, 0),
    (-296, -503, -532, -294, 300, 0, 0, 0, 0, 0, 0, 0),
    (-832, -1489, -1796, -1578, -660, 1133, 0, 0, 0, 0, 0, 0),
    (-7506, -13843, -17842, -18334, -14150, -4121, 12922, 0, 0, 0, 0, 0),
    (-358, -673, -902, -1002, -930, -643, -98, 746, 0, 0, 0, 0),
    (-2816, -5363, -8179, -8574, -8700, -7481, -4648, 68, 6936, 0, 0, 0),
    (-29592, -56881, -79564, -95338, -101900, -96947, -78176, -43284, 10032,
    84075, 0, 0), (-1222, -2365, -3350, -4098, -4530, -4567, -4130, -3140,
    -1518, 815, 3938, 0), (-8558, -16649, -23806, -29562, -33450, -35003,
    -33754, -29236, -20982, -8525, 8602, 30866));
  DerWeigh: array [1 .. 11] of real = (12, 252, 1188, 5148, 24024, 334152,
    23256, 255816, 3634092, 197340, 1776060);
var
  i, j, k, l, m, n, md, Factor, lFD: integer;
  a, b, c, y1, y2, AvNs: double;
  ch, cha: char;
  fn: string;
  P1, P2, P3, P4, A20, A21, A22, AAA, mFD: real;
  z: array [1 .. 50] of double;
  DNS: array [-4 .. 4] of double;
  bXY, mXY: tXYarray;
  wPeak: tPeak;
begin
  if Peaks = nil then
    Peaks := tPeaks.Create
  else
    Peaks.Clear;
  if CM then
  begin
    if not SpOpt.oChrom.Peak.Enabled then
      exit;
    Factor := 12 - SpOpt.oChrom.Peak.Sensiv;
  end
  else
  begin
    if not SpOpt.oMass.Peak.Enabled then
      exit;
    Factor := 12 - SpOpt.oMass.Peak.Sensiv;
  end;
  ch := 'n';
  if not(Factor in [1 .. 11]) then
  begin
    LastMathError := 'Peaking/Wrong peak sensitivity';
    exit;
  end;
  bXY := InXY;
  { if CM then
    else Equidistant(InXY,bXY); }
  if CM then
    l := SpOpt.oChrom.Peak.Method
  else
    l := SpOpt.oMass.Peak.Method;
  case l of
    1:
      begin // first deriv.
        SetLength(FD, length(bXY));
        for i := 0 to length(bXY) - 1 do
          FD[i, X] := bXY[i, X];
        mFD := 0;
        m := 0;
        for i := Factor + 1 to length(bXY) - Factor - 2 do
        begin
          a := 0;
          inc(m);
          for j := 1 to Factor + 1 do
            a := a + DerCoeff[Factor, j] * (bXY[i - j, Y] - bXY[i + j, Y]);
          a := a / DerWeigh[Factor];
          FD[i, Y] := a;
          mFD := mFD + abs(a);
        end;
        if m = 0 then
          exit;
        mFD := (mFD / m) * (Factor / 12) * (Factor / 12);
        // find peak
        j := 0;
        lFD := length(FD);
        for i := Factor + 1 to lFD - Factor - 2 do
        begin
          m := 0;
          n := 0;
          a := 0;
          b := 0;
          while (FD[i - m, Y] > 0) and ((i - m) > 0) do
          begin
            a := a + FD[i - m, Y];
            inc(m);
          end;
          if m = 0 then
            continue;
          a := a / m;
          while (FD[i + n + 1, Y] < 0) and ((i + n) < lFD) do
          begin
            b := b - FD[i + n + 1, Y];
            inc(n);
          end;
          if n = 0 then
            continue;
          b := abs(b) / n;
          if (m >= Factor) and (n >= Factor) and (a > mFD) and (b > mFD) then
          // max is right from i-th point
          begin { fine peak position }
            a := (FD[i, Y] - FD[i + 1, Y]) / (FD[i, X] - FD[i + 1, X]);
            b := FD[i, Y] - a * FD[i, X];
            wPeak.X := -b / a;

            a := (bXY[i, Y] - bXY[i + 1, Y]) / (bXY[i, X] - bXY[i + 1, X]);
            b := bXY[i, Y] - a * bXY[i, X];
            wPeak.Y := a * wPeak.X + b;
            if bXY[i, Y] > bXY[i + 1, Y] then
              wPeak.Index := i
            else
              wPeak.Index := i + 1;
            if ((i - 4) > 0) and ((i + 4) < length(bXY)) and false then
            // temp OFF
            begin
              for k := -4 to 4 do
                DNS[k] := 1 / (bXY[i + k, Y] + 0.1);
              P4 := DNS[-4] + DNS[+4];
              P3 := DNS[-3] + DNS[+3];
              P2 := DNS[-2] + DNS[+2];
              P1 := DNS[-1] + DNS[+1];
              A20 := -21 * P4 + 14 * P3 + 39 * P2 + 54 * P1 + 59 * DNS[0];
              A20 := A20 / 231;
              A21 := 4 * (DNS[-4] - DNS[+4]) + 3 * (DNS[-3] - DNS[+3]) + 2 *
                (DNS[-2] - DNS[+2]) + (DNS[-1] - DNS[+1]);
              A21 := A21 / 60;
              A22 := 28 * P4 + 7 * P3 - 8 * P2 - 17 * P1 - 20 * DNS[0];
              A22 := A22 / 924;
              if A22 = 0 then
              begin
                LastMathError := 'Error in Peak procedure';
                continue;
              end;
              c := -A21 / (2 * A22);
              // Peak.Pos[j]:= Spect[Fr].From+Spect[Fr].Step*(i-1-c);
              AAA := A20 + c * (A21 + c * A22);
              if AAA = 0 then
              begin
                LastMathError := 'Error in Peak procedure';
                continue;
              end;
              wPeak.Y := 1 / AAA;
            end;
            Peaks.Add(wPeak);
            inc(j); // next peak
          end;
        end;
      end;
    0:
      begin // GRAMS method
        AvNs := 0;
        m := length(bXY) - 1;
        for i := 0 to m - 2 do // average noise
          AvNs := AvNs + abs(bXY[i, Y] - bXY[i + 1, Y]);
        AvNs := (Factor * 0.4) * AvNs / (m - 1);
        i := 0;
        while (i <= m - 2) do
        begin
          if (bXY[i + 1, Y] - bXY[i, Y]) > AvNs then // peak start
          begin
            wPeak.Left := bXY[i, X];
            y1 := bXY[i, Y];
            y2 := 0;
            for k := i to m - 2 do // max seek
              if (bXY[k, Y] < bXY[k + 1, Y]) and (bXY[k + 1, Y] > bXY[k + 2, Y])
              then
              begin
                wPeak.Y := bXY[k + 1, Y];
                wPeak.X := bXY[k + 1, X];
                wPeak.Index := k + 1;
                break;
              end;
            for n := k + 1 to m - 2 do // right seek
              if ((abs(bXY[n + 1, Y] - bXY[n, Y]) < AvNs) and
                (abs(bXY[n + 1, X] - wPeak.X) > abs((wPeak.X - wPeak.Left) / 2))
                ) or // 2(?)- max factor of peak asymmetry
                (abs(bXY[n + 1, X] - wPeak.X) > abs(2 * (wPeak.X - wPeak.Left)))
              then
              begin
                wPeak.Right := bXY[n + 1, X];
                y2 := bXY[n + 1, Y];
                break;
              end;
            b := 0;
            for k := i to n do
              b := b + (bXY[k + 1, X] - bXY[k, X]) *
                (bXY[k, Y] + bXY[k + 1, Y]) / 2;
            wPeak.Area := b - (wPeak.Right - wPeak.Left) * (y2 + y1) / 2;
            Peaks.Add(wPeak);
            if n > i then
              i := n;
          end;
          inc(i);
        end;
      end; // end - GRAMS method
  end;
  i := 0; // MinHeight
  if CM then
    b := SpOpt.oChrom.Peak.MinHeight
  else
    b := SpOpt.oMass.Peak.MinHeight;
  while i < Peaks.Count do
    if Peaks[i].Y < b then
      Peaks.Delete(i)
    else
      inc(i);
  i := 0; // MinDist
  if CM then
    b := SpOpt.oChrom.Peak.MinDist
  else
    b := SpOpt.oMass.Peak.MinDist;
  while i < Peaks.Count - 1 do
    if (Peaks[i + 1].X - Peaks[i].X) < b then
    begin
      if Peaks[i].Y > Peaks[i + 1].Y then
        Peaks.Delete(i + 1)
      else
        Peaks.Delete(i);
    end
    else
      inc(i);
  i := 0; // MinArea
  if CM then
    b := SpOpt.oChrom.Peak.MinArea
  else
    b := SpOpt.oMass.Peak.MinArea;
  if l = 0 then
    while i < Peaks.Count do
      if Peaks[i].Y < b then
        Peaks.Delete(i)
      else
        inc(i);
end; { Peaking }

end.
