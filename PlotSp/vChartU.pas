unit vChartU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeeShape, TeEngine, Series, TeeProcs, Chart, ImgList, ComCtrls, ToolWin,
  Grids, ExtCtrls, StdCtrls, TeeTools, TeeStore, CandleCh, SpecU, SpOptU, PeakU,
  Menus, Math;

type
  TSelectEvent = procedure(Sender: TObject; Idx: integer) of object;

  TvChart = class(TFrame)
    pnlData: TPanel;
    Splitter2: TSplitter;
    sgData: TStringGrid;
    sgPeaks: TStringGrid;
    pnlChart: TPanel;
    ImageList1: TImageList;
    chrChart: TChart;
    ImageList2: TImageList;
    pnlLeft: TPanel;
    tlbrManip: TToolBar;
    tbDataTable: TToolButton;
    ToolButton1: TToolButton;
    tbSmooth: TToolButton;
    tbBLine: TToolButton;
    tbPeak: TToolButton;
    Panel1: TPanel;
    lbAcq: TLabel;
    ToolBar1: TToolBar;
    tbAutosize: TToolButton;
    tbAutoY: TToolButton;
    ToolButton3: TToolButton;
    tbZoomMode: TToolButton;
    tbRangeMode: TToolButton;
    ChartCursor: TCursorTool;
    ChromSeries: TLineSeries;
    MassSeries: TVolumeSeries;
    ToolBar2: TToolBar;
    tbSaveData: TToolButton;
    tbCopyData: TToolButton;
    ToolButton5: TToolButton;
    tbSavePeaks: TToolButton;
    tbCopyPeaks: TToolButton;
    SaveDialog1: TSaveDialog;
    ctlNearest: TNearestTool;
    ctlDragMark: TDragMarksTool;
    ctlColorBand: TColorBandTool;
    CursorAnnotation: TAnnotationTool;
    procedure chrChartDragOver(Sender, Source: TObject; X, Y: integer;
      State: TDragState; var Accept: Boolean);
    procedure chrChartEndDrag(Sender, Target: TObject; X, Y: integer);
    procedure chrChartStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure chrChartZoom(Sender: TObject);
    procedure chrChartMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure tbAutosizeClick(Sender: TObject);
    procedure tbAutoYClick(Sender: TObject);
    procedure chrChartDblClick1(Sender: TObject);
    procedure chrChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure chrChartMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure tbSaveDataClick(Sender: TObject);
    procedure tbCopyDataClick(Sender: TObject);
    procedure ctlNearestChange(Sender: TObject);
    procedure sgDataClick(Sender: TObject);
    procedure sgPeaksClick(Sender: TObject);
    procedure ChartCursorChange(Sender: TCursorTool; X, Y: integer;
      const XValue, YValue: Double; Series: TChartSeries; ValueIndex: integer);
    procedure chrChartDblClick(Sender: TObject);
  private
    { Private declarations }
    InsLf, InsRt: single;
    InsN: integer;
    fChartVis: Boolean;
    fAcqMode: Boolean;
    RMarks: TList;
    ActiveMark: Boolean;
    fChromComp: Boolean;
    fZoomMode, fFixY: Boolean;
    ActMarkPos: integer;
    FOnSelect: TSelectEvent;
    procedure SetChartVis(Value: Boolean);
    procedure SetAcqMode(Value: Boolean);
    procedure CreateCursor;
    procedure SetZoomMode(Value: Boolean);
    procedure SetFixY(Value: Boolean);

  public
    { Public declarations }
    sgRanges: TStringGrid;
    srsSpec: TChartSeries;
    Peaks: tPeaks;
    SpOpt: tSpOpt;
    property ChromComp: Boolean read fChromComp;
    property ChartVis: Boolean read fChartVis write SetChartVis;
    property AcqMode: Boolean read fAcqMode write SetAcqMode default false;
    property ZoomMode: Boolean read fZoomMode write SetZoomMode default true;
    property FixY: Boolean read fFixY write SetFixY default true;

    property OnSelect: TSelectEvent read FOnSelect write FOnSelect;

    procedure Initialise(CM: Boolean);
    procedure UpdateDataTable;
    function GetClosestPoint(crX: Double): integer;
    function RangeNumber: integer;
    function IsInside(X: Double): integer;
    function IsEmpty: Boolean;
    function AddRMark(StartPos, EndPos: Double): integer;
    procedure SelectMark(Idx: integer);
    procedure UpdateFromTable;
    procedure SaveToTemplate(Filename: string);
    procedure LoadFromTemplate(Filename: string);
  end;

var
  MyPriority: Boolean;

implementation

{$R *.DFM}

uses ClipBrd, AboutU;

function TvChart.AddRMark(StartPos, EndPos: Double): integer;
var
  cb: TColorBandTool;
