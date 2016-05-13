unit PlotCollectU;

interface

uses Classes, ComCtrls, Forms, PlotU, Controls, Sysutils, Dialogs, Menus,
  windows, Vcl.Graphics;

const
  PlotAbrv: string[2] = 'Sp';

type

  TPlots = class(TComponent)
  private
    { Private declarations }
    fParent: TWinControl;

    fDocked, Busy: boolean;
    PageCtrl: TPageControl;
    mPopup: TPopupMenu;
    Shells: TList;
    fItems: TList; // plots themselves
    procedure SetParent(Value: TWinControl);
    function GetActive: integer;
    procedure SetActive(Value: integer);
    procedure SetDocked(Value: boolean);
    function GetItems(Index: integer): TfrmPlot;
    procedure SetItems(Index: integer; Value: TfrmPlot);
    function GetCount: integer;

    function FirstFreeNumber: integer;
    procedure PageCtrlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);

    procedure OnChange(Sender: TObject);
    procedure OnPopup(Sender: TObject);
    procedure OnPopupClick(Sender: TObject);

  public
    { Public declarations }
    PageTabs: TList;
    DataPath: string;
    MaxNPlots: integer;
    property Parent: TWinControl read fParent write SetParent;
    property Active: integer read GetActive write SetActive;
    // 0 based into fItems
    property Docked: boolean read fDocked write SetDocked default true;
    property Items[Index: integer]: TfrmPlot read GetItems
      write SetItems; default;
    // 0 based index
    property Count: integer read GetCount;
    function IdxByFilename(Filename: string): integer;
    function Add(tml: string): integer;
    // names are '1' based, but result '0' based
    function Delete(Idx: integer): boolean; // Idx is '0' based
    procedure Clear;
    constructor Create(AOwner: TComponent); override;
  end;

function ActivePlot: TfrmPlot;
function IsActPlotEmpty: boolean;

var Plots: TPlots;

implementation
uses SpOptU, Types, AboutU; //, OptionsU;

function ActivePlot: TfrmPlot;
var
  i, j: integer;
begin
  j := Plots.Active;
  if j = -1 then
    Result := nil
  else
    Result := Plots[j];
end;

function IsActPlotEmpty: boolean;
var
  i, j: integer;
  bb: boolean;
begin
  j := Plots.Active;
  bb := (j = -1);
  if not bb then
    bb := Plots[j].IsEmpty;
  Result := bb;
  if Result then
    ErrorMsg('There is no plot to consider');
end;

procedure TPlots.OnPopup(Sender: TObject);
var
  Index: integer;
  NewItem: TMenuItem;
begin
  mPopup.Items.Clear;
  for index := 0 to Count - 1 do
  begin
    NewItem := TMenuItem.Create(mPopup); // create the new item
    mPopup.Items.Add(NewItem); // add it to the Popupmenu
    NewItem.Caption := GetPlotSymbol(Items[index].Number + 1) + ') ' +
      Items[index].Spec.Filename;
    NewItem.Tag := index;
    NewItem.RadioItem := true;
    NewItem.OnClick := OnPopupClick; // assign it an event handler
  end;
  mPopup.Items[Active].Checked := true;
end;

procedure TPlots.OnPopupClick(Sender: TObject);
begin
  PageCtrl.ActivePageIndex := (Sender as TMenuItem).Tag;
end;

constructor TPlots.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DataPath := RootPath+AboutU.DataPath; //Options.SpectraPath;
  fDocked := true;
  PageCtrl := TPageControl.Create(AOwner);
  PageCtrl.Parent := Application.MainForm;
  PageCtrl.Visible := false;
  PageCtrl.Align := alClient;
  PageCtrl.HotTrack := true;
  PageCtrl.TabPosition := tpBottom;
  //PageCtrl.TabHeight:= 26;
  with PageCtrl.Font do
  begin
    Size:= 9; Style:= [fsBold];
  end;
  PageCtrl.OnChange := OnChange;
  PageTabs := TList.Create;
  Shells := TList.Create;
  fItems := TList.Create;
  mPopup := TPopupMenu.Create(self);
  mPopup.AutoPopup := false;
  Busy := false;
  // PageCtrl.PopupMenu:= Popup;
  mPopup.OnPopup := OnPopup;
  PageCtrl.OnMouseDown := PageCtrlMouseDown;
  MaxNPlots := 35;
end;

/// ///////////////////////////////////////////////////////////////////
procedure TPlots.PageCtrlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  p: TPoint;
begin
  p.X := X;
  p.Y := Y;
  p := PageCtrl.ClientToScreen(p);
  if Button = mbRight then
    mPopup.Popup(p.X, p.Y);
end;

procedure TPlots.OnChange(Sender: TObject);
var
  pc: TPageControl;
begin
  pc := Sender as TPageControl; pc.TabHeight:= 26;
  if not fDocked or (Count = 0) then
    exit;
  // (Owner as TForm).Caption:= Items[pc.ActivePageIndex].Spec.Filename;
end;

procedure TPlots.SetParent(Value: TWinControl);
begin
  PageCtrl.Parent := Value;
  fParent := Value;
end;

function TPlots.GetActive: integer;
var
  i, j: integer;
