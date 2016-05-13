unit OptionsU;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Grids, IniFiles, Dialogs, FileCtrl, CheckLst;

type
  tOptions = class(TIniFile)
  private
    { Private declarations }
    fSpectraPath: string;
  public
    { Public declarations }
    ItrExtVis, OnlyMin, Oscilo, AutoSave: boolean;
    AutoRunScript: string;
    ItrShowLevel: byte; // 1-5 level by radiogroup; 0 - absol. forbidden
    Dvcs, UserTabs: TStrings;
    Templates: array [1 .. 3] of string;
    OsciloDvc,AcquireDvc: string;
    constructor Create(const FileName: string);
    procedure AssignData(Src: tOptions);
    function Load: boolean;
    function Save: boolean;
    function SpectraPath: string;
    function CheckDvcExist(DvcName: string): boolean;
    function CheckDvcOrder(DvcName: string): integer;
    function CheckDvcEnabled(DvcName: string): boolean;
    function CheckDvcMax(DvcName: string): boolean;
    function CheckUserTab(TabName, Dvc: string): boolean;
  end;

  TfrmOptions = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    tsInterpreter: TTabSheet;
    rgItrShowLevel: TRadioGroup;
    tsOnStart: TTabSheet;
    GroupBox2: TGroupBox;
    cbItrExtVis: TCheckBox;
    Label4: TLabel;
    rgSaveOptions: TRadioGroup;
    GroupBox3: TGroupBox;
    eAutoRunScript: TEdit;
    bBrowseAutoRun: TButton;
    odAutoRunScript: TOpenDialog;
    GroupBox4: TGroupBox;
    eSpectraPath: TEdit;
    bBrowseSpectraPath: TButton;
    DirectoryListBox1: TDirectoryListBox;
    tsTemplates: TTabSheet;
    GroupBox1: TGroupBox;
    eDataAcqTml: TEdit;
    bbDataAqcPlot: TBitBtn;
    GroupBox5: TGroupBox;
    eOpenTml: TEdit;
    bbOpenPlot: TBitBtn;
    GroupBox6: TGroupBox;
    eNewTml: TEdit;
    bbNewPlot: TBitBtn;
    odTemplate: TOpenDialog;
    clbCtrl: TCheckListBox;
    clbMsr: TCheckListBox;
    tsUserTabs: TTabSheet;
    clbUserTabs: TCheckListBox;
    Panel3: TPanel;
    cbTabNames: TComboBox;
    bbAdd: TBitBtn;
    bbDelete: TBitBtn;
    chkOnlyMin: TCheckBox;
    chkOscilo: TCheckBox;
    chkAutoSave: TCheckBox;
    Panel4: TPanel;
    GroupBox7: TGroupBox;
    Label1: TLabel;
    cbOsciloDvc: TComboBox;
    cbAcquireDvc: TComboBox;
    Label2: TLabel;
    bbOK: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure rgItrShowLevelClick(Sender: TObject);
    procedure bBrowseAutoRunClick(Sender: TObject);
    procedure bBrowseSpectraPathClick(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure bbNewPlotClick(Sender: TObject);
    procedure bHelpClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure clbCtrlClickCheck(Sender: TObject);
    procedure cbTabNamesChange(Sender: TObject);
    procedure bbAddClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    { Private declarations }
    LastUserTab: integer;
    procedure UpdatePages(Opts: tOptions);
    procedure UpdateOptions(var Opts: tOptions);
  public
    { Public declarations }
    procedure Execute;
  end;

var
  frmOptions: TfrmOptions;
  Options, BuffOpt: tOptions;

implementation

{$R *.DFM}

uses CmdCentreU, SpionU, DvcRackU, CtrlDeviceU, SpOptU, AboutU, DeviceU;

constructor tOptions.Create(const FileName: string);
begin
  inherited Create(FileName);
  Dvcs := TStringList.Create;
  UserTabs := TStringList.Create;
end; { tOptions.Create }

procedure tOptions.AssignData(Src: tOptions);
begin
  ItrShowLevel := Src.ItrShowLevel;
  OnlyMin := Src.OnlyMin;
  ItrExtVis := Src.ItrExtVis;
  AutoRunScript := Src.AutoRunScript;
  fSpectraPath := Src.SpectraPath;
  Templates := Src.Templates;
  OsciloDvc:= Src.OsciloDvc;
  AcquireDvc:= Src.AcquireDvc;
  Dvcs.Assign(Src.Dvcs);
  UserTabs.Assign(Src.UserTabs);
end; { tOptions.AssignData }

function tOptions.Load: boolean;
var
  i, j: integer;
begin
  // On Start page
  ReadSectionValues('Devices', Dvcs);
  AutoRunScript := ReadString('General', 'AutoRunScript',
    RootPath + ScriptPath + 'startup.scr');
  fSpectraPath := ReadString('General', 'SpectraPath', RootPath + DataPath);
  // Interpreter page
  ItrShowLevel := ReadInteger('Interpreter', 'ShowLevel', 3);
  ItrExtVis := ReadBool('Interpreter', 'ExtCtrlVis', true);
  AutoSave := ReadBool('Interpreter', 'AutoSave', true);
  // Templates
  Templates[1] := ReadString('Templates', 'New', '');
  Templates[2] := ReadString('Templates', 'Open', '');
  Templates[3] := ReadString('Templates', 'DataAqc', '');
  for i := 1 to 3 do
    if ExtractFilePath(Templates[i]) = '' then
      Templates[i] := RootPath + ConfigPath + Templates[i];
  Oscilo := ReadBool('Templates', 'Oscilo', true);
  OsciloDvc := ReadString('Templates', 'OsciloDvc', '');
  AcquireDvc := ReadString('Templates', 'AcquireDvc', '');
  // UserTabs
  OnlyMin := ReadBool('General', 'OnlyMin', false);
  ReadSectionValues('UserTabs', UserTabs);
end; { tOptions.Load }

function tOptions.Save: boolean;
var
  i: integer;
  ss: string;
  bb: boolean;
begin
  // On Start page
  WriteString('General', 'AutoRunScript', AutoRunScript);
  WriteString('General', 'SpectraPath', SpectraPath);
  // Interpreter page
  WriteInteger('Interpreter', 'ShowLevel', ItrShowLevel);
  WriteBool('Interpreter', 'ExtCtrlVis', ItrExtVis);
  WriteBool('Interpreter', 'AutoSave', AutoSave);
  // templates
  for i := 1 to 3 do
    if SameText(ExtractFilePath(Templates[i]), UpperCase(RootPath + ConfigPath))
    then
      Templates[i] := ExtractFilename(Templates[i]);
  WriteString('Templates', 'New', Templates[1]);
  WriteString('Templates', 'Open', Templates[2]);
  WriteString('Templates', 'DataAqc', Templates[3]);
  WriteString('Templates', 'OsciloDvc', OsciloDvc);
  WriteString('Templates', 'AcquireDvc', AcquireDvc);
  // max devices
  EraseSection('Devices');
  for i := 0 to Dvcs.Count - 1 do
  begin
    ss := UpperCase(Dvcs.Names[i]);
    WriteBool('Devices', ss, Dvcs.Values[ss] = '1');
  end;
  if frmDvcRack.TabControl1.TabIndex = 2 then
  begin
    EraseSection('MaxDev');
    for i := 0 to Dvcs.Count - 1 do
    begin
      ss := Dvcs.Names[i];
      bb := false;
      if MDByName(ss) <> nil then
        bb := MDByName(ss).Maximed;
      if CDByName(ss) <> nil then
        bb := CDByName(ss).Maximed;
      WriteBool('MaxDev', UpperCase(Dvcs.Names[i]), bb);
    end;
  end;
  WriteBool('Templates', 'Oscilo', Oscilo);
  // UserTabs
  WriteBool('General', 'OnlyMin', OnlyMin);
  EraseSection('UserTabs');
  for i := 0 to UserTabs.Count - 1 do
    WriteString('UserTabs', UserTabs.Names[i],
      UserTabs.Values[UserTabs.Names[i]]);
end; { tOptions.Save }

function tOptions.SpectraPath: string;
begin
  if DirectoryExists(fSpectraPath) then
    Result := fSpectraPath
  else
    Result := RootPath + DataPath;
end;

/// ////////////////////////////////////////////////////////////////////
procedure TfrmOptions.rgItrShowLevelClick(Sender: TObject);
begin
  Options.ItrShowLevel := rgItrShowLevel.ItemIndex + 1;
end; { TfrmOptions.rgItrShowLevelClick }

procedure TfrmOptions.UpdatePages(Opts: tOptions);
var
  i, j: integer;
  ss: string;
begin
  // On Start page
  clbCtrl.Items.Clear;
  for i := low(ctrlDvcs) to high(ctrlDvcs) do
  begin
    ss := ctrlDvcs[i].Header;
    clbCtrl.Items.Add(ss);
    j := pos('(', ss);
    delete(ss, 1, j);
    delete(ss, length(ss), 1);
    clbCtrl.Checked[i] := (Options.Dvcs.Values[ss] = '1');
  end;
  clbMsr.Items.Clear;
  for i := low(msrDvcs) to high(msrDvcs) do
  begin
    ss := msrDvcs[i].Header;
    clbMsr.Items.Add(ss);
    j := pos('(', ss);
    delete(ss, 1, j);
    delete(ss, length(ss), 1);
    clbMsr.Checked[i] := (Options.Dvcs.Values[ss] = '1');
  end;
  eAutoRunScript.Text := Opts.AutoRunScript;
  eSpectraPath.Text := Opts.SpectraPath;
  // Interpreter page
  rgItrShowLevel.ItemIndex := Opts.ItrShowLevel - 1;
  cbItrExtVis.Checked := Opts.ItrExtVis;
  chkAutoSave.Checked := Opts.AutoSave;
  // Templates
  eNewTml.Text := Opts.Templates[1];
  eOpenTml.Text := Opts.Templates[2];
  eDataAcqTml.Text := Opts.Templates[3];
  chkOscilo.Checked := Opts.Oscilo;

  DvcList(cbOsciloDvc.Items,dkMsr);
  cbOsciloDvc.ItemIndex:= cbOsciloDvc.Items.IndexOf(Options.OsciloDvc);
  DvcList(cbAcquireDvc.Items,dkMsr);
  cbAcquireDvc.ItemIndex:= cbAcquireDvc.Items.IndexOf(Options.AcquireDvc);
  // UserTabs
  chkOnlyMin.Checked := Opts.OnlyMin;
  clbUserTabs.Items.Clear;
  for i := 0 to length(allDvcs) - 1 do
    clbUserTabs.Items.Add(allDvcs[i].pnlHeader.Caption);
  cbTabNames.Items.Clear;
  LastUserTab := -1;
  for i := 0 to Options.UserTabs.Count - 1 do
    cbTabNames.Items.Add(Options.UserTabs.Names[i]);
end; { TfrmOptions.UpdatePages }

procedure TfrmOptions.UpdateOptions(var Opts: tOptions);
var
  ss: string;
begin
  // On Start page
  Opts.AutoRunScript := eAutoRunScript.Text;
  ss := eSpectraPath.Text;
  if ss[length(ss)] <> '\' then
    ss := ss + '\';
  Opts.fSpectraPath := ss;
  // Interpreter page
  Opts.ItrShowLevel := rgItrShowLevel.ItemIndex + 1;
  Opts.ItrExtVis := cbItrExtVis.Checked;
  Opts.AutoSave := chkAutoSave.Checked;
  // Templates
  Opts.Templates[1] := eNewTml.Text;
  Opts.Templates[2] := eOpenTml.Text;
  Opts.Templates[3] := eDataAcqTml.Text;
  Opts.Oscilo := chkOscilo.Checked;
  Opts.OsciloDvc := cbOsciloDvc.Text;
  Opts.AcquireDvc := cbAcquireDvc.Text;
  // UserTabs
  Opts.OnlyMin := chkOnlyMin.Checked;
end; { TfrmOptions.UpdateOptions }

procedure TfrmOptions.Execute;
begin
  UpdatePages(Options);
  if ShowModal = mrOK then
  begin
    UpdateOptions(Options);
    if rgSaveOptions.ItemIndex = 1 then
      Options.Save;
    if cbTabNames.ItemIndex > -1 then
      cbTabNamesChange(nil);
    frmDvcRack.UpdateTabs(Options.UserTabs);
  end
  else
    Options.Load;
  DirectoryListBox1.Visible := false;
  bBrowseSpectraPath.Caption := 'Close Browsing';
end; { TfrmOptions.Execute }

function tOptions.CheckDvcExist(DvcName: string): boolean;
var
  i, j: integer;
begin
  Result := false;
  if SameText(DvcName, 'ITR') or SameText(DvcName, 'SNH') then
    exit;
  for i := 0 to Dvcs.Count - 1 do
    if SameText(Dvcs.Names[i], DvcName) then
    begin
      Result := true;
      break;
    end;
end;

function tOptions.CheckDvcOrder(DvcName: string): integer;
var
  i, j: integer;
begin
  Result := -1;
  for i := 0 to Dvcs.Count - 1 do
    if SameText(Dvcs.Names[i], DvcName) then
    begin
      Result := i;
      break;
    end;
end;

function tOptions.CheckDvcEnabled(DvcName: string): boolean;
begin
  Result := false;
  if not CheckDvcExist(DvcName) then
    exit;
  Result := Dvcs.Values[UpperCase(DvcName)] = '1';
end;

function tOptions.CheckDvcMax(DvcName: string): boolean;
begin
  Result := false;
  if not CheckDvcExist(DvcName) then
    exit;
  Result := ReadBool('MaxDev', UpperCase(DvcName), true);
end;

function tOptions.CheckUserTab(TabName, Dvc: string): boolean;
begin
  Result := pos(Dvc, UserTabs.Values[TabName]) > 0;
end;

/// ///////////////////////////////////////////////////////////////////
procedure TfrmOptions.bBrowseAutoRunClick(Sender: TObject);
begin
  odAutoRunScript.FileName := Options.AutoRunScript;
  odAutoRunScript.InitialDir := RootPath + ScanPath;
  if odAutoRunScript.Execute then
    eAutoRunScript.Text := odAutoRunScript.FileName;
end;

procedure TfrmOptions.bBrowseSpectraPathClick(Sender: TObject);
var
  dir: string;
begin { Dir:= eSpectraPath.Text;
    if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],1000)
    then eSpectraPath.Text:= Dir;
    exit; }
  DirectoryListBox1.Visible := not DirectoryListBox1.Visible;
  if DirectoryListBox1.Visible then
  begin
    bBrowseSpectraPath.Caption := 'Close Browsing';
    eSpectraPath.Text := DirectoryListBox1.Directory + '\';
  end
  else
  begin
    bBrowseSpectraPath.Caption := 'Choose Directory';
    DirectoryListBox1.Directory := eSpectraPath.Text;
  end;
