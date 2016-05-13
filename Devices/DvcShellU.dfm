object frmDvcShell: TfrmDvcShell
  Left = 683
  Top = 135
  BorderIcons = [biMinimize]
  Caption = ' Device Rack'
  ClientHeight = 494
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnResize = FormResize
  PixelsPerInch = 106
  TextHeight = 13
  object PopupMenu1: TPopupMenu
    AutoPopup = False
    Left = 96
    Top = 208
    object pmHide: TMenuItem
      Caption = 'Hide'
      OnClick = pmHideClick
    end
  end
end