begin
  Result := -1;
  cb := TColorBandTool.Create(self);
  cb.ParentChart := chrChart;
  cb.Axis := chrChart.BottomAxis;
  if (RMarks.Count mod 2) = 0 then
    cb.Brush.Style := bsBDiagonal
  else
    cb.Brush.Style := bsFDiagonal;
  cb.Color := clRed;
  cb.Transparency := 20;
  cb.Brush.Color := clWhite;
  cb.Pen.Color := clRed;
  cb.Active := true;
  cb.StartValue := StartPos;
  if StartPos = EndPos then
    with chrChart.Series[0] do
      cb.EndValue := XScreenToValue(CalcXPosValue(EndPos) + 1)
  else
    cb.EndValue := EndPos;
  Result := RMarks.Add(cb);
end;

procedure TvChart.SelectMark(Idx: integer);
var
  i, j: integer;
begin
  j := RMarks.Count - 1;
  for i := 0 to j do
    if i = (Idx - 1) then
    begin
      TColorBandTool(RMarks[i]).Color := clFuchsia;
      TColorBandTool(RMarks[i]).Pen.Color := clFuchsia;
    end
    else
    begin
      TColorBandTool(RMarks[i]).Color := clRed;
      TColorBandTool(RMarks[i]).Pen.Color := clRed;
    end;
end;

procedure TvChart.CreateCursor;
begin
  if ChartCursor = nil then
  begin
    ChartCursor := TCursorTool.Create(self);
    with ChartCursor do
    begin
      ParentChart := chrChart;
      Series := srsSpec;
      Style := cssVertical;
      Pen.Color := clRed;
    end;
  end;
  ChartCursor.Series := srsSpec;
  ChartCursor.Active := ChromComp;
  CursorAnnotation.Active := ChartCursor.Active;
end;

procedure TvChart.SetZoomMode(Value: Boolean);
var
  i, j: integer;
begin
  tbZoomMode.Down := Value;
  tbRangeMode.Down := not Value;
  chrChart.AllowZoom := Value;
  if Value then
    chrChart.Cursor := crCross
  else
    chrChart.Cursor := crHSplit;
  ChartCursor.Active := Value and ChromComp;
  CursorAnnotation.Active := ChartCursor.Active;

  for i := 0 to RMarks.Count - 1 do
    TColorBandTool(RMarks[i]).Active := not Value;
  tbAutoY.Click;
  if Assigned(FOnSelect) and (fZoomMode <> Value) then
    FOnSelect(self, -1);
  fZoomMode := Value;
end;

procedure TvChart.SetFixY(Value: Boolean);
begin
  fFixY := Value;
  if fFixY then
    tbAutoY.ImageIndex := 9
  else
    tbAutoY.ImageIndex := 5;
  tbAutoYClick(nil);
end;

procedure TvChart.Initialise(CM: Boolean);
begin
  RMarks := TList.Create;
  chrChart.CancelMouse := false;
  fChromComp := CM;
  if fChromComp then
  begin
    srsSpec := chrChart.Series[0];
    chrChart.Series[1].ParentChart := nil;
    sgData.Options := sgData.Options + [goRowSelect];
    sgPeaks.Options := sgPeaks.Options + [goRowSelect];
  end
  else
  begin
    srsSpec := chrChart.Series[1];
    chrChart.Series[0].ParentChart := nil;
    sgData.Options := sgData.Options - [goRowSelect];
    sgPeaks.Options := sgPeaks.Options - [goRowSelect];
  end;
  CreateCursor;
  ctlNearest.Active := not CM and not AcqMode;
  chrChart.Title.Visible := CM;
  Peaks := tPeaks.Create;
  InsLf := 0;
  InsRt := 0;
  InsN := 0;
  // chrChart.TeeUseMouseWheel:= true;
end;

function TvChart.IsEmpty: Boolean;
begin
  Result := (srsSpec.Count = 0);
end;

procedure TvChart.SetChartVis(Value: Boolean);
begin
  fChartVis := Value;
  if fChartVis then
    pnlChart.BringToFront
  else
    pnlData.BringToFront;
end;

procedure TvChart.SetAcqMode(Value: Boolean);
begin
  fAcqMode := Value;
  if fAcqMode then
  begin
    tbZoomMode.Down := true;
    ChartVis := true;
    lbAcq.Caption := 'Acq';
  end;
  tbRangeMode.Enabled := not fAcqMode;
  if fAcqMode then
    lbAcq.Font.Color := clRed
  else
  begin
    lbAcq.Font.Color := clBlack;
    lbAcq.Caption := '';
  end;
  ChartCursor.Active := not fAcqMode;
  CursorAnnotation.Active := ChartCursor.Active;
  tlbrManip.Visible := not fAcqMode;
  ctlNearest.Active := not ChromComp and not fAcqMode;
end;

function TvChart.GetClosestPoint(crX: Double): integer;
var
  i, j: integer;
  af, al: Double;
