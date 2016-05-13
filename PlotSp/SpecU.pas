unit SpecU;

interface

uses Classes, Dialogs, Sysutils, Forms, Controls, StdCtrls, clipbrd, Math,
  Windows, HDIndexU;

const
  MaxNScans = 10000;
  MaxNArray = 200000;
  MaxInMemory = 2E7;

type
  (* // HD header
    rCalibrationStructureOldFloat=record                            // Size=2560
    mass:array[0..15, 0..1, 0..1, 0..1, 0..1]of Single;
    intensity:array[0..15, 0..1, 0..1, 0..1, 0..1]of Single;
    Valid:array[0..15, 0..1, 0..1, 0..1, 0..1]of Word;
    end;

    rRun_Stats=record                                               //Size=9294
    magic: Word;
    software_version_number: array[0..3]of Char;
    machine_type: Word;
    creation_date: Cardinal;
    old_default_calibration: rCalibrationStructureOldFloat;
    old_created_calibration: rCalibrationStructureOldFloat;
    old_current_calibration: rCalibrationStructureOldFloat;
    number_of_scans: Word;
    comment_fields: array[0..1599]of Char;
    end;

    rScan_stats=Record                                             //Size=80
    scan_number, stored_mode: Word;
    number_of_shots_per_scan: Cardinal;
    number_of_scans_per_second: Single;
    tagged: Word;
    scan_time: Cardinal;
    max_peak_height_per_single_scan,  max_mv_per_single_shot: Integer;
    max_peak_height, total_peak_area: Integer;
    scan_record_length: Cardinal;
    positive_ion,  high_mass_range,
    reflectron, raster_x_on, raster_y_on,
    x_position, y_position,
    laser_power, laser_2_power:Word;
    parent_mass: Single;
    laser_2_time, scan_x_then_y, data_source,
    sample_number, m_tdc_length, m_tdc_rate,
    m_trans_rec_length,  m_trans_rec_rate: Word;
    ions_per_adc_bit: Single;
    end;

    Mass_Table=record                                   // Size=14
    mass:Real;
    intensity:Integer;
    flags:Word;
    end; *)

  // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  tIdxXY = (X, Y);
  dPoint = array [X .. Y] of single;
  tXYarray = array of dPoint;
  tMass = array of tXYarray;
  tNomMass = array of single;
  RefreshPlotProc = procedure of object;
  tFileKind = (fkNone, fkTxt, fkDta, fkNetCDF, fkHD, fkMassLynx, fkCashe);
  // none if there is no file yet

  TnetCDF = class;

  TSpec = class(TPersistent)
  private
    { Private declarations }
    fMassOnly, fCasheOn, fFromFileOn: boolean;
    DiskCashe: File;
    CasheIdx: array of integer;
    fFilename: string;
    fFileKind: tFileKind;
    fMass: tMass;
    fAutoRefresh: boolean;
    LastNomMassIdx: integer;
    // HDHandler: THDHandler;
    f_HDFile: File;
    HDnSpec: integer;
    function MassLimit(left: boolean): single;
    procedure SetMassOnly(Value: boolean);
    function GetNSpec: integer;
    function GetMass(Index: integer): tXYarray;
    function GetNomMass(Index: integer): tXYarray;
    procedure SetCasheOn(Value: boolean);
    procedure SetAutoRefresh(Value: boolean);
  public
    { Public declarations }
    ScanStats: rScan_stats; // HD stuff
    FileHeader: rRun_Stats;
    LastReadIndex: integer;

    netCDF: TnetCDF;

    Chrom: tXYarray; // internally X is in seconds
    Number: integer;
    CMass: tXYarray;
    SplitOn: integer; // exception for HDT
    HDindex: THDIndex;
    RefreshPlot: RefreshPlotProc;

    procedure Initialise;
    function AddSSpec(ret, tot: double; SMass: tXYarray): integer;
    function AddMass(m, a: single; iSpec: integer): integer;
    function AssignXY(inXY: tXYarray): tXYarray;
    procedure AssignSpec(Source: TSpec);
    procedure Clear;
    function AreaSellectThre(var Threshold: integer; ChromPeakX: single;
      var LeftLimit, RightLimit: single): tXYarray;
    function AreaSellectLimit(LeftLimit, RightLimit: single): tXYarray;

    function OpenFile(oFilename: string): boolean;
    function SaveFile(sFilename: string): boolean;

    function OpenHDFile(oFilename: string): boolean;
    function SaveHDFile(sFilename: string): boolean;
    function ReadHDSpectrum(iIndex: integer): tXYarray;
    function CreateHDFile(sFilename: string): boolean;
    function CloseHDFile: boolean;
    function AddHDSpectrum(Spectrum: tXYarray): boolean;

    procedure FillSampleValues(Num: integer);

    property FileKind: tFileKind read fFileKind default fkNone;
    property Mass[Index: integer]: tXYarray read GetMass;
    property NomMass[Index: integer]: tXYarray read GetNomMass;
    property Filename: string read fFilename;
    property MassOnly: boolean read fMassOnly write SetMassOnly default false;
    property NSpec: integer read GetNSpec;
    property AutoRefresh: boolean read fAutoRefresh write SetAutoRefresh
      default true;

    // CasheOn has bigger priority than FromFileOn, ('cos it's faster and safer)
    // so it swiches ON regardless FromFileOn state,
    // when it goes from ON to OFF - depends of the size,
    // if it's too big - forbiden
    property CasheOn: boolean read fCasheOn write SetCasheOn default false;
    // FromFileOn can be switched ON only inside OpenFile or CreateHDFile
    property FromFileOn: boolean read fFromFileOn default false;
  end;

  TnetCDF = class
    error_log, instrument_name, instrument_id, instrument_mfr, instrument_model,
      instrument_os_version, instrument_sw_version: string;
    flag_count: integer;
    a_d_sampling_rate, scan_duration, mass_range_min, mass_range_max,
      resolution: double;

    Spec: TSpec;
    function Open(oFilename: string): boolean;
    function ReadSpectrum(Idx: integer): tXYarray;
    function Save(sFilename: string): boolean;
  end;

function MyFloatToStr(a: double): string;
function LowerOrder(a: double): double;
function CheckFileKind(Filename: string): tFileKind;
procedure XY2file(inXY: tXYarray; Filename: string);
function file2XY(Filename: string): tXYarray;

implementation
uses DelphiDeclarations, SpOptU, SpMathU, AboutU, MassLynxReadU;
var
  MassLynx: TMassLynx;

/// /////////////////////////////////////////////////////////////////////
function MyFloatToStr(a: double): string;
begin
  Result := FloatToStrF(a, ffGeneral, 7, 3);
end;

function LowerOrder(a: double): double;
var
  i: integer;
  b: double;
begin
  if a < 1 then
  begin
    Result := 0;
    exit;
  end;
  b := 1;
  for i := 0 to 25 do
  begin
    if (a > b) and (a < b * 10) then
      Result := b;
    b := b * 10;
  end;
end;

function CheckFileKind(Filename: string): tFileKind;
var
  ss: string;
  i, j: integer;
