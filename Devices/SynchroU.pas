unit SynchroU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, DataStreamU, MsrDeviceU, PlotU, StdCtrls, Spin, TeEngine,
  ImgList, SpecU;

const NDataStm = 9;

type
  tShnMode = (sPass, sDly, sExt, sBtn);


  TfmSynchro = class(TFrame)
    pnlDCh0: TPanel;
    sbPause: TSpeedButton;
    bAbort: TSpeedButton;
    cbMode: TComboBox;
    sbShoot: TSpeedButton;
    eNumber: TEdit;
    procedure cbModeChange(Sender: TObject);
    procedure bAbortClick(Sender: TObject);
    procedure sbShootClick(Sender: TObject);
    procedure eNumberValueChanged(Sender: TObject);
  private
    { Private declarations }
    Dly: integer;
    ExtN: integer;
    PauseClick, ShootClick, ExtEvent: boolean;
  public
    { Public declarations }
    ShnMode: tShnMode;
    AbortClick: boolean;
    DataStm: array [1 .. NDataStm] of TfmDataStm;
    // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    // set synchro mode
    function ModSet(mode: string): boolean;

    // get current synchro mode
    function ModGet: string;

    // synchronization itself; from script - SnhGet(0)
    function Done: boolean;

    // set synchro and Done
    function SnhGet(md: integer): boolean;

    // open data stream
    function OpnStm(Sn: boolean; smDvc, sPlot: string): integer;
    // if wPlot=nil then create one
    function DSmGet(idx: integer): boolean;

    function DSmCls(idx: integer): boolean;
    // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    function OpenStream(Schr: boolean; mDvc: TmsrDevice;
      wPlot: TfrmPlot): integer;
    // if wPlot=nil then create one
    procedure OpenCloseEvent(Sender: TObject);
    constructor Create(AOwner: TComponent); override;
  end;

var
  fmSynchro: TfmSynchro;

implementation

{$R *.DFM}

uses DvcRackU, PlotCollectU, SpOptU, AboutU;

function TfmSynchro.ModSet(mode: string): boolean;
// mode='Pas' return synchronization unconditionally eqv. to Dly=0
// mode='Dly=#' return synchro after # [ms]
// mode='Ext[=#]' return synchro after event number # happened,
// if '=#' is omitted then last used event is used
// mode='Btn' return synchro after pressing the synchro button
var
  ss, sm, sv: string;
  i, j: integer;
begin
  Result := false;
  ss := UpperCase(trim(mode));
  sm := Copy(ss, 1, 3);
  if sm = 'PAS' then
  begin
    ShnMode := sPass;
    cbMode.ItemIndex := 0;
    eNumber.Visible := false;
    Result := true;
  end;
  if sm = 'DLY' then
  begin
    sv := Copy(ss, 5, 255);
    val(sv, i, j);
    if j = 0 then
      Dly := i
    else
      exit;
    ShnMode := sDly;
    cbMode.ItemIndex := 1;
    eNumber.Visible := true;
    eNumber.Text := IntToStr(Dly);
    eNumber.SetFocus;
    Result := true;
  end;
  if sm = 'EXT' then
  begin
    sv := Copy(ss, 5, 255);
    if sv <> '' then
    begin
      sv := Copy(ss, 5, 255);
      val(sv, i, j);
      if j = 0 then
        ExtN := i
      else
        exit;
    end;
    ShnMode := sExt;
    cbMode.ItemIndex := 2;
    eNumber.Visible := true;
    eNumber.Text := IntToStr(ExtN);
    eNumber.SetFocus;
    Result := true;
  end;
  if sm = 'BTN' then
  begin
    ShnMode := sBtn;
    cbMode.ItemIndex := 3;
    eNumber.Visible := false;
    Result := true;
  end;
  if Visible then
  begin
    sbShoot.Visible := (ShnMode = sBtn);
    sbPause.Visible := not sbShoot.Visible;
  end;
  sbPause.Down := false;
end; { SnhDevF.ModSet }

function TfmSynchro.ModGet: string;
// Return currently active mode expl.above
begin
  case ShnMode of
    sPass:
      ModGet := 'Pas';
    sDly:
      ModGet := 'Dly=' + IntToStr(Dly);
    sExt:
      ModGet := 'Ext=' + IntToStr(ExtN);
    sBtn:
      ModGet := 'Btn';
  end;
end; { SnhDevF.ModGet }