begin
  Result := -1;
  if AcqMode then
    exit;
  with srsSpec do
  begin
    if Count = 0 then
      exit;
    af := XValue[FirstValueIndex];
    al := XValue[LastValueIndex];
    if al = af then
      exit;
    i := round((LastValueIndex - FirstValueIndex) * (crX - af) / (al - af)) +
      FirstValueIndex;
    j := i;
    if j > 0 then
      while (XValue[j] - crX) > (XValue[j] - XValue[j - 1]) do
      begin
        dec(j);
        if j = 0 then
          break;
      end;
    if j < Count - 1 then
      while (crX - XValue[j]) > (XValue[j + 1] - XValue[j]) do
      begin
        inc(j);
        if j = Count - 1 then
          break;
      end;
    if (crX > XValue[j]) and (j < Count - 1) then
      if (XValue[j + 1] - crX) < (crX - XValue[j]) then
        inc(j);
    if (crX < XValue[j]) and (j > 0) then
      if (XValue[j] - crX) > (crX - XValue[j - 1]) then
        dec(j);
    if j < FirstValueIndex then
      j := FirstValueIndex;
    if j > LastValueIndex then
      j := LastValueIndex;
  end;
  Result := j;
end; { TvChart.GetClosestPoint }

procedure TvChart.chrChartStartDrag(Sender: TObject;
  var DragObject: TDragObject);
var
  tmpX, tmpY: Double;
  X, Y: integer;
begin
  if tbZoomMode.Down or AcqMode then
    exit;
  if not PtInRect(chrChart.ChartRect, chrChart.GetCursorPos) then
    exit;
  srsSpec.GetCursorValues(tmpX, tmpY);
  AddRMark(tmpX, 0);
  sgRanges.Cells[0, RMarks.Count - 1] := MyFloatToStr(tmpX);
end; { TvChart.chrChartStartDrag }

procedure TvChart.chrChartDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: Boolean);
var
  tmpX, tmpY: Double;
  i, j: integer;
  a: Double;
begin
  if tbZoomMode.Down or AcqMode then
    exit;
  if not PtInRect(chrChart.ChartRect, chrChart.GetCursorPos) then
    exit;
  srsSpec.GetCursorValues(tmpX, tmpY);
  Accept := true;
end; { TvChart.chrChartDragOver }

procedure TvChart.chrChartEndDrag(Sender, Target: TObject; X, Y: integer);
var
  tmpX, tmpY: Double;
  WShape: TChartShape;
  i, j: integer;
begin
  if tbZoomMode.Down or AcqMode then
    exit;
  if not PtInRect(chrChart.ChartRect, chrChart.GetCursorPos) then
    exit;
  srsSpec.GetCursorValues(tmpX, tmpY);
  i := RMarks.Count - 1;
  if i < 1 then
    exit;
  if trim(sgRanges.Cells[0, i]) = trim(sgRanges.Cells[1, i]) then
  begin
    j := GetClosestPoint(tmpX);
    if j > -1 then
    begin
      if not IsInside(srsSpec.XValues[j]) > -1 then
      begin
        TColorBandTool(RMarks[i]).StartValue := srsSpec.XValues[j];
        TColorBandTool(RMarks[i]).EndValue := srsSpec.XValues[j] + 1;
        sgRanges.Cells[0, i] := MyFloatToStr(srsSpec.XValues[j]);
        sgRanges.Cells[1, i] := '-';
        sgRanges.Cells[2, i] := '1';
      end
      else
      begin
        TColorBandTool(RMarks[i]).Free;
        RMarks.Delete(i);
        sgRanges.Cells[0, i] := '';
        sgRanges.Cells[1, i] := '';
        sgRanges.Cells[2, i] := '';
      end;
    end;
  end;
  if tbRangeMode.Down then
    if Assigned(FOnSelect) then
      FOnSelect(self, -1);
end; { TvChart.chrChartEndDrag }

procedure TvChart.chrChartZoom(Sender: TObject);
var
  i, j: integer;
begin // if AcqMode then exit;
  ZoomMode := tbZoomMode.Down;
  with srsSpec.Marks do
    for i := 0 to Positions.Count - 1 do
      if Assigned(Positions.Items[i]) then
        Positions.Position[i].Custom := false;
  if Assigned(FOnSelect) and (not ChromComp) and (Sender <> nil) then
    FOnSelect(self, -1);
  CursorAnnotation.Active := ChartCursor.Active;
  if CursorAnnotation.Active then
    CursorAnnotation.Shape.Left := srsSpec.CalcXPosValue
      (ChartCursor.XValue) - 20;
  ActMarkPos := -1;
end; { TvChart.chrChartZoom }

function TvChart.RangeNumber: integer;
var
  i, j: integer;
begin
  Result := 0;
  with sgRanges do
  begin
    j := RowCount - 1;
    while (j > 0) and (trim(Cells[0, j]) = '') do
      dec(j);
  end;
  Result := j;
end;

function TvChart.IsInside(X: Double): integer;
// returns which range is over (covers) x
var
  i, j, k, ea, eb: integer;
  a, b: Double;