end;

procedure TfrmOptions.DirectoryListBox1Change(Sender: TObject);
begin
  eSpectraPath.Text := DirectoryListBox1.Directory + '\';
end;

procedure TfrmOptions.bbNewPlotClick(Sender: TObject);
var
  i, j: integer;
begin
  j := (Sender as TBitBtn).Tag;
  odTemplate.FileName := Options.Templates[j];
  if DirectoryExists(ExtractFilePath(Options.Templates[j])) then
    odTemplate.InitialDir := ExtractFilePath(Options.Templates[j])
  else
    odTemplate.InitialDir := GetConfigPath;
  if not odTemplate.Execute then
    exit;
  case j of
    1:
      eNewTml.Text := odTemplate.FileName;
    2:
      eOpenTml.Text := odTemplate.FileName;
    3:
      eDataAcqTml.Text := odTemplate.FileName;
  end;
  Options.Templates[j] := odTemplate.FileName;
end;

procedure TfrmOptions.bHelpClick(Sender: TObject);
begin
  Application.HelpContext(3210);
end;

procedure TfrmOptions.FormResize(Sender: TObject);
begin
  clbCtrl.Width := round(GroupBox2.Width / 2) - 5;
end;

procedure TfrmOptions.clbCtrlClickCheck(Sender: TObject);
var
  i, j: integer;
  ss: string;
