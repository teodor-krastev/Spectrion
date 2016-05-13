object frmSpcnClient: TfrmSpcnClient
  Left = 642
  Top = 213
  Caption = 'Spectrion client'
  ClientHeight = 727
  ClientWidth = 327
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000004
    4444444444444444444440000000004444444444444444444444440000000444
    FFFFFFFFFFFFFFFFFFFF4440000044FFFFFFFFFFFFFFFFFFFFFFF440000044FF
    F444444444444444444FFF4400004FFF44444444444444444444FF4400004FF4
    444FFFFFFFFFFFFF4444FFF400004FFF44FFFFFFFFFFFFFFFF444FF4400044FF
    44FFF44444444444FFF44FF4400044FF444FF444444444444FF44FFF400004FF
    F44FF4444FF44FF44FFF44FF4400044FF44FFF444FF44FFF44FF44FF4400044F
    F444FF444FFF44FF44FF44FFF400004FFF44FF4444FF44FF44FFF44FF4400044
    FF44FFFF44FF44FFF44FF44FF4400044FF444FFF44FFF44FF44FF44FFF400004
    FFF44444444FF44FF44FFF44FF4400044FFF4444444FF44FF444FF44FF440004
    4FFFFFFFF44FFF44FFFFFF44FFF40000444FFFFFFF44FF44FFFFF444FFF40000
    044444444444FF4444444444FF440000044444444444FFF44444444FFF440000
    004FFFFFF4444FFFFFFFFFFFF44000000044FFFFFFF44FFFFFFFFFF444000000
    0004444444444444444444444000000000004444444444444444444400000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFE000007FC000003F8000001F0000001F0000
    000F0000000F0000000F00000007000000070000000780000003800000038000
    0003C0000001C0000001C0000001E0000000E0000000E0000000F0000000F800
    0000F8000000FC000001FC000003FE000007FF00000FFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 106
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 327
    Height = 50
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Caption = ' Command '
    TabOrder = 0
    object eCommand: TEdit
      AlignWithMargins = True
      Left = 4
      Top = 20
      Width = 236
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 24
    end
    object bbSend: TBitBtn
      AlignWithMargins = True
      Left = 244
      Top = 18
      Width = 79
      Height = 28
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = '  Send'
      Glyph.Data = {
        E6000000424DE60000000000000076000000280000000F0000000E0000000100
        0400000000007000000000000000000000001000000000000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF0087FFFFFFFFFFFF0B3087FFFFFFFFFFF0BB0087FF
        FFFFFFFF0BB3008FFFFFFFFFF0BBB008FFFFFFFFF00BBB007FFFFFFF00BBB007
        FFF0FFFFF00BBB007FF0FFFFFFF00BB007F0FFFFFFFFF00B0070FFFFFFFFFFF0
        00F0FFFFFFFFFFFFFFF0}
      TabOrder = 1
      OnClick = bbSendClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 50
    Width = 327
    Height = 79
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Caption = ' Procedure '
    TabOrder = 1
    DesignSize = (
      327
      79)
    object Label1: TLabel
      Left = 7
      Top = 26
      Width = 33
      Height = 16
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Name'
    end
    object Label2: TLabel
      Left = 7
      Top = 52
      Width = 43
      Height = 16
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Params'
    end
    object eParam: TEdit
      Left = 54
      Top = 51
      Width = 183
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object bOpenParam: TButton
      Left = 256
      Top = 50
      Width = 30
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 1
      OnClick = bOpenParamClick
    end
    object cbProcName: TComboBox
      Left = 52
      Top = 20
      Width = 174
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Items.Strings = (
        'Acquire'
        'NIST'
        'UniScan'
        'AutoTune'
        'TICStrip')
    end
    object bbRunProc: TBitBtn
      Left = 230
      Top = 20
      Width = 79
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      Caption = '  Run'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888800008888888888888888888800008888888888888888888800008888
        8088888888888888000088888A08888888888888000088888AA0888888888888
        000088888AAA088888888888000088888AAAA08888888888000088888AAAAA08
        88888888000088888AAAAAA088888888000088888AAAAAAA0888888800008888
        8AAAAAAAA8888888000088888AAAAAAA88888888000088888AAAAAA888888888
        000088888AAAAA8888888888000088888AAAA88888888888000088888AAA8888
        88888888000088888AA8888888888888000088888A8888888888888800008888
        88888888888888880000}
      TabOrder = 3
      OnClick = bbRunProcClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 129
    Width = 327
    Height = 52
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Caption = ' Special '
    TabOrder = 2
    DesignSize = (
      327
      52)
    object bbAbort: TBitBtn
      Left = 189
      Top = 18
      Width = 97
      Height = 30
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      Caption = '  Abort'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000010000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777700007777711111111177777700007777199999999917777700007771
        9999999999917777000077199999999999991777000071999999999999999177
        000019999999999999999917000019FFF99F99FFF9F9991700001999F99F99F9
        F9F99917000019FFF99F99F9F9FFF917000019F9999F99F9F9F9F917000019FF
        F9FFF9FFF9FFF917000019999999999999999917000019999999999999999917
        0000719999999999999991770000771999999999999917770000777199999999
        9991777700007777199999999917777700007777711111111177777700007777
        77777777777777770000}
      TabOrder = 0
      OnClick = bbAbortClick
    end
    object bbGetSpec: TBitBtn
      Left = 13
      Top = 20
      Width = 92
      Height = 28
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'GetSpec'
      TabOrder = 1
      OnClick = bbGetSpecClick
    end
  end
  object mmConv: TMemo
    Left = 0
    Top = 181
    Width = 327
    Height = 546
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 3
    WordWrap = False
  end
  object OpenDialog1: TOpenDialog
    Left = 48
    Top = 264
  end
  object Timer1: TTimer
    Interval = 5000
    Left = 128
    Top = 264
  end
end