begin
  Result := fkNone;
  ss := UpperCase(ExtractFileExt(Filename));
  system.Delete(ss, 1, 1);
  if (ss = 'TXT') or (ss = 'PRN') then
    Result := fkTxt;
  if ss = 'CDF' then
    Result := fkNetCDF;
  if ss = 'CSH' then
    Result := fkCashe;
  if copy(ss, 1, 1) = 'R' then
  begin
    val(copy(ss, 2, 2), i, j);
    if j = 0 then
      Result := fkHD;
  end;
  ss := UpperCase(ExtractFilePath(Filename));
  system.Delete(ss, length(ss), 1);
  ss := UpperCase(ExtractFileExt(ss));
  if ss = '.RAW' then
    Result := fkMassLynx;
end;

procedure XY2file(inXY: tXYarray; Filename: string);
var
  i, j: integer;
  ls: TStrings;
begin
  try
    ls := TStringList.Create;
    for i := 0 to length(inXY) - 1 do
      ls.Add(MyFloatToStr(inXY[i, X]) + #9 + MyFloatToStr(inXY[i, Y]));
    ls.SaveToFile(Filename);
  finally
    ls.Free;
  end;
end;

function file2XY(Filename: string): tXYarray;
var
  i, j: integer;
  ls: TStrings;
begin
  setLength(Result, 0);
  try
    ls := TStringList.Create;
    if not FileExists(Filename) then
      exit;
    ls.LoadFromFile(Filename);
    setLength(Result, ls.Count);
    for i := 0 to ls.Count - 1 do
    begin
      j := pos(#9, ls[i]);
      if j = 0 then
        continue;
      Result[i, X] := StrToFloat(copy(ls[i], 1, j - 1));
      Result[i, Y] := StrToFloat(copy(ls[i], j + 1, 255));
    end;
  finally
    ls.Free;
  end;
end;

/// //////////////////////////////////////////////////////////////////////
procedure TSpec.Initialise; // init the switches
begin
  LastReadIndex := -99;
  CasheOn := false;
  fFromFileOn := false;
  SplitOn := 0;
  HDnSpec := -1;
  fAutoRefresh := false;
end;

procedure TSpec.Clear; // clear all the data
begin
  Finalize(Chrom);
  Finalize(fMass);
  Finalize(CMass);
  Finalize(CasheIdx);
  if CasheOn then
  begin
    CloseFile(DiskCashe);
    fCasheOn := false;
  end;
  if Assigned(HDindex) then
    FreeAndNil(HDindex);
  if Assigned(netCDF) then
    FreeAndNil(netCDF);
  if Assigned(MassLynx) then
    FreeAndNil(MassLynx);
end;

procedure TSpec.SetMassOnly(Value: boolean);
begin
  fMassOnly := Value;
  if Value then
    fFileKind := fkTxt;
end;

procedure TSpec.SetAutoRefresh(Value: boolean);
var
  bb: boolean;
begin
  bb := not fAutoRefresh and Value;
  fAutoRefresh := Value;
  if bb then
    RefreshPlot;
end;

procedure TSpec.SetCasheOn(Value: boolean);
var
  i, j, zr: integer;
  wMass: tXYarray;
begin
  zr := 0;
  if fCasheOn = Value then
  begin
    fCasheOn := Value;
    exit;
  end;
  if fMassOnly then
  begin
    fCasheOn := false;
    exit;
  end;
  if not fCasheOn and Value then // creates the cashe file
  begin
    AssignFile(DiskCashe, GetDataPath + 'SP' + GetPlotSymbol(Number + 1)
      + '.csh');
    Rewrite(DiskCashe, 1);
    Seek(DiskCashe, 0);
    BlockWrite(DiskCashe, zr, 4);
    setLength(CasheIdx, NSpec);
    for i := 0 to NSpec - 1 do
    begin
      CasheIdx[i] := FilePos(DiskCashe);
      wMass := Mass[i]; // takes the data from memory or ext. file (FromFileOn)
      for j := 0 to length(wMass) - 1 do
      begin
        BlockWrite(DiskCashe, wMass[j, X], 4);
        BlockWrite(DiskCashe, wMass[j, Y], 4);
      end;
      BlockWrite(DiskCashe, zr, 4);
      BlockWrite(DiskCashe, zr, 4);
    end;
    setLength(fMass, 0);
    fFromFileOn := false;
    LastReadIndex := -99;
  end;
  if fCasheOn and not Value then // get the cashe file into memory
  begin
    if FileSize(DiskCashe) > MaxInMemory then
      raise Exception.Create('The file is too big (' +
        IntToStr(round(FileSize(DiskCashe) / 1024)) + ' k) ' +
        'to fit into the memory.');
    setLength(fMass, NSpec);
    for i := 0 to NSpec - 1 do
      fMass[i] := GetMass(i);
    CloseFile(DiskCashe);
    setLength(CasheIdx, 0);
    fFromFileOn := false;
  end;
  fCasheOn := Value;
end; { TSpec.SetCasheOn }

function TSpec.GetNSpec: integer;
begin
  Result := length(Chrom);
end;

function TSpec.GetMass(Index: integer): tXYarray;
var
  i, j, k: integer;
begin
  if FromFileOn and (HDnSpec > -1) and (FileKind = fkHD) then // for acquisition
  begin
    Result := CMass;
    exit;
  end;
  if (index < 0) or (index >= NSpec) then
    exit;
  if not CasheOn and not FromFileOn then
    Result := fMass[Index];
  if CasheOn and FromFileOn then
    raise Exception.Create('Internal cashe error. #1');
  if CasheOn then // from the cashe
  begin
    if LastReadIndex = Index then
      Result := CMass
    else
    begin
      Seek(DiskCashe, CasheIdx[Index]);
      if Index = (NSpec - 1) then
        k := round((FileSize(DiskCashe) - CasheIdx[Index]) / 8)
      else
        k := round((CasheIdx[Index + 1] - CasheIdx[Index]) / 8);
      dec(k);
      setLength(Result, k);
      for i := 0 to k - 1 do
      begin
        BlockRead(DiskCashe, Result[i, X], 4);
        BlockRead(DiskCashe, Result[i, Y], 4);
      end;
      CMass := Result;
    end;
    LastReadIndex := Index;
    exit;
  end;
  if FromFileOn then // from the file
  begin
    if FileKind <> fkHD then // so far works only with HD files
    raise Exception.Create('Internal cashe error. #2');
    if LastReadIndex = Index then
      Result := CMass
    else
    begin
      CMass := ReadHDSpectrum(Index);
      Result := CMass;
    end;
    LastReadIndex := Index;
  end;
end; { TSpec.GetMass }

function TSpec.GetNomMass(Index: integer): tXYarray;
begin
  if (Index < 0) or (Index >= NSpec) then
    exit;
  ToNomMass(Mass[Index], Result);
end;

function TSpec.MassLimit(left: boolean): single;
var
  i, j: integer;
  a, b, c: double;
begin
  if left then
    a := Mass[0][0, X]
  else
    a := Mass[0][high(Mass[0]), X];
  for i := 1 to NSpec - 1 do
    if left then
      a := min(a, Mass[i][0, X])
    else
      a := max(a, Mass[i][high(Mass[i]), X]);
  Result := a;
end;

function TSpec.AreaSellectThre(var Threshold: integer; ChromPeakX: single;
  var LeftLimit, RightLimit: single): tXYarray;
var
  i, j, k, li, ri, ci: integer;
  a, b, c: double;
  wMass: tXYarray;
begin
  if Threshold > 100 then
    exit;
  if Threshold >= 0 then
    a := MaxXYarray(Chrom)[Y] * Threshold / 100 // manual
  else
  begin
    a := MaxXYarray(Chrom)[Y] * Threshold / 100; // auto !!! later
  end;
  li := trunc(MassLimit(true));
  ri := ceil(MassLimit(false));
  setLength(Result, ri - li + 2);
  for j := 0 to ri - li + 1 do
    Result[j, X] := j + li;
  b := abs(ChromPeakX - Chrom[0, X]);
  ci := 0;
  for i := 0 to NSpec - 1 do // chrom peak index
    if b > abs(ChromPeakX - Chrom[i, X]) then
    begin
      b := abs(ChromPeakX - Chrom[i, X]);
      ci := i;
    end;
  for i := ci - 1 downto 0 do
    if Chrom[i, Y] > a then
    begin
      wMass := NomMass[i];
      LeftLimit := Chrom[i, X];
      for j := 0 to length(wMass) - 1 do
      begin
        k := round(wMass[j, X]);
        if k < li then
          continue;
        Result[k - li, X] := k;
        Result[k - li, Y] := Result[k - li, Y] + wMass[j, Y];
      end;
    end
    else
      break;
  for i := ci to NSpec - 1 do
    if Chrom[i, Y] > a then
    begin
      wMass := NomMass[i];
      RightLimit := Chrom[i, X];
      for j := 0 to length(wMass) - 1 do
      begin
        k := round(wMass[j, X]);
        if k < li then
          continue;
        Result[k - li, X] := k;
        Result[k - li, Y] := Result[k - li, Y] + wMass[j, Y];
      end;
    end
    else
      break;
end; { TSpec.AreaSellection }

function TSpec.AreaSellectLimit(LeftLimit, RightLimit: single): tXYarray;
var
  i, j, k, li, ri: integer;
  wMass: tXYarray;
begin
  li := trunc(MassLimit(true));
  ri := ceil(MassLimit(false));
  setLength(Result, ri - li + 2);
  for i := 0 to NSpec - 1 do
  begin
    if LeftLimit > Chrom[i, X] then
      continue;
    wMass := NomMass[i];
    for j := 0 to length(wMass) - 1 do
    begin
      k := round(wMass[j, X]);
      Result[k - li, X] := k;
      Result[k - li, Y] := Result[k - li, Y] + wMass[j, Y];
    end;
    if RightLimit < Chrom[i, X] then
      break;
  end;
end; { TSpec.AreaSellectLimit }
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function TSpec.OpenFile(oFilename: string): boolean;
var
  ts: TStringList;
  i, j, n, k, m, l, fsz, b1, b2: integer;
  inix, cx, cy: real;
  ss: string;
  f: file of Byte;
  bprn: boolean;
  ax, ay, sy: single;
begin
  Result := false;
  fFileKind := CheckFileKind(oFilename);
  fFromFileOn := false;
  AssignFile(f, oFilename);
  Reset(f);
  fsz := FileSize(f);
  CloseFile(f);
  try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    case fFileKind of
      fkHD:
        begin
          fFromFileOn := (fsz > MaxInMemory);
          if OpenHDFile(oFilename) then
            Result := true
          else
            fFileKind := fkNone;
        end;
      fkNetCDF:
        begin
          if netCDF = nil then
            netCDF := TnetCDF.Create;
          netCDF.Spec := self;
          if netCDF.Open(oFilename) then
            Result := true
          else
            fFileKind := fkNone;
        end;
      fkMassLynx:
        begin
          if Assigned(MassLynx) then MassLynx.Free;
          MassLynx := TMassLynx.Create;
          MassLynx.Spec := self;
          if MassLynx.Open(ExtractFilePath(oFilename)) then
            Result := true
          else
            fFileKind := fkNone;
        end;
      fkTxt:
        begin
          ts := TStringList.Create;
          Result := false;
          fFileKind := fkNone;
          ts.LoadFromFile(oFilename);
          n := ts.Count;
          if n = 0 then
          begin
            ShowMessage('Empty data file');
            FreeAndNil(ts);
            exit;
          end;
          setLength(CMass, n);
          l := 0;
          inix := 1;
          bprn := (ExtractFileExt(UpperCase(oFilename)) = '.PRN');
          if bprn then
          begin
            ss := InputBox('Input Box', 'First mass', '1');
            val(ss, inix, j);
            if j <> 0 then
               raise Exception.Create('Wrong first mass.');
          end;
          for i := 0 to n - 1 do
          begin
            ss := ts[i];
            k := 0;
            if length(ss) > 0 then
              if (ss[1] = ';') or (ss[1] = '''') then
                continue;
            b1 := pos('(', ss);
            b2 := pos(')', ss);
            if b1 * b2 > 0 then
              Delete(ss, b1, b2 - b1 + 1);
            if not bprn then
            begin
              j := system.pos(#9, ss);
              if j = 0 then
                if MessageDlg('Error: "tab" is missing, line (' + IntToStr(i) +
                  ') ->' + ss + #10 + oFilename + #10 + 'Continue ?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                  continue
                else
                begin
                  FreeAndNil(ts);
                  exit;
                end;
              val(trim(copy(ss, 1, j - 1)), cx, k);
            end;
            val(trim(copy(ss, j + 1, 255)), cy, m);
            if (k <> 0) or (m <> 0) then
              if MessageDlg('Error: Wrong number syntax, line (' + IntToStr(i) +
                ') ->' + ss + #10 + oFilename + #10 + 'Continue ?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                continue
              else
              begin
                FreeAndNil(ts);
                exit;
              end;
            if bprn then
              CMass[l, X] := inix
            else
              CMass[l, X] := cx;
            CMass[l, Y] := cy;
            inc(l);
            inix := inix + 1;
          end;
          dec(l);
          setLength(CMass, l);
          Result := true;
          fFileKind := fkTxt;
          FreeAndNil(ts);
        end;
      fkCashe:
        begin
          AssignFile(DiskCashe, oFilename);
          setLength(Chrom, 0);
          setLength(CasheIdx, 0);
          Reset(DiskCashe, 1);
          Seek(DiskCashe, 0);
          BlockRead(DiskCashe, ax, 4);
          i := 0;
          while not EoF(DiskCashe) do
          begin
            BlockRead(DiskCashe, ax, 4);
            BlockRead(DiskCashe, ay, 4);
            sy := sy + ay;
            if (ax = 0) and (ay = 0) then
            begin
              setLength(Chrom, length(Chrom) + 1);
              Chrom[i, X] := i;
              Chrom[i, Y] := sy;
              setLength(CasheIdx, length(CasheIdx) + 1);
              CasheIdx[i] := FilePos(DiskCashe);
              sy := 0;
              inc(i);
            end;
          end;
          fFromFileOn := false;
          fCasheOn := true;
          LastReadIndex := -99;
        end;
    end;
    fFilename := oFilename;
    if fFileKind = fkNone then
    begin
      Clear;
      fFilename := '';
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end; { TSpec.OpenFile }

function TSpec.SaveFile(sFilename: string): boolean;
var
  i, j: integer;
  ts: TStrings;
  cFileKind: tFileKind;
begin
  Result := false;
  if sFilename = '' then
    raise Exception.Create('Filename is missing');
  cFileKind := CheckFileKind(sFilename);
  if fMassOnly then
    fFileKind := fkTxt;
  try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    case cFileKind of
      fkNone:
        ShowMessage('Unknown file type');
      fkHD:
        Result := SaveHDFile(sFilename);
      fkNetCDF:
        begin
          netCDF := TnetCDF.Create;
          netCDF.Spec := self;
          Result := netCDF.Save(sFilename);
        end;
      fkMassLynx:
        ShowMessage('MassLynx file saving is not available yet.');
      fkTxt:
        begin
          if length(CMass) = 0 then
          raise Exception.Create('No data to save.');
          ts := TStringList.Create;
          for i := Low(CMass) to High(CMass) do
            ts.Add(FloatToStr(CMass[i, X]) + #9 + FloatToStr(CMass[i, Y]));
          ts.SaveToFile(sFilename);
          ts.Free;
        end;
    end;
    // conversion from one type to another
    // ...
  finally
    Screen.Cursor := crDefault;
  end;
end;

function Gauss(X, x0, sigma: real): real;
begin
  Result := exp(-(sqr(X - x0) / (2 * sqr(sigma)))) / sqrt(2 * pi * sqr(sigma));
end;

procedure TSpec.FillSampleValues(Num: integer);
var
  i, j, k: integer;
  SMass: tXYarray;
  a: real;
begin // Clear;
  setLength(SMass, Num);
  for i := 1 to 10 do
  begin
    a := 0;
    for j := 0 to Num - 1 do
    begin
      SMass[j, X] := j;
      SMass[j, Y] := 80 * Gauss(j, 40, 5) + 50 * Gauss(j, 80, 5) + 65 *
        Gauss(j, 100, 5) + random / 1.5;
      a := a + SMass[j, Y];
    end;
    AddSSpec(2 * i + 20, a, SMass);
  end;
end; { TSpec.FillSampleValues }

function TSpec.AssignXY(inXY: tXYarray): tXYarray;
var
  i, j: integer;
begin
  setLength(Result, length(inXY));
  for i := low(inXY) to high(inXY) do
    Result[i] := inXY[i];
end;

procedure TSpec.AssignSpec(Source: TSpec); // copy only the memory data
var
  i, j: integer;
begin
  setLength(Chrom, Source.NSpec);
  for i := 0 to Source.NSpec - 1 do
    Chrom[i] := Source.Chrom[i];
  setLength(CMass, high(Source.CMass) - low(Source.CMass) + 1);
  for i := low(Source.CMass) to high(Source.CMass) do
    CMass[i] := Source.CMass[i];
  setLength(fMass, Source.NSpec);
  for i := 0 to Source.NSpec - 1 do
  begin
    setLength(fMass[i], high(Source.Mass[i]) - low(Source.Mass[i]) + 1);
    for j := low(Source.Mass[i]) to high(Source.Mass[i]) do
      fMass[i, j] := Source.fMass[i, j];
  end;
end; { TSpec.Assign }

function TSpec.AddSSpec(ret, tot: double; SMass: tXYarray): integer;
var
  i, j, k, zr: integer;
  iXY: tIdxXY;
  wMass: tXYarray;
begin
  Result := -1;
  try
    zr := 0;
    if fMassOnly or (HDnSpec > -1) then
    begin
      setLength(CMass, length(SMass));
      for i := low(SMass) to high(SMass) do
        CMass[i] := SMass[i];
      if (HDnSpec > -1) then
      begin
        k := HDnSpec;
        setLength(Chrom, k + 1);
        Chrom[k, X] := ret;
        Chrom[k, Y] := tot;
        AddHDSpectrum(SMass);
      end;
      LastReadIndex := k;
    end
    else
    begin
      if NSpec > 0 then
        if ret <= Chrom[NSpec - 1, X] then
        raise Exception.Create('Retation times must follow in ascending order');
      if FromFileOn and not CasheOn then
        CasheOn := true; // transfer the data from the file to the cashe
      k := NSpec;
      setLength(Chrom, k + 1);
      Chrom[k, X] := ret;
      Chrom[k, Y] := tot;
      if CasheOn // to the cashe
      then
      begin
        setLength(CasheIdx, length(CasheIdx) + 1);
        CasheIdx[length(CasheIdx) - 1] := FileSize(DiskCashe);
        if not EoF(DiskCashe) then
          Seek(DiskCashe, FileSize(DiskCashe));
        for j := 0 to length(SMass) - 1 do
        begin
          BlockWrite(DiskCashe, SMass[j, X], 4);
          BlockWrite(DiskCashe, SMass[j, Y], 4);
        end;
        BlockWrite(DiskCashe, zr, 4);
        BlockWrite(DiskCashe, zr, 4);
      end // to memory
      else
      begin
        setLength(fMass, k + 1);
        setLength(fMass[k], length(SMass));
        for i := low(SMass) to high(SMass) do
          fMass[k, i] := SMass[i];
      end;
    end;
    Result := NSpec - 1;
  finally
    Application.ProcessMessages;
    if fAutoRefresh then
      RefreshPlot;
  end;
end; { TSpec.AddSSpec }

function TSpec.AddMass(m, a: single; iSpec: integer): integer;
begin
  Result := -1;
  if fMassOnly then
  begin
    setLength(CMass, length(CMass) + 1);
    CMass[high(CMass), X] := m;
    CMass[high(CMass), Y] := a;
    Result := length(CMass);
  end
  else
  begin
    if (iSpec < 0) or (iSpec >= NSpec) then
      exit;
    if CasheOn and (iSpec <> (NSpec - 1)) then // if it is not the last spec
      raise Exception.Create('Internal error <AddMass> #1');
    if CasheOn then
    begin
      if not EoF(DiskCashe) then
        Seek(DiskCashe, FileSize(DiskCashe));
      BlockWrite(DiskCashe, m, 4);
      BlockWrite(DiskCashe, a, 4);
      Result := round((FilePos(DiskCashe) - CasheIdx[iSpec]) / 4);
    end
    else
    begin
      if iSpec>=length(fMass) then
      begin
        if DesignTime then ShowMessage('length adjustment');
        setLength(fMass,iSpec+1);
      end;

      setLength(fMass[iSpec], length(fMass[iSpec]) + 1);
      fMass[iSpec, high(fMass[iSpec]), X] := m;
      fMass[iSpec, high(fMass[iSpec]), Y] := a;
      Result := length(fMass[iSpec]);
    end;
  end;
end; { TSpec.AddMass }

// ----------------------------------------------------------------------------//
// Funciton: OpenFile                                                         //
// //
// Purpose: Opens an HD formatted file and displays it into a spectrum plot   //
// //
// Parameters : oFileName:string, the complete path to the file               //
// //
// Return Value: boolean : True if the file is opened and displayed,          //
// False otherwise                                    //
// ----------------------------------------------------------------------------//
function TSpec.OpenHDFile(oFilename: string): boolean;
const
  RecLength = 100000;
var
  fHDFile: File;
  AmtTransferred, i, j, nScanStyle: integer;
  nScans: Word;
  bDone, AR: boolean;
  aMass: array of tXYarray;
  rMassTmp: tXYarray;
  nPeaks: Cardinal;
  aTIC, aRetTime: array of single;
  MIPair: array [0 .. 1] of Mass_Table;
begin
  Result := false;
  fFilename := oFilename;
  AR := AutoRefresh;
  AutoRefresh := false;
  try
    try
      if HDindex = nil then
        HDindex := THDIndex.Create;
      fFromFileOn := HDindex.IndexFile(oFilename);
      if not fFromFileOn then
      begin
        HDindex.Free;
        exit;
      end;
      // Open file
      AssignFile(fHDFile, oFilename);
      Reset(fHDFile, 1);
      BlockRead(fHDFile, FileHeader, 9294, AmtTransferred); // Read file header
      if 9294 <> AmtTransferred then
      raise Exception.Create('Error while reading HD run stats');
      nScans := FileHeader.number_of_scans;

      // Mem allocation
      if fFromFileOn then
      begin
        setLength(Chrom, nScans);
        for i := 0 to nScans - 1 do
        begin
          Chrom[i, X] := HDindex.aRetTime[i];
          Chrom[i, Y] := HDindex.aTIC[i];
        end;
        Result := true;
        exit;
      end;

      setLength(aTIC, nScans);
      setLength(aRetTime, nScans);
      setLength(aMass, nScans);
      setLength(rMassTmp, RecLength);

      // Positionning in file
      Seek(fHDFile, 14016 + 9294);
      if not CasheOn and FromFileOn then
        Finalize(CasheIdx);
      // Start
      for i := 1 to nScans do
      begin // 4100 = max number of peaks
        if i = 1 then // For the first one only
        begin
          BlockRead(fHDFile, ScanStats, 80);
          nScanStyle := ScanStats.stored_mode;
        end
        else if (nScanStyle = 0) or (nScanStyle = 1) or (nScanStyle = 3) or
          (nScanStyle = 2) then // i.e. for i:=1 to NbScans-1
          BlockRead(fHDFile, ScanStats, 80);

        if not CasheOn and FromFileOn then
        begin
          setLength(CasheIdx, length(CasheIdx) + 1);
          CasheIdx[length(CasheIdx) - 1] := FilePos(fHDFile);
        end;

        // Parameter initialization
        aRetTime[i - 1] := i / ScanStats.number_of_scans_per_second;
        if isNAN(aRetTime[i - 1]) or (aRetTime[i - 1] = 8) then
          raise EMathError.Create('Problem reading R file');
        aTIC[i - 1] := 0.0;
        nPeaks := 0;

        repeat
          bDone := false;
          BlockRead(fHDFile, MIPair[0], 14);
          if MIPair[0].Mass <> 0.0 then
          begin
            aTIC[i - 1] := aTIC[i - 1] + MIPair[0].intensity;
            rMassTmp[nPeaks][X] := MIPair[0].Mass;
            rMassTmp[nPeaks][Y] := MIPair[0].intensity;
            nPeaks := nPeaks + 1;
            BlockRead(fHDFile, MIPair[1], 14);
          end
          else
            break;
          if MIPair[1].Mass = 0.0 then
            bDone := true
          else
          begin
            aTIC[i - 1] := aTIC[i - 1] + MIPair[1].intensity;
            rMassTmp[nPeaks][X] := MIPair[1].Mass;
            rMassTmp[nPeaks][Y] := MIPair[1].intensity;
            nPeaks := nPeaks + 1;
          end;
          if nPeaks > RecLength then
            raise Exception.Create('Too many peaks have been read without a zero');
        until bDone;

        setLength(aMass[i - 1], nPeaks);
        for j := 0 to nPeaks - 1 do
        begin
          aMass[i - 1][j] := rMassTmp[j];
          aMass[i - 1][j] := rMassTmp[j];
        end;
      end;
      if not CasheOn and FromFileOn then
      begin
        setLength(Chrom, nScans);
        for i := 0 to nScans - 1 do
        begin
          Chrom[i, X] := aRetTime[i];
          Chrom[i, Y] := aTIC[i];
        end;
        Result := true;
        exit;
      end;

      // Display Results
      for i := 0 to nScans - 1 do
        AddSSpec(aRetTime[i], aTIC[i], aMass[i]);
      Result := true;
    except
      on EMathError do
        ShowMessage('Problem reading R file');
    end;
  finally
    AutoRefresh := AR;
    if Result then
      CloseFile(fHDFile);
    Finalize(aMass);
    Finalize(aRetTime);
    Finalize(aTIC);
    Finalize(rMassTmp);
  end;
end; { TSpec.OpenHDFile }

// ----------------------------------------------------------------------------//
// Funciton: SaveFile                                                         //
// //
// Purpose: Saves the contents of the selected plot into a HD formatted file  //
// //
// Parameters : sFileName:string, the complete path to the file               //
// //
// Return Value: boolean : True if the file is saved                          //
// False otherwise                                    //
// ----------------------------------------------------------------------------//
function TSpec.SaveHDFile(sFilename: string): boolean;
var
  fHDFile: File;
  fh: rRun_Stats;
var
  nScans, i, j: integer;
var
  bDone: boolean;
var
  rMass: Mass_Table;
begin
  Result := false;

  try
    // Open file
    AssignFile(fHDFile, sFilename);
    Rewrite(fHDFile, 1);
    // Write Header
    nScans := NSpec;
    if FileKind = fkHD then
      FileHeader := fh;
    FileHeader.number_of_scans := nScans;
    FileHeader.theos_zero_flag := 'TZ';
    FileHeader.theos_zero := Chrom[0, X];
    BlockWrite(fHDFile, FileHeader, 9294);

    Seek(fHDFile, 14016 + 9294);

    for i := 1 to nScans do
    begin
      ScanStats.stored_mode := 2;
      if Chrom[i - 1][X] <> 0 then
        ScanStats.number_of_scans_per_second := i / Chrom[i - 1][X]
      else
        ScanStats.number_of_scans_per_second := 1;
      BlockWrite(fHDFile, ScanStats, 80);

      for j := 0 to length(Mass[i - 1]) - 1 do
      begin
        rMass.Mass := Mass[i - 1][j][X];
        rMass.intensity := round(Mass[i - 1][j][Y]);
        BlockWrite(fHDFile, rMass, 14);
      end;
      rMass.Mass := 0.0;
      BlockWrite(fHDFile, rMass, 14);
    end;
    Result := true;
  finally
    CloseFile(fHDFile);
  end;
end; { TSpec.SaveHDFile }

// ----------------------------------------------------------------------------//
// Funciton: ReadSpectrum                                                     //
// //
// Purpose: Reads a single spectrum form a HD formated file.                  //
// //
// Parameters : sFileName:string, the complete path to the file               //
// iIndex:Integer, the index of the spectrum                     //
// -> the first one beeing 0 (zero)              //
// //
// Return Value: tXYArray : array representing the single spectrum            //
// //
// NOTE: The TIC corresponding to the spectrum can be derived from the        //
// returned tXYArray.                                                   //
// ----------------------------------------------------------------------------//
function TSpec.ReadHDSpectrum(iIndex: integer): tXYarray;
var
  fHDFile: File; rFileHeader: rRun_Stats; rScanStats: rScan_stats;
  i, j, AmtTransferred, nScans, nScanStyle: integer;
  bDone: boolean; rMass: Mass_Table;  rMassTmp: tXYarray;
begin
  try
    AssignFile(fHDFile, fFilename);
    Reset(fHDFile, 1);
    // Read file header
    BlockRead(fHDFile, rFileHeader, 9294, AmtTransferred);
    if 9294 <> AmtTransferred then
    begin
      ShowMessage('Error while reading HD run stats');
      CloseFile(fHDFile);
      exit;
    end;
    nScans := rFileHeader.number_of_scans;
    if iIndex > nScans then
      raise Exception.Create('This file has only ' + IntToStr(nScans) + 'Scans!');

    // Positionning in file
    Seek(fHDFile, 14016 + 9294);

    // Read iIndex scans
    if (HDindex = nil) or not FromFileOn then
      for i := 0 to iIndex - 1 do
      begin
        BlockRead(fHDFile, rScanStats, 80);
        nScanStyle := rScanStats.stored_mode;
        if (nScanStyle <> 3) and (nScanStyle <> 4) and (nScanStyle <> 2) and
          (nScanStyle <> 6) then
        begin
          ShowMessage('The file is not nominal mass, fast DSP nom mass or slow accurrate HD ALG acquired the conversion ends here.');
          Finalize(rMassTmp);
          CloseFile(fHDFile);
          exit;
        end;

        bDone := false;
        repeat
        begin
          BlockRead(fHDFile, rMass, 14);
          if rMass.Mass = 0.0 then
            bDone := true;
        end;
        until bDone;
        BlockRead(fHDFile, rScanStats, 80); // Read the Scan header
      end
    else
      Seek(fHDFile, HDindex.aIndexTable[iIndex]);
    // We're at the desired index now
    bDone := false;
    i := 0;
    repeat
    begin
      BlockRead(fHDFile, rMass, 14);
      if rMass.Mass <> 0.0 then
      begin
        setLength(Result, i + 1);
        Result[i][X] := rMass.Mass;
        Result[i][Y] := rMass.intensity;
        i := i + 1;
      end
      else
        bDone := true;
    end;
    until bDone;
  finally
    CloseFile(fHDFile);
  end;
end; { TSpec.ReadHDSpectrum }

function TSpec.CreateHDFile(sFilename: string): boolean;
begin
  Result := false;
  fFilename := sFilename;
  // Open file
  AssignFile(f_HDFile, sFilename);
  Rewrite(f_HDFile, 1);
  if IOResult <> 0 then
    exit;
  HDnSpec := 0;
  Seek(f_HDFile, 14016 + 9294);
  fFileKind := fkHD;
  fCasheOn := false;
  fFromFileOn := true;
  Result := true;
end;

function TSpec.CloseHDFile: boolean;
var
  FileHeader: rRun_Stats;
begin
  Result := false;
  if HDnSpec = -1 then
    exit;
  // Write Header
  Seek(f_HDFile, 0);
  FileHeader.number_of_scans := HDnSpec;
  BlockWrite(f_HDFile, FileHeader, 9294);
  system.CloseFile(f_HDFile);
  HDnSpec := -1;
  Result := true;
  if not fFromFileOn then
    exit;
  if HDindex = nil then
    HDindex := THDIndex.Create;
  if not HDindex.IndexFile(fFilename) then
    HDindex.Free
  else
    fFromFileOn := true;
end;

function TSpec.AddHDSpectrum(Spectrum: tXYarray): boolean;
var
  i: integer;
var
  rMass: Mass_Table;
var
  ScanStats: rScan_stats;
var
  nPeaks: integer;
begin
  Result := false;
  if HDnSpec = -1 then
    exit;
  inc(HDnSpec);
  // Write Scan stats
  ScanStats.stored_mode := 2;
  ScanStats.number_of_scans_per_second := 1;
  BlockWrite(f_HDFile, ScanStats, 80);
  // Write Scan Data
  nPeaks := length(Spectrum);
  for i := 0 to nPeaks - 1 do
  begin
    rMass.Mass := Spectrum[i][X];
    rMass.intensity := round(Spectrum[i][Y]);
    BlockWrite(f_HDFile, rMass, 14);
  end;
  rMass.Mass := 0.0;
  BlockWrite(f_HDFile, rMass, 14);
  Result := true;
end;

/// //////////////// file data formats ///////////////////
function TnetCDF.Open(oFilename: string): boolean;
var i,j,k,m,n,ierr,ncid,nscan,ndimsp,nvarsp,ngattsp,unlimdimidp: integer;
pc: array[0..200] of AnsiChar; szs,szp: size_t; sz: cardinal;
idx,np: array[0..MaxNScans] of integer;
tt,dt: array[0..MaxNArray] of double;
bb: boolean; ss: string; st: nc_type; pt: pointer;
ws: WideString; pwc: PWideChar; pac: pAnsiChar;

procedure ShowError;
begin if ierr<>0 then ShowMessage(nc_strerror(ierr));
end;

begin
Result:= false;
ierr:= 0;
ShowError;
//ierr:= LoadLibrary('netcdf.DLL');
ws:= WideString(oFilename); pwc:= pwidechar(ws);

//pac:= String2PAnsiChar;
ierr:= nc_open(str2pac(oFilename),0,ncid); ShowError;
Spec.fFilename:= oFilename;
ierr:= nc_inq(ncid,ndimsp,nvarsp,ngattsp,unlimdimidp); ShowError;
{with plot.Memo1 do
     begin Lines.add('ndimsp= '+IntToStr(ndimsp));
     Lines.add('nvarsp= '+IntToStr(nvarsp));
     Lines.add('ngattsp= '+IntToStr(ngattsp));
     Lines.add('unlimdimidp= '+IntToStr(unlimdimidp));
     Lines.add(''); Lines.add('Dimensions');
     for i:=0 to ndimsp-1 do
         begin nc_inq_dimname(ncid,i,pc); ss:= string(pc);
         nc_inq_dimlen(ncid,i,sz);
         Lines.add(IntToStr(i)+'->'+ss+' ['+IntTostr(sz)+']');
         end; Lines.add(''); Lines.add('Variables');
     for i:=0 to nvarsp-1 do
        begin nc_inq_varname(ncid,i,pc); nc_inq_vardimid(ncid,i,j);
        ss:= string(pc);
        Lines.add(IntToStr(i)+'->'+ss+' ['+IntTostr(j)+']');
        end;
     end; exit; }
//ierr:= nc_inq_dimid(ncid,'scan_type',k); ShowError;
//ierr:= nc_inq_vartype(ncid,k,st); ShowError;


// number of scans
ierr:= nc_inq_dimid(ncid,str2pac('scan_number'),k); ShowError;
ierr:= nc_inq_dimlen(ncid,k,szs); ShowError;
if szs>MaxNScans then
   begin ShowMessage('Too large number of scans ('+IntToStr(szs)+' vs '+IntToStr(MaxNScans)+')'); exit;
   end;
SetLength(Spec.fMass,szs);
// number of points
ierr:= nc_inq_dimid(ncid,str2pac('point_number'),k); ShowError;
ierr:= nc_inq_dimlen(ncid,k,szp); ShowError;
if szp>MaxNArray then
   begin ShowMessage('Too large GC/MS spectrum ('+IntToStr(szp)+' vs '+IntToStr(MaxNArray)+')'); exit;
   end;
// service info
ierr:= nc_inq_varid(ncid,str2pac('error_log'),k);
if ierr=0 then begin ierr:= nc_get_var_text(ncid,k,pc); ShowError;
               error_log:= string(pc);
               end;
ierr:= nc_inq_varid(ncid,str2pac('instrument_name'),k);
if ierr=0 then begin ierr:= nc_get_var_text(ncid,k,pc); ShowError;
               instrument_name:= string(pc);
               end;

ierr:= nc_inq_varid(ncid,str2pac('instrument_id'),k);
if ierr=0 then begin ierr:= nc_get_var_text(ncid,k,pc); ShowError;
               instrument_id:= string(pc);
               end;
ierr:= nc_inq_varid(ncid,str2pac('instrument_mfr'),k);
if ierr=0 then begin ierr:= nc_get_var_text(ncid,k,pc); ShowError;
               instrument_mfr:= string(pc);
               end;
ierr:= nc_inq_varid(ncid,str2pac('instrument_model'),k);
if ierr=0 then begin ierr:= nc_get_var_text(ncid,k,pc); ShowError;
               instrument_model:= string(pc);
               end;
ierr:= nc_inq_varid(ncid,str2pac('instrument_os_version'),k);
if ierr=0 then begin ierr:= nc_get_var_text(ncid,k,pc); ShowError;
               instrument_os_version:= string(pc);
               end;
ierr:= nc_inq_varid(ncid,str2pac('instrument_sw_version'),k);
if ierr=0 then begin ierr:= nc_get_var_text(ncid,k,pc); ShowError;
               instrument_sw_version:= string(pc);
               end;

{ierr:= nc_inq_varid(ncid,'flag_count',k); ShowError;
pt:= @flag_count;
//ierr:= nc_get_var_int(ncid,k,pt); ShowError;

ierr:= nc_inq_varid(ncid,'a_d_sampling_rate',k); ShowError;
pt:= @a_d_sampling_rate;
//ierr:= nc_get_var_double(ncid,k,pt); ShowError;

ierr:= nc_inq_varid(ncid,'scan_duration',k); ShowError;
ierr:= nc_inq_varid(ncid,'mass_range_min',k); ShowError;
ierr:= nc_inq_varid(ncid,'mass_range_max',k); ShowError;
ierr:= nc_inq_varid(ncid,'resolution',k); ShowError; }

// data
                  // retention times
ierr:= nc_inq_varid(ncid,str2pac('scan_acquisition_time'),k); ShowError;
pt:= @tt; ierr:= nc_get_var_double(ncid,k,pt); ShowError;
pt:= @dt;                    // total intensities
ierr:= nc_inq_varid(ncid,str2pac('total_intensity'),k); ShowError;
ierr:= nc_get_var_double(ncid,k,pt); ShowError;
SetLength(Spec.Chrom,szs);
for i:=0 to szs-1 do
    begin Spec.Chrom[i,X]:= tt[i]; Spec.Chrom[i,Y]:= dt[i];
    end;

pt:= @idx;                  // indexes
ierr:= nc_inq_varid(ncid,str2pac('scan_index'),k); ShowError;
ierr:= nc_get_var_int(ncid,k,pt); ShowError;
pt:= @np;                   // point number
ierr:= nc_inq_varid(ncid,str2pac('point_count'),k); ShowError;
ierr:= nc_get_var_int(ncid,k,pt); ShowError;

pt:= @dt;
ierr:= nc_inq_varid(ncid,str2pac('mass_values'),k); ShowError;
ierr:= nc_get_var_double(ncid,k,pt); ShowError; // mass positions
for i:=0 to szs-1 do
  if np[i]>0 then SetLength(Spec.fMass[i],np[i]);
for i:=0 to szs-1 do
  if np[i]>0 then
    begin j:= 0; k:= idx[i];
    repeat Spec.fMass[i,j,X]:= dt[k]; inc(j); inc(k);
    until j>=np[i];
    end;

ierr:= nc_inq_varid(ncid,str2pac('intensity_values'),k); ShowError;
ierr:= nc_get_var_double(ncid,k,pt); ShowError; // intensities
for i:=0 to szs-1 do
  if np[i]>0 then
    begin j:= 0; k:= idx[i];
    repeat Spec.fMass[i,j,Y]:= dt[k]; inc(j); inc(k);
    until j>=np[i];
    end;

ierr:= nc_close(ncid); ShowError;
Result:= true;
end; { TSpec.OpenFile }

function TnetCDF.ReadSpectrum(Idx: integer): tXYarray;
begin
end;

function TnetCDF.Save(sFilename: string): boolean;
var i,j,k,m,n,ierr,ncid,nscan,ndimsp,nvarsp,ngattsp,unlimdimidp,ds,dp,di,de: integer;
pc: array[0..32] of char; pq: pchar; szs,szp,startp,countp: size_t; sz: cardinal;
idx,np: array[0..MaxNScans] of integer;
da: array[0..MaxNArray] of double;
bb: boolean; ss: string; st: nc_type; pt: pointer;
ksat,kti,ksi,kpc,kmv,kiv: integer;

procedure ShowError;
begin if ierr<>0 then ShowMessage(nc_strerror(ierr));
end;

begin Result:= false;
if Spec.NSpec=0 then
   begin ShowMessage('No data to save'); exit;
   end;
ierr:= nc_create(str2pac(sFilename),0,ncid); ShowError;
//  dim declarations
{ierr:= nc_def_dim(ncid,'_2_byte_string',2,i); ShowError;
ierr:= nc_def_dim(ncid,'_4_byte_string',4,i); ShowError;
ierr:= nc_def_dim(ncid,'_8_byte_string',8,i); ShowError;
ierr:= nc_def_dim(ncid,'_16_byte_string',16,i); ShowError;
ierr:= nc_def_dim(ncid,'_32_byte_string',32,i); ShowError;
ierr:= nc_def_dim(ncid,'_64_byte_string',64,i); ShowError;
ierr:= nc_def_dim(ncid,'_128_byte_string',128,i); ShowError;
ierr:= nc_def_dim(ncid,'_255_byte_string',255,i); ShowError;

ierr:= nc_def_dim(ncid,'error_number',1,de); ShowError;
ierr:= nc_def_dim(ncid,'instrument_number',1,di); ShowError; }

szs:= Spec.NSpec;
ierr:= nc_def_dim(ncid,str2pac('scan_number'),szs,ds); ShowError;
szp:= 0;
for i:=0 to Spec.NSpec-1 do
    for j:=Low(Spec.Mass[i]) to High(Spec.Mass[i]) do
        begin inc(szp);
        end;
if szp>MaxNArray then
   begin ShowMessage('Too large GC/MS spectrum'); exit;
   end;
ierr:= nc_def_dim(ncid,str2pac('point_number'),szp,dp); ShowError;
//  var declarations
{ierr:= nc_def_var(ncid,'error_log',nc_char,1,de,i); ShowError;

ierr:= nc_def_var(ncid,'instrument_name',nc_char,1,di,i); ShowError;
ierr:= nc_def_var(ncid,'instrument_id',nc_char,1,di,i); ShowError;
ierr:= nc_def_var(ncid,'instrument_mfr',nc_char,1,di,i); ShowError;
ierr:= nc_def_var(ncid,'instrument_model',nc_char,1,di,i); ShowError;
ierr:= nc_def_var(ncid,'instrument_os_version',nc_char,1,di,i); ShowError;
ierr:= nc_def_var(ncid,'instrument_sw_version',nc_char,1,di,i); ShowError; }

ierr:= nc_def_var(ncid,str2pac('scan_index'),nc_int,1,ds,ksi); ShowError;
ierr:= nc_def_var(ncid,str2pac('point_count'),nc_int,1,ds,kpc); ShowError;

{ierr:= nc_def_var(ncid,'flag_count',nc_int,1,ds,i); ShowError;
ierr:= nc_def_var(ncid,'a_d_sampling_rate',nc_double,1,ds,i); ShowError;
ierr:= nc_def_var(ncid,'scan_duration',nc_double,1,ds,i); ShowError;
ierr:= nc_def_var(ncid,'mass_range_min',nc_double,1,ds,i); ShowError;
ierr:= nc_def_var(ncid,'mass_range_max',nc_double,1,ds,i); ShowError;
ierr:= nc_def_var(ncid,'resolution',nc_double,1,ds,i); ShowError;}

ierr:= nc_def_var(ncid,str2pac('scan_acquisition_time'),nc_double,1,ds,ksat); ShowError;
ierr:= nc_def_var(ncid,'total_intensity',nc_double,1,ds,kti); ShowError;

ierr:= nc_def_var(ncid,str2pac('mass_values'),nc_double,1,dp,kmv); ShowError;
ierr:= nc_def_var(ncid,str2pac('intensity_values'),nc_double,1,dp,kiv); ShowError;
ierr:= nc_enddef(ncid); ShowError;
// service info
{ierr:= nc_inq_varid(ncid,'error_log',k); ShowError;
ierr:= nc_put_var_text(ncid,k,pchar(error_log)); ShowError;

ierr:= nc_inq_varid(ncid,'instrument_name',k); ShowError;
//pc:= instrument_name;
//pq:= pchar(instrument_name); sz:= StrLen(pq)+2;
ierr:= nc_put_var_text(ncid,1,'Mass Spectrometer'); ShowError;  // pchar()
ierr:= nc_inq_varid(ncid,'instrument_id',k); ShowError;
ierr:= nc_put_var_text(ncid,k,pchar(instrument_id)); ShowError;
ierr:= nc_inq_varid(ncid,'instrument_mfr',k); ShowError;
ierr:= nc_put_var_text(ncid,k,pchar(instrument_mfr)); ShowError;
ierr:= nc_inq_varid(ncid,'instrument_model',k); ShowError;
ierr:= nc_put_var_text(ncid,k,pchar(instrument_model)); ShowError;
ierr:= nc_inq_varid(ncid,'instrument_os_version',k); ShowError;
ierr:= nc_put_var_text(ncid,k,pchar(instrument_os_version)); ShowError;
ierr:= nc_inq_varid(ncid,'instrument_sw_version',k); ShowError;
ierr:= nc_put_var_text(ncid,k,pchar(instrument_sw_version)); ShowError; }

// data
startp:= 0; countp:= Spec.NSpec;
for i:=0 to Spec.NSpec-1 do da[i]:= Spec.Chrom[i,X]; // retention times
pt:= @da;
ierr:= nc_put_vara_double(ncid,ksat,startp,countp,pt); ShowError;

for i:=0 to Spec.NSpec-1 do da[i]:= Spec.Chrom[i,Y];  // total intensities
ierr:= nc_put_vara_double(ncid,kti,startp,countp,pt); ShowError;

np[0]:= length(Spec.Mass[0]); idx[i]:= 0;
for i:=1 to Spec.NSpec-1 do
    begin np[i]:= length(Spec.Mass[i]); idx[i]:= idx[i-1]+np[i];
    end;
pt:= @idx;                  // indexes
ierr:= nc_put_vara_int(ncid,ksi,startp,countp,pt); ShowError;
pt:= @np;                   // point number
ierr:= nc_put_vara_int(ncid,kpc,startp,countp,pt); ShowError;

szp:= 0;
for i:=0 to Spec.NSpec-1 do
    for j:=Low(Spec.Mass[i]) to High(Spec.Mass[i]) do
        begin da[szp]:= Spec.Mass[i][j,X]; inc(szp);
        end; dec(szp);
pt:= @da;                  // mass positions
ierr:= nc_put_vara_double(ncid,kmv,startp,szp,pt); ShowError;

szp:= 0;
for i:=0 to Spec.NSpec-1 do
    for j:=Low(Spec.Mass[i]) to High(Spec.Mass[i]) do
        begin da[szp]:= Spec.Mass[i][j,Y]; inc(szp);
        end; dec(szp);
pt:= @da;                  // intensities
ierr:= nc_put_vara_double(ncid,kiv,startp,szp,pt); ShowError;

ierr:= nc_close(ncid); ShowError;
Result:= true;
end; { TnetCDF.Save }

{ "98apr.cdf"
ndimsp= 13
nvarsp= 20
ngattsp= 37
unlimdimidp= 12

Dimensions
0->_2_byte_string [2]
1->_4_byte_string [4]
2->_8_byte_string [8]
3->_16_byte_string [16]
4->_32_byte_string [32]
5->_64_byte_string [64]
6->_80_byte_string [80]
7->_128_byte_string [128]
8->_255_byte_string [256]
9->scan_number [11]
10->instrument_number [1]
11->error_number [1]
12->point_number [7373]

Variables
0->error_log [11]
1->instrument_name [10]
2->instrument_id [10]
3->instrument_mfr [10]
4->instrument_model [10]
5->instrument_sw_version [10]
6->instrument_os_version [10]
7->scan_index [9]
8->point_count [9]
9->flag_count [9]
10->a_d_sampling_rate [9]
11->scan_acquisition_time [9]
12->scan_duration [9]
13->mass_range_min [9]
14->mass_range_max [9]
15->scan_type [9]
16->resolution [9]
17->total_intensity [9]
18->mass_values [12]
19->intensity_values [12]

=============================
"Sample_2.cdf"

ndimsp= 13
nvarsp= 29
ngattsp= 27
unlimdimidp= 9

Dimensions
0->_2_byte_string [2]
1->_4_byte_string [4]
2->_8_byte_string [8]
3->_16_byte_string [16]
4->_32_byte_string [32]
5->_64_byte_string [64]
6->_128_byte_string [128]
7->_255_byte_string [255]
8->range [2]
9->point_number [4737]
10->error_number [1]
11->scan_number [1579]
12->instrument_number [1]

Variables
0->error_log [10]
1->a_d_sampling_rate [11]
2->a_d_coaddition_factor [11]
3->scan_acquisition_time [11]
4->scan_duration [11]
5->inter_scan_time [11]
6->resolution [11]
7->actual_scan_number [11]
8->total_intensity [11]
9->mass_range_min [11]
10->mass_range_max [11]
11->time_range_min [11]
12->time_range_max [11]
13->scan_index [11]
14->point_count [11]
15->flag_count [11]
16->mass_values [9]
17->time_values [9]
18->intensity_values [9]
19->instrument_name [12]
20->instrument_id [12]
21->instrument_mfr [12]
22->instrument_model [12]
23->instrument_serial_no [12]
24->instrument_sw_version [12]
25->instrument_fw_version [12]
26->instrument_os_version [12]
27->instrument_app_version [12]
28->instrument_comments [12]
}

end. { SpecU }
