unit SCopyU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProcU, StdCtrls, ComCtrls, ExtCtrls, Grids, ImgList, ToolWin,
  Vcl.Buttons, BMDSpinEdit, Vcl.Samples.Spin;

type
  TfmSmartCopy = class(TfmProc)
    PageControl1: TPageControl;
    tsZapping: TTabSheet;
    tsRecalc: TTabSheet;
    chkNewPlot: TCheckBox;
    tsMSP: TTabSheet;
    sgMSPheader: TStringGrid;
    ToolBar1: TToolBar;
    tbAddTo: TToolButton;
    tbClear: TToolButton;
    ImageList1: TImageList;
    SaveDialog1: TSaveDialog;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    chkChrom: TCheckBox;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    chkSynchroChrom: TCheckBox;
    btnDoIt: TButton;
    chkSynchroMS: TCheckBox;
    rgChromRecalc: TRadioGroup;
    rgMSRecalc: TRadioGroup;
    rgMassSpec: TRadioGroup;
    Label4: TLabel;
    Label5: TLabel;
    neMassShift: TBMDSpinEdit;
    neMinMass: TSpinEdit;
    neMaxMass: TSpinEdit;
    procedure bbRunClick(Sender: TObject);
    procedure tsMSPShow(Sender: TObject);
    procedure tbAddToClick(Sender: TObject);
    procedure chkSynchroChromClick(Sender: TObject);
    procedure btnDoItClick(Sender: TObject);
    procedure rgChromRecalcClick(Sender: TObject);
  private
    { Private declarations }
    procedure Zapping;
    procedure RecalcSp;
    procedure MSPexport;
  public
    { Public declarations }
    procedure Execute(AutoRun, ShowUp: boolean; var InOut: string); override;
  end;

implementation
{$R *.dfm}
uses CmdCentreU, SpionU, PlotU, PlotCollectU, DvcRackU, SynchroU, OptionsU,
SpecU, SpMathU, AboutU;

procedure TfmSmartCopy.Execute(AutoRun, ShowUp: boolean; var InOut: string);
begin if AutoRun then bbRunClick(nil);
end;

procedure TfmSmartCopy.bbRunClick(Sender: TObject);
var i,j: integer;
begin if plots.count=0 then exit;
case PageControl1.ActivePageIndex of
   0: Zapping;
   1: RecalcSp;
   2: MSPexport;
   end;
end;

procedure TfmSmartCopy.Zapping;
var i,j,c,k,m,c1,c2: integer; ss: string; m1,m2,shift: double; wXY: tXYarray;
begin i:= plots.Active; if Plots[i].IsEmpty then exit;
j:= Plots.Add(''); if (j=-1) then exit; Plots[j].Clear;
Plots[j].Spec.AutoRefresh:= false; shift:= neMassShift.Value;
case rgMassSpec.ItemIndex of
   0:begin m1:= 0; m2:= 1e6;
     end;
   1:begin m1:= Plots[i].chrMass.chrChart.BottomAxis.Minimum;
     m2:= Plots[i].chrMass.chrChart.BottomAxis.Maximum;
     end;
   2:begin m1:= neMinMass.Value; m2:= neMaxMass.Value;
     end;
   end;
if Plots[i].MassOnly
  then begin wXY:= Plots[i].Spec.CMass; Plots[j].MassOnly:= true;
  for m:=0 to length(wXY)-1 do
      if (wXY[m,X]>=m1) and (wXY[m,X]<=m2) then
         Plots[j].Spec.AddMass(wXY[m,X]+shift,wXY[m,Y],0);
  end
  else begin
  if chkChrom.Checked
    then begin c1:= Plots[i].chrChrom.srsSpec.FirstValueIndex;
    c2:= Plots[i].chrChrom.srsSpec.LastValueIndex;
    end
    else begin c1:= 0; c2:= Plots[i].chrChrom.srsSpec.Count-1;
    end; m:= 0;
  for c:=c1 to c2 do
    begin SetLength(wXY,0);
    k:= Plots[j].Spec.AddSSpec(Plots[i].Spec.Chrom[c,X],Plots[i].Spec.Chrom[c,Y],wXY);
    wXY:= Plots[i].Spec.Mass[c];
    for m:=0 to length(wXY)-1 do
        if (wXY[m,X]>=m1) and (wXY[m,X]<=m2) then
           Plots[j].Spec.AddMass(wXY[m,X]+shift,wXY[m,Y],k);
    end;
  end;
