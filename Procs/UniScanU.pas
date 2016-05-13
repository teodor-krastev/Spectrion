unit UniScanU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProcU, Buttons, ExtCtrls, StdCtrls, Spin, ComCtrls,
  FileCtrl, DateUtils, Types, IniFiles, DeviceU, Vcl.Mask, BMDSpinEdit;

type
  TfmUniScan = class(TfmProc)
    GroupBox1: TGroupBox;
    pcCDs: TPageControl;
    tsCD1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label13: TLabel;
    cbUnits1: TComboBox;
    cbCtrlDvc1: TComboBox;
    seCh1N: TSpinEdit;
    tsCD2: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    cbUnits2: TComboBox;
    cbCtrlDvc2: TComboBox;
    seCh2N: TSpinEdit;
    tsCDNone: TTabSheet;
    rbHowMany: TRadioButton;
    rbHowMuch: TRadioButton;
    rgNCDs: TRadioGroup;
    GroupBox2: TGroupBox;
    pcMDs: TPageControl;
    tsMD1: TTabSheet;
    Label12: TLabel;
    seChn1: TSpinEdit;
    cbMsrDvc1: TComboBox;
    GroupBox4: TGroupBox;
    rbSingle1: TRadioButton;
    rbMulti1: TRadioButton;
    tsMD2: TTabSheet;
    Label4: TLabel;
    seChn2: TSpinEdit;
    cbMsrDvc2: TComboBox;
    GroupBox5: TGroupBox;
    rbSingle2: TRadioButton;
    rbMulti2: TRadioButton;
    rgNMDs: TRadioGroup;
    GroupBox3: TGroupBox;
    sbSave: TSpeedButton;
    sbOpen: TSpeedButton;
    cbScanFlies: TComboBox;
    FileListBox1: TFileListBox;
    SaveDialog1: TSaveDialog;
    chkDStream1: TCheckBox;
    chkDStream2: TCheckBox;
    eFrom1: TBMDSpinEdit;
    eStep1: TBMDSpinEdit;
    eTo1: TBMDSpinEdit;
    eFrom2: TBMDSpinEdit;
    eStep2: TBMDSpinEdit;
    eTo2: TBMDSpinEdit;
    nsTimes: TSpinEdit;
    procedure rgNCDsClick(Sender: TObject);
    procedure rgNMDsClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure sbOpenClick(Sender: TObject);
    procedure cbMsrDvc1Change(Sender: TObject);
    procedure cbMsrDvc2Change(Sender: TObject);
    procedure bbRunClick(Sender: TObject);

  private
    { Private declarations }
    function Open(Filename: string): boolean;
    function Save(Filename: string): boolean;
    function ScanPar2Form: boolean;
    function Form2ScanPar: boolean;

  public
    { Public declarations }
    NCDs, NMDs: byte; // number of CDs and MDs
    CDScan: array [1 .. 2] of tCDScan; // control device scan parameters
    MDScan: array [1 .. 2] of tMDScan; // measurement device scan parameters
    procedure LoadOpt; override;
    procedure Execute(AutoRun, ShowUp: boolean; var ScanName: string); override;
    // if ScanName is empty usual dialog window
    // otherwise load a scan from ScanName file and run it
    // if ScanName ends with ? the ScanName (without the ?) parameter file
    // is loaded in dialog window
  end;

var
  fmUniScan: TfmUniScan;

implementation

{$R *.dfm}

uses SpionU, OptionsU, DvcRackU, CmdCentreU, PlotCollectU, AboutU, SpecU,
  SpOptU, SpMathU;

procedure TfmUniScan.Execute(AutoRun, ShowUp: boolean; var ScanName: string);
var
  sn: string;
  bq: boolean;
  i, j: integer;