begin
  if Count = 0 then
  begin
    Result := -1;
    exit;
  end;
  if fDocked then
    Result := PageCtrl.ActivePageIndex
  else
  begin
    for i := 0 to Count - 1 do
      if Items[i].PlotShell.Active then
        Result := i;
  end;
end;

procedure TPlots.SetActive(Value: integer);
var
  i: byte;
  ss: string;
begin
  if (Value < 0) or (Value > (Count - 1)) then
    exit;
  if fDocked then
    PageCtrl.ActivePageIndex := Value
  else
  begin
    if Items[Value].PlotShell = nil then
    begin
      ErrorMsg('45');
      exit;
    end;
    Items[Value].PlotShell.BringToFront;
    Items[Value].PlotShell.SetFocus;
    if not Items[Value].PlotShell.Active then
    begin
      ErrorMsg('46');
      exit;
    end;
  end;
end;

procedure TPlots.SetDocked(Value: boolean);
var
  i: byte;
  ch: char;
begin
  if fDocked = Value then
    exit;
  fDocked := Value;
  if Count = 0 then
    exit;
  PageCtrl.Visible := fDocked;
  if fDocked then
  begin
    for i := 0 to fItems.Count - 1 do
    begin
      PageTabs.Add(TTabSheet.Create(PageCtrl));
      TTabSheet(PageTabs.Last).PageControl := PageCtrl;
      TTabSheet(PageTabs.Last).Name := PlotAbrv + GetPlotSymbol(i + 1);
      Items[i].DockedPlace := TWinControl(PageTabs.Last);
      Items[i].Docked := true;
    end;
  end
  else
  begin
    for i := 0 to fItems.Count - 1 do
      Items[i].Docked := false;
    while (PageTabs.Count > 0) do
    begin
      TTabSheet(PageTabs[0]).Free;
      PageTabs.Delete(0);
    end;
  end;
end; { TPlots.SetDocked }

function TPlots.GetItems(Index: integer): TfrmPlot;
begin
  if (Index > -1) and (Index < fItems.Count) then
    Result := TfrmPlot(fItems[Index])
  else
    Result := nil;
end;

procedure TPlots.SetItems(Index: integer; Value: TfrmPlot);
begin
  if (Index > -1) and (Index < fItems.Count) then
    fItems[Index] := Value;
end;

function TPlots.GetCount: integer;
begin
  Result := fItems.Count;
end;

function TPlots.Add(tml: string): integer;
var
  i: integer;
begin
  Result := -1;
  i := FirstFreeNumber;
  if (i > MaxNPlots) or (i = -1) then
  begin
    ErrorMsg('Maximum number of plots reached ! ->' + IntToStr(MaxNPlots));
    exit;
  end;
  if Busy then
    exit;
  Busy := true;
  if fDocked then
  begin
    PageCtrl.Visible := true;
    PageTabs.Add(TTabSheet.Create(PageCtrl));
    TTabSheet(PageTabs.Last).PageControl := PageCtrl;
  end;
  fItems.Add(TfrmPlot.Create(self));
  TfrmPlot(fItems.Last).Number := i;
  TfrmPlot(fItems.Last).Name := PlotAbrv +
    GetPlotSymbol(TfrmPlot(fItems.Last).Number + 1);
  if fDocked then
    TfrmPlot(fItems.Last).DockedPlace := TWinControl(PageTabs.Last);
  TfrmPlot(fItems.Last).Initialise(tml);
  TfrmPlot(fItems.Last).Docked := fDocked;
  // TfrmPlot(fItems.Last).AutoSize:= true;
  TfrmPlot(fItems.Last).Caption := '(' + TfrmPlot(fItems.Last).Name + ')';
  TfrmPlot(fItems.Last).SetIniPos;
  if not DirectoryExists(TfrmPlot(fItems.Last).SpOpt.DataPath) then
    TfrmPlot(fItems.Last).SpOpt.DataPath := DataPath;
  if fDocked then
    TTabSheet(PageTabs.Last).Caption := TfrmPlot(fItems.Last).Name;
  Active := fItems.Count - 1;
  Result := fItems.Count - 1;
  Busy := false;
end; { TPlots.Add }

function TPlots.Delete(Idx: integer): boolean;
begin
  Result := false;
  if (Idx < 0) and (Idx > (fItems.Count - 1)) then
    exit;
  TfrmPlot(fItems[Idx]).Free;
  fItems.Delete(Idx);
  if fDocked then
  begin
    TTabSheet(PageTabs[Idx]).Free;
    PageTabs.Delete(Idx);
  end;
  Result := true;
end;

procedure TPlots.Clear;
begin
  while (Count > 0) do
    Delete(0);
end;

function TPlots.FirstFreeNumber: integer;
var
  i, j, k: integer;
  bb: boolean;
begin
  Result := -1;
  k := 0;
  if Count = 0 then
  begin
    Result := 0;
    exit;
  end;
  for i := 0 to MaxNPlots - 1 do
  begin
    bb := false;
    for j := 0 to Count - 1 do
      bb := bb or (Items[j].Number = i);
    if not bb then
    begin
      Result := i;
      exit;
    end;
  end;
end; { TPlots.FirstFreeNumber }

function TPlots.IdxByFilename(Filename: string): integer;
var
  i, j: integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if UpperCase(Plots[i].Spec.Filename) = UpperCase(Filename) then
      Result := i;
end;

end.
