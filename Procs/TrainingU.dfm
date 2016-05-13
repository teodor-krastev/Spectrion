object frmOpts: TfrmOpts
  Left = 509
  Top = 262
  Caption = 'PCA Options'
  ClientHeight = 383
  ClientWidth = 399
  Color = clWhite
  Constraints.MinHeight = 183
  Constraints.MinWidth = 325
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 106
  TextHeight = 16
  object Panel2: TPanel
    Left = 0
    Top = 342
    Width = 399
    Height = 41
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      399
      41)
    object bbOK: TBitBtn
      Left = 76
      Top = 7
      Width = 86
      Height = 27
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akRight, akBottom]
      Caption = '  OK'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbOKClick
    end
    object BitBtn2: TBitBtn
      Left = 167
      Top = 7
      Width = 79
      Height = 27
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akRight, akBottom]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 252
      Top = 7
      Width = 72
      Height = 27
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akRight, akBottom]
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 399
    Height = 98
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 198
      Height = 94
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Caption = 'Thresholds'
      TabOrder = 0
      object Label1: TLabel
        Left = 13
        Top = 26
        Width = 110
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Positive/Possible ID'
      end
      object Label2: TLabel
        Left = 13
        Top = 59
        Width = 116
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Possible/Negative ID'
      end
      object nePNID: TBMDSpinEdit
        Left = 132
        Top = 55
        Width = 63
        Height = 32
        Cursor = crArrow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        Increment = 1.000000000000000000
        MaxValue = 1000.000000000000000000
        Value = 5.000000000000000000
        Precision = 1
        TrackBarEnabled = False
        GuageHeight = -1
      end
      object nePPID: TBMDSpinEdit
        Left = 132
        Top = 19
        Width = 63
        Height = 32
        Cursor = crArrow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        Increment = 1.000000000000000000
        MaxValue = 1000.000000000000000000
        Value = 2.000000000000000000
        Precision = 1
        TrackBarEnabled = False
        GuageHeight = -1
      end
    end
    object GroupBox2: TGroupBox
      Left = 204
      Top = 2
      Width = 157
      Height = 46
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Number of Loadings'
      TabOrder = 1
      object neNLoadings: TSpinEdit
        Left = 89
        Top = 14
        Width = 65
        Height = 26
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        MaxValue = 0
        MinValue = 0
        ParentFont = False
        TabOrder = 0
        Value = 4
      end
    end
    object GroupBox3: TGroupBox
      Left = 204
      Top = 47
      Width = 159
      Height = 47
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Compound/Substance'
      TabOrder = 2
      object eComp: TEdit
        Left = 2
        Top = 18
        Width = 155
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 24
      end
    end
  end
  object reOptions: TRichEdit
    Left = 0
    Top = 98
    Width = 399
    Height = 244
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