begin
  Result := -1;
  k := -1;
  if sgRanges = nil then
    exit;
  if (X >= InsLf) and (X <= InsRt) and (InsLf <> InsRt) then
  begin
    Result := InsN;
    exit;
  end;
  with sgRanges do
  begin
    for i := 1 to RowCount - 1 do
    begin
      if trim(Cells[0, i]) = '' then
        break;
      val(Cells[0, i], a, ea);
      if ea > 0 then
        continue;
      if (Cells[1, i]) = '-' then
      begin
        b := a;
        if ChromComp then
        begin
          if MyFloatToStr(X) = trim(Cells[0, i]) then
            k := i
          else
            continue;
        end
        else
        begin
          if (abs(X - a)) < 0.5 then
            k := i
          else
            continue;
        end;
      end;
      val(Cells[1, i], b, eb);
      if eb = 0 then
        if (X >= a) and (X <= b) then
          k := i;
      if k > 0 then
      begin
        InsLf := a;
        InsRt := b;
        InsN := k;
        break;
      end;
    end;
  end;
  Result := k;
end; { TfrmPlot.IsInside }

procedure TvChart.UpdateFromTable;
var
  i, j, k, m, l: integer;
  a: Double;
  bb: Boolean;
begin
  while RMarks.Count > 0 do // clear all the RMarks
  begin
    i := RMarks.Count - 1;
    TColorBandTool(RMarks[i]).Free;
    RMarks.Delete(i);
  end; // left the cursor mark
  with sgRanges do
  begin
    for k := RowCount - 1 downto 1 do // remove empties
    begin
      val(trim(Cells[1, k]), a, j);
      val(trim(Cells[0, k]), a, i);
      if (i = 0) and (trim(Cells[1, k]) = '') then
      begin
        Cells[1, k] := '-';
        m := GetClosestPoint(a);
        if m > -1 then
          Cells[0, k] := MyFloatToStr(srsSpec.XValues[m]);
      end;
      if (i > 0) or ((j > 0) and (trim(Cells[1, k]) <> '-')) then
        Cells[0, k] := '';
    end;
    for k := RowCount - 1 downto 1 do // find last
      if trim(Cells[0, i]) = trim(Cells[1, i]) then
        Cells[1, i] := '-';
    for k := RowCount - 1 downto 1 do // find last
      if trim(Cells[0, k]) <> '' then
        break;
    for i := 1 to k do // remove dulplicates
      for j := i + 1 to k do
        if trim(Cells[0, i]) = trim(Cells[0, j]) then
          Cells[0, j] := '';
    m := 0;
    for k := RowCount - 1 downto 1 do // find last non-empty
      if (trim(Cells[0, k]) <> '') or (trim(Cells[1, k]) <> '') then
        break;
    for i := 1 to RowCount - 1 do // compress
      while (trim(Cells[0, i]) = '') and (k > m) do
      begin
        inc(m);
        for j := i to k do
        begin
          Cells[0, j] := Cells[0, j + 1];
          Cells[1, j] := Cells[1, j + 1];
          Cells[2, j] := Cells[2, j + 1];
        end;
      end;
    for k := RowCount - 1 downto 1 do // find last
      if trim(Cells[0, k]) <> '' then
        break;
    for i := 1 to k do // recreate colorbands
    begin
      l := AddRMark(StrToFloat(Cells[0, i]), StrToFloat(Cells[0, i]));
      if trim(Cells[1, i]) <> '-' then
        TColorBandTool(RMarks[l]).EndValue := StrToFloat(Cells[1, i]);
    end;
  end;
end; { TvChart.UpdateFromTable }

procedure TvChart.UpdateDataTable;
var
  i, j: integer;
  srsW: TChartSeries;
  sgD, sgP: TStringGrid;
begin
  with sgData do // data table
  begin
    ColCount := 2;
    RowCount := srsSpec.Count + 1;
    if ChromComp then
    begin
      Cells[1, 0] := '  TIC/SIC';
      j := -3;
      case SpOpt.oChrom.Visual.XUnits of
        0:
          sgData.Cells[0, 0] := ' Index';
        1:
          sgData.Cells[0, 0] := ' Ret.time[s]';
        2:
          sgData.Cells[0, 0] := ' Ret.time[min]';
      end;
    end
    else
    begin
      Cells[0, 0] := ' m/z';
      Cells[1, 0] := '  Ampl.';
      j := -4;
    end;
    for i := 0 to srsSpec.Count - 1 do
    begin
      if MyPriority then
        Cells[0, i + 1] := MyFloatToStr(RoundTo(srsSpec.XValues[i], j)) + ' (' +
          IntToStr(i) + ')'
      else
        Cells[0, i + 1] := MyFloatToStr(RoundTo(srsSpec.XValues[i], j));
      Cells[1, i + 1] := MyFloatToStr(srsSpec.YValues[i]);
    end;
  end;
  with sgPeaks do // peak table
  begin
    Visible := (Peaks.Count > 0);
    tbSavePeaks.Enabled := Visible;
    tbCopyPeaks.Enabled := Visible;
    if not Visible then
      exit;
    ColCount := 6;
    DefaultColWidth := 80;
    ColWidths[0] := 45;
    if ChromComp then
    begin
      Cells[1, 0] := ' Ret.Time';
      Cells[2, 0] := '  TIC/SIC';
    end
    else
    begin
      Cells[1, 0] := ' m/z';
      Cells[2, 0] := '  Ampl.';
    end;
    Cells[0, 0] := ' Index';
    Cells[3, 0] := '  Left';
    Cells[4, 0] := '  Right';
    Cells[5, 0] := '  Area';
    RowCount := Peaks.Count + 1;
    for i := 0 to Peaks.Count - 1 do
    begin
      Cells[0, i + 1] := IntToStr(Peaks[i].Index);
      Cells[1, i + 1] := MyFloatToStr(Peaks[i].X);
      Cells[2, i + 1] := MyFloatToStr(Peaks[i].Y);
      Cells[3, i + 1] := MyFloatToStr(Peaks[i].Left);
      Cells[4, i + 1] := MyFloatToStr(Peaks[i].Right);
      Cells[5, i + 1] := MyFloatToStr(Peaks[i].Area);
    end;
    if ChromComp then
    begin
      if SpOpt.oChrom.Peak.Method = 1 then
        ColCount := 3;
    end
    else
    begin
      if (SpOpt.oMass.Peak.Method = 1) or (SpOpt.oMass.Peak.Method = 2) then
        ColCount := 3;
    end;
  end;