begin
  bq := false;
  DvcList(cbCtrlDvc1.Items,dkCtrl);
  cbCtrlDvc2.Items.Assign(cbCtrlDvc1.Items);
  cbCtrlDvc1.ItemIndex := 0;
  cbCtrlDvc2.ItemIndex := 1;

  DvcList(cbMsrDvc1.Items,dkMsr);
  cbMsrDvc1.Items.AddStrings(cbCtrlDvc1.Items);
  cbMsrDvc2.Items.Assign(cbMsrDvc1.Items);
  cbMsrDvc1.ItemIndex := 0;
  cbMsrDvc2.ItemIndex := 1;

  cbUnits1.ItemIndex := 0;
  cbUnits2.ItemIndex := 0;
  rgNCDsClick(nil);
  rgNMDsClick(nil);
  FileListBox1.Directory := RootPath + ScanPath;
  FileListBox1.Update;
  cbScanFlies.Items.Assign(FileListBox1.Items);

  sn := ScanName;
  if sn <> '' then
  begin
    if sn[length(sn)] = '?' then
    begin
      delete(sn, length(sn), 1);
      bq := true;
    end;
    if ExtractFilePath(sn) = '' then
      sn := RootPath + ScanPath + sn;
    if UpperCase(ExtractFileExt(sn)) = '' then
      sn := sn + '.scn';
    if copy(sn, 1, 7) = 'file://' then
      delete(sn, 1, 7);
    if Open(sn) then
      ScanPar2Form
    else
      exit;
    if not bq then
      bbRunClick(nil);
  end;
end; { TfrmUniScan.Execute }

procedure TfmUniScan.bbRunClick(Sender: TObject);
var
  i, j, k: integer;
  c, c1, c2, r: double;
  ch, ch2: char;
  spa: array [1 .. 2] of string;
  bb, StopFlag: boolean;
  spc, ss: string;
  j1, ds: array [1 .. 2] of integer;
  wMass: tXYarray;
  a: array [1 .. 2] of double;
  Meanwhile, EndTime: TDateTime;