begin
  with (Sender as TCheckListBox) do
  begin
    ss := Items[ItemIndex];
    j := pos('(', ss);
    delete(ss, 1, j);
    delete(ss, length(ss), 1);
    if Checked[ItemIndex] then
      Options.Dvcs.Values[ss] := '1'
    else
      Options.Dvcs.Values[ss] := '0';
  end;
end;

procedure TfrmOptions.cbTabNamesChange(Sender: TObject);
var
  i, j: integer;
  ss, st: string;
begin
  if cbTabNames.ItemIndex = -1 then
    exit;
  if (LastUserTab > -1) and (LastUserTab < Options.UserTabs.Count) then
  begin
    st := Options.UserTabs.Names[LastUserTab] + '=';
    for i := 0 to clbUserTabs.Items.Count - 1 do
      if clbUserTabs.Checked[i] then
      begin
        ss := clbUserTabs.Items[i];
        j := length(ss);
        st := st + ' ' + copy(ss, j - 3, 3);
      end;
    Options.UserTabs[LastUserTab] := st;
  end;
  for i := 0 to clbUserTabs.Items.Count - 1 do
  begin
    ss := clbUserTabs.Items[i];
    j := length(ss);
    ss := copy(ss, j - 3, 3);
    clbUserTabs.Checked[i] := Options.CheckUserTab(cbTabNames.Text, ss);
  end;
  LastUserTab := cbTabNames.ItemIndex;
end;

procedure TfrmOptions.bbAddClick(Sender: TObject);
var
  ss: string;
  bb: boolean;
  i, j: integer;
begin
  ss := InputBox('User Tabs', 'Name',
    'User' + IntToStr(cbTabNames.Items.Count + 1));
  j := cbTabNames.Items.IndexOf(ss);
  if j > -1 then
  begin
    ErrorMsg('Duplicated user tab names.');
    exit;
  end;
  Options.UserTabs.Add(ss + '=');
  cbTabNames.Items.Add(ss);
  cbTabNames.ItemIndex := cbTabNames.Items.Count - 1;
end;

procedure TfrmOptions.bbDeleteClick(Sender: TObject);
var
  i, j: integer;
begin
  if cbTabNames.ItemIndex = -1 then
    exit;
  if MessageDlg('The current user tab will be deleted. Do you confirm?',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    exit;
  i := cbTabNames.ItemIndex;
  cbTabNames.Items.delete(i);
  Options.UserTabs.delete(i);
end;

end. { OptionsU }
