unit SimpleScanU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProcU, Spin, StdCtrls, ExtCtrls, IniFiles, Vcl.Buttons, Vcl.Mask,
  BMDSpinEdit;

type
  TfmSimpleScan = class(TfmProc)
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    lbDim: TLabel;
    cbCtrlDvc: TComboBox;
    cbUnits: TComboBox;
    GroupBox2: TGroupBox;
    Label12: TLabel;
    cbMsrDvc: TComboBox;
    seChn: TSpinEdit;
    Button1: TButton;
    eFrom: TBMDSpinEdit;
    eTo: TBMDSpinEdit;
    eStep: TBMDSpinEdit;
    nsChn: TSpinEdit;
    procedure nsChnChange(Sender: TObject);
    procedure bbRunClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CDScan: tCDScan;
    MDScan: tMDScan;
    // procedure LoadOpt; override;
    procedure Execute(AutoRun, ShowUp: boolean; var InOut: string); override;
  published
    procedure SEvent(Dvc, Msg: string); // must be published
    procedure DCEvent(Dvc: string; OldSt, NewSt: Integer; Msg: string);
  end;

var
  fmSimpleScan: TfmSimpleScan;

implementation

{$R *.dfm}

uses DvcRackU, CmdCentreU, PlotCollectU, OptionsU, DeviceU;

procedure TfmSimpleScan.Execute(AutoRun, ShowUp: boolean; var InOut: string);
begin
  cbUnits.ItemIndex := 0;
  DvcList(cbCtrlDvc.Items,dkCtrl);
  cbCtrlDvc.Items.Add('<none>');
  cbCtrlDvc.ItemIndex := 0;
  DvcList(cbMsrDvc.Items,dkMsr);
  cbMsrDvc.ItemIndex := 0;
end;

{ procedure TfmSimpleScan.LoadOpt;
  begin inherited;
  Ini:= TMemIniFile.Create('SScan.ini');
  end; }

procedure TfmSimpleScan.nsChnChange(Sender: TObject);
begin
  inherited;
//  lbDim.Caption := InterprtD(cbCtrlDvc.Text + '.DimGet(' +
//    IntToStr(nsChn.Value) + ')');
end;

procedure TfmSimpleScan.bbRunClick(Sender: TObject);
// run simple scan with set beforehand parameters
var
  c, r: real;
  i, j, k: Integer;
  ch: char;
  ss, st: string;
  bb: boolean;
begin
  inherited;
  Enabled := false;
  try
    if not sbRun.Down then exit;
    with CDScan do
    begin
      DName := cbCtrlDvc.Text;
      AbsUnits := (cbUnits.ItemIndex = 0);
      Start := eFrom.Value;
      Finish := eTo.Value;
      Step := eStep.Value;
      if Step = 0 then
        exit;
      if Start > Finish then
        Step := -abs(Step);
    end;
    with MDScan do
    begin
      DName := cbMsrDvc.Text;
      Channel := seChn.Value;
      MultiChannel := false;
    end;
    ss := MDScan.DName + '.EnbGet';
    Interprt(ss);
    if ss = 'FALSE' then
      exit;
    if CDScan.DName <> '<none>' then
    begin
      ss := CDScan.DName + '.EnbGet';
      Interprt(ss);
      if ss = 'FALSE' then
        exit;
    end;
    j := Plots.Add(Options.Templates[3]);
    if j = -1 then
      exit;
    Plots[j].Clear;
    Plots[j].MassOnly := true;
    Plots[j].AcqMode := true;
    InterprtD('Itr.LckSet(TRUE)');
    if CDScan.AbsUnits then
      ch := 'A'
    else
      ch := 'R';
    c := CDScan.Start; // current position
    //InterprtD(CDScan.DName + '.DftSet(' + IntToStr(nsChn.Value) + ')');
    repeat // the scan
      if CDScan.DName <> '<none>' then
      begin
        InterprtD(CDScan.DName + '.' + ch + 'JpSet(' + FloatToStr(c) + ','+IntToStr(nsChn.Value)+')');
      end;

      st := 'Snh.SnhGet(0)';
      bb := Interprt(st);
      //
      { ss:= MDScan.DName+'.SpcGet(4)'; Interprt(ss);
        Plots[j].AddArrSpec(c,buffXY);
        Plots[j].Spec.SaveFile('tq'+IntToStr(round(c))+'.txt'); }

      ss := MDScan.DName + '.ChnGet('+IntToStr(seChn.Value)+')';
      Interprt(ss);
      val(ss, r, k);
      with Plots[j] do
        if k = 0 then
          Spec.AddMass(c, r, 0);
      //
      Plots[j].RefreshPlot;
      c := c + CDScan.Step;
    until (st = 'User abort !') or Application.Terminated or (not sbRun.Down) or
      (c > CDScan.Finish);
    InterprtD('Itr.LckSet(FALSE)');
    Plots[j].AcqMode := false;
  finally
    Enabled := true; sbRun.Down := false;
  end;
end;

procedure TfmSimpleScan.SEvent(Dvc, Msg: string);
begin
  Label12.Caption := Dvc;
  seChn.Value := seChn.Value + 1;
end;

procedure TfmSimpleScan.DCEvent(Dvc: string; OldSt, NewSt: Integer; Msg: string);
begin
  Label12.Caption := Dvc;
  seChn.Value := seChn.Value - 1;
end;

procedure TfmSimpleScan.Button1Click(Sender: TObject);
var
  i, j: Integer;
  ss: string;
begin
  inherited;
  i := Integer(MethodAddress('SEvent'));  j := Integer(self);
  InterprtD('CT1.EvnSet(SimpleScan,' + IntToStr(i) + ',' + IntToStr(j) + ')');
  i := Integer(MethodAddress('DCEvent')); j := Integer(self);
  InterprtD('CT1.DSESet(SimpleScan,' + IntToStr(i) + ',' + IntToStr(j) + ')');
end;

end.