Plots[j].Spec.AutoRefresh:= true;
Plots[j].SetIniPos;
end; { TfmSmartCopy.bbRunClick }

procedure TfmSmartCopy.MSPexport;
var wXY: tXYarray; tMSP:TextFile; fn: string;
var i, SpecLng:Integer;
begin if IsActPlotEmpty then exit;
  if sgMSPheader.Cells[0, 1]='' then
    begin
      ErrorMsg('A Name must be specified');
      exit;
    end;
  SaveDialog1.InitialDir:= RootPath+DataPath;
  if not SaveDialog1.Execute then exit;
  fn:= SaveDialog1.FileName;
  ToNomMass(ActivePlot.CMass,wXY);

  // Get Real Length
  SpecLng:=0;
  for i:=0 to Length(wXY)-1 do
    if wXY[i][Y]<>0 then
      Inc(SpecLng);
  AssignFile(tMSP, fn);
  if FileExists(fn) then Append(tMSP)
                    else Rewrite(tMSP);
  WriteLn(tMSP, 'Name: '+sgMSPheader.Cells[1,1]);
  WriteLn(tMSP, 'Formula: '+sgMSPheader.Cells[1,2]);
  WriteLn(tMSP, 'CAS#: '+sgMSPheader.Cells[1,3]);
  WriteLn(tMSP, 'EPA#: '+sgMSPheader.Cells[1,4]);
  WriteLn(tMSP, 'DB#: '+sgMSPheader.Cells[1,5]);
  WriteLn(tMSP, 'Num Peaks: '+IntToStr(SpecLng));
  for i:=0 to Length(wXY)-1 do
    begin
      if wXY[i][Y]<>0 then
        WriteLn(tMSP, FloatToStr(wXY[i][X])+' '+FloatToStr(wXY[i][Y])+';');
    end;
  Flush(tMSP);
  CloseFile(tMSP);
end;

procedure TfmSmartCopy.tsMSPShow(Sender: TObject);
begin
  inherited;
  sgMSPheader.Cells[0, 0]:='Field';     sgMSPheader.Cells[1, 0]:='Value';
  sgMSPheader.Cells[0, 1]:='Name';      sgMSPheader.Cells[1, 1]:= '';
  sgMSPheader.Cells[0, 2]:='Formula';   sgMSPheader.Cells[1, 2]:= '';
  sgMSPheader.Cells[0, 3]:='CAS Number';sgMSPheader.Cells[1, 3]:= '';
  sgMSPheader.Cells[0, 4]:='EPA Number';sgMSPheader.Cells[1, 4]:= '';
  sgMSPheader.Cells[0, 5]:='DB Number'; sgMSPheader.Cells[1, 5]:= '';
end;

procedure TfmSmartCopy.tbAddToClick(Sender: TObject);
begin inherited; MSPexport;
end;

procedure TfmSmartCopy.chkSynchroChromClick(Sender: TObject);
begin inherited;
btnDoIt.Enabled:= (chkSynchroChrom.Checked or chkSynchroMS.Checked)
                  and (Plots.Count>1);
end;

