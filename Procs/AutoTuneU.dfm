inherited fmAutoTune: TfmAutoTune
  Width = 287
  Height = 623
  AutoSize = True
  ExplicitHeight = 623
  inherited sttHeader: TStaticText
    Width = 281
    Caption = 'Auto-tune'
    Font.Color = clWindowText
    ExplicitWidth = 445
  end
  object PageControl1: TPageControl [1]
    Left = 0
    Top = 25
    Width = 287
    Height = 444
    ActivePage = tsOptim
    Align = alTop
    HotTrack = True
    TabOrder = 1
    ExplicitWidth = 451
    object tsOptim: TTabSheet
      Caption = 'Optim.'
      ExplicitWidth = 443
      object rgMethod: TRadioGroup
        Left = 0
        Top = 0
        Width = 279
        Height = 81
        Align = alTop
        Caption = ' Optimization Method '
        ItemIndex = 1
        Items.Strings = (
          'Initial seek (in blind)'
          'Consecutive scanning'
          'Simplex optimization')
        TabOrder = 0
        OnClick = rgMethodClick
        ExplicitWidth = 443
      end
      object PageControl2: TPageControl
        AlignWithMargins = True
        Left = 3
        Top = 84
        Width = 273
        Height = 129
        ActivePage = tsCD1
        Align = alTop
        TabOrder = 1
        ExplicitWidth = 437
        object tsCD1: TTabSheet
          Caption = 'CD 1'
          ExplicitWidth = 429
          object Label1: TLabel
            Left = 96
            Top = 16
            Width = 29
            Height = 16
            Caption = 'Ch.#'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 8
            Top = 40
            Width = 31
            Height = 16
            Caption = 'From'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label6: TLabel
            Left = 72
            Top = 40
            Width = 15
            Height = 16
            Caption = 'To'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbStep1: TLabel
            Left = 133
            Top = 40
            Width = 30
            Height = 16
            Caption = 'Step'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cbCD1name: TComboBox
            Left = 0
            Top = 8
            Width = 89
            Height = 24
            Style = csDropDownList
            TabOrder = 0
          end
          object seCD1chn: TSpinEdit
            Left = 133
            Top = 8
            Width = 49
            Height = 26
            MaxValue = 100
            MinValue = 0
            TabOrder = 1
            Value = 2
          end
          object nsCD1From: TBMDSpinEdit
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
            TabOrder = 2
            Increment = 1.000000000000000000
            MaxValue = 1000.000000000000000000
            Precision = 1
            TrackBarEnabled = False
            GuageHeight = -1
          end
          object nsCD1To: TBMDSpinEdit
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
            TabOrder = 3
            Increment = 1.000000000000000000
            MaxValue = 1000.000000000000000000
            Value = 100.000000000000000000
            Precision = 1
            TrackBarEnabled = False
            GuageHeight = -1
          end
          object nsCD1Step: TBMDSpinEdit
            Left = 132
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
        end
        object tsCD2: TTabSheet
          Caption = 'CD 2'
          ImageIndex = 1
          ExplicitWidth = 429
          object Label2: TLabel
            Left = 96
            Top = 16
            Width = 29
            Height = 16
            Caption = 'Ch.#'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label8: TLabel
            Left = 3
            Top = 40
            Width = 31
            Height = 16
            Caption = 'From'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label9: TLabel
            Left = 72
            Top = 40
            Width = 15
            Height = 16
            Caption = 'To'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbStep2: TLabel
            Left = 133
            Top = 40
            Width = 30
            Height = 16
            Caption = 'Step'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cbCD2name: TComboBox
            Left = 0
            Top = 8
            Width = 89
            Height = 24
            Style = csDropDownList
            TabOrder = 0
          end
          object seCD2chn: TSpinEdit
            Left = 133
            Top = 8
            Width = 49
            Height = 26
            MaxValue = 100
            MinValue = 0
            TabOrder = 1
            Value = 2
          end
          object nsCD2From: TBMDSpinEdit
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
            TabOrder = 2
            Increment = 1.000000000000000000
            MaxValue = 1000.000000000000000000
            Precision = 1
            TrackBarEnabled = False
            GuageHeight = -1
          end
          object nsCD2To: TBMDSpinEdit
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
            TabOrder = 3
            Increment = 1.000000000000000000
            MaxValue = 1000.000000000000000000
            Value = 100.000000000000000000
            Precision = 1
            TrackBarEnabled = False
            GuageHeight = -1
          end
          object nsCD2Step: TBMDSpinEdit
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
        end
        object tsCD3: TTabSheet
          Caption = 'CD 3'
          ImageIndex = 2
          TabVisible = False
          ExplicitWidth = 429
          object Label3: TLabel
            Left = 96
            Top = 16
            Width = 29
            Height = 16
            Caption = 'Ch.#'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label11: TLabel
            Left = 8
            Top = 40
            Width = 31
            Height = 16
            Caption = 'From'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label12: TLabel
            Left = 72
            Top = 40
            Width = 15
            Height = 16
            Caption = 'To'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbStep3: TLabel
            Left = 133
            Top = 40
            Width = 30
            Height = 16
            Caption = 'Step'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cbCD3name: TComboBox
            Left = 0
            Top = 8
            Width = 89
            Height = 24
            Style = csDropDownList
            TabOrder = 0
          end
          object seCD3chn: TSpinEdit
            Left = 133
            Top = 8
            Width = 49
            Height = 26
            MaxValue = 100
            MinValue = 0
            TabOrder = 1
            Value = 0
          end
          object nsCD3From: TBMDSpinEdit
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
            TabOrder = 2
            Increment = 1.000000000000000000
            MaxValue = 1000.000000000000000000
            Precision = 1
            TrackBarEnabled = False
            GuageHeight = -1
          end
          object nsCD3To: TBMDSpinEdit
            Left = 67
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
            MaxValue = 1000.000000000000000000
            Value = 100.000000000000000000
            Precision = 1
            TrackBarEnabled = False
            GuageHeight = -1
          end
          object nsCD3Step: TBMDSpinEdit
            Left = 131
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
        end
      end
      object rgNumbCD: TRadioGroup
        AlignWithMargins = True
        Left = 3
        Top = 219
        Width = 273
        Height = 40
        Align = alTop
        Caption = 'Number of Control Devices'
        Columns = 3
        ItemIndex = 1
        Items.Strings = (
          'One'
          'Two'
          'Three')
        TabOrder = 2
        OnClick = rgNumbCDClick
        ExplicitWidth = 437
      end
      object GroupBox2: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 265
        Width = 273
        Height = 79
        Align = alTop
        Caption = ' Optimize by '
        TabOrder = 3
        ExplicitWidth = 437
        object Label14: TLabel
          Left = 5
          Top = 48
          Width = 32
          Height = 16
          Caption = 'Peak:'
        end
        object Label7: TLabel
          Left = 110
          Top = 48
          Width = 11
          Height = 20
          Caption = '..'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 136
          Top = 20
          Width = 48
          Height = 16
          Caption = 'Intensity'
        end
        object gbTotal: TRadioButton
          Left = 8
          Top = 20
          Width = 57
          Height = 17
          Caption = 'Total'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object rbPeak: TRadioButton
          Left = 64
          Top = 20
          Width = 57
          Height = 17
          Caption = 'Peak '
          TabOrder = 0
        end
        object nsPeakFrom: TBMDSpinEdit
          Left = 45
          Top = 42
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
          TabOrder = 2
          Increment = 1.000000000000000000
          MaxValue = 1000.000000000000000000
          Precision = 1
          TrackBarEnabled = False
          GuageHeight = -1
        end
        object nsPeakTo: TBMDSpinEdit
          Left = 127
          Top = 42
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
          MaxValue = 1000.000000000000000000
          Precision = 1
          TrackBarEnabled = False
          GuageHeight = -1
        end
      end
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 350
        Width = 273
        Height = 58
        Align = alTop
        Caption = 'Weights - Intensity / Resolution '
        TabOrder = 4
        ExplicitWidth = 437
        object lbIntensWeight: TLabel
          Left = 71
          Top = 31
          Width = 30
          Height = 16
          Caption = 'lbInt'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label15: TLabel
          Left = 173
          Top = 29
          Width = 14
          Height = 16
          Caption = '%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object seResWeight: TSpinEdit
          Left = 107
          Top = 22
          Width = 60
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 0
        end
      end
    end
    object tsVerif: TTabSheet
      Caption = 'Verif.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      ExplicitWidth = 443
      object sbRefFile: TSpeedButton
        Left = 0
        Top = 3
        Width = 25
        Height = 25
        Hint = 'Open Scan'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          5A010000424D5A01000000000000760000002800000013000000130000000100
          040000000000E400000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888000008888888888888888888000008800000000000000888000008800
          BFBFBBFBFBF08880000088070BFBFFBFBFBF08800000880B0FBFBBFBFBFB0880
          000088070BFBFFBFBFBF08800000880B70BFBBFBFBFBF08000008807B0FBFFBF
          BFBFB0800000880B700000000000008000008807B7B7BAEA0B08088000008800
          0B7B80AEA0800880000088888000880AEA0A08800000888888888880AEAE0880
          00008888888888880AEA08800000888888888880AEAE08800000888888888800
          000008800000888888888888888888800000888888888888888888800000}
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = sbRefFileClick
      end
      object lbRefFile: TLabel
        Left = 27
        Top = 8
        Width = 44
        Height = 16
        Caption = 'Ref.File'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 8
        Top = 80
        Width = 57
        Height = 16
        Caption = 'Tolerance'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object Label17: TLabel
        Left = 128
        Top = 80
        Width = 12
        Height = 16
        Caption = '%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lbMsrDiff: TLabel
        Left = 8
        Top = 136
        Width = 77
        Height = 16
        Caption = 'Difference ='
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 8
        Top = 120
        Width = 66
        Height = 16
        Caption = 'Measured '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FileListBox1: TFileListBox
        Left = 29
        Top = 280
        Width = 145
        Height = 97
        Mask = '*.tun'
        TabOrder = 0
        Visible = False
      end
    end
    object tsCalibr: TTabSheet
      Caption = 'Calibr.'
      ImageIndex = 2
      ExplicitWidth = 443
    end
  end
  object GroupBox3: TGroupBox [2]
    Left = 0
    Top = 523
    Width = 287
    Height = 52
    Align = alTop
    Caption = ' Setting '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 451
    object sbSave: TSpeedButton
      AlignWithMargins = True
      Left = 257
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
        CCFFCCCCFFCC576977C0C0C0C0C0C0000000000000000000576977CCFFCCCCFF
        CC576977C0C0C0C0C0C0C0C0C0576977CCFFCCCCFFCC576977C0C0C0C0C0C000
        0000000000000000576977CCFFCCCCFFCC576977C0C0C0C0C0C0C0C0C0576977
        CCFFCCCCFFCC576977C0C0C0C0C0C0000000000000000000576977CCFFCCCCFF
        CC576977C0C0C0C0C0C0C0C0C0576977CCFFCCCCFFCC57697757697757697757
        6977576977576977576977CCFFCCCCFFCC576977C0C0C0C0C0C0C0C0C0576977
        CCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFF
        CC576977C0C0C0C0C0C0C0C0C0576977CCFFCCCCFFCC57697757697757697757
        6977576977576977576977CCFFCCCCFFCC576977C0C0C0C0C0C0C0C0C0576977
        CCFFCC576977FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF576977CCFF
        CC576977C0C0C0C0C0C0C0C0C0576977CCFFCC576977FFFFFFFF0000FF0000FF
        0000FF0000FFFFFFFFFFFF576977CCFFCC576977C0C0C0C0C0C0C0C0C0576977
        CCFFCC576977FFFFFFFFFFFFFF0000FF0000FF0000FFFFFFFFFFFF576977CCFF
        CC576977C0C0C0C0C0C0C0C0C0576977CCFFCCBEC9D0FFFFFFFF0000FF0000FF
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
      ExplicitLeft = 181
      ExplicitTop = 23
      ExplicitHeight = 26
    end
    object sbOpen: TSpeedButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 25
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
        CCFFCCCCFFCC576977C0C0C0C0C0C0000000000000000000576977CCFFCCCCFF
        CC576977C0C0C0C0C0C0C0C0C0576977CCFFCCCCFFCC576977C0C0C0C0C0C000
        0000000000000000576977CCFFCCCCFFCC576977C0C0C0C0C0C0C0C0C0576977
        CCFFCCCCFFCC576977C0C0C0C0C0C0000000000000000000576977CCFFCCCCFF
        CC576977C0C0C0C0C0C0C0C0C0576977CCFFCCCCFFCC57697757697757697757
        6977576977576977576977CCFFCCCCFFCC576977C0C0C0C0C0C0C0C0C0576977
        CCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFFCCCCFF
        CC576977C0C0C0C0C0C0C0C0C0576977CCFFCCCCFFCC57697757697757697757
        6977576977576977576977CCFFCCCCFFCC576977C0C0C0C0C0C0C0C0C0576977
        CCFFCC576977FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF576977CCFF
        CC576977C0C0C0C0C0C0C0C0C0576977CCFFCC576977FFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFF576977CCFFCC576977C0C0C0C0C0C0C0C0C0576977
        CCFFCC576977FFFFFFFFFFFFFF0000FF0000FF0000FFFFFFFFFFFF576977CCFF
        CC576977C0C0C0C0C0C0C0C0C0576977CCFFCC576977FFFFFFFFFFFFFFFFFFFF
        0000FF0000FF0000FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0576977
        CCFFCC576977FFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000C0C0C0FF00
        00C0C0C0C0C0C0C0C0C0C0C0C0576977576977576977576977576977576977C0
        C0C0C0C0C0FF0000FF0000FF0000FF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF0000FF0000FF00
        00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0FF0000FF0000FF0000FF0000C0C0C0C0C0C0C0C0C0}
      ParentShowHint = False
      ShowHint = True
      OnClick = sbOpenClick
      ExplicitLeft = 3
      ExplicitTop = 24
    end
    object cbTuneFiles: TComboBox
      Left = 33
      Top = 18
      Width = 221
      Height = 24
      Margins.Top = 7
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 0
      OnChange = cbTuneFilesChange
      ExplicitWidth = 385
    end
  end
  object GroupBox5: TGroupBox [3]
    AlignWithMargins = True
    Left = 3
    Top = 472
    Width = 281
    Height = 48
    Align = alTop
    Caption = ' Measurement Device '
    TabOrder = 3
    ExplicitWidth = 445
    object Label4: TLabel
      Left = 113
      Top = 24
      Width = 29
      Height = 16
      Caption = 'Ch.#'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbMDname: TComboBox
      Left = 2
      Top = 18
      Width = 105
      Height = 24
      Align = alLeft
      Style = csDropDownList
      TabOrder = 0
    end
    object seMDchn: TSpinEdit
      Left = 148
      Top = 19
      Width = 49
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 2
    end
  end
  inherited pnlButtons: TPanel
    Top = 578
    Width = 284
    Align = alTop
    TabOrder = 4
    ExplicitTop = 578
    ExplicitWidth = 448
    inherited sbRun: TSpeedButton
      Left = 93
      OnClick = bbRunClick
      ExplicitLeft = 18
    end
    inherited sbClose: TSpeedButton
      Left = 170
      ExplicitLeft = 95
    end
    inherited bbHelp: TBitBtn
      Left = 247
      ExplicitLeft = 411
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'tun'
    Filter = 'Autotune Files (*.tun)|*.tun'
    Title = 'Save Autotune Setting'
    Left = 112
    Top = 496
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'txt'
    Title = 'Open Reference MS File'
    Left = 64
    Top = 496
  end
end