begin
  try
    InterprtD('itr.busset(true)');
    if not Form2ScanPar then
    begin
      ErrorMsg('Error in input parameters.');
      exit;
    end;
    for i := 1 to NCDs do
    begin
      ss := CDScan[i].DName + '.EnbGet';
      Interprt(ss);
      if ss = 'FALSE' then
        exit;
    end;
    for i := 1 to NMDs do
    begin
      ss := MDScan[i].DName + '.EnbGet';
      Interprt(ss);
      if ss = 'FALSE' then
        exit;
    end;
    Enabled := false;
    InterprtD('Itr.LckSet(TRUE)');
    StopFlag := false;
    if NMDs = 1 then
    begin
      j1[1] := Plots.Add('');
      if j1[1] = -1 then
        exit;
    end
    else
    begin
      Plots.Clear;
      j1[1] := Plots.Add(Options.Templates[3]);
      if j1[1] = -1 then
        exit;
      j1[2] := Plots.Add(Options.Templates[3]);
      if j1[2] = -1 then
        exit;
      frmSpion.mFloatPlotsClick(nil);
      frmSpion.Tile;
    end;
    for j := 1 to NMDs do
      with Plots[j1[j]] do
      begin
        AcqMode := true;
        MassOnly := (not MDScan[j].MultiChannel) and (NCDs < 2);
        if MDScan[j].DStream then
        begin
          ss := 'snh.adsopn(' + MDScan[j].DName + ',sp' +
            GetPlotSymbol(j1[j] + 1) + ')';
          if not Interprt(ss) then
            exit;
          val(ss, ds[j], i);
          if i > 0 then
            exit;
        end;
      end;
    case NCDs of
      0:
        begin // for none Ctrl device
          if not CDScan[1].AbsUnits then // false - time limit
          begin
            CDScan[1].Start := Time;
            CDScan[1].Finish := IncSecond(Time, round(CDScan[1].Finish));
          end;
          c := 0;
          i := 0; // the scan
          repeat
            spc := 'Snh.SnhGet(0)';
            StopFlag := StopFlag or not Interprt(spc);
            for j := 1 to NMDs do
              with MDScan[j], Plots[j1[j]] do
              begin
                if MultiChannel then
                begin
                  if DStream then
                  begin
                    spc := DName + '.DSmGet';
                    StopFlag := StopFlag or not Interprt(spc);
                  end
                  else
                  begin
                    if c = 0 then
                    begin
                      InterprtD(DName + '.SpcGet(' + IntTostr(Channel) + ')');
                      InterprtD('Snh.SnhGet(0)');
                    end;
                    InterprtD(DName + '.SpcGet(' + IntTostr(Channel) + ')');
                    Spec.AddSSpec(c, YsumXY(buffXY), buffXY);
                  end;
                end
                else
                begin
                  if (DvcByName(DName).DvcKind = dkMsr) then
                    spc := DName + '.ChnGet(' + IntTostr(Channel) + ')'
                  else
                    spc := DName + '.MsrGet(' + IntTostr(Channel) + ')';
                  Interprt(spc);
                  val(spc, r, k);
                  if k = 0 then
                    Spec.AddMass(c, r, 0);
                  RefreshPlot;
                end;
              end;
            if CDScan[1].AbsUnits then
              c := c + CDScan[1].Step
            else
              c := MilliSecondsBetween(CDScan[1].Start, Time) / 1000;
          until ((c > CDScan[1].Finish) and CDScan[1].AbsUnits) or
            ((CompareTime(CDScan[1].Finish, Time) = LessThanValue) and
            not CDScan[1].AbsUnits) or Application.Terminated or StopFlag;
        end;
      1:
        begin // for one Ctrl device
          if CDScan[1].AbsUnits then
            ch := 'A'
          else
            ch := 'R';
          c := CDScan[1].Start;
          i := 0; // the scan
          repeat
            InterprtD(CDScan[1].DName + '.' + ch + 'JpSet(' + FloatToStr(c) +
              ',' + IntTostr(seCh1N.Value) + ')');
            spc := 'Snh.SnhGet(0)';
            StopFlag := StopFlag or not Interprt(spc);
            for j := 1 to NMDs do
              with MDScan[j], Plots[j1[j]] do
              begin
                if MultiChannel then
                begin
                  if DStream then
                  begin
                    spc := DName + '.DSmGet';
                    StopFlag := StopFlag or not Interprt(spc);
                  end
                  else
                  begin
                    if c = CDScan[1].Start then
                    begin
                      InterprtD(DName + '.SpcGet(' + IntTostr(Channel) + ')');
                      InterprtD('Snh.SnhGet(0)');
                    end;
                    InterprtD(DName + '.SpcGet(' + IntTostr(Channel) + ')');
                    Spec.AddSSpec(c, YsumXY(buffXY), buffXY);
                  end;
                end
                else
                begin
                  if (DvcByName(DName).DvcKind = dkMsr) then
                    spc := DName + '.ChnGet(' + IntTostr(Channel) + ')'
                  else
                    spc := DName + '.MsrGet(' + IntTostr(Channel) + ')';
                  Interprt(spc);
                  val(spc, r, k);
                  if k = 0 then
                    Spec.AddMass(c, r, 0);
                  RefreshPlot;
                end;
              end;
            c := c + CDScan[1].Step;
          until (c > CDScan[1].Finish) or Application.Terminated or StopFlag;
        end;
      2:
        begin // two control devices
          if CDScan[1].AbsUnits then
            ch := 'A'
          else
            ch := 'R';
          if CDScan[2].AbsUnits then
            ch2 := 'A'
          else
            ch2 := 'R';
          c1 := CDScan[1].Start;
          i := 0;
          bb := false;
          repeat // outer loop by CD[1]
            InterprtD(CDScan[1].DName + '.' + ch + 'JpSet(' + FloatToStr(c1) +
              ',' + IntTostr(seCh1N.Value) + ')');
            c2 := CDScan[2].Start;
            a[1] := 0;
            a[2] := 0;
            for j := 1 to NMDs do
              with Plots[j1[j]] do
                Spec.AddSSpec(c1, 0, wMass);
            repeat // inner scan by CD[2]
              InterprtD(CDScan[2].DName + '.' + ch2 + 'JpSet(' + FloatToStr(c2)
                + ',' + IntTostr(seCh2N.Value) + ')');
              spc := 'Snh.SnhGet(0)';
              StopFlag := StopFlag or not Interprt(spc);
              for j := 1 to NMDs do
                with MDScan[j], Plots[j1[j]] do
                begin
                  if (DvcByName(DName).DvcKind = dkMsr) then
                    spc := DName + '.ChnGet(' + IntTostr(Channel) + ')'
                  else
                    spc := DName + '.MsrGet(' + IntTostr(Channel) + ')';
                  Interprt(spc);
                  val(spc, r, k);
                  if k = 0 then
                    Spec.AddMass(c2, r, i);
                  a[j] := a[j] + r;
                  Spec.Chrom[i, Y] := a[j];
                  RefreshPlot;
                end;
              Application.ProcessMessages;
              c2 := c2 + CDScan[2].Step;
            until (c2 > CDScan[2].Finish) or Application.Terminated or StopFlag;

            Application.ProcessMessages;
            c1 := c1 + CDScan[1].Step;
            inc(i);
          until (c1 > CDScan[1].Finish) or Application.Terminated or StopFlag;
        end;
    end;
    for j := 1 to NMDs do
      if MDScan[j].DStream then
      begin
        ss := 'snh.dsmcls(' + IntTostr(ds[j]) + ')';
        if not Interprt(ss) then
          exit;
        val(ss, ds[j], i);
        if i > 0 then
          exit;
      end
      else
        Plots[j1[j]].AcqMode := false;

  finally
    Enabled := true;
    sbRun.Down := false;
    InterprtD('Itr.LckSet(FALSE)');
    InterprtD('itr.busset(FALSE)');
  end;