end; { TvChart.UpdateDataTable }

procedure TvChart.tbAutosizeClick(Sender: TObject);
begin
  chrChart.LeftAxis.Automatic := true;
  chrChart.BottomAxis.Automatic := true;
end;

procedure TvChart.tbAutoYClick(Sender: TObject);
var
  i, j: integer;
  Ymax, Ymin, dY, dYUp, k: Double;
begin
  if tbAutoY.Down then
    chrChart.Zoom.Direction := tzdHorizontal
  else
    chrChart.Zoom.Direction := tzdBoth;
  if not tbAutoY.Down then
    exit;
  Ymax := chrChart.LeftAxis.Minimum;
  Ymin := chrChart.LeftAxis.Maximum;
  if FixY then
  begin
    if srsSpec.YValues.MinValue < srsSpec.YValues.MaxValue then
    begin
      if srsSpec.YValues.MinValue < chrChart.LeftAxis.Maximum then
        chrChart.LeftAxis.Minimum := srsSpec.YValues.MinValue;
      if srsSpec.YValues.MaxValue > chrChart.LeftAxis.Minimum then
        chrChart.LeftAxis.Maximum := srsSpec.YValues.MaxValue;
    end;
  end
  else
  begin
    for i := 0 to srsSpec.Count - 1 do
      if (srsSpec.XValues.Value[i] > chrChart.BottomAxis.Minimum) and
        (srsSpec.XValues.Value[i] < chrChart.BottomAxis.Maximum) then
      begin
        if Ymax < srsSpec.YValues.Value[i] then
          Ymax := srsSpec.YValues.Value[i];
        if Ymin > srsSpec.YValues.Value[i] then
          Ymin := srsSpec.YValues.Value[i];
      end;
    dY := abs(Ymin - Ymax) * 0.03;
    if tbPeak.Down then
      dYUp := 4 * dY
    else
      dYUp := dY;
    if Ymin < Ymax then
      chrChart.LeftAxis.SetMinMax(Ymin, Ymax + dYUp);
  end;
end; { TvChart.tbAutoYClick }

procedure TvChart.chrChartDblClick1(Sender: TObject);
var
  i, j, k, m, l: integer;
  Xpos, Ypos, a, b: Double;
begin
  ActMarkPos := -1;
  if ZoomMode or AcqMode or IsEmpty or not PtInRect(chrChart.ChartRect,
    chrChart.GetCursorPos) then
    exit;

  srsSpec.GetCursorValues(Xpos, Ypos);
  a := 0;
  m := srsSpec.Count - 1;
  for i := 0 to m do // first approximation
    a := a + srsSpec.YValues[i];
  b := 2 * a / (m + 1);
  a := 0;
  j := 0;
  for i := 0 to m do // second approximation
    if srsSpec.YValues[i] < b then // without the peaks
    begin
      a := a + srsSpec.YValues[i];
      inc(j);
    end;
  if j > 0 then
    a := a / j;

  j := GetClosestPoint(Xpos);
  if j < 0 then
    exit;
  i := j;
  k := j;
  while (i > 0) and (srsSpec.YValues[i] > a) do
    dec(i);
  while (k < (m - 1)) and (srsSpec.YValues[k] > a) do
    inc(k);
  l := RMarks.Count;
  if l > 1 then
    with sgRanges do
      if (trim(Cells[0, l]) = trim(Cells[0, l - 1])) and
        (trim(Cells[1, l]) = '-') and (trim(Cells[1, l - 1]) = '-') then
      begin
        TColorBandTool(RMarks.Last).Free;
        RMarks.Delete(l - 1);
        Cells[0, l] := '';
        Cells[1, l] := '';
        Cells[2, l] := '';
      end;
  if RMarks.Count = 0 then
    AddRMark(srsSpec.XValues[i], srsSpec.XValues[k]);
  l := RMarks.Count;
  if l > 0 then
    with sgRanges do
    begin
      TColorBandTool(RMarks.Last).StartValue := srsSpec.XValues[i];
      TColorBandTool(RMarks.Last).EndValue := srsSpec.XValues[k];

      Cells[0, l] := MyFloatToStr(srsSpec.XValues[i]);
      Cells[1, l] := MyFloatToStr(srsSpec.XValues[k]);
      Cells[2, l] := '1';
    end;
  ActiveMark := false;
  ActMarkPos := -1;
