object fmSynchro: TfmSynchro
  Left = 0
  Top = 0
  Width = 452
  Height = 31
  Align = alTop
  TabOrder = 0
  object pnlDCh0: TPanel
    Left = 0
    Top = 0
    Width = 452
    Height = 31
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = ' Synchro-device'
    Color = 132
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 451
    object sbPause: TSpeedButton
      AlignWithMargins = True
      Left = 267
      Top = 2
      Width = 81
      Height = 27
      Hint = '|Pause the synchronization'
      Margins.Left = 1
      Margins.Top = 2
      Margins.Right = 1
      Margins.Bottom = 2
      Align = alRight
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Pause'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76020000424D7602000000000000760000002800000040000000100000000100
        0400000000000002000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF22FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2A2FFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2AA2FFFFFFCCCCCCCCCCCC
        CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2AAA2FFFFFC77777777777
        7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2AAAA2FFFFC77777777777
        7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2AAAAA2FFFC77777777777
        7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2AAAAAA2FFC77777777777
        7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2AAAAA2FFFC77777777777
        7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2AAAA2FFFFCCCCCCCCCCCC
        CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2AAA2FFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2AA2FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2A2FFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF22FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2FFFFFFFFF}
      NumGlyphs = 4
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Spacing = 6
      ExplicitLeft = 336
      ExplicitTop = 3
      ExplicitHeight = 24
    end
    object bAbort: TSpeedButton
      AlignWithMargins = True
      Left = 424
      Top = 3
      Width = 25
      Height = 25
      Hint = 'Abort'
      Margins.Left = 0
      Align = alRight
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
      ParentShowHint = False
      ShowHint = True
      OnClick = bAbortClick
      ExplicitLeft = 427
      ExplicitHeight = 24
    end
    object sbShoot: TSpeedButton
      AlignWithMargins = True
      Left = 350
      Top = 1
      Width = 73
      Height = 29
      Hint = '|Press the button to fire a single event'
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      AllowAllUp = True
      Caption = 'Shoot'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        E6000000424DE60000000000000076000000280000000F0000000E0000000100
        0400000000007000000000000000000000001000000000000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF0087FFFFFFFFFFFF0B3087FFFFFFFFFFF0BB0087FF
        FFFFFFFF0BB3008FFFFFFFFFF0BBB008FFFFFFFFF00BBB007FFFFFFF00BBB007
        FFF0FFFFF00BBB007FF0FFFFFFF00BB007F0FFFFFFFFF00B0070FFFFFFFFFFF0
        00F0FFFFFFFFFFFFFFF0}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Spacing = 6
      Visible = False
      OnClick = sbShootClick
      ExplicitLeft = 352
    end
    object cbMode: TComboBox
      AlignWithMargins = True
      Left = 169
      Top = 3
      Width = 96
      Height = 24
      Hint = '|The way '#39'Shn'#39' will return the synchro-control'
      Margins.Left = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = cbModeChange
      Items.Strings = (
        'Pass'
        'Delay [ms]'
        'Ext.event'
        'Button')
      ExplicitLeft = 168
    end
    object eNumber: TEdit
      AlignWithMargins = True
      Left = 102
      Top = 3
      Width = 63
      Height = 25
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = eNumberValueChanged
      ExplicitLeft = 101
      ExplicitHeight = 26
    end
  end
end