procedure TfmSmartCopy.btnDoItClick(Sender: TObject);
var i,j: integer; mi,ma: double;
begin inherited;
if chkSynchroChrom.Checked and not ActivePlot.MassOnly then
   begin mi:= ActivePlot.chrChrom.chrChart.BottomAxis.Minimum;
   ma:= ActivePlot.chrChrom.chrChart.BottomAxis.Maximum;
   for i:=0 to Plots.Count-1 do
       if (i<>Plots.Active) and not Plots[i].MassOnly then
          begin Plots[i].chrChrom.chrChart.BottomAxis.SetMinMax(mi,ma);
          Plots[i].chrChrom.tbAutoY.Click;
          end;
   end;
if chkSynchroMS.Checked then
   begin mi:= ActivePlot.chrMass.chrChart.BottomAxis.Minimum;
   ma:= ActivePlot.chrMass.chrChart.BottomAxis.Maximum;
   for i:=0 to Plots.Count-1 do
       if i<>Plots.Active then
          begin Plots[i].chrMass.chrChart.BottomAxis.SetMinMax(mi,ma);
          Plots[i].chrMass.tbAutoY.Click;
          end;
   end;
end;  { TfmSmartCopy.btnDoItClick }

procedure TfmSmartCopy.rgChromRecalcClick(Sender: TObject);
begin inherited;
if rgChromRecalc.ItemIndex=1 then rgMSRecalc.ItemIndex:= 0;
rgMSRecalc.Enabled:= (rgChromRecalc.ItemIndex<>1);
end;

procedure TfmSmartCopy.RecalcSp;
var i,j,k: integer; a,b,c: single; wXY: tXYarray;

procedure NextSpec(k: integer);
var m: integer;
begin
case rgMSRecalc.ItemIndex of
  0:if k>-1 then Plots[j].AddArrSpec(Plots[i].Spec.Chrom[k,X],Plots[i].Spec.Mass[k])
            else Plots[j].AddArrSpec(0,Plots[i].Spec.CMass);
  1:begin if k>-1 then Plots[i].ShowSMass(k);
    if not Plots[i].SpOpt.oMass.Peak.Enabled then Plots[i].actPeaksMassExecute(nil);
    with Plots[i].chrMass.Peaks do
      begin SetLength(wXY,Count);
      for m:=0 to Count-1 do
          begin wXY[m][X]:= Items[m].X; wXY[m][Y]:= Items[m].Y;
          end;
      if k>-1 then Plots[j].AddArrSpec(Plots[i].Spec.Chrom[k,X],wXY)
              else Plots[j].AddArrSpec(0,wXY);
      end;
    end;
  2:begin
    if k>-1 then ToNomMass(Plots[i].Spec.Mass[k],wXY)
            else ToNomMass(Plots[i].Spec.CMass,wXY);
    if k>-1 then Plots[j].AddArrSpec(Plots[i].Spec.Chrom[k,X],wXY)
            else Plots[j].AddArrSpec(0,wXY);
    end;
  3:begin
    if k>-1 then IntEquidistant(Plots[i].Spec.Mass[k],wXY)
            else IntEquidistant(Plots[i].Spec.CMass,wXY);
    if k>-1 then Plots[j].AddArrSpec(Plots[i].Spec.Chrom[k,X],wXY)
            else Plots[j].AddArrSpec(0,wXY);
    end;
  end;  { case }
SetLength(wXY,0);
end;

begin i:= plots.Active; if Plots[i].IsEmpty then exit;
j:= Plots.Add(''); if (j=-1) then exit;
if rgChromRecalc.ItemIndex<>1
  then begin Plots[j].MassOnly:= (rgChromRecalc.ItemIndex=2) or (Plots[i].MassOnly);
  if Plots[j].MassOnly
     then NextSpec(-1)
     else for k:=0 to Plots[i].Spec.NSpec-1 do NextSpec(k);
  end
  else begin // S/N ratio
  with Plots[i].Spec do
  for k:=0 to NSpec-1 do
      Plots[j].Spec.AddSSpec(Chrom[k,X],SNratio(Mass[k])*100,Mass[k]);
  Plots[j].RefreshPlot; 
  end;
Plots[j].SetIniPos;
end;  { TfmSmartCopy.RecalcSp }

end.