end; { TvChart.chrChartDblClick }

procedure TvChart.chrChartMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  tmpX, tmpY: Double;
  i: integer;
  chr: TChart;
begin
  if ssRight in Shift then
    exit;
  if ZoomMode and not ChromComp then
    exit;
  if ssDouble in Shift then
  begin
    chrChartDblClick1(Sender);
    exit;
  end;
  if (Sender = chrChart) then
  begin
    chr := (Sender as TChart);
    if chr.SeriesCount = 0 then
      exit;
    with srsSpec do
    begin
      if XScreenToValue(X) < XValue[FirstValueIndex] then
        exit;
      if XScreenToValue(X) > XValue[LastValueIndex] then
        exit;
    end;
    ActMarkPos := X;
  end;
  if ZoomMode or AcqMode or IsEmpty or
    (not PtInRect(chrChart.ChartRect, Point(X, Y)) and (Sender = chrChart)) then
    exit;
  ActiveMark := false;
end; { TvChart.chrChartMouseDown }

procedure TvChart.chrChartMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
var
  tmpX, tmpY, a: Double;
  i, j: integer;
begin
  if ssRight in Shift then
    exit;
  if ZoomMode or IsEmpty or AcqMode then
    exit;
  if (abs(ActMarkPos - X) > Mouse.DragThreshold) and (ActMarkPos > 0) then
  begin
    tmpX := srsSpec.XScreenToValue(ActMarkPos);
    if IsInside(tmpX) > -1 then
    begin
      ActMarkPos := -1;
      exit;
    end;
    with srsSpec do
      if (XScreenToValue(X) < XValue[FirstValueIndex]) or
        (XScreenToValue(X) > XValue[LastValueIndex]) then
      begin
        ActMarkPos := -1;
        exit;
      end;
    i := AddRMark(tmpX, tmpX);
    j := GetClosestPoint(tmpX);
    sgRanges.Cells[0, i + 1] := MyFloatToStr(srsSpec.XValues[j]);
    ActMarkPos := -1;
    ActiveMark := true;
    exit;
  end;
  if ActiveMark then
  begin
    tmpX := srsSpec.XScreenToValue(X);
    ActiveMark := PtInRect(chrChart.ChartRect, Point(X, Y));
    i := RMarks.Count;
    if i < 1 then
      exit;
    a := tmpX - TColorBandTool(RMarks.Last).StartValue;
    if a < 0 then
      exit;
    TColorBandTool(RMarks.Last).Active := true;
    j := GetClosestPoint(tmpX);
    TColorBandTool(RMarks.Last).EndValue := tmpX;
    sgRanges.Cells[1, i] := MyFloatToStr(srsSpec.XValues[j]);
    sgRanges.Cells[2, i] := '1';
  end;
end; { TvChart.chrChartMouseMove }

procedure TvChart.chrChartMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  tmpX, tmpY, a, b, c, xc, yc: Double;
  i, j, k, l: longint;
