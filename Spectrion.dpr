program Spectrion;

uses
  Forms,
  Sysutils,
  Classes,
  SpionU in 'SpionU.pas' {frmSpion},
  CmdShellU in 'CmdShellU.pas' {frmCmdShell},
  CmdCentreU in 'CmdCentreU.pas' {frmCmdCentre: TFrame},
  DvcRackU in 'DvcRackU.pas' {frmDvcRack: TFrame},
  DvcShellU in 'Devices\DvcShellU.pas' {frmDvcShell},
  DeviceU in 'Devices\DeviceU.pas' {dDevice: TFrame},
  PlotU in 'PlotSp\PlotU.pas' {frmPlot: TFrame},
  PlotCollectU in 'PlotSp\PlotCollectU.pas',
  MsrDeviceU in 'Devices\MsrDeviceU.pas' {msrDevice: TFrame},
  CtrlDeviceU in 'Devices\CtrlDeviceU.pas' {ctrlDevice: TFrame},
  DataStreamU in 'Devices\DataStreamU.pas' {fmDataStm: TFrame},
  OptionsU in 'OptionsU.pas' {frmOptions},
  MsrDevice1U in 'Devices\MsrDevice1U.pas' {msrDevice1: TFrame},
  SynchroU in 'Devices\SynchroU.pas' {fmSynchro: TFrame},
  DelphiDeclarations in 'PlotSp\DelphiDeclarations.pas',
  SpecU in 'PlotSp\SpecU.pas',
  SpOptU in 'PlotSp\SpOptU.pas',
  SpMathU in 'PlotSp\SpMathU.pas',
  vChartU in 'PlotSp\vChartU.pas' {vChart: TFrame},
  FitEngU in 'Procs\FitEngU.pas',
  PeakU in 'PlotSp\PeakU.pas',
  ProcU in 'Procs\ProcU.pas' {fmProc: TFrame},
  SimpleScanU in 'Procs\SimpleScanU.pas' {fmSimpleScan: TFrame},
  UniScanU in 'Procs\UniScanU.pas' {fmUniScan: TFrame},
  AutoTuneU in 'Procs\AutoTuneU.pas' {fmAutoTune: TFrame},
  HKProgressBr in 'Utils\HKProgressBr.pas' {ProgressForm},
  AboutU in 'AboutU.pas' {frmAbout},
  BMDSpinEdit in 'Utils\BMDSpinEdit.pas',
  CtrlDevice1U in 'Devices\CtrlDevice1U.pas' {ctrlDevice1: TFrame},
  AutoTuneSimulU in 'Devices\AutoTuneSimulU.pas',
  SCopyU in 'Procs\SCopyU.pas' {fmSmartCopy: TFrame},
  PCAprocU in 'Procs\PCAprocU.pas' {fmPCAproc: TFrame},
  TrainingU in 'Procs\TrainingU.pas' {frmOpts},
  PCAmathU in 'Procs\PCAmathU.pas',
  MassLynxReadU in 'PlotSp\MassLynxReadU.pas',
  mzML110 in 'PlotSp\mzML110.pas';

{$R *.RES}
begin
DecimalSeparator:= '.';
ErrorMsgFile:= TStringList.Create;
if FileExists(RootPath+'spectrion.err') then ErrorMsgFile.LoadFromFile(RootPath+'spectrion.err');

  Application.Initialize;
  Application.Title := 'Spectrion';
  Application.HelpFile := 'G:\Programs\Spectrion\Spectrion.chw';
  Application.CreateForm(TfrmSpion, frmSpion);
  Application.CreateForm(TfrmCmdShell, frmCmdShell);
  Application.CreateForm(TfrmDvcShell, frmDvcShell);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmOpts, frmOpts);
  frmSpion.SetForms;
  Application.Run;

ErrorMsgFile.Free;
end.
