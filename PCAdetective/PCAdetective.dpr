program PCAdetective;

uses
  Forms,
  PCAmainU in 'PCAmainU.pas' {frmPCAprep},
  vChartU in '..\PlotSp\vChartU.pas' {vChart: TFrame},
  PlotCollectU in '..\PlotSp\PlotCollectU.pas',
  SpOptU in '..\PlotSp\SpOptU.pas',
  PlotU in '..\PlotSp\PlotU.pas' {frmPlot: TFrame},
  SpecU in '..\PlotSp\SpecU.pas',
  DelphiDeclarations in '..\PlotSp\DelphiDeclarations.pas',
  AboutU in 'AboutU.pas' {AboutBox},
  PeakU in '..\PlotSp\PeakU.pas',
  HDIndexU in '..\PlotSp\HDIndexU.pas',
  HKProgressBr in '..\PlotSp\HKProgressBr\HKProgressBr.pas' {ProgressForm},
  SpMathU in '..\PlotSp\SpMathU.pas',
  ProcU in '..\Procs\ProcU.pas' {fmProc: TFrame},
  PCAprocU in '..\Procs\PCAprocU.pas' {fmPCAproc: TFrame},
  DirPickU in 'DirPickU.pas' {frmDirPicker},
  TrainingU in '..\Procs\TrainingU.pas' {frmOpts};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'PCAprep';
  Application.CreateForm(TfrmPCAprep, frmPCAprep);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TfrmDirPicker, frmDirPicker);
  Application.CreateForm(TfrmOpts, frmOpts);
  Application.Run;
end.