begin
  ctlNearest.Active := not ChromComp and not AcqMode;
  if (Button = mbRight) or (srsSpec.Count = 0) or AcqMode or (ssDouble in Shift)
    or IsEmpty or (ZoomMode and not ChromComp) or
    (not PtInRect(chrChart.ChartRect, Point(X, Y)) and (Sender = chrChart)) then
    exit;
  tmpX := srsSpec.XScreenToValue(X);
  i := GetClosestPoint(tmpX);
  j := RMarks.Count;
  if tbRangeMode.Down then
  begin
    if (not ActiveMark and (ActMarkPos >= 0) and // single point selection
      (i >= srsSpec.FirstValueIndex) and (i <= srsSpec.LastValueIndex))
    // or (ssShift in Shift)
    { and
      ((trim(sgRanges.Cells[1,j])='') or //(abs(ActMarkPos-X)<Mouse.DragThreshold) or
      (trim(sgRanges.Cells[0,j])=trim(sgRanges.Cells[1,j]))) } then
    begin
      if IsInside(srsSpec.XValues[i]) = -1 then
      begin
        if (ssShift in Shift) then
          a := srsSpec.XValues[ctlNearest.Point]
        else
          a := srsSpec.XValues[i];
        j := AddRMark(a, a);
        sgRanges.Cells[0, j + 1] := MyFloatToStr(a);
        sgRanges.Cells[1, j + 1] := '-';
        sgRanges.Cells[2, j + 1] := '1';
      end;
    end;
    if ActiveMark and // range selection
      (i >= srsSpec.FirstValueIndex) and (i <= srsSpec.LastValueIndex) then
    begin
      TColorBandTool(RMarks[j - 1]).EndValue := srsSpec.XValues[i];
      sgRanges.Cells[1, j] := MyFloatToStr(srsSpec.XValues[i]);
      sgRanges.Cells[2, j] := '1';
      b := srsSpec.XValues[i];
      i := GetClosestPoint(StrToFloat(sgRanges.Cells[0, j]));
      TColorBandTool(RMarks[j - 1]).StartValue := srsSpec.XValues[i];
      sgRanges.Cells[0, j] := MyFloatToStr(srsSpec.XValues[i]);
      if b < srsSpec.XValues[i] then // inversed band
      begin
        sgRanges.Cells[0, j] := '';
        sgRanges.Cells[1, j] := '';
        sgRanges.Cells[2, j] := '';
        UpdateFromTable;
      end;
    end;
    ActiveMark := false;
    ActMarkPos := -1;
    if Assigned(FOnSelect) then
      FOnSelect(self, -1);
    { l:= RMarks.Count;
      if l>1 then         // double click when twice click (leave it ?)
      with sgRanges do
      if ((trim(Cells[0,l])=trim(Cells[0,l-1])) and
      (trim(Cells[1,l])='-') and (trim(Cells[1,l-1])='-')) then chrChartDblClick(Sender); }
  end
  else
  begin // zooming
    if not ChartCursor.Active then
      exit;
    srsSpec.GetCursorValues(xc, yc);
    k := srsSpec.CalcXPosValue(xc);
    if chrChart.Zoom.Active and (abs(ActMarkPos - k) > Mouse.DragThreshold) then
    begin
      ActMarkPos := -1;
      exit;
    end;
    with srsSpec do // zoom mode selection
    begin
      if (i >= FirstValueIndex) and (i <= LastValueIndex) then
      begin
        ChartCursor.XValue := XValues[i];
        if Assigned(FOnSelect) then
          FOnSelect(self, i);

        with CursorAnnotation do
        begin
          Shape.Left := ChartCursor.Series.CalcXPosValue(XValues[i]) - 20;
          Shape.Font.Color := clNavy;
          Text := srsSpec.XValueToText(XValues[i]);
        end;
      end
      else
        Hint := 'Out of range. Try again.';
    end;
  end;
  ActMarkPos := -1;
end; { TvChart.chrChartMouseUp }

procedure TvChart.SaveToTemplate(Filename: string);
var
  md, mu: TMouseEvent;
  mm: TMouseMoveEvent;
  oz, os: TNotifyEvent;
  i: integer;
  cp: Double;
begin
  with sgRanges do
    for i := 1 to RowCount - 1 do
    begin
      Cells[0, i] := '';
      Cells[1, i] := '';
      Cells[2, i] := '';
    end;
  UpdateFromTable;
  cp := ChartCursor.XValue;
  if ChromComp then
    ChromSeries.ParentChart := nil
  else
    MassSeries.ParentChart := nil;
  md := chrChart.OnMouseDown;
  chrChart.OnMouseDown := nil;
  mu := chrChart.OnMouseUp;
  chrChart.OnMouseUp := nil;
  mm := chrChart.OnMouseMove;
  chrChart.OnMouseMove := nil;
  os := chrChart.OnScroll;
  chrChart.OnScroll := nil;
  oz := chrChart.OnZoom;
  chrChart.OnZoom := nil;
  chrChart.OnUndoZoom := nil;
  FreeAndNil(ChartCursor);
  chrChart.Tools.Clear;

  SaveChartToFile(TCustomChart(chrChart), Filename, false); // itself
  chrChart.OnMouseDown := md;
  chrChart.OnMouseUp := mu;
  chrChart.OnMouseMove := mm;
  chrChart.OnScroll := os;
  chrChart.OnZoom := oz;
  chrChart.OnUndoZoom := oz;
  srsSpec.ParentChart := chrChart;
  CreateCursor;
  ChartCursor.XValue := cp;
  ZoomMode := true;
end; { TvChart.SaveToTemplate }

procedure TvChart.LoadFromTemplate(Filename: string);
var
  md, mu: TMouseEvent;
  mm: TMouseMoveEvent;
  oz, os: TNotifyEvent;
  i: integer;
  cp: Double;
begin
  if not FileExists(Filename) then
    raise Exception.Create(Filename + '- not found');
  with sgRanges do
    for i := 1 to RowCount - 1 do
    begin
      Cells[0, i] := '';
      Cells[1, i] := '';
      Cells[2, i] := '';
    end;
  UpdateFromTable;
  cp := ChartCursor.XValue;
  if ChromComp then
    ChromSeries.ParentChart := nil
  else
    MassSeries.ParentChart := nil;
  md := chrChart.OnMouseDown;
  chrChart.OnMouseDown := nil;
  mu := chrChart.OnMouseUp;
  chrChart.OnMouseUp := nil;
  mm := chrChart.OnMouseMove;
  chrChart.OnMouseMove := nil;
  os := chrChart.OnScroll;
  chrChart.OnScroll := nil;
  oz := chrChart.OnZoom;
  chrChart.OnZoom := nil;
  chrChart.OnUndoZoom := nil;
  FreeAndNil(ChartCursor);
  chrChart.Tools.Clear;
  LoadChartFromFile(TCustomChart(chrChart), Filename); // itself
  chrChart.OnMouseDown := md;
  chrChart.OnMouseUp := mu;
  chrChart.OnMouseMove := mm;
  chrChart.OnZoom := os;
  chrChart.OnUndoZoom := oz;
  chrChart.OnScroll := oz;
  srsSpec.ParentChart := chrChart;
  if ctlNearest = nil then
    ctlNearest := TNearestTool.Create(chrChart);
  ctlNearest.ParentChart := chrChart;
  CreateCursor;
  ChartCursor.XValue := cp;
  ZoomMode := true;
