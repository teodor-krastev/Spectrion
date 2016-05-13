unit PCAprocU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProcU, ExtCtrls, StdCtrls, ComCtrls, ToolWin,
  IniFiles, TrainingU, ImgList, Vcl.Buttons;

type
  TTrainingList = class(TMemIniFile)
  private
    { Private declarations }
    TrainingS: TStrings;
    LoadedTrn: TTraining;
    function GetTraining(SIndex: string): TTraining;
  public
    { Public declarations }
    lvResults: TListView;
    property Training[SIndex: string]: TTraining read GetTraining;
    function Open: boolean;
    procedure Save;
    function DirName: string;
  end;

  TfmPCAproc = class(TfmProc)
    lvRes: TListView;
    ToolBar1: TToolBar;
    tbOpen: TToolButton;
    tbSave: TToolButton;
    ToolBar2: TToolBar;
    tbAdd: TToolButton;
    tbDelete: TToolButton;
    ToolButton1: TToolButton;
    tbCopy: TToolButton;
    OpenDialog1: TOpenDialog;
    ImageList1: TImageList;
    SaveDialog1: TSaveDialog;
    pnlToolbars: TPanel;
    procedure bbCancelClick(Sender: TObject);
    procedure tbOpenClick(Sender: TObject);
    procedure tbAddClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure bbRunClick(Sender: TObject);
    procedure tbCopyClick(Sender: TObject);
  private
    { Private declarations }
    procedure AddNewCompound(aFieldName: string);
    procedure ListSet(Filename: string);
  public
    { Public declarations }
    TrainingList: TTrainingList;
    procedure Execute(AutoRun, ShowUp: boolean; var InOut: string); override;
  end;

var
  TheLastTrainingList: string;

implementation
{$R *.dfm}

uses PCAmathU, PlotCollectU, Clipbrd, PlotU, AboutU;

function TTrainingList.GetTraining(SIndex: string): TTraining;
var
  i, j: integer;
  ss: string;
begin
  ss := TrainingS.Values[SIndex];
  if ss = '' then
  begin
    ErrorMsg('No such training');
    exit;
  end;
  if Assigned(LoadedTrn) then
    if CompareText(LoadedTrn.Filename, ss) <> 0 then
      FreeAndNil(LoadedTrn);
  LoadedTrn := TTraining.Create(ss);
  LoadedTrn.Open;
  Result := LoadedTrn;
end;

function TTrainingList.Open: boolean;
var
  i, j: integer;
  sl, tl: TStrings;
  ss: string;
