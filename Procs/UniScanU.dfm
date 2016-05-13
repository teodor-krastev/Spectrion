inherited fmUniScan: TfmUniScan
  Width = 342
  Height = 540
  AutoSize = True
  ExplicitWidth = 342
  ExplicitHeight = 540
  object FileListBox1: TFileListBox [0]
    Left = 64
    Top = 312
    Width = 145
    Height = 97
    Mask = '*.scn'
    TabOrder = 4
    Visible = False
  end
  inherited sttHeader: TStaticText
    Width = 336
    Caption = 'Uni-Scan'
    ExplicitWidth = 445
  end
  object GroupBox1: TGroupBox [2]
    AlignWithMargins = True
    Left = 1
    Top = 30
    Width = 340
    Height = 223
    Margins.Left = 1
    Margins.Top = 5
    Margins.Right = 1
    Align = alTop
    Caption = ' Scan Control Devices '
    TabOrder = 1
    ExplicitWidth = 449
    object TLabel
      Left = 16
      Top = 112
      Width = 4
      Height = 16
    end
    object pcCDs: TPageControl
      Left = 2
      Top = 18
      Width = 336
      Height = 159
      ActivePage = tsCD1
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 445
      object tsCD1: TTabSheet
        Caption = 'CD1'
        ExplicitWidth = 437
        object Label1: TLabel
          Left = 8
          Top = 40
          Width = 35
          Height = 16
          Caption = 'From:'
        end
        object Label2: TLabel
          Left = 80
          Top = 40
          Width = 20
          Height = 16
          Caption = 'To:'
        end
        object Label3: TLabel
          Left = 131
          Top = 40
          Width = 31
          Height = 16
          Caption = 'Step:'
        end
        object Label5: TLabel
          Left = 16
          Top = 104
          Width = 33
          Height = 16
          Caption = 'Units:'
        end
        object Label13: TLabel
          Left = 104
          Top = 16
          Width = 28
          Height = 16
          Caption = 'Ch.#'
        end
        object cbUnits1: TComboBox
          Left = 63
          Top = 99
          Width = 90
          Height = 24
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 0
          Text = 'Relat. units'
          Items.Strings = (
            'Abs. units'
            'Relat. units')
        end
        object cbCtrlDvc1: TComboBox
          Left = 0
          Top = 8
          Width = 89
          Height = 24
          Style = csDropDownList
          TabOrder = 1
          Items.Strings = (
            'CD1'
            'CD2')
        end
        object seCh1N: TSpinEdit
          Left = 136
          Top = 8
          Width = 49
          Height = 26
          EditorEnabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
        end
        object eFrom1: TBMDSpinEdit
          Left = 3
          Top = 62
          Width = 59
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
          MaxValue = 1000000.000000000000000000
          MinValue = -1000000.000000000000000000
          Precision = 1
          TrackBarEnabled = False
          GuageHeight = -1
        end
        object eStep1: TBMDSpinEdit
          Left = 133
          Top = 62
          Width = 59
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
        object eTo1: TBMDSpinEdit
          Left = 68
          Top = 62
          Width = 59
          Height = 28
          Cursor = crArrow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          TabOrder = 5
          Increment = 1.000000000000000000
          MaxValue = 100000.000000000000000000
          MinValue = -100000.000000000000000000
          Value = 200.000000000000000000
          Precision = 1
          TrackBarEnabled = False
          GuageHeight = -1
        end
      end
      object tsCD2: TTabSheet
        Caption = 'CD2 /fast'
        object Label8: TLabel
          Left = 8
          Top = 40
          Width = 35
          Height = 16
          Caption = 'From:'
        end
        object Label9: TLabel
          Left = 80
          Top = 40
          Width = 20
          Height = 16
          Caption = 'To:'
        end
        object Label10: TLabel
          Left = 131
          Top = 40
          Width = 31
          Height = 16
          Caption = 'Step:'
        end
        object Label11: TLabel
          Left = 16
          Top = 104
          Width = 33
          Height = 16
          Caption = 'Units:'
        end
        object Label6: TLabel
          Left = 104
          Top = 16
          Width = 28
          Height = 16
          Caption = 'Ch.#'
        end
        object cbUnits2: TComboBox
          Left = 63
          Top = 99
          Width = 90
          Height = 24
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 0
          Text = 'Relat. units'
          Items.Strings = (
            'Abs. units'
            'Relat. units')
        end
        object cbCtrlDvc2: TComboBox
          Left = 0
          Top = 8
          Width = 89
          Height = 24
          Style = csDropDownList
          TabOrder = 1
          Items.Strings = (
            'CD1'
            'CD2')
        end
        object seCh2N: TSpinEdit
          Left = 136
          Top = 8
          Width = 49
          Height = 26
          EditorEnabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
        end
        object eFrom2: TBMDSpinEdit
          Left = 3
          Top = 62
          Width = 59
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
          MaxValue = 100000.000000000000000000
          MinValue = -100000.000000000000000000
          Precision = 1
          TrackBarEnabled = False
          GuageHeight = -1
        end
        object eStep2: TBMDSpinEdit
          Left = 135
          Top = 62
          Width = 59
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
        object eTo2: TBMDSpinEdit
          Left = 68
          Top = 62
          Width = 61
          Height = 28
          Cursor = crArrow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          TabOrder = 5
          Increment = 1.000000000000000000
          MaxValue = 100000.000000000000000000
          MinValue = -100000.000000000000000000
          Value = 200.000000000000000000
          Precision = 1
          TrackBarEnabled = False
          GuageHeight = -1
        end
      end
      object tsCDNone: TTabSheet
        Caption = 'None'
        object rbHowMany: TRadioButton
          Left = 16
          Top = 16
          Width = 129
          Height = 17
          Caption = 'How many times '
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object rbHowMuch: TRadioButton
          Left = 16
          Top = 40
          Width = 137
          Height = 17
          Caption = 'How much time [s] '
          TabOrder = 1
        end
        object nsTimes: TSpinEdit
          Left = 52
          Top = 72
          Width = 61
          Height = 26
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
        end
      end
    end
    object rgNCDs: TRadioGroup
      Left = 2
      Top = 177
      Width = 336
      Height = 44
      Align = alClient
      Caption = 'Number of Ctrl. Devices'
      Columns = 3
      ItemIndex = 1
      Items.Strings = (
        'None'
        'One'
        'Two')
      TabOrder = 1
      OnClick = rgNCDsClick
      ExplicitWidth = 445
    end
  end
  object GroupBox2: TGroupBox [3]
    AlignWithMargins = True
    Left = 1
    Top = 261
    Width = 340
    Height = 178
    Margins.Left = 1
    Margins.Top = 5
    Margins.Right = 1
    Align = alTop
    Caption = ' Measurement / Ctrl-Msr Devices '
    TabOrder = 2
    ExplicitWidth = 449
    object pcMDs: TPageControl
      Left = 2
      Top = 18
      Width = 336
      Height = 111
      ActivePage = tsMD1
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 445
      object tsMD1: TTabSheet
        Caption = 'MD1'
        ExplicitWidth = 437
        object Label12: TLabel
          Left = 98
          Top = 16
          Width = 24
          Height = 16
          Caption = 'Ch#'
        end
        object seChn1: TSpinEdit
          Left = 128
          Top = 8
          Width = 49
          Height = 26
          EditorEnabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object cbMsrDvc1: TComboBox
          Left = 4
          Top = 7
          Width = 89
          Height = 24
          Style = csDropDownList
          TabOrder = 1
          OnChange = cbMsrDvc1Change
          Items.Strings = (
            'MD1'
            'MD2')
        end
        object GroupBox4: TGroupBox
          Left = 0
          Top = 38
          Width = 115
          Height = 42
          Caption = ' Numb.Channels '
          TabOrder = 2
          object rbSingle1: TRadioButton
            Left = 5
            Top = 19
            Width = 65
            Height = 17
            Caption = 'Single '
            TabOrder = 0
          end
          object rbMulti1: TRadioButton
            Left = 64
            Top = 19
            Width = 49
            Height = 17
            Caption = 'Multi'
            Checked = True
            TabOrder = 1
            TabStop = True
          end
        end
        object chkDStream1: TCheckBox
          Left = 120
          Top = 56
          Width = 97
          Height = 17
          Caption = 'D.Stream'
          TabOrder = 3
        end
      end
      object tsMD2: TTabSheet
        Caption = 'MD2'
        object Label4: TLabel
          Left = 98
          Top = 16
          Width = 24
          Height = 16
          Caption = 'Ch#'
        end
        object seChn2: TSpinEdit
          Left = 128
          Top = 8
          Width = 49
          Height = 26
          EditorEnabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object cbMsrDvc2: TComboBox
          Left = 4
          Top = 7
          Width = 89
          Height = 24
          Style = csDropDownList
          TabOrder = 1
          OnChange = cbMsrDvc2Change
          Items.Strings = (
            'MD1'
            'MD2')
        end
        object GroupBox5: TGroupBox
          Left = 0
          Top = 38
          Width = 115
          Height = 42
          Caption = ' Numb.Channels '
          TabOrder = 2
          object rbSingle2: TRadioButton
            Left = 5
            Top = 19
            Width = 60
            Height = 17
            Caption = 'Single '
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object rbMulti2: TRadioButton
            Left = 64
            Top = 19
            Width = 49
            Height = 17
            Caption = 'Multi'
            TabOrder = 1
          end
        end
        object chkDStream2: TCheckBox
          Left = 120
          Top = 56
          Width = 78
          Height = 17
          Caption = 'D.Stream'
          TabOrder = 3
        end
      end
    end
    object rgNMDs: TRadioGroup
      Left = 2
      Top = 129
      Width = 336
      Height = 47
      Margins.Left = 1
      Margins.Right = 1
      Align = alClient
      Caption = 'Number of Msr. Devices'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'One'
        'Two')
      TabOrder = 1
      OnClick = rgNMDsClick
      ExplicitWidth = 445
    end
  end
  object GroupBox3: TGroupBox [4]
    AlignWithMargins = True
    Left = 1
    Top = 443
    Width = 340
    Height = 52
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Align = alTop
    Caption = ' Scans '
    TabOrder = 3
    ExplicitWidth = 449
    object sbSave: TSpeedButton
      AlignWithMargins = True
      Left = 310
      Top = 18
      Width = 25
      Height = 25
      Hint = 'Save Scan'
      Margins.Top = 0
      Margins.Bottom = 7
      Align = alRight
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0BEC9D057697757697757697700000000000000
        0000000000000000576977576977576977576977C0C0C0C0C0C0C0C0C0576977
        CCFFFFCCFFFF576977C0C0C0C0C0C0000000000000000000576977CCFFFFCCFF
        FF576977C0C0C0C0C0C0C0C0C0576977CCFFFFCCFFFF576977C0C0C0C0C0C000
        0000000000000000576977CCFFFFCCFFFF576977C0C0C0C0C0C0C0C0C0576977
        CCFFFFCCFFFF576977C0C0C0C0C0C0000000000000000000576977CCFFFFCCFF
        FF576977C0C0C0C0C0C0C0C0C0576977CCFFFFCCFFFF57697757697757697757
        6977576977576977576977CCFFFFCCFFFF576977C0C0C0C0C0C0C0C0C0576977
        CCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFF
        FF576977C0C0C0C0C0C0C0C0C0576977CCFFFFCCFFFF57697757697757697757
        6977576977576977576977CCFFFFCCFFFF576977C0C0C0C0C0C0C0C0C0576977
        CCFFFF576977FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF576977CCFF
        FF576977C0C0C0C0C0C0C0C0C0576977CCFFFF576977FFFFFFFF0000FF0000FF
        0000FF0000FFFFFFFFFFFF576977CCFFFF576977C0C0C0C0C0C0C0C0C0576977
        CCFFFF576977FFFFFFFFFFFFFF0000FF0000FF0000FFFFFFFFFFFF576977CCFF
        FF576977C0C0C0C0C0C0C0C0C0576977CCFFFFBEC9D0FFFFFFFF0000FF0000FF
        0000FF0000FFFFFFFFFFFF576977576977576977C0C0C0C0C0C0C0C0C0576977
        BEC9D0BEC9D0FF0000FF0000FF0000FFFFFFFF0000FFFFFFFFFFFF0000008080
        80000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF0000FF0000FF0000C0C0C0C0
        C0C0C0C0C0C0C0C0000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0
        FF0000FF0000FF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF0000C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
      ParentShowHint = False
      ShowHint = True
      OnClick = sbSaveClick
      ExplicitLeft = 168
      ExplicitTop = 19
    end
    object sbOpen: TSpeedButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 24
      Height = 25
      Hint = 'Open Scan'
      Margins.Top = 0
      Margins.Bottom = 7
      Align = alLeft
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C057697757697757697700000000000000
        0000000000000000576977576977576977576977C0C0C0C0C0C0C0C0C0576977
        CCFFFFCCFFFF576977C0C0C0C0C0C0000000000000000000576977CCFFFFCCFF
        FF576977C0C0C0C0C0C0C0C0C0576977CCFFFFCCFFFF576977C0C0C0C0C0C000
        0000000000000000576977CCFFFFCCFFFF576977C0C0C0C0C0C0C0C0C0576977
        CCFFFFCCFFFF576977C0C0C0C0C0C0000000000000000000576977CCFFFFCCFF
        FF576977C0C0C0C0C0C0C0C0C0576977CCFFFFCCFFFF57697757697757697757
        6977576977576977576977CCFFFFCCFFFF576977C0C0C0C0C0C0C0C0C0576977
        CCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFF
        FF576977C0C0C0C0C0C0C0C0C0576977CCFFFFCCFFFF57697757697757697757
        6977576977576977576977CCFFFFCCFFFF576977C0C0C0C0C0C0C0C0C0576977
        CCFFFF576977FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF576977CCFF
        FF576977C0C0C0C0C0C0C0C0C0576977CCFFFF576977FFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFF576977CCFFFF576977C0C0C0C0C0C0C0C0C0576977
        CCFFFF576977FFFFFFFFFFFFFF0000FF0000FF0000FFFFFFFFFFFF576977CCFF
        FF576977C0C0C0C0C0C0C0C0C0576977CCFFFF576977FFFFFFFFFFFFFFFFFFFF
        0000FF0000FF0000FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0576977
        CCFFFF576977FFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000C0C0C0FF00
        00C0C0C0C0C0C0C0C0C0C0C0C0576977576977576977576977576977576977C0
        C0C0C0C0C0FF0000FF0000FF0000FF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF0000FF0000FF00
        00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0FF0000FF0000FF0000FF0000C0C0C0C0C0C0C0C0C0}
      ParentShowHint = False
      ShowHint = True
      OnClick = sbOpenClick
      ExplicitLeft = 2
      ExplicitTop = 16
      ExplicitHeight = 34
    end
    object cbScanFlies: TComboBox
      Left = 32
      Top = 18
      Width = 275
      Height = 24
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 384
    end
  end
  inherited pnlButtons: TPanel
    AlignWithMargins = False
    Left = 0
    Top = 498
    Width = 342
    Align = alTop
    TabOrder = 5
    ExplicitLeft = 0
    ExplicitTop = 498
    ExplicitWidth = 451
    inherited sbRun: TSpeedButton
      Left = 151
      OnClick = bbRunClick
      ExplicitLeft = 20
    end
    inherited sbClose: TSpeedButton
      Left = 228
      ExplicitLeft = 97
    end
    inherited bbHelp: TBitBtn
      Left = 305
      ExplicitLeft = 414
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'scn'
    Filter = 'UniScan (*.scn)|*.scn'
    Title = 'Uni-Scan setting file'
    Left = 112
    Top = 456
  end
end