end; { TfmUniScan.bbRunClick }

procedure TfmUniScan.LoadOpt;
begin
  if Assigned(Ini) then
  begin
    Open(Ini.Filename);
    FreeAndNil(Ini);
  end;
end;

function TfmUniScan.Open(Filename: string): boolean;
// load scan file into parameter vars
var
  ScanFile: TIniFile;
  i, j: integer;
  ss: string;
begin
  Result := false;
  if not FileExists(Filename) then
  begin
    ErrorMsg('The scan file "' + Filename + '" does not exist');
    exit;
  end;
  ScanFile := TIniFile.Create(Filename);
  with ScanFile do
  begin
    NCDs := ReadInteger('DeviceNumb', 'CDs', 1);
    NMDs := ReadInteger('DeviceNumb', 'MDs', 1);
    for i := 1 to 2 do
      with CDScan[i] do
      begin
        ss := 'CD' + IntTostr(i);
        DName := ReadString(ss, 'DName', '');
        Start := ReadFloat(ss, 'From', 0);
        Finish := ReadFloat(ss, 'To', 1000);
        Step := ReadFloat(ss, 'Step', 1);
        Channel := ReadInteger(ss, 'Channel', 1);
        AbsUnits := ReadBool(ss, 'AbsUnits', true);
      end;
    for i := 1 to 2 do
      with MDScan[i] do
      begin
        ss := 'MD' + IntTostr(i);
        DName := ReadString(ss, 'DName', '');
        MultiChannel := ReadBool(ss, 'MultiChannel', false);
        DStream := ReadBool(ss, 'DStream', false);
        Channel := ReadInteger(ss, 'Channel', 0);
      end;
  end;
  ScanFile.Free;
  Result := true;
end; { TfrmUniScan.Open }

function TfmUniScan.Save(Filename: string): boolean;
// save parameter vars into scan file
var
  ScanFile: TIniFile;
  i, j: integer;
  ss: string;
begin
  ScanFile := TIniFile.Create(Filename);
  with ScanFile do
  begin
    WriteInteger('DeviceNumb', 'CDs', NCDs);
    WriteInteger('DeviceNumb', 'MDs', NMDs);
    for i := 1 to 2 do
      with CDScan[i] do
      begin
        ss := 'CD' + IntTostr(i);
        WriteString(ss, 'DName', DName);
        WriteFloat(ss, 'From', Start);
        WriteFloat(ss, 'To', Finish);
        WriteFloat(ss, 'Step', Step);
        WriteInteger(ss, 'Channel', Channel);
        WriteBool(ss, 'AbsUnits', AbsUnits);
      end;
    for i := 1 to 2 do
      with MDScan[i] do
      begin
        ss := 'MD' + IntTostr(i);
        WriteString(ss, 'DName', DName);
        WriteBool(ss, 'MultiChannel', MultiChannel);
        WriteBool(ss, 'DStream', DStream);
        WriteInteger(ss, 'Channel', Channel);
      end;
  end;
  ScanFile.Free;
