unit SpOptU;

interface
uses IniFiles, Sysutils, Dialogs, Controls, FileCtrl, Forms;

type
  rSmooth = record
    SGDegree: integer;
    FillNull: boolean;
    Enabled: boolean;
  end;

  rVisual = record
    TeeFile: string;
    XUnits: integer;
    AutoY: boolean;
    FixY: boolean;
    YUnits: boolean;
  end;

  rBLine = record
    Threshold: double;
    AutoTS: boolean;
    Enabled: boolean;
  end;

  rPeak = record
    Method: integer;
    Sensiv: integer;
    MinHeight: double;
    MinDist: double;
    MinArea: double;
    Enabled: boolean;
  end;

  ToChrom = record
    Visual: rVisual;
    Smooth: rSmooth;
    BLine: rBLine;
    Peak: rPeak;
  end;

  ToMass = record
    Visual: rVisual;
    Smooth: rSmooth;
    BLine: rBLine;
    Peak: rPeak;
  end;

  tSpOpt = class(TIniFile)
    MassOnly: boolean;
    DataPath: string;

    oChrom: ToChrom;
    oMass: ToMass;

    Locked: boolean;

    procedure SetDefaults;
    procedure Assign(Source: tSpOpt);
    function Open(BaseOpt: tSpOpt): boolean; // if BaseOpt=nil then SetDefaults
    function Save: boolean;
  end;

  function GetConfigPath: string;
  function GetDataPath: string;
  function GetPlotSymbol(Idx: integer): char;
  function CheckPlotSymbol(ch: char): integer;

implementation

uses AboutU;

procedure tSpOpt.SetDefaults;
begin
  MassOnly := false;
  DataPath := '';
  with oChrom do
  begin
    with Visual do
    begin
      TeeFile := '';
      AutoY := false;
      XUnits := 0;
      YUnits := false;
      FixY := true;
    end;
    with Smooth do
    begin
      SGDegree := 3;
      Enabled := false;
    end;
    with BLine do
    begin
      Threshold := 0;
      AutoTS := false;
      Enabled := false;
    end;
    with Peak do
    begin
      Method := 0;
      Sensiv := 5;
      MinHeight := 0;
      MinDist := 0;
      MinArea := 0;
      Enabled := false;
    end;
  end;
  with oMass do
  begin
    with Visual do
    begin
      TeeFile := '';
      AutoY := false;
      FixY := true;
      XUnits := 0;
      YUnits := false;
    end;
    with Smooth do
    begin
      FillNull := true;
      SGDegree := 3;
      Enabled := false;
    end;
    with BLine do
    begin
      Threshold := 0;
      AutoTS := false;
      Enabled := false;
    end;
    with Peak do
    begin
      Method := 2;
      Sensiv := 5;
      MinHeight := 0;
      MinDist := 0;
      MinArea := 0;
      Enabled := false;
    end;
  end;
end; { tSpOpt.SetDefaults }

procedure tSpOpt.Assign(Source: tSpOpt);
begin
  MassOnly := Source.MassOnly;
  DataPath := Source.DataPath;
  oChrom := Source.oChrom;
  oMass := Source.oMass;
  Locked := Source.Locked;
end;

