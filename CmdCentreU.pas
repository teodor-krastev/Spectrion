unit CmdCentreU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ToolWin, ExtCtrls, ImgList, clipbrd, DeviceU, Vcl.Buttons,
  ProcU, AboutU, IniFiles, System.StrUtils;

type
  TOnCommandExe = procedure(const Cmd: WideString; const Reply: WideString) of object;

  MPtr = record
    Adr, Cls: pointer;
  end;

  TMyEvent = class
  private
    FOnFireEvent: TOnFireEvent;
    FOnDvcStEvent: TOnDvcStEvent;
  public
    TheDevice, TheProc: string;
  published
    procedure TheEvent(Dvc, Msg: string);
    procedure DvcStEvent(Dvc: string; OldSt, NewSt: Integer; Msg: string);
    property OnFireEvent: TOnFireEvent read FOnFireEvent write FOnFireEvent;
    property OnDvcStEvent: TOnDvcStEvent read FOnDvcStEvent write FOnDvcStEvent;
  end;

  TfrmCmdCentre = class(TFrame)
    pcCmdCentre: TPageControl;
    tsProc: TTabSheet;
    tsScript: TTabSheet;
    pnlProc: TPanel;
    Splitter1: TSplitter;
    pnlScript: TPanel;
    CoolBar1: TCoolBar;
    ToolBar2: TToolBar;
    ToolButton8: TToolButton;
    tbRun: TToolButton;
    ToolBar1: TToolBar;
    tbOpen: TToolButton;
    tbPaste: TToolButton;
    tbSaveAsScript: TToolButton;
    ToolButton5: TToolButton;
    ImageList1: TImageList;
    eCommand: TComboBox;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    tbCopyToClipboard: TToolButton;
    ToolButton1: TToolButton;
    tbClear: TToolButton;
    tbHelp: TToolButton;
    ToolButton3: TToolButton;
    rtScript: TRichEdit;
    procedure tbRunClick(Sender: TObject);
    procedure eCommandKeyPress(Sender: TObject; var Key: Char);
    procedure tbOpenClick(Sender: TObject);
    procedure tbSaveAsScriptClick(Sender: TObject);
    procedure tbPasteClick(Sender: TObject);
    procedure tbCopyToClipboardClick(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure tbClearClick(Sender: TObject);
    procedure eCommandEnter(Sender: TObject);
    procedure tbHelpClick(Sender: TObject);
  private
    { Private declarations }
    fFillIn, fAlwaysVis, fDocked, fLeftAlign, fPaged: boolean;
    ProcInPlace: TfmProc;
    FOnCommandExe: TOnCommandExe;
    procedure SetPaged(Value: boolean);
    procedure SetAlwaysVis(Value: boolean);
    procedure SetDocked(Value: boolean);
    procedure SetLeftAlign(Value: boolean);

    procedure bbProcCancelClick(Sender: TObject);
    procedure bbProcHelpClick(Sender: TObject);
  public
    { Public declarations }
    destructor Destroy; override;
    procedure RegProcs;
    procedure OnError(const Msg: string);
    property Paged: boolean read fPaged write SetPaged default true;
    property FillIn: boolean read fFillIn; // if a Proc is in place
    property AlwaysVis: boolean read fAlwaysVis write SetAlwaysVis;
    property Docked: boolean read fDocked write SetDocked default true;
    property LeftAlign: boolean read fLeftAlign write SetLeftAlign default true;

    property OnCommandExe: TOnCommandExe read FOnCommandExe write FOnCommandExe;

    constructor Create(AOwner: TComponent); override;
    procedure Reshow;
    procedure HomeProc(WProc: TfmProc);
    procedure FreeProc;
  end;
//!!!!!! THE HEART OF SPECTRION !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function RunScript(FName: string): boolean;
function Interprt(var InOutText: string): boolean;
function InterprtD(InText: string): string;

procedure CallProc(ProcName: string; AutoRun, ShowUp: boolean;
  var InOut: string);
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var
  frmCmdCentre: TfrmCmdCentre;
  Procs: TStrings;

implementation

uses CmdShellU, DvcRackU, MsrDeviceU, CtrlDeviceU, OptionsU, SynchroU,
  PlotCollectU, PlotU, SpionU, SpOptU,
  UniScanU, SimpleScanU, AutoTuneU, SCopyU, PCAprocU;
{$R *.DFM}
const DefWidth = 225;

var DvcEventList, FullEventList: TStrings; fBusy: boolean;

procedure TMyEvent.TheEvent(Dvc, Msg: string);
var
  i: Integer;
begin
  if TheProc = '' then
  begin
    for i := 0 to FullEventList.Count - 1 do
      if pos(':' + Dvc, FullEventList[i]) > 0 then
        if Assigned(TMyEvent(FullEventList.Objects[i]).FOnFireEvent) then
          TMyEvent(FullEventList.Objects[i]).FOnFireEvent(Dvc, Msg);
  end
  else
  begin
    if Assigned(FOnFireEvent) then
    begin
      InterprtD('//Event: ' + Msg);
      FOnFireEvent(Dvc, Msg);
    end;
  end;
end;

procedure TMyEvent.DvcStEvent(Dvc: string; OldSt, NewSt: Integer; Msg: string);
var
  i: Integer;
begin
  if TheProc = '' then
  begin
    for i := 0 to FullEventList.Count - 1 do
      if pos(':' + Dvc, FullEventList[i]) > 0 then
        if Assigned(TMyEvent(FullEventList.Objects[i]).FOnDvcStEvent) then
          TMyEvent(FullEventList.Objects[i]).FOnDvcStEvent(Dvc, OldSt,
            NewSt, Msg);;
  end
  else
  begin
    if Assigned(FOnFireEvent) then
    begin // InterprtD('//DvcSt: '+IntToStr(OldSt)+'-'+IntToStr(NewSt)+' '+Msg);
      FOnDvcStEvent(Dvc, OldSt, NewSt, Msg);
    end;
  end;
end;

procedure TfrmCmdCentre.OnError(const Msg: string);
begin
  InterprtD('//Error: ' + Msg);
end;

function RunScript(FName: string): boolean;
// run a script from file
var
  i, j: Integer;
  sl: TStrings;
  sf, ss: string;
  bb: boolean;
begin
  Result := false;
  bb := true;
  { if ExtractFilePath(FName)='' then sf:= RootPath+ScriptPath+FName
    else } sf := FName;
  if UpperCase(ExtractFileExt(sf)) = '' then
    sf := sf + '.scr';
  if not FileExists(sf) then
    exit;
  sl := TStringList.Create;
  sl.LoadFromFile(sf);
  for i := 0 to sl.Count - 1 do
  begin
    ss := sl.Strings[i];
    if ss[1] <> '>' then
      bb := bb and Interprt(ss);
  end;
  sl.Free;
  Result := bb;
end; { ScriptRun }

function Interprt(var InOutText: string): boolean;
// input full text command in InOutText and
// returns result in InOutTex and true in func. value when succeed
// returns error message and false in func. value when failed
var
  Cmd, sDvc, sCmd, sStr, sStr1, sStr2, sStr3, ss: string;
  bb, Rslt, found: boolean;
  i, j, k, np: Integer;
  InText: string;
  FMyEvent, DMyEvent: TMyEvent;
  wrd: word;
  dbl: double;
  ij, ik: Integer;
  bt: byte;
  msrDvc: TmsrDevice;
  ctrlDvc: TctrlDevice;
  Dvc: TdDevice;
label 99; // bad style, but great speed (the only label in the program)
  function StripQ(ss: string): string;
  var
    i: byte;
    st: string;
  begin
    st := ss;
    for i := length(st) downto 1 do
      if st[i] = '"' then
        System.delete(st, i, 1);
    Result := st;
  end;

  function Decompose: boolean;
  // decompose full text command into
  // sDvc for device name,
  // sCmd for command itself,
  // sStr for parameters (if any)
  var
    i, j: byte;
  begin
    Result := false;
    Cmd := UpperCase(Trim(InOutText));
    sDvc := copy(Cmd, 1, 3);
    sCmd := copy(Cmd, 5, 6);
    sStr := '';
    if (sDvc[1] = '/') and (sDvc[2] = '/') then // this is a comment line
    begin
      sDvc := '//';
      sCmd := '';
      Decompose := true;
      exit;
    end;
    if Cmd[4] <> '.' then
      exit;
    if length(Cmd) > 10 then // if there are params
    begin
      j := length(Cmd);
      if (Cmd[11] <> '(') or (Cmd[j] <> ')') then
        exit;
      j := j - 12;
      sStr := copy(Cmd, 12, j);
      sStr := StripQ(sStr);
    end;
    Result := true;
  end; { Decompose }

  function SeparParams: byte;
  var
    i, j: byte;
    ss: string;
  begin
    Result := 0;
    if length(sStr) = 0 then
      exit;
    Result := 1;
    sStr1 := sStr;
    i := pos(',', sStr);
    if i = 0 then
      exit;
    sStr1 := StripQ(copy(sStr, 1, i - 1));
    sStr2 := StripQ(copy(sStr, i + 1, 255));
    if (length(sStr1) * length(sStr2)) = 0 then
      exit;
    ss := sStr2;
    Result := 2;
    i := pos(',', ss);
    if i = 0 then
      exit;
    sStr2 := StripQ(copy(ss, 1, i - 1));
    sStr3 := StripQ(copy(ss, i + 1, 255));
    if (length(sStr2) * length(sStr3)) = 0 then
      exit;
    Result := 3;
  end;

  procedure AddTxt2RichEdit(reView: TRichEdit; txt: string);
  begin
    while reView.Lines.Count > 5000 // lines number limit
      do
      reView.Lines.delete(0);
    reView.SelAttributes.Color := clBlack;
    reView.SelAttributes.Style := [];
    if (leftStr(txt, 1) = '!') or (leftStr(txt, 1) = '#') then
      reView.SelAttributes.Color := clMaroon;
    if (leftStr(txt, 2) = '=>') or (leftStr(txt, 3) = '...') then
    begin
      reView.SelAttributes.Color := clMaroon;
      reView.SelAttributes.Style := [fsBold];
    end;
    if leftStr(txt, 3) = 'Err' then
      reView.SelAttributes.Color := $000000D2;
    if leftStr(txt, 1) = '>' then
      reView.SelAttributes.Color := clNavy;
    reView.SelText := txt + chr(10);
    if reView.CanFocus and reView.Showing then
    begin
      reView.SetFocus;
      reView.SelStart := reView.GetTextLen;
      reView.Perform(EM_SCROLLCARET, 0, 0);
    end;
  end;

  procedure ShowTxt(ss: string);
  begin
    if frmCmdCentre.rtScript.Visible and (Options.ItrShowLevel > 0) and
      (InOutText <> '') then
      AddTxt2RichEdit(frmCmdCentre.rtScript, ss)
  end;

// The heard of the interpreter
begin
  Interprt := false;
  found := false;
  Rslt := false;
  InText := InOutText;
  if Options.ItrShowLevel >= 2 then
    ShowTxt(InOutText);
  if InOutText = '' then
    exit;
  if not(Decompose) then
    goto 99;
  InOutText := '';
  //
  // interpretation of Measurement Device commands
  msrDvc := MDByName(sDvc);
  if msrDvc <> nil then // commands are ordered by speed importance
  begin
    if not frmDvcRack.MainSwitch then
    begin
      InOutText := 'The main switch is OFF';
      Rslt := false;
      found := true;
      goto 99;
    end;
    if sCmd = 'CHNGET' then // Get the value of N channel of measured spectrum
    begin
      found := true;
      val(sStr, ij, k);
      if k <> 0 then
        Rslt := msrDvc.ChnGet(-999, dbl)
      else
        Rslt := msrDvc.ChnGet(ij, dbl);
      if Rslt then
      begin
        InOutText := FloatToStrF(dbl, ffGeneral, 8, 3);
        if Options.ItrShowLevel >= 3 then
          ShowTxt('>Value= ' + InOutText);
      end;
      Goto 99;
    end;
    if sCmd = 'SPCGET' then // Measure and put measured spectrum in the buffer.
    begin
      found := true;
      val(sStr, ij, k);
      if k <> 0 then
      begin
        Rslt := false;
        InOutText := 'Wrong parameter (integer)';
      end
      else
        Rslt := msrDvc.SpcGet(ij, buffXY);
      if Rslt then
      begin
        InOutText := 'OK';
        if Options.ItrShowLevel >= 3 then
          ShowTxt('>OK');
      end;
    end;
    if sCmd = 'DSMGET' then // Get spectrum channel throu open data stream
    begin
      found := true;
      Rslt := msrDvc.DSmGet;
      if Rslt then
      begin
        InOutText := 'OK';
        if Options.ItrShowLevel >= 3 then
          ShowTxt('>Value= ' + InOutText);
      end;
      Goto 99;
    end;
    if sCmd = 'DFTSET' then // Set default channel
    begin
      found := true;
      val(sStr, ij, k);
      if k <> 0 then
      begin
        Rslt := false;
        InOutText := 'Wrong parameter (integer)';
      end
      else
      begin
        Rslt := msrDvc.DftSet(ij);
        if Rslt then
        begin
          InOutText := 'OK';
          if Options.ItrShowLevel >= 3 then
            ShowTxt('>OK');
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'DIMGET' then // Get the units of measurement
    begin
      found := true;
      SeparParams;
      val(sStr1, ij, k);
      Rslt := msrDvc.DimGet(ij, sStr2);
      if Rslt then
        InOutText := sStr2
      else
        InOutText := 'Single-channel device';
      if Rslt and (Options.ItrShowLevel >= 3) then
        ShowTxt('>Units are ' + InOutText);
      Goto 99;
    end;
  end;
  // interpretation of Control Device commands
  ctrlDvc := CDByName(sDvc);
  if ctrlDvc <> nil then
  begin
    if not frmDvcRack.MainSwitch then
    begin
      InOutText := 'The main switch is OFF';
      Rslt := false;
      found := true;
      goto 99;
    end;
    if sCmd = 'ABSGET' then // Get demanded absolute position
    begin
      found := true;
      SeparParams;
      val(sStr1, ij, k);
      if k <> 0 then
        ij := 0;
      if k <> 0 then
      begin
        Rslt := false;
        InOutText := 'Wrong parameter (integer)';
      end
      else
      begin
        Rslt := ctrlDvc.AbsGet(ik, ij);
        if Rslt then
        begin
          InOutText := IntToStr(ik);
          if Options.ItrShowLevel >= 4 then
            ShowTxt('>AbsPos= ' + InOutText);
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'RELGET' then // Get demanded relative position
    begin
      found := true;
      SeparParams;
      val(sStr1, ij, k);
      if k <> 0 then
        ij := 0;
      if k <> 0 then
      begin
        Rslt := false;
        InOutText := 'Wrong parameter (integer)';
      end
      else
      begin
        Rslt := ctrlDvc.RelGet(dbl, ij);
        if Rslt then
        begin
          InOutText := MyFloatToStr(dbl);
          if Options.ItrShowLevel >= 4 then
            ShowTxt('>RelPos= ' + InOutText);
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'MSRGET' then // Measure "real" relative position
    begin
      found := true;
      SeparParams;
      val(sStr1, ij, k);
      if k <> 0 then
        ij := 0;
      if k <> 0 then
      begin
        Rslt := false;
        InOutText := 'Wrong parameter (integer)';
      end
      else
      begin
        Rslt := ctrlDvc.MsrGet(dbl, ij);
        if Rslt then
        begin
          InOutText := MyFloatToStr(dbl);
          if Options.ItrShowLevel >= 4 then
            ShowTxt('>MsrPos= ' + InOutText);
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'AJPSET' then // Jump on absolute position
    begin
      found := true;
      np := SeparParams;
      val(sStr1, dbl, k);
      ij := round(dbl);
      if np > 1 then
        val(sStr2, np, k)
      else
        np := 0;
      if k <> 0 then
      begin
        Rslt := false;
        InOutText := 'Wrong parameter (integer)';
      end
      else
      begin
        Rslt := ctrlDvc.AJpSet(ij, np);
        if Rslt then
        begin
          InOutText := IntToStr(ij);
          if Options.ItrShowLevel >= 4 then
            ShowTxt('>AbsPos= ' + InOutText);
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'RJPSET' then // Jump on relative position
    begin
      found := true;
      np := SeparParams;
      val(sStr1, dbl, k);
      if np > 1 then
        val(sStr2, np, k)
      else
        np := 0;
      if k <> 0 then
      begin
        Rslt := false;
        InOutText := 'Wrong parameter (real)';
      end
      else
      begin
        Rslt := ctrlDvc.RJpSet(dbl, np);
        if Rslt then
        begin
          InOutText := FloatToStrF(dbl, ffGeneral, 8, 3);
          if Options.ItrShowLevel >= 4 then
            ShowTxt('>RelPos= ' + InOutText);
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'AMVSET' then // Move AP absolute units
    begin
      found := true;
      np := SeparParams;
      val(sStr1, ij, k);
      if np > 1 then
        val(sStr2, np, k)
      else
        np := 0;
      if k <> 0 then
      begin
        Rslt := false;
        InOutText := 'Wrong parameter (integer)';
      end
      else
      begin
        Rslt := ctrlDvc.AMvSet(ij, np);
        if Rslt then
        begin
          InOutText := IntToStr(ij);
          if Options.ItrShowLevel >= 4 then
            ShowTxt('>AbsPos= ' + InOutText);
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'RMVSET' then // Move RP relative units
    begin
      found := true;
      np := SeparParams;
      val(sStr1, dbl, k);
      if np > 1 then
        val(sStr2, np, k)
      else
        np := 0;
      if k <> 0 then
      begin
        Rslt := false;
        InOutText := 'Wrong parameter (real)';
      end
      else
      begin
        Rslt := ctrlDvc.RMvSet(dbl, np);
        if Rslt then
        begin
          InOutText := FloatToStrF(dbl, ffGeneral, 8, 3);
          if Options.ItrShowLevel >= 4 then
            ShowTxt('>RelPos= ' + InOutText);
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'DFTSET' then // Set control default channel
    begin
      found := true;
      val(sStr, bt, k);
      if k <> 0 then
      begin
        Rslt := false;
        InOutText := 'Wrong parameter (word)';
      end
      else
      begin
        Rslt := ctrlDvc.DftSet(bt);
        if Rslt then
        begin
          InOutText := 'OK';
          if Options.ItrShowLevel >= 4 then
            ShowTxt('>OK');
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'DIMGET' then // Get the units
    begin
      found := true;
      // SeparParams;
      val(sStr, ij, k);
      if k <> 0 then
      begin
        Rslt := false;
        InOutText := 'Wrong parameter (word)';
      end
      else
      begin
        Rslt := ctrlDvc.DimGet(ij, sStr2);
        InOutText := sStr2;
      end;
      if Rslt and (Options.ItrShowLevel >= 3) then
        ShowTxt('>Chn ID is ' + InOutText);
      Goto 99;
    end;
  end;
  //
  // interpretation of Common Device commands
  Dvc := DvcByName(sDvc);
  if Dvc <> nil then
  begin
    if sCmd = 'INISET' then // (re)Initiate the device
    begin
      found := true;
      Rslt := Dvc.IniSet;
      if Rslt then
      begin
        InOutText := 'OK';
        if Options.ItrShowLevel >= 4 then
          ShowTxt('>OK');
      end;
      Goto 99;
    end;
    if sCmd = 'CLSSET' then // Close the device
    begin
      found := true;
      Rslt := Dvc.ClsSet;
      if Rslt then
      begin
        InOutText := 'OK';
        if Options.ItrShowLevel >= 3 then
          ShowTxt('>OK');
      end;
      Goto 99;
    end;
    if sCmd = 'BUSGET' then // Check if the device is busy
    begin
      found := true; //
      if Dvc.BusGet then
        InOutText := 'TRUE'
      else
        InOutText := 'FALSE';
      Rslt := true;
      if (Options.ItrShowLevel >= 4) then
      begin
        if Dvc.BusGet then
          ShowTxt('>The device is busy.')
        else
          ShowTxt('>The device is not busy.');
      end;
      Goto 99;
    end;
    if sCmd = 'ENBGET' then // Check the device availability
    begin
      found := true; //
      if Dvc.EnbGet then
        InOutText := 'TRUE'
      else
        InOutText := 'FALSE';
      Rslt := true;
      if (Options.ItrShowLevel >= 4) then
      begin
        if Dvc.EnbGet then
          ShowTxt('>The device is enabled.')
        else
          ShowTxt('>The device is disabled.');
      end;
      Goto 99;
    end;
    if sCmd = 'ENBSET' then // Set the device availability
    begin
      found := true; //
      bb := (sStr = 'TRUE');
      Dvc.EnbSet(bb);
      Rslt := (Dvc.EnbGet = bb);
      if Rslt and (Options.ItrShowLevel >= 4) then
      begin
        InOutText := 'OK';
        if bb then
          ShowTxt('>The device is enabled.')
        else
          ShowTxt('>The device is disabled.');
      end;
      Goto 99;
    end;
    if sCmd = 'SETLOD' then // Load MD's settings from file
    begin
      found := true;
      Rslt := Dvc.SetLod(sStr);
      InOutText := sStr;
      if Rslt and (Options.ItrShowLevel >= 3) then
        ShowTxt('>OK');
      Goto 99;
    end;
    if sCmd = 'SETSAV' then // Save MD's settings into file
    begin
      found := true;
      Rslt := Dvc.SetSav(sStr);
      InOutText := sStr;
      if Rslt and (Options.ItrShowLevel >= 3) then
        ShowTxt('>OK');
      Goto 99;
    end;
    if sCmd = 'SETGET' then // Get MD's setting file
    begin
      found := true;
      Rslt := Dvc.SetGet(sStr);
      InOutText := sStr;
      if Rslt and (Options.ItrShowLevel >= 3) then
        ShowTxt('> ' + InOutText);
      Goto 99;
    end;
    if sCmd = 'DVCLCK' then // lock/unlock device for manual change
    begin
      found := true;
      bb := (sStr = 'TRUE');
      Rslt := Dvc.DvcLck(bb);
      if Options.ItrShowLevel >= 4 then
      begin
        if Rslt then
          ShowTxt('>The device is locked.')
        else
          ShowTxt('>The device is unlocked.');
      end;
      Goto 99;
    end;
    if sCmd = 'CMDEXE' then // Command for internal interpretation by the device
    begin
      found := true;
      Rslt := Dvc.CmdExe(sStr);
      InOutText := sStr;
      if Rslt and (Options.ItrShowLevel >= 4) then
        ShowTxt('>OK');
      Goto 99;
    end;
    if sCmd = 'EVNSET' then // Command for event fire of the device (custom)
    begin
      found := true;
      Rslt := false;
      if SeparParams <> 3 then
        exit;
      ij := FullEventList.IndexOf(sStr1 + ':' + sDvc);
      bb := (ij > -1);
      if bb then
        FMyEvent := TMyEvent(FullEventList.Objects[ij])
      else
      begin
        FMyEvent := TMyEvent.Create;
        FullEventList.AddObject(sStr1 + ':' + sDvc, FMyEvent);
        FMyEvent.TheDevice := sDvc;
        FMyEvent.TheProc := sStr1;
      end;
      ij := DvcEventList.IndexOf(sDvc);
      bb := (ij > -1);
      if bb then
        DMyEvent := TMyEvent(DvcEventList.Objects[ij])
      else
      begin
        DMyEvent := TMyEvent.Create;
        DvcEventList.AddObject(sDvc, DMyEvent);
        DMyEvent.TheDevice := sDvc;
        DMyEvent.TheProc := '';
      end;
      Dvc.OnFireEvent := nil;
      val(sStr2, ij, k);
      if (k = 0) and (ij > 0) then
        MPtr(FMyEvent.FOnFireEvent).Adr := Ptr(ij)
      else
        Goto 99;
      val(sStr3, ij, k);
      if (k = 0) and (ij > 0) then
        MPtr(FMyEvent.FOnFireEvent).Cls := Ptr(ij)
      else
        Goto 99;
      Dvc.OnFireEvent := DMyEvent.TheEvent;
      Rslt := true;
      InOutText := 'OK';
      if Rslt and (Options.ItrShowLevel >= 4) then
        ShowTxt('>Event ' + sStr1 + ':' + sDvc + ' is set');
      Goto 99;
    end;
    if sCmd = 'DSESET' then // Command for event fire of the device state change
    begin
      found := true;
      Rslt := false;
      if SeparParams <> 3 then
        exit;
      ij := FullEventList.IndexOf(sStr1 + ':' + sDvc);
      bb := (ij > -1);
      if bb then
        FMyEvent := TMyEvent(FullEventList.Objects[ij])
      else
      begin
        FMyEvent := TMyEvent.Create;
        FullEventList.AddObject(sStr1 + ':' + sDvc, FMyEvent);
        FMyEvent.TheDevice := sDvc;
        FMyEvent.TheProc := sStr1;
      end;
      ij := DvcEventList.IndexOf(sDvc);
      bb := (ij > -1);
      if bb then
        DMyEvent := TMyEvent(DvcEventList.Objects[ij])
      else
      begin
        DMyEvent := TMyEvent.Create;
        DvcEventList.AddObject(sDvc, DMyEvent);
        DMyEvent.TheDevice := sDvc;
        DMyEvent.TheProc := '';
      end;
      Dvc.OnDvcStEvent := nil;
      val(sStr2, ij, k);
      if (k = 0) and (ij > 0) then
        MPtr(FMyEvent.FOnDvcStEvent).Adr := Ptr(ij)
      else
        Goto 99;
      val(sStr3, ij, k);
      if (k = 0) and (ij > 0) then
        MPtr(FMyEvent.FOnDvcStEvent).Cls := Ptr(ij)
      else
        Goto 99;
      Dvc.OnDvcStEvent := DMyEvent.DvcStEvent;
      Rslt := true;
      InOutText := 'OK';
      if Rslt and (Options.ItrShowLevel >= 4) then
        ShowTxt('>Event ' + sStr1 + ':' + sDvc + ' is set');
      Goto 99;
    end;
  end;
  // interpretation of Synchronization Device commands
  if sDvc = 'SNH' then
  begin
    if not frmDvcRack.MainSwitch then
    begin
      InOutText := 'The main switch is OFF';
      Rslt := false;
      found := true;
      goto 99;
    end;
    if sCmd = 'SDSOPN' then // Open Synchro data stream
    begin
      found := true;
      SeparParams;
      i := fmSynchro.OpnStm(true, sStr1, sStr2);
      Rslt := (i > 0);
      if Rslt then
        InOutText := IntToStr(i)
      else
        InOutText := 'Cannot open sync.data stream.';
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>Data stream #' + IntToStr(i) + ' opened');
      Goto 99;
    end;
    if sCmd = 'ADSOPN' then // Open Asynchro data stream
    begin
      found := true;
      SeparParams;
      i := fmSynchro.OpnStm(false, sStr1, sStr2);
      Rslt := (i > 0);
      if Rslt then
        InOutText := IntToStr(i)
      else
        InOutText := 'Cannot open async.data stream.';
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>Data stream #' + IntToStr(i) + ' opened');
      Goto 99;
    end;
    if sCmd = 'DSMGET' then // Get next data stream data
    begin
      found := true;
      SeparParams;
      i := -1;
      val(sStr1, i, j);
      if (j = 0) and (i in [1 .. 9]) then
        Rslt := fmSynchro.DSmGet(i);
      if Rslt then
        InOutText := IntToStr(i)
      else
        InOutText := 'Cannot get data stream.';
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>Next spec from data stream #' + IntToStr(i));
      Goto 99;
    end;
    if sCmd = 'DSMCLS' then // Close data stream
    begin
      found := true;
      SeparParams;
      i := -1;
      val(sStr1, i, j);
      if (j = 0) and (i in [1 .. 9]) then
        Rslt := fmSynchro.DSmCls(i);
      if Rslt then
        InOutText := IntToStr(i)
      else
        InOutText := 'Cannot close data stream.';
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>Data stream #' + IntToStr(i) + ' closed');
      Goto 99;
    end;
    if sCmd = 'MODSET' then // Set synchro mode
    begin
      found := true;
      Rslt := fmSynchro.ModSet(sStr);
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>Set synchro to ' + sStr + '.');
      Goto 99;
    end;
    if sCmd = 'MODGET' then // Get synchro mode
    begin
      found := true;
      InOutText := fmSynchro.ModGet;
      Rslt := true;
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>Synchro mode= ' + InOutText + '.');
      Goto 99;
    end;
    if sCmd = 'SNHGET' then // Get synchronization
    begin
      found := true;
      Rslt := fmSynchro.SnhGet(StrToInt(sStr));
      if Rslt then
        InOutText := 'OK'
      else
        InOutText := 'User abort !';
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>OK');
      Goto 99;
    end;
  end;
  // interpretation of commands to the interpreter kernel
  if sDvc = 'ITR' then
  begin
    if sCmd = 'SCRRUN' then // script run
    begin
      found := true;
      if (Options.ItrShowLevel >= 5) then
        ShowTxt('>Run ' + sStr);
      Rslt := RunScript(sStr);
      if Rslt then
      begin
        InOutText := 'OK';
        if Options.ItrShowLevel >= 5 then
          ShowTxt('>Successful exec.');
      end
      else
      begin
        InOutText := 'Problem in script';
        if Options.ItrShowLevel >= 5 then
          ShowTxt('>Unsuccessful exec.');
      end;
      Goto 99;
    end;
    if sCmd = 'LCKSET' then // Lock manual operation of main form
    begin
      found := true;
      frmDvcRack.Locked := (sStr = 'TRUE');

      if (Options.ItrShowLevel >= 5) then
      begin
        if frmDvcRack.Locked then
          ShowTxt('>Lock manual control.')
        else
          ShowTxt('>Unlock manual control.');
      end;
      Rslt := true;
      InOutText := 'OK';
      Goto 99;
    end;
    if sCmd = 'BUSGET' then // check busy
    begin
      found := true;
      InOutText := '';
      if fBusy then
        InOutText := 'TRUE'
      else
        InOutText := 'FALSE';
      Rslt := true;
      if (Options.ItrShowLevel >= 4) then
      begin
        if fBusy then
          ShowTxt('>The device rack is busy.')
        else
          ShowTxt('>The device rack is not busy.');
      end;
      Goto 99;
    end;
    if sCmd = 'BUSSET' then // set busy
    begin
      found := true;
      InOutText := '';
      bb := (sStr = 'TRUE');
      fBusy := bb;
      Rslt := (fBusy = bb);
      if Rslt then
      begin
        InOutText := 'OK';
        if (Options.ItrShowLevel >= 4) then
        begin
          if bb then
            ShowTxt('>The device rack is set to busy.')
          else
            ShowTxt('>The device rack is set to not-busy.');
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'ENBGET' then // check main switch
    begin
      found := true;
      InOutText := '';
      if frmDvcRack.MainSwitch then
        InOutText := 'TRUE'
      else
        InOutText := 'FALSE';
      Rslt := true;
      if (Options.ItrShowLevel >= 4) then
      begin
        if frmDvcRack.MainSwitch then
          ShowTxt('>The device rack is enabled.')
        else
          ShowTxt('>The device rack is disabled.');
      end;
      Goto 99;
    end;
    if sCmd = 'ENBSET' then // set main switch
    begin
      found := true;
      InOutText := '';
      bb := (sStr = 'TRUE');
      frmDvcRack.MainSwitch := bb;
      Rslt := (frmDvcRack.MainSwitch = bb);
      if Rslt then
      begin
        InOutText := 'OK';
        if (Options.ItrShowLevel >= 4) then
        begin
          if bb then
            ShowTxt('>The device rack is enabled.')
          else
            ShowTxt('>The device rack is disabled.');
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'DVRSET' then // set device rack  ON/OFF
    begin
      found := true;
      InOutText := '';
      bb := (sStr = 'TRUE');
      with frmDvcRack do
        if Enabled then
        begin
          MainSwitch := bb;
          Enabled := false;
        end
        else
          Enabled := true;
      Rslt := (frmDvcRack.Enabled = bb);
      frmSpion.mRefreshClick(nil);
      if Rslt then
      begin
        InOutText := 'OK';
        if (Options.ItrShowLevel >= 4) then
        begin
          if bb then
            ShowTxt('>The device rack is ON.')
          else
            ShowTxt('>The device rack is OFF.');
        end;
      end;
      Goto 99;
    end;
    if sCmd = 'SETLOD' then // Load new setting (options)
    begin
      found := true;
      Rslt := true;
      for k := low(allDvcs) to high(allDvcs) do
      begin
        ss := sStr;
        bb := allDvcs[k].SetLod(ss);
        if not bb then
          ShowTxt('>Error: ' + ss + ' in ' + allDvcs[k].Name);
        Rslt := Rslt and bb;
      end;
      InOutText := 'OK';
    end;
    if sCmd = 'SETSAV' then // Save the current setting (options)
    begin
      found := true;
      Rslt := true;
      for k := low(allDvcs) to high(allDvcs) do
      begin
        ss := sStr;
        bb := allDvcs[k].SetSav(ss);
        if not bb then
          ShowTxt('>Error: ' + ss + ' in ' + allDvcs[k].Name);
        Rslt := Rslt and bb;
      end;
      InOutText := 'OK';
    end;
    if sCmd = 'SHWSET' then // Allow/forbid (temporal) writing on script panel
    begin
      found := true; // for time critical parts of script
      Options.ItrExtVis := (UpperCase(sStr) = 'TRUE');
      // anything else in sStr disable the writing
      Rslt := true;
      if Options.ItrShowLevel >= 5 then
        ShowTxt('>OK');
      Goto 99;
    end;
    if sCmd = 'VERGET' then // Show version number
    begin
      found := true; //
      InOutText := '100';
      Rslt := true;
      if Options.ItrShowLevel >= 5 then
        ShowTxt('>v1.00');
      Goto 99;
    end;
    if sCmd = 'MSRGET' then // Show msr device list
    begin
      found := true; //
      InOutText := '';
      for i := high(msrDvcs) downto low(msrDvcs) do
        InOutText := InOutText + msrDvcs[i].Name + ',';
      Rslt := true;
      if Options.ItrShowLevel >= 5 then
        ShowTxt(InOutText);
      Goto 99;
    end;
    if sCmd = 'CTRGET' then // Show ctrl device list
    begin
      found := true; //
      InOutText := '';
      for i := high(ctrlDvcs) downto low(ctrlDvcs) do
        InOutText := InOutText + ctrlDvcs[i].Name + ',';
      Rslt := true;
      if Options.ItrShowLevel >= 5 then
        ShowTxt(InOutText);
      Goto 99;
    end;
  end;
  if copy(sDvc, 1, 2) = UpperCase(PlotAbrv) then // plots manipulation
  begin
    if sCmd = 'NEWSET' then
    begin
      found := true;
      j := Plots.Add(sStr);
      InOutText := IntToStr(j);
      Rslt := (j > -1);
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>OK');
    end;
    if sCmd = 'CLRALL' then
    begin
      found := true;
      Plots.Clear;
      Rslt := true;
      if Rslt then
        InOutText := 'OK';
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>OK');
    end;
    if sDvc[3] in ['1' .. '9', '#'] then
    begin
      if sDvc[3] = '#' then
        i := Plots.Active
      else
        i := CheckPlotSymbol(sDvc[3]) - 1;
    end
    else
    begin
      i := -1;
      goto 99;
    end;
    if Plots[i] = nil then
      goto 99;
    if sCmd = 'DELETE' then
    begin
      found := true;
      Rslt := Plots.delete(i);
      if Rslt then
        InOutText := 'OK';
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>OK');
    end;
    if sCmd = 'VIESET' then
    begin
      found := true;
      Rslt := true;
      case sStr[1] of
        'M':
          Plots[i].WhatVis := wvMass;
        'C':
          Plots[i].WhatVis := wvChrom;
        'B':
          Plots[i].WhatVis := wvBoth;
      else
        Rslt := false;
      end;
      if Rslt then
        InOutText := 'OK'
      else
        InOutText := 'Wrong param';
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>OK');
    end;
    if sCmd = 'FILOPN' then
    begin
      found := true;
      Rslt := Plots[i].OpenData(sStr);
      Plots.Active := i;
      if Rslt then
        InOutText := 'OK'
      else
        InOutText := 'Problem opening';
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>OK');
    end;
    if sCmd = 'FILSAV' then
    begin
      found := true;
      Rslt := Plots[i].SaveData(sStr);
      if Rslt then
        InOutText := 'OK'
      else
        InOutText := 'Problem saving';
      if Rslt and (Options.ItrShowLevel >= 5) then
        ShowTxt('>OK');
    end;
  end;
  if sDvc = '//' then
  begin
    found := true;
    Rslt := true; // Comments
  end;
99:
  if not(found) then
  begin
    InOutText := 'Unknown command.';
    Rslt := false;
  end;
  Result := Rslt;
  if InOutText = '' then
    if Rslt then
      InOutText := 'OK'
    else
      InOutText := 'ERROR';
  if not Rslt then
    ShowTxt('>Error:' + InOutText);
  if Assigned(frmCmdCentre.FOnCommandExe) then
    frmCmdCentre.FOnCommandExe(WideString(InText), WideString(InOutText));
end; { Interprt }

function InterprtD(InText: string): string;
// same as ExecV but simpler - no need to organize buff string
var
  ss: string;
begin
  ss := InText;
  Interprt(ss);
  Result := ss;
end; { InterprtD }

// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
procedure TfrmCmdCentre.SetPaged(Value: boolean);
begin
  fPaged := Value;
  Reshow;
end;

procedure TfrmCmdCentre.SetAlwaysVis(Value: boolean);
begin
  fAlwaysVis := Value;
  Visible := fAlwaysVis or fFillIn;
  if not fDocked and (frmCmdShell <> nil) then
    frmCmdShell.Visible := Visible;
  Reshow;
end;

procedure TfrmCmdCentre.SetDocked(Value: boolean);
begin
  fDocked := Value;
  Reshow;
end;

procedure TfrmCmdCentre.SetLeftAlign(Value: boolean);
begin
  fLeftAlign := Value;
  Reshow;
end;

constructor TfrmCmdCentre.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DvcEventList := TStringList.Create;
  FullEventList := TStringList.Create;
  // ProcInPlace:= pnlProc;
end;

procedure TfrmCmdCentre.Reshow;
var
  i: Integer;
begin
  if not Visible then
    exit;
  if fDocked then
  begin
    if fLeftAlign then
      Align := alLeft
    else
      Align := alRight;
    Parent := Application.MainForm;
    frmCmdShell.Hide;
    if fFillIn then
      ClientWidth := ProcInPlace.Width + 3
    else
      ClientWidth := DefWidth;
    { if Resizable then
      if fPaged then pnlProc.Height:= }
  end
  else
  begin
    Parent := frmCmdShell;
    frmCmdShell.Show;
    Align := alClient;
    if fFillIn then
      frmCmdShell.ClientWidth := ProcInPlace.Width
    else
      frmCmdShell.ClientWidth := DefWidth;
  end;

  Splitter1.Visible := not fPaged;
  pnlProc.Visible := fFillIn;
  pcCmdCentre.Visible := fPaged;
  if fPaged then
  begin
    pnlScript.Parent := tsScript;
    tsProc.TabVisible := fFillIn;
    if fFillIn then
    begin
      pnlProc.Parent := tsProc;
      pnlProc.Align := alClient;
      pcCmdCentre.ActivePage := tsProc;
    end
    else
      pcCmdCentre.ActivePage := tsScript;
    if ProcInPlace <> nil then
      if ProcInPlace.Resizable then
        ProcInPlace.Height := pnlProc.Height;
  end
  else
  begin // Tiled
    pnlScript.Parent := self;
    pnlScript.Visible := true;
    pnlScript.BringToFront;
    if ProcInPlace <> nil then
      if ProcInPlace.Resizable then
        ProcInPlace.Height := Height - 250;
    if fFillIn then
    begin
      pnlProc.Align := alTop;
      pnlProc.Parent := self;
      pnlProc.Height := ProcInPlace.Height;
    end;
    Splitter1.Top := pnlProc.Height;
  end;
end; { TfrmCmdCentre.Reshow }

destructor TfrmCmdCentre.Destroy;
var
  i, j: Integer;
  fmProc: TfmProc;
begin
  for i := 0 to Procs.Count - 1 do
    FreeAndNil(TfmProc(Procs.Objects[i]).Ini);
  FreeAndNil(Procs);
  inherited;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmCmdCentre.tbRunClick(Sender: TObject);
var
  ss: string;
begin
  ss := eCommand.Text;
  if eCommand.Items.Count > 0 then
    eCommand.Items.Insert(0, ss)
  else
    eCommand.Items.Add(ss);
  if Interprt(ss) then
    eCommand.Text := '';
end;

procedure TfrmCmdCentre.eCommandKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    tbRunClick(nil);
  end;
end;

procedure TfrmCmdCentre.tbOpenClick(Sender: TObject);
begin
  OpenDialog1.InitialDir := RootPath + ScriptPath;
  if OpenDialog1.Execute then
    RunScript(OpenDialog1.Filename);
end;

procedure TfrmCmdCentre.tbPasteClick(Sender: TObject);
var
  wl: TStrings;
begin
  if not Clipboard.HasFormat(CF_TEXT) then
  begin
    MessageDlg('There is no text on the Clipboard', mtInformation, [mbOK], 0);
    exit;
  end;
  wl := TStringList.Create;
  wl.Text := Clipboard.AsText;
  wl.SaveToFile(RootPath + ScriptPath + 'temp.scr');
  wl.Free;
  RunScript(RootPath + ScriptPath + 'temp.scr');
end;

procedure TfrmCmdCentre.tbSaveAsScriptClick(Sender: TObject);
var
  wl: TStrings;
  i: Integer;
begin
  SaveDialog1.InitialDir := RootPath + ScriptPath;
  if SaveDialog1.Execute then
  begin
    wl := TStringList.Create;
    for i := 0 to rtScript.Lines.Count - 1 do
      if rtScript.Lines[i][1] <> '>' then
        wl.Add(rtScript.Lines[i]);
    wl.SaveToFile(SaveDialog1.Filename);
    wl.Free;
  end;
end;

procedure TfrmCmdCentre.tbCopyToClipboardClick(Sender: TObject);
begin
  rtScript.CopyToClipboard;
end;

procedure TfrmCmdCentre.Splitter1Moved(Sender: TObject);
begin
  ProcInPlace.Height := pnlProc.Height;
end;

procedure TfrmCmdCentre.tbClearClick(Sender: TObject);
begin
  rtScript.Lines.Clear;
end;

procedure TfrmCmdCentre.eCommandEnter(Sender: TObject);
begin
  if eCommand.Text = 'Command' then
    eCommand.Text := '';
end;

procedure TfrmCmdCentre.tbHelpClick(Sender: TObject);
begin
  Application.HelpContext(4000);
end;

/// // P R O C E D U R E S ///////////////////////////////////////
procedure TfrmCmdCentre.bbProcCancelClick(Sender: TObject);
begin
  FreeProc;
end;

procedure TfrmCmdCentre.bbProcHelpClick(Sender: TObject);
begin
  if not(Sender is TBitBtn) then
    exit;
  if (Sender as TBitBtn).Tag = 0 then
    Application.HelpContext(1000)
  else
    Application.HelpContext((Sender as TBitBtn).Tag);
end;

procedure TfrmCmdCentre.HomeProc(WProc: TfmProc);
begin
  if fFillIn and (ProcInPlace <> WProc) then
    FreeProc;
  ProcInPlace := WProc;
  ProcInPlace.Parent := pnlProc;
  ProcInPlace.Visible := true;
  Visible := true;
  fFillIn := true;
  if not fDocked and (frmCmdShell <> nil) then
    frmCmdShell.Visible := Visible;
  Reshow;
  Application.ProcessMessages;
end;

procedure TfrmCmdCentre.FreeProc;
begin
  fFillIn := false;
  Visible := fAlwaysVis;
  if Assigned(ProcInPlace) then
  begin
    if Assigned(ProcInPlace.OnFreeProc) then
      ProcInPlace.OnFreeProc(ProcInPlace);
    ProcInPlace.Visible := false;
    ProcInPlace.Parent := nil;
  end;
  if not fDocked and (frmCmdShell <> nil) then
    frmCmdShell.Visible := Visible;
  Reshow;
  if not Docked then
    frmSpion.mRefreshClick(nil);
end;

procedure TfrmCmdCentre.RegProcs;
  function RegLast: Integer;
  var
    l: Integer;
    fmProc: TfmProc;
  begin
    l := Procs.Count - 1;
    fmProc := TfmProc(Procs.Objects[l]);
    fmProc.Name := 'fm' + Procs[l];
    fmProc.Resizable := false;
    fmProc.sbClose.OnClick := bbProcCancelClick;
    fmProc.bbHelp.OnClick := bbProcHelpClick;
    Result := l;
  end;

var
  i, j: Integer;
begin
  Procs := TStringList.Create;
  Procs.AddObject('UniScan', TfmUniScan.Create(self));        RegLast;
  Procs.AddObject('SimpleScan', TfmSimpleScan.Create(self));  RegLast;
  Procs.AddObject('AutoTune', TfmAutoTune.Create(self));      RegLast;
  Procs.AddObject('SmartCopy', TfmSmartCopy.Create(self));    RegLast;
  Procs.AddObject('PCAclass', TfmPCAproc.Create(self));       RegLast;
end; { TfrmCmdCentre.RegProcs }

procedure CallProc(ProcName: string; AutoRun, ShowUp: boolean;
  var InOut: string);
var
  i, j, k: Integer;
  fmProc: TfmProc;
  fn: string;
  ls, ml: TStrings;
begin
  for i := 0 to Procs.Count - 1 do
    if SameText(Procs[i], ProcName) then
    begin
      fmProc := TfmProc(Procs.Objects[i]);
      if not AutoRun and not ShowUp then
        frmCmdCentre.FreeProc
      else
      begin
        if ShowUp then
          frmCmdCentre.HomeProc(fmProc);
        if copy(InOut, 1, 7) = 'file:\\' then
        begin
          fn := copy(InOut, 8, 255); // from ext. file
          FreeAndNil(fmProc.Ini);
          if FileExists(fn) then
            fmProc.Ini := TMemIniFile.Create(fn);
          fmProc.LoadOPt;
        end
        else
        begin
          if not Assigned(fmProc.Ini) then
            fmProc.LoadOPt; // load defaults
          if (InOut <> '') and Assigned(fmProc.Ini) then
          begin
            ls := TStringList.Create;
            ml := TStringList.Create;
            ls.Text := InOut;
            fmProc.Ini.GetStrings(ml);
            for j := 0 to ls.Count - 1 do
              for k := 0 to ml.Count - 1 do
                if SameText(ls.Names[j], ml.Names[k]) then
                  ml.Values[ml.Names[k]] := ls.Values[ls.Names[j]];
            ls.Free;
            fmProc.Ini.SetStrings(ml);
            ml.Free;
            fmProc.LoadOPt;
          end;
        end;
        InterprtD('// ' + ProcName + ' ' + BoolToStr(AutoRun) + '  ' + InOut);
        fmProc.Execute(AutoRun, ShowUp, InOut);
      end;
    end;
end; { CallProc }

end.