end; { TfrmUniScan.Save }

function TfmUniScan.ScanPar2Form: boolean;
// set the form accoring scan parameter vars into
var
  i, j: integer;
begin
  Result := false;
  // CDs
  rgNCDs.ItemIndex := NCDs;
  rgNCDsClick(nil);
  if NCDs = 0 then
  begin
    rbHowMany.Checked := CDScan[1].AbsUnits;
    rbHowMuch.Checked := not CDScan[1].AbsUnits;
    nsTimes.Value := round(CDScan[1].Finish);
  end;
  if NCDs > 0 then
    with CDScan[1] do
    begin
      i := cbCtrlDvc1.Items.IndexOf(DName);
      if i = -1 then
        exit
      else
        cbCtrlDvc1.ItemIndex := i;
      eFrom1.Value := Start;
      eTo1.Value := Finish;
      eStep1.Value := Step;
      seCh1N.Value := Channel;
      if AbsUnits then
        cbUnits1.ItemIndex := 0
      else
        cbUnits1.ItemIndex := 1;
    end;
  if NCDs > 1 then
    with CDScan[2] do
    begin
      i := cbCtrlDvc2.Items.IndexOf(DName);
      if i = -1 then
        exit
      else
        cbCtrlDvc2.ItemIndex := i;
      eFrom2.Value := Start;
      eTo2.Value := Finish;
      eStep2.Value := Step;
      seCh2N.Value := Channel;
      if AbsUnits then
        cbUnits2.ItemIndex := 0
      else
        cbUnits2.ItemIndex := 1;
    end;
  // MDs
  rgNMDs.ItemIndex := NMDs - 1;
  rgNMDsClick(nil);
  if NMDs > 0 then
    with MDScan[1] do
    begin
      i := cbMsrDvc1.Items.IndexOf(DName);
      if i = -1 then
        exit
      else
        cbMsrDvc1.ItemIndex := i;
      seChn1.Value := Channel;
      rbSingle1.Checked := not MultiChannel;
      rbMulti1.Checked := MultiChannel;
      chkDStream1.Checked := DStream;
      cbMsrDvc1Change(nil);
    end;
  if NMDs > 1 then
    with MDScan[2] do
    begin
      i := cbMsrDvc2.Items.IndexOf(DName);
      if i = -1 then
        exit
      else
        cbMsrDvc2.ItemIndex := i;
      seChn2.Value := Channel;
      rbSingle2.Checked := not MultiChannel;
      rbMulti2.Checked := MultiChannel;
      chkDStream2.Checked := DStream;
      cbMsrDvc2Change(nil);
    end;
  Result := true;
end; { TfrmUniScan.ScanPar2Form }

function TfmUniScan.Form2ScanPar: boolean;
// set scan parameters according visual components state
var
  i, j: integer;
begin
  Result := false;
  if NCDs = 0 then
    with CDScan[1] do
    begin
      DName := '<none>';
      Start := 1;
      Finish := nsTimes.Value;
      Step := 1;
      AbsUnits := rbHowMany.Checked;
    end;
  if NCDs > 0 then
    with CDScan[1] do
    begin
      DName := cbCtrlDvc1.Text;
      Start := eFrom1.Value;
      Finish := eTo1.Value;
      Step := eStep1.Value;
      Channel := seCh1N.Value;
      if (Step = 0) or (Start >= Finish) then
        exit;
      AbsUnits := (cbUnits1.ItemIndex = 0);
    end;
  if NCDs > 1 then
    with CDScan[2] do
    begin
      DName := cbCtrlDvc2.Text;
      Start := eFrom2.Value;
      Finish := eTo2.Value;
      Step := eStep2.Value;
      Channel := seCh2N.Value;
      if (Step = 0) or (Start >= Finish) then
        exit;
      AbsUnits := (cbUnits2.ItemIndex = 0);
    end;
  if NMDs > 0 then
    with MDScan[1] do
    begin
      DName := cbMsrDvc1.Text;
      MultiChannel := rbMulti1.Checked;
      DStream := chkDStream1.Checked;
      Channel := seChn1.Value;
    end;
  if NMDs > 1 then
    with MDScan[2] do
    begin
      DName := cbMsrDvc2.Text;
      MultiChannel := rbMulti2.Checked;
      DStream := chkDStream2.Checked;
      Channel := seChn2.Value;
    end;
  Result := true;