end; { TvChart.LoadFromTemplate }

procedure TvChart.tbSaveDataClick(Sender: TObject);
var
  i, j: integer;
  sg: TStringGrid;
  ts: TStrings;
  ss: string;
begin
  sg := nil;
  if Sender = tbSaveData then
    sg := sgData;
  if (Sender = tbSavePeaks) and sgPeaks.Visible then
    sg := sgPeaks;
  if sg = nil then
    exit;
  if sg.RowCount <= 1 then
    exit;
  ts := TStringList.Create;
  for i := 1 to sg.RowCount - 1 do
  begin
    ss := sg.Cells[0, i];
    for j := 1 to sg.ColCount - 1 do
      ss := ss + #9 + sg.Cells[j, i];
    ts.Add(ss);
  end;
  if SaveDialog1.Execute then
    ts.SaveToFile(SaveDialog1.Filename);
  ts.Free;
end;

procedure TvChart.tbCopyDataClick(Sender: TObject);
var
  i, j: integer;
  sg: TStringGrid;
  ts: TStrings;
  ss: string;
begin
  sg := nil;
  if Sender = tbCopyData then
    sg := sgData;
  if (Sender = tbCopyPeaks) and sgPeaks.Visible then
    sg := sgPeaks;
  if sg = nil then
    exit;
  if sg.RowCount <= 1 then
    exit;
  ts := TStringList.Create;
  for i := 1 to sg.RowCount - 1 do
  begin
    ss := sg.Cells[0, i];
    for j := 1 to sg.ColCount - 1 do
      ss := ss + #9 + sg.Cells[j, i];
    ts.Add(ss);
  end;
  ClipBoard.AsText := ts.Text;
  ts.Free;
end;

procedure TvChart.ctlNearestChange(Sender: TObject);
var
  sx, sy: string;
begin
  if IsEmpty then
    exit;
  if chrChart.SubTitle.Text.Count = 0 then
  begin
    chrChart.SubTitle.Text.Add(''); // chrChart.UndoZoom;
  end;
  if not ChromComp then
  begin
    sx := MyFloatToStr(round(srsSpec.XValues[ctlNearest.Point] * 10) / 10);
    sy := MyFloatToStr(srsSpec.YValues[ctlNearest.Point]);
    chrChart.Hint := '|Mass= ' + sx + ' [amu]' + '  Intens= ' + sy;
    chrChart.SubTitle.Text[0] := sx + ' / ' + sy;
  end;
end;

procedure TvChart.sgDataClick(Sender: TObject);
begin
  if Assigned(FOnSelect) then
    FOnSelect(self, sgData.Row - 1);
end;

procedure TvChart.sgPeaksClick(Sender: TObject);
begin // if not ChromComp then exit;
  sgData.Row := StrToInt(sgPeaks.Cells[0, sgPeaks.Row]) + 1;
end;

procedure TvChart.ChartCursorChange(Sender: TCursorTool; X, Y: integer;
  const XValue, YValue: Double; Series: TChartSeries; ValueIndex: integer);
begin
  if not ChromComp then
    exit;
  with CursorAnnotation do // waiting for teechart patch
  begin
    Shape.Font.Color := clMaroon;
    Shape.Left := X - 20;
    Text := Series.XValueToText(XValue);
  end;
end;

procedure TvChart.chrChartDblClick(Sender: TObject);
var
  i, j, k: integer;
  tmpX, tmpY: Double;
begin
  if ZoomMode and ChromComp and (srsSpec.Count > 2) then
  begin
    srsSpec.GetCursorValues(tmpX, tmpY);
    j := GetClosestPoint(tmpX);
    if j = -1 then
      exit;
    i := 1;
    if j = 0 then
      k := 1
    else
    begin
      if (srsSpec.YValue[j - 1] > srsSpec.YValue[j]) then
        k := -1
      else
        k := 1;
    end;
    while (((j + i * k) > 0) and ((j + i * k) < srsSpec.Count)) and
      (srsSpec.YValue[j + i * k] < srsSpec.YValue[j + (i + 1) * k]) do
      inc(i);
    ChartCursor.XValue := srsSpec.XValue[j + i * k];
    if Assigned(FOnSelect) then
      FOnSelect(self, j + i * k);
  end;
end;

end. { vChartU }

{ TSeriesMarkPosition=class
  public
  ArrowFrom : TPoint;
  ArrowFix  : Boolean;
  ArrowTo   : TPoint;
  Custom    : Boolean;
  Height    : Integer;
  LeftTop   : TPoint;
  Width     : Integer;
  Procedure Assign(Source:TSeriesMarkPosition);
  Function Bounds:TRect;
  end;
}