begin
  sl := TStringList.Create;
  tl := TStringList.Create;
  Result := false;
  ReadSection('List', TrainingS);
  try
    for i := 0 to TrainingS.Count - 1 do
    begin
      ss := DirName + TrainingS[i] + '.trn';
      if not FileExists(ss) then
      begin
        ErrorMsg('No such training file ->' + #10 + ss);
        exit;
      end;
      sl.LoadFromFile(ss);
      tl.Add(sl.Values['Compound'] + '=' + ss);
    end;
    TrainingS.Assign(tl);
    Result := true;
  finally
    sl.Free;
    tl.Free;
  end;
end; { TTrainingList.Open }

procedure TTrainingList.Save;
var
  i, j: integer;
  ss: string;
begin
  EraseSection('List');
  for i := 0 to TrainingS.Count - 1 do
  begin
    ss := TrainingS.Values[lvResults.Items[i].Caption];
    ss := ChangeFileExt(ExtractFileName(ss), '');
    WriteBool('List', ss, lvResults.Items[i].Checked);
  end;
  UpdateFile;
end; { TTrainingList.Save }

function TTrainingList.DirName: string;
begin
  Result := ExtractFilePath(Filename);
end;

/// ///////////////////////////////////////////////////////////////////
procedure TfmPCAproc.AddNewCompound(aFieldName: string);
var
  NewItem: TListItem;
begin
  NewItem := lvRes.Items.Add;
  NewItem.Caption := aFieldName;
end;

procedure TfmPCAproc.ListSet(Filename: string);
var
  i, j: integer;
  sl: TStrings;
begin
  if Filename = '' then
    exit;
  if not FileExists(Filename) then
  begin
    if MessageDlg('Training list file: "' + Filename + '" does not exist.' + #10
      + 'Create a new one ?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      exit;
  end;
  if TrainingList <> nil then
  begin
    FreeAndNil(TrainingList.TrainingS);
    FreeAndNil(TrainingList);
  end;
  TrainingList := TTrainingList.Create(Filename);
  lvRes.Items.Clear;
  TrainingList.lvResults := lvRes;
  TrainingList.TrainingS := TStringList.Create;
  if not TrainingList.Open then
  begin
    bbCancelClick(nil);
    exit;
  end;
  sttHeader.Hint := 'The training list file is ' + TrainingList.Filename;
  Hint := sttHeader.Hint;
  for i := 0 to TrainingList.TrainingS.Count - 1 do
    AddNewCompound(TrainingList.TrainingS.Names[i]);
  sl := TStringList.Create;
  TrainingList.ReadSection('List', sl);
  for i := 0 to lvRes.Items.Count - 1 do
    lvRes.Items[i].Checked := TrainingList.ReadBool('List', sl[i], false);
  sl.Free;
  TheLastTrainingList := Filename;
end;

procedure TfmPCAproc.Execute(AutoRun, ShowUp: boolean; var InOut: string);
begin
  ListSet(TheLastTrainingList);
end; { TfmPCAproc.Execute }

procedure TfmPCAproc.bbCancelClick(Sender: TObject);
begin
  if TrainingList <> nil then
    FreeAndNil(TrainingList.TrainingS);
  FreeAndNil(TrainingList);
  inherited;
end;

procedure TfmPCAproc.tbOpenClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Training List (*.trl)|*.trl';
  OpenDialog1.DefaultExt := 'trl';
  if OpenDialog1.Execute then
    ListSet(OpenDialog1.Filename);
end;

procedure TfmPCAproc.tbSaveClick(Sender: TObject);
begin
  if TheLastTrainingList = '' then
  begin
    if SaveDialog1.Execute then
      TrainingList.Save;
  end
  else
    TrainingList.Save;
end;

procedure TfmPCAproc.tbAddClick(Sender: TObject);
var
  i, j: integer;
  sl: TStrings;
  ss, st: string;
begin
  OpenDialog1.Filter := 'Training Set (*.trn)|*.trn';
  OpenDialog1.DefaultExt := 'trn';
  if OpenDialog1.Execute then
  begin
    ss := ExtractFileDir(OpenDialog1.Filename);
    st := ExtractFileDir(TrainingList.DirName);
    if UpperCase(ss) <> UpperCase(st) then
    begin
      ErrorMsg('All training files must be in training list directory.');
      exit;
    end;
    sl := TStringList.Create;
    sl.LoadFromFile(OpenDialog1.Filename);
    TrainingList.TrainingS.Add(sl.Values['Compound'] + '=' +
      OpenDialog1.Filename);
    AddNewCompound(sl.Values['Compound']);
    sl.Free;
  end;
end; { TfmPCAproc.tbAddClick }

procedure TfmPCAproc.tbDeleteClick(Sender: TObject);
var
  i, j: integer;
  ss: string;
begin
  if lvRes.ItemIndex = -1 then
    exit;
  ss := lvRes.Items[lvRes.ItemIndex].Caption;
  i := 0;
  repeat
    if ss = TrainingList.TrainingS.Names[i] then
      TrainingList.TrainingS.Delete(i);
    inc(i);
  until (i = TrainingList.TrainingS.Count);
  lvRes.Items.Delete(lvRes.ItemIndex);
end;

procedure TfmPCAproc.bbRunClick(Sender: TObject);
var
  ss: string;
  i, j, k, m: integer;
  unk: adouble;
  scoreU: adouble;
  md: double;
  wPlot: TfrmPlot;
begin
  k := 1;
  try
  Screen.Cursor := crHourGlass;
  if plots.Count = 0 then
  begin
    ErrorMsg('No spec to consider.');
    exit;
  end;
  for i := 0 to lvRes.Items.Count - 1 do
    lvRes.Items[i].SubItems.Clear;
  lvRes.UpdateItems(0, lvRes.Items.Count - 1);
  Application.ProcessMessages;
  for i := 0 to lvRes.Items.Count - 1 do
  begin
    if not lvRes.Items[i].Checked then
      continue;
    with TrainingList.Training[lvRes.Items[i].Caption] do
    begin
      if not Calculated then
        continue;
      wPlot := TfrmPlot.Create(self);
      wPlot.Visible := false;
      wPlot.Initialise(DefaultTml);
      wPlot.OpenData(ExtractFilePath(Filename) + LoadedSpec[0]);
      unk := PreProc( { wPlot } plots[plots.Active], plots[plots.Active]);
      DecompByEvec(NLoadings, LoadedSpec.Count, unk, Loadings, RcM, scoreU);
      md := abs(MahalDist(MahalMat, NLoadings, scoreU, RMSG));
      if md <= PPID then
        ss := 'Yes';
      if (md > PPID) and (md <= PNID) then
        ss := 'Poss.';
      if md > PNID then
        ss := 'No';
      lvRes.Items[i].SubItems.Add(ss);
      lvRes.Items[i].SubItems.Add(FloatToStrF(md, ffGeneral, 6, 3));
      wPlot.Free;
    end;
    inc(k);
  end;
  finally
    Screen.Cursor := crDefault;
    sbRun.Down:= false;
  end;
end; { TfmPCAproc.bbRunClick }

procedure TfmPCAproc.tbCopyClick(Sender: TObject);
var
  i, j: integer;
  ss: string;
begin
  with lvRes do
  begin
    ss := '';
    for i := 0 to Items.Count - 1 do
    begin
      if not Items[i].Checked then
        continue;
      ss := ss + Items[i].Caption + #10;
      for j := 0 to Items[i].SubItems.Count - 1 do
        ss := ss + #9 + Items[i].SubItems[j];
      ss := ss + #10;
    end;
  end;
  Clipboard.AsText := ss;
end;

end.