function tSpOpt.Open(BaseOpt: tSpOpt): boolean;
begin
  Result := false;
  Locked := false;
  if BaseOpt = nil then
    BaseOpt := self;
  if BaseOpt = self then
    SetDefaults;
  MassOnly := ReadBool('General', 'MassOnly', BaseOpt.MassOnly);
  DataPath := ReadString('General', 'DataPath', BaseOpt.DataPath);
  // if not DirectoryExists(DataPath) then DataPath:= GetDataPath;
  with oChrom do
  begin
    with Visual do
    begin
      TeeFile := ReadString('C_Visual', 'TeeFile',
        BaseOpt.oChrom.Visual.TeeFile);
      AutoY := ReadBool('C_Visual', 'AutoY', BaseOpt.oChrom.Visual.AutoY);
      FixY := ReadBool('C_Visual', 'FixY', BaseOpt.oChrom.Visual.FixY);
      XUnits := ReadInteger('C_Visual', 'XUnits', BaseOpt.oChrom.Visual.XUnits);
      YUnits := ReadBool('C_Visual', 'YUnits', BaseOpt.oChrom.Visual.YUnits);
    end;
    with Smooth do
    begin
      SGDegree := ReadInteger('C_Smooth', 'SGDegree',
        BaseOpt.oChrom.Smooth.SGDegree);
      Enabled := ReadBool('C_Smooth', 'Enabled', BaseOpt.oChrom.Smooth.Enabled);
    end;
    with BLine do
    begin
      Threshold := ReadFloat('C_BLine', 'Threshold',
        BaseOpt.oChrom.BLine.Threshold);
      AutoTS := ReadBool('C_BLine', 'AutoTS', BaseOpt.oChrom.BLine.AutoTS);
      Enabled := ReadBool('C_BLine', 'Enabled', BaseOpt.oChrom.BLine.Enabled);
    end;
    with Peak do
    begin
      Method := ReadInteger('C_Peak', 'Method', BaseOpt.oChrom.Peak.Method);
      Sensiv := ReadInteger('C_Peak', 'Sensiv', BaseOpt.oChrom.Peak.Sensiv);
      MinHeight := ReadFloat('C_Peak', 'MinHeight',
        BaseOpt.oChrom.Peak.MinHeight);
      MinDist := ReadFloat('C_Peak', 'MinDist', BaseOpt.oChrom.Peak.MinDist);
      MinArea := ReadFloat('C_Peak', 'MinArea', BaseOpt.oChrom.Peak.MinArea);
      Enabled := ReadBool('C_Peak', 'Enabled', BaseOpt.oChrom.Peak.Enabled);
    end;
  end;
  with oMass do
  begin
    with Visual do
    begin
      TeeFile := ReadString('M_Visual', 'TeeFile',
        BaseOpt.oMass.Visual.TeeFile);
      AutoY := ReadBool('M_Visual', 'AutoY', BaseOpt.oMass.Visual.AutoY);
      FixY := ReadBool('M_Visual', 'FixY', BaseOpt.oMass.Visual.FixY);
      XUnits := ReadInteger('M_Visual', 'XUnits', BaseOpt.oMass.Visual.XUnits);
      YUnits := ReadBool('M_Visual', 'YUnits', BaseOpt.oMass.Visual.YUnits);
    end;
    with Smooth do
    begin
      FillNull := true;
      SGDegree := ReadInteger('M_Smooth', 'SGDegree',
        BaseOpt.oMass.Smooth.SGDegree);
      Enabled := ReadBool('M_Smooth', 'Enabled', BaseOpt.oMass.Smooth.Enabled);
    end;
    with BLine do
    begin
      Threshold := ReadFloat('M_BLine', 'Threshold',
        BaseOpt.oMass.BLine.Threshold);
      AutoTS := ReadBool('M_BLine', 'AutoTS', BaseOpt.oMass.BLine.AutoTS);
      Enabled := ReadBool('M_BLine', 'Enabled', BaseOpt.oMass.BLine.Enabled);
    end;
    with Peak do
    begin
      Method := ReadInteger('M_Peak', 'Method', BaseOpt.oMass.Peak.Method);
      Sensiv := ReadInteger('M_Peak', 'Sensiv', BaseOpt.oMass.Peak.Sensiv);
      MinHeight := ReadFloat('M_Peak', 'MinHeight',
        BaseOpt.oMass.Peak.MinHeight);
      MinDist := ReadFloat('M_Peak', 'MinDist', BaseOpt.oMass.Peak.MinDist);
      MinArea := ReadFloat('M_Peak', 'MinArea', BaseOpt.oMass.Peak.MinArea);
      Enabled := ReadBool('M_Peak', 'Enabled', BaseOpt.oMass.Peak.Enabled);
    end;
  end;
  Result := true;
end; { OpenOpts }