end; { TfrmUniScan.Form2ScanPar }

procedure TfmUniScan.rgNCDsClick(Sender: TObject);
// change the number of control devices
begin
  if (rgNCDs.ItemIndex = 2) and (cbCtrlDvc2.Items.Count < 2) then
    rgNCDs.ItemIndex := 1;
  case rgNCDs.ItemIndex of
    0:
      begin
        tsCDNone.TabVisible := true;
        tsCD1.TabVisible := false;
        tsCD2.TabVisible := false;
        pcCDs.ActivePage := tsCDNone;
      end;
    1:
      begin
        tsCDNone.TabVisible := false;
        tsCD1.TabVisible := true;
        tsCD2.TabVisible := false;
        pcCDs.ActivePage := tsCD1;
      end;
    2:
      begin
        tsCDNone.TabVisible := false;
        tsCD1.TabVisible := true;
        tsCD2.TabVisible := true;
        pcCDs.ActivePage := tsCD1;
        cbCtrlDvc2.ItemIndex := 1;
      end;
  end;
  NCDs := rgNCDs.ItemIndex;
  cbMsrDvc1Change(nil);
  cbMsrDvc2Change(nil);
end; { TfrmUniScan.rgNCDsClick }

procedure TfmUniScan.rgNMDsClick(Sender: TObject);
// change the number of measurement devices
begin
  NMDs := rgNMDs.ItemIndex + 1;
  tsMD2.TabVisible := (rgNMDs.ItemIndex = 1);
  pcMDs.ActivePage := tsMD1;
end; { TfrmUniScan.rgNMDsClick }

procedure TfmUniScan.sbSaveClick(Sender: TObject);
var
  ss: string;
begin
  Form2ScanPar;
  SaveDialog1.InitialDir := RootPath + ScanPath;
  if SaveDialog1.Execute then
  begin
    Save(SaveDialog1.Filename);
    FileListBox1.Update;
    cbScanFlies.Items.Assign(FileListBox1.Items);
  end;
end; { TfrmUniScan.SpeedButton1Click }

procedure TfmUniScan.sbOpenClick(Sender: TObject);
var
  ss: string;
begin
  ss := cbScanFlies.Text;
  Open(RootPath + ScanPath + ChangeFileExt(ExtractFileName(ss), '.scn'));
  ScanPar2Form;
  Caption := 'Universal Scanning - ' + ss;
end; { TfrmUniScan.sbOpenClick }

procedure TfmUniScan.cbMsrDvc1Change(Sender: TObject);
var
  ss: string;
begin
  if cbMsrDvc1.Text = '' then
    exit;
  rbMulti1.Enabled := (DvcByName(cbMsrDvc1.Text).DvcKind = dkMsr);
  if rbMulti1.Enabled then
  begin
    ss := cbMsrDvc1.Text + '.DimGet('+IntToStr(seChn1.Value)+')';
    rbMulti1.Enabled := Interprt(ss) and (NCDs < 2);
  end
  else
  begin
    rbSingle1.Checked := true;
    rbMulti1.Enabled := false;
  end;
end;

procedure TfmUniScan.cbMsrDvc2Change(Sender: TObject);
var
  ss: string;
begin
  if cbMsrDvc2.Text = '' then
    exit;
  rbMulti2.Enabled := (DvcByName(cbMsrDvc2.Text).DvcKind = dkMsr);
  if rbMulti2.Enabled then
  begin
    ss := cbMsrDvc2.Text + '.DimGet('+IntToStr(seChn2.Value)+')';
    rbMulti2.Enabled := Interprt(ss) and (NCDs < 2);
  end
  else
  begin
    rbSingle2.Checked := true;
    rbMulti2.Enabled := false;
  end;
end;

end.
