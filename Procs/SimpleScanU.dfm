inherited fmSimpleScan: TfmSimpleScan
  Width = 193
  Height = 407
  AutoSize = True
  ExplicitWidth = 193
  ExplicitHeight = 407
  inherited sttHeader: TStaticText
    Width = 187
    Caption = 'Simple Scan'
    ExplicitWidth = 187
  end
  inherited pnlButtons: TPanel
    Top = 362
    Width = 190
    Margins.Top = 7
    Align = alTop
    ExplicitTop = 367
    ExplicitWidth = 190
    inherited sbRun: TSpeedButton
      Left = -1
      OnClick = bbRunClick
      ExplicitLeft = 4
    end
    inherited sbClose: TSpeedButton
      Left = 76
      ExplicitLeft = 76
      ExplicitTop = 11
      ExplicitHeight = 36
    end
    inherited bbHelp: TBitBtn
      Left = 153
      ExplicitLeft = 153
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 25
    Width = 193
    Height = 225
    HelpContext = 2300
    Align = alTop
    Caption = ' Control Device '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label8: TLabel
      Left = 8
      Top = 96
      Width = 35
      Height = 16
      Caption = 'From:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 24
      Top = 128
      Width = 20
      Height = 16
      Caption = 'To:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 11
      Top = 160
      Width = 31
      Height = 16
      Caption = 'Step:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 11
      Top = 195
      Width = 33
      Height = 16
      Caption = 'Units:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 64
      Width = 27
      Height = 16
      Caption = 'Chn:'
    end
    object lbDim: TLabel
      Left = 99
      Top = 64
      Width = 12
      Height = 16
      Caption = 'ID'
    end
    object cbCtrlDvc: TComboBox
      Left = 16
      Top = 24
      Width = 145
      Height = 24
      HelpContext = 2300
      Style = csDropDownList
      TabOrder = 0
    end
    object cbUnits: TComboBox
      Left = 50
      Top = 192
      Width = 97
      Height = 24
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Abs. units'
      Items.Strings = (
        'Abs. units'
        'Relat. units')
    end
    object eFrom: TBMDSpinEdit
      Left = 50
      Top = 86
      Width = 79
      Height = 28
      Cursor = crArrow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      Increment = 1.000000000000000000
      MaxValue = 1000.000000000000000000
      Precision = 1
      TrackBarEnabled = False
      GuageHeight = -1
    end
    object eTo: TBMDSpinEdit
      Left = 50
      Top = 121
      Width = 79
      Height = 28
      Cursor = crArrow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 3
      Increment = 1.000000000000000000
      MaxValue = 1000.000000000000000000
      Value = 100.000000000000000000
      Precision = 1
      TrackBarEnabled = False
      GuageHeight = -1
    end
    object eStep: TBMDSpinEdit
      Left = 48
      Top = 155
      Width = 79
      Height = 28
      Cursor = crArrow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 4
      Increment = 1.000000000000000000
      MaxValue = 1000.000000000000000000
      Value = 1.000000000000000000
      Precision = 1
      TrackBarEnabled = False
      GuageHeight = -1
    end
    object nsChn: TSpinEdit
      Left = 44
      Top = 54
      Width = 49
      Height = 26
      EditorEnabled = False
      MaxValue = 65000
      MinValue = 0
      TabOrder = 5
      Value = 0
      OnChange = nsChnChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 250
    Width = 193
    Height = 105
    HelpContext = 2300
    Align = alTop
    Caption = ' Measure Device '
    TabOrder = 3
    object Label12: TLabel
      Left = 8
      Top = 74
      Width = 59
      Height = 16
      Caption = 'Channel #'
    end
    object cbMsrDvc: TComboBox
      Left = 8
      Top = 26
      Width = 153
      Height = 24
      Style = csDropDownList
      TabOrder = 0
    end
    object seChn: TSpinEdit
      Left = 73
      Top = 64
      Width = 49
      Height = 26
      EditorEnabled = False
      MaxValue = 65000
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object Button1: TButton
      Left = 128
      Top = 64
      Width = 51
      Height = 25
      Caption = 'Test'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