function tSpOpt.Save: boolean;
begin
  Result := false;
  if ExtractFilename(Filename) = 'empty.tml' then
    exit;
  WriteBool('General', 'MassOnly', MassOnly);
  WriteString('General', 'DataPath', DataPath);
  with oChrom do
  begin
    with Visual do
    begin
      WriteString('C_Visual', 'TeeFile', TeeFile);
      WriteBool('C_Visual', 'AutoY', AutoY);
      WriteBool('C_Visual', 'FixY', FixY);
      WriteInteger('C_Visual', 'XUnits', XUnits);
      WriteBool('C_Visual', 'YUnits', YUnits);
    end;
    with Smooth do
    begin
      WriteInteger('C_Smooth', 'SGDegree', SGDegree);
      WriteBool('C_Smooth', 'Enabled', Enabled);
    end;
    with BLine do
    begin
      WriteFloat('C_BLine', 'Threshold', Threshold);
      WriteBool('C_BLine', 'AutoTS', AutoTS);
      WriteBool('C_BLine', 'Enabled', Enabled);
    end;
    with Peak do
    begin
      WriteInteger('C_Peak', 'Method', Method);
      WriteInteger('C_Peak', 'Sensiv', Sensiv);
      WriteFloat('C_Peak', 'MinHeight', MinHeight);
      WriteFloat('C_Peak', 'MinDist', MinDist);
      WriteFloat('C_Peak', 'MinArea', MinArea);
      WriteBool('C_Peak', 'Enabled', Enabled);
    end;
  end;
  with oMass do
  begin
    with Visual do
    begin
      WriteString('M_Visual', 'TeeFile', TeeFile);
      WriteBool('M_Visual', 'AutoY', AutoY);
      WriteBool('M_Visual', 'FixY', FixY);
      WriteInteger('M_Visual', 'XUnits', XUnits);
      WriteBool('M_Visual', 'YUnits', YUnits);
    end;
    with Smooth do
    begin
      WriteInteger('M_Smooth', 'SGDegree', SGDegree);
      WriteBool('M_Smooth', 'Enabled', Enabled);
    end;
    with BLine do
    begin
      WriteFloat('M_BLine', 'Threshold', Threshold);
      WriteBool('M_BLine', 'AutoTS', AutoTS);
      WriteBool('M_BLine', 'Enabled', Enabled);
    end;
    with Peak do
    begin
      WriteInteger('M_Peak', 'Method', Method);
      WriteInteger('M_Peak', 'Sensiv', Sensiv);
      WriteFloat('M_Peak', 'MinHeight', MinHeight);
      WriteFloat('M_Peak', 'MinDist', MinDist);
      WriteFloat('M_Peak', 'MinArea', MinArea);
      WriteBool('M_Peak', 'Enabled', Enabled);
    end;
  end;
  Result := true;
end; { SaveOpts }

function GetConfigPath: string;
var
  ss: string;
begin
  Result := '';
  ss := RootPath + ConfigPath;
  if not DirectoryExists(ss) then
  begin
    if MessageDlg(ss + ' does not exist.' + #10 + 'Do you want to create one ?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      system.MkDir(ss)
    else
      exit;
  end;
  Result := ss;
end;

function GetDataPath: string;
var
  ss: string;
begin
  Result := '';
  ss := RootPath + DataPath;
  if not DirectoryExists(ss) then
  begin
    if MessageDlg(ss + ' does not exist.' + #10 + 'Do you want to create one ?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      system.MkDir(ss)
    else
      exit;
  end;
  Result := ss;
end;

function GetPlotSymbol(Idx: integer): char; // idx 0-based
begin
  Result := #0;
  if (Idx >= 0) and (Idx < 10) then
    Result := char(48 + Idx); // 48 -> '0'
  if (Idx > 9) and (Idx < 36) then
    Result := char(55 + Idx);
end;

function CheckPlotSymbol(ch: char): integer; // 0-based
var
  Idx: integer;
begin
  Result := -1;
  Idx := ord(ch);
  if (Idx >= 48) and (Idx < 58) then
    Result := Idx - 48;
  if (Idx > 64) and (Idx < 91) then
    Result := Idx - 55;
end;

end. { SpOptU }