function TfmSynchro.Done: boolean;
// return true after sinchronization event
// returns false on user abort
begin
  Done := true;

  repeat
    Application.ProcessMessages;
  until (not sbPause.Down);

  case ShnMode of
    sDly:
      Delay(Dly);
    sBtn:
      begin // waiting for button click
        ShootClick := false;
        repeat
          Delay(50);
          if CanFocus then
            SetFocus;
        until (ShootClick or AbortClick or Application.Terminated);
      end;
    sExt:
      begin // waiting for ext. event
        ExtEvent := false;
        // this flag must be turned on from the external event
        repeat
          Delay(50);
          if CanFocus then
            SetFocus;
        until (ExtEvent or AbortClick or Application.Terminated);
      end;
  end;
  Result := not(AbortClick);
  AbortClick := false;
end; { TSnhDevF.Done }

function TfmSynchro.SnhGet(md: integer): boolean;
// return true after sinchronization event
// returns false on user abort
// same as done + md setting (see below)
begin
  // md<0 sinchro with event #md
  if md < 0 then
    ModSet('Ext=' + IntToStr(-md));
  // md>0 sinchro after md [ms]
  if md > 0 then
    ModSet('Dly=' + IntToStr(md));
  Result := Done;
end; { TSnhDvcF.SnhGet }

// D A T A   S T R E A M ==============================================
function TfmSynchro.OpnStm(Sn: boolean; smDvc, sPlot: string): integer;
var
  wPlot: TfrmPlot;
  i: byte;
begin
  Result := 0;
  if sPlot = '' then
    wPlot := nil
  else
  begin
    if Copy(sPlot, 1, 2) <> UpperCase(PlotAbrv) then
      exit;
    i := CheckPlotSymbol(sPlot[3]) - 1;
  end;
  Result := OpenStream(Sn, MDByName(smDvc), Plots[i]);
end;

function TfmSynchro.DSmGet(idx: integer): boolean;
begin
  Result := false;
  if fmSynchro.DataStm[idx].Enabled then
    Result := fmSynchro.DataStm[idx].GetData;
end;

function TfmSynchro.DSmCls(idx: integer): boolean;
begin
  fmSynchro.DataStm[idx].Close;
  Result := not fmSynchro.DataStm[idx].Enabled;
end;

function TfmSynchro.OpenStream(Schr: boolean; mDvc: TmsrDevice;
  wPlot: TfrmPlot): integer;
var
  i: integer;
  bb: boolean;
  plot1: TfrmPlot;
begin
  Result := 0;
  for i := 1 to NDataStm do
    if not DataStm[i].Enabled then
      with DataStm[i] do
      begin
        plot1 := wPlot;
        if not Open(Schr, i, mDvc, plot1) then
          exit;
        Result := i;
        SelfSynchro := Schr;
        if plot1 <> nil then
          plot1.DataStmN := i;
        break;
      end;
end;

procedure TfmSynchro.OpenCloseEvent(Sender: TObject);
var i,h: integer;
begin
  h:= 31; //pnlDCh0.Height;
  for i:= 1 to NDataStm do
    if DataStm[i].Visible then
       h:= h+DataStm[i].Height;
  Height:= h;
end;
/// ////////////////////  V I S U A L ////////////////////////////////////////////

constructor TfmSynchro.Create(AOwner: TComponent);
var
  i: byte;
begin
  inherited Create(AOwner);
  AbortClick := false;
  for i := 1 to NDataStm do
  begin
    DataStm[i] := TfmDataStm.Create(AOwner);
    DataStm[i].Name := 'DataSmt_' + IntToStr(i);
    DataStm[i].Parent := self;
    DataStm[i].Top := pnlDCh0.Top + pnlDCh0.Height + 5;
    DataStm[i].Visible := false;
    DataStm[i].Enabled := false;
    DataStm[i].OpenCloseEvent:= OpenCloseEvent;
  end;
end;

procedure TfmSynchro.cbModeChange(Sender: TObject);
begin
  case cbMode.ItemIndex of
    0: ModSet('PAS');
    1: ModSet('DLY=100');
    2: ModSet('EXT=1');
    3: ModSet('BTN');
  end;
end;

procedure TfmSynchro.bAbortClick(Sender: TObject);
begin
  AbortClick := true;
end;

procedure TfmSynchro.sbShootClick(Sender: TObject);
begin
  ShootClick := true;
end;

procedure TfmSynchro.eNumberValueChanged(Sender: TObject);
var
  i, j: integer;
begin
  val(eNumber.Text, i, j);
  if j <> 0 then
    exit;
  case cbMode.ItemIndex of
    1: Dly := i;
    2: ExtN := i;
  end;
end;

end.
