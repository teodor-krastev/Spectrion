object frmPCAprep: TfrmPCAprep
  Left = 276
  Top = 120
  Width = 871
  Height = 851
  Caption = 'PCA preparations'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object pnlMain: TPanel
    Left = 201
    Top = 25
    Width = 662
    Height = 759
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlMain'
    TabOrder = 3
    object SplitterLeft: TSplitter
      Left = 0
      Top = 491
      Width = 662
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      Color = clGray
      MinSize = 100
      ParentColor = False
    end
    object pnlUpper: TPanel
      Left = 0
      Top = 0
      Width = 662
      Height = 491
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlUpper'
      UseDockManager = False
      TabOrder = 0
      object pnlUpLeft: TPanel
        Left = 0
        Top = 0
        Width = 433
        Height = 491
        Align = alClient
        BevelOuter = bvNone
        Constraints.MinHeight = 100
        Constraints.MinWidth = 200
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object pnlUpRight: TPanel
        Left = 433
        Top = 0
        Width = 229
        Height = 491
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object GroupBox3: TGroupBox
          Left = 0
          Top = 81
          Width = 229
          Height = 88
          Align = alTop
          Caption = ' Pre-processing '
          TabOrder = 0
          object Label1: TLabel
            Left = 16
            Top = 32
            Width = 123
            Height = 16
            Caption = 'Increasing sensitivity'
          end
          object chkNormalize: TCheckBox
            Left = 16
            Top = 56
            Width = 97
            Height = 17
            Caption = 'Normalize'
            TabOrder = 0
          end
          object fseIncSens: TAbNumSpin
            Left = 152
            Top = 24
            Width = 65
            Height = 26
            ColorDefault = clWindow
            DigitsBool = 0
            DigitsHex = 0
            FormatStr = '#0.#'
            Increment = 0.100000001490116
            MaxValue = 5
            Options = [eoLimitMax, eoLimitMin]
            TabOrder = 1
            Text = '0'
            Interval = 100
            StartDelay = 500
          end
        end
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 229
          Height = 81
          Align = alTop
          Caption = ' Unify the spec. boundaries [m/z] '
          TabOrder = 1
          object Label11: TLabel
            Left = 16
            Top = 24
            Width = 113
            Height = 16
            Caption = 'Max lower boudary'
          end
          object Label12: TLabel
            Left = 16
            Top = 56
            Width = 121
            Height = 16
            Caption = 'Min higher boundary'
          end
          object seLowBound: TSpinEdit
            Left = 144
            Top = 16
            Width = 73
            Height = 26
            MaxValue = 0
            MinValue = 0
            TabOrder = 0
            Value = 0
          end
          object seHighBound: TSpinEdit
            Left = 144
            Top = 48
            Width = 73
            Height = 26
            MaxValue = 0
            MinValue = 0
            TabOrder = 1
            Value = 0
          end
        end
        object GroupBox2: TGroupBox
          Left = 0
          Top = 169
          Width = 229
          Height = 96
          Align = alTop
          Caption = ' Calculation Setting '
          TabOrder = 2
          object Label17: TLabel
            Left = 16
            Top = 24
            Width = 104
            Height = 16
            Caption = 'Loadings number'
          end
          object Label18: TLabel
            Left = 16
            Top = 64
            Width = 103
            Height = 16
            Caption = 'Precision = 1/10^'
          end
          object sePrecPower: TSpinEdit
            Left = 123
            Top = 54
            Width = 57
            Height = 26
            MaxValue = 10
            MinValue = 1
            TabOrder = 0
            Value = 5
          end
          object fseNLoadings: TAbNumSpin
            Left = 128
            Top = 16
            Width = 73
            Height = 26
            ColorDefault = clWindow
            DigitsBool = 0
            DigitsHex = 0
            EditBase = ebInt
            FormatStr = '#0.#'
            Increment = 1
            MaxValue = 100
            MinValue = 1
            Options = [eoLimitMax, eoLimitMin]
            TabOrder = 1
            Text = '1'
            Interval = 100
            StartDelay = 500
          end
        end
        object bbRetrieve: TBitBtn
          Left = 24
          Top = 272
          Width = 201
          Height = 28
          Caption = 'Retrieve from calc. training'
          TabOrder = 3
          OnClick = bbRetrieveClick
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7777777777777777777777777777777777777777777777777777777777777777
            7777777777777778477777444447777748777744447777777477774447777777
            7477774474777777747777477744777748777777777744448777777777777777
            7777777777777777777777777777777777777777777777777777}
        end
        object chkInclSp: TCheckBox
          Left = 88
          Top = 312
          Width = 137
          Height = 17
          Caption = 'Including Spectra'
          TabOrder = 4
        end
      end
    end
    object pnlLower: TPanel
      Left = 0
      Top = 494
      Width = 662
      Height = 265
      Align = alBottom
      Caption = 'pnlLower'
      Constraints.MinHeight = 200
      Constraints.MinWidth = 100
      UseDockManager = False
      TabOrder = 1
      Visible = False
      object pnlLowRight: TPanel
        Left = 640
        Top = 1
        Width = 21
        Height = 263
        Align = alRight
        BevelOuter = bvNone
        Caption = 'pnlLowRight'
        Constraints.MinHeight = 1
        Constraints.MinWidth = 1
        TabOrder = 0
        Visible = False
      end
      object pnlLowLeft: TPanel
        Left = 1
        Top = 1
        Width = 639
        Height = 263
        Align = alClient
        BevelOuter = bvNone
        Constraints.MinHeight = 150
        Constraints.MinWidth = 200
        TabOrder = 1
        object pcChartCtrl: TPageControl
          Left = 0
          Top = 0
          Width = 639
          Height = 263
          ActivePage = tsMDist
          Align = alClient
          HotTrack = True
          TabIndex = 2
          TabOrder = 0
          OnChange = pcChartCtrlChange
          object tsLoadings: TTabSheet
            Caption = 'Loadings'
            object Chart1: TChart
              Left = 0
              Top = 0
              Width = 520
              Height = 232
              Legend.Visible = False
              MarginBottom = 2
              MarginLeft = 2
              MarginRight = 2
              MarginTop = 2
              Title.Alignment = taRightJustify
              Title.Text.Strings = (
                '')
              BottomAxis.Grid.Color = clSilver
              LeftAxis.Grid.Color = clSilver
              LeftAxis.Grid.Visible = False
              View3D = False
              View3DWalls = False
              Zoom.Brush.Color = 15400959
              Zoom.Brush.Style = bsSolid
              Zoom.Pen.Color = clGray
              Align = alClient
              Color = clWhite
              TabOrder = 0
              object srsBars1: TVolumeSeries
                Marks.ArrowLength = 8
                Marks.Visible = False
                SeriesColor = clBlack
                UseYOrigin = True
                VolumeValues.DateTime = False
                VolumeValues.Name = 'Y'
                VolumeValues.Order = loNone
                XValues.DateTime = False
                XValues.Name = 'X'
                XValues.Order = loAscending
              end
            end
            object Panel2: TPanel
              Left = 520
              Top = 0
              Width = 111
              Height = 232
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 1
              DesignSize = (
                111
                232)
              object Label5: TLabel
                Left = 17
                Top = 8
                Width = 78
                Height = 16
                Anchors = [akTop, akRight]
                Caption = 'Loading (PC)'
              end
              object seLoadings: TSpinEdit
                Left = 22
                Top = 40
                Width = 65
                Height = 26
                Anchors = [akTop, akRight]
                MaxValue = 2
                MinValue = 1
                TabOrder = 0
                Value = 1
                OnChange = seLoadingsChange
              end
            end
          end
          object tsRebuild: TTabSheet
            Caption = 'Rebuild Sp'
            ImageIndex = 1
            object Panel3: TPanel
              Left = 408
              Top = 0
              Width = 223
              Height = 232
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 0
              object Label6: TLabel
                Left = 8
                Top = 24
                Width = 102
                Height = 16
                Caption = 'Rebuilt Spectrum'
              end
              object Label7: TLabel
                Left = 8
                Top = 64
                Width = 141
                Height = 16
                Caption = 'Number of factors used '
              end
              object seRebuildSp: TSpinEdit
                Left = 120
                Top = 16
                Width = 65
                Height = 26
                MaxValue = 2
                MinValue = 1
                TabOrder = 0
                Value = 1
                OnChange = seRebuildSpChange
              end
              object seNFactors: TSpinEdit
                Left = 150
                Top = 56
                Width = 65
                Height = 26
                MaxValue = 0
                MinValue = 1
                TabOrder = 1
                Value = 0
                OnChange = seRebuildSpChange
              end
              object rgErrors: TRadioGroup
                Left = 6
                Top = 96
                Width = 211
                Height = 89
                Caption = ' Residuals chart '
                ItemIndex = 1
                Items.Strings = (
                  'Off'
                  'Main spec scale'
                  'Proper scale')
                TabOrder = 2
                OnClick = seRebuildSpChange
              end
            end
            object Chart2: TChart
              Left = 0
              Top = 0
              Width = 408
              Height = 232
              Legend.Visible = False
              MarginBottom = 2
              MarginLeft = 2
              MarginRight = 2
              MarginTop = 2
              Title.Alignment = taRightJustify
              Title.Text.Strings = (
                '')
              BottomAxis.Grid.Color = clSilver
              LeftAxis.Grid.Color = clSilver
              LeftAxis.Grid.Visible = False
              View3D = False
              View3DWalls = False
              Zoom.Brush.Color = 15400959
              Zoom.Brush.Style = bsSolid
              Zoom.Pen.Color = clGray
              Align = alClient
              Color = clWhite
              TabOrder = 1
              object srsBars2: TVolumeSeries
                Marks.ArrowLength = 8
                Marks.Visible = False
                SeriesColor = clBlack
                UseYOrigin = True
                VolumeValues.DateTime = False
                VolumeValues.Name = 'Y'
                VolumeValues.Order = loNone
                XValues.DateTime = False
                XValues.Name = 'X'
                XValues.Order = loAscending
              end
              object srsLine2: TLineSeries
                Marks.ArrowLength = 8
                Marks.Visible = False
                SeriesColor = clRed
                VertAxis = aRightAxis
                Pointer.InflateMargins = True
                Pointer.Style = psRectangle
                Pointer.Visible = False
                XValues.DateTime = False
                XValues.Name = 'X'
                XValues.Order = loAscending
                YValues.DateTime = False
                YValues.Name = 'Y'
                YValues.Order = loNone
              end
            end
          end
          object tsMDist: TTabSheet
            Caption = 'M.Dist'
            ImageIndex = 2
            object Chart3: TChart
              Left = 0
              Top = 0
              Width = 496
              Height = 232
              Legend.Visible = False
              MarginBottom = 2
              MarginLeft = 2
              MarginRight = 2
              MarginTop = 2
              Title.Alignment = taRightJustify
              Title.Text.Strings = (
                '')
              BottomAxis.Grid.Color = clSilver
              LeftAxis.Grid.Color = clSilver
              LeftAxis.Grid.Visible = False
              View3D = False
              View3DWalls = False
              Zoom.Brush.Color = 15400959
              Zoom.Brush.Style = bsSolid
              Zoom.Pen.Color = clGray
              Align = alClient
              Color = clWhite
              TabOrder = 0
              object srsPoints3: TPointSeries
                Marks.Arrow.Visible = False
                Marks.ArrowLength = 7
                Marks.Bevel = bvRaised
                Marks.BevelWidth = 1
                Marks.Brush.Color = clWhite
                Marks.Frame.EndStyle = esSquare
                Marks.Style = smsValue
                Marks.Visible = True
                SeriesColor = clRed
                ClickableLine = False
                Pointer.HorizSize = 3
                Pointer.InflateMargins = True
                Pointer.Style = psDiamond
                Pointer.VertSize = 3
                Pointer.Visible = True
                XValues.DateTime = False
                XValues.Name = 'X'
                XValues.Order = loAscending
                YValues.DateTime = False
                YValues.Name = 'Y'
                YValues.Order = loNone
              end
            end
            object Panel4: TPanel
              Left = 496
              Top = 0
              Width = 135
              Height = 232
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 1
              object Label8: TLabel
                Left = 8
                Top = 16
                Width = 117
                Height = 16
                Caption = 'Used factor number'
              end
              object seMDFactor: TSpinEdit
                Left = 32
                Top = 40
                Width = 89
                Height = 26
                MaxValue = 0
                MinValue = 1
                TabOrder = 0
                Value = 1
                OnChange = seMDFactorChange
              end
            end
          end
          object tsEigenValues: TTabSheet
            Caption = 'Eigen Values'
            ImageIndex = 3
            object Chart4: TChart
              Left = 0
              Top = 0
              Width = 520
              Height = 232
              Legend.Visible = False
              MarginBottom = 2
              MarginLeft = 2
              MarginRight = 2
              MarginTop = 2
              Title.Alignment = taRightJustify
              Title.Text.Strings = (
                '')
              BottomAxis.Grid.Color = clSilver
              LeftAxis.AxisValuesFormat = '0.0e-0'
              LeftAxis.Grid.Color = clSilver
              LeftAxis.Grid.Visible = False
              View3D = False
              View3DWalls = False
              Zoom.Brush.Color = 15400959
              Zoom.Brush.Style = bsSolid
              Zoom.Pen.Color = clGray
              Align = alClient
              Color = clWhite
              TabOrder = 0
              PrintMargins = (
                15
                36
                15
                36)
              object srsPoints4: TPointSeries
                Marks.ArrowLength = 0
                Marks.Visible = False
                SeriesColor = clRed
                ClickableLine = False
                Pointer.HorizSize = 3
                Pointer.InflateMargins = True
                Pointer.Style = psDiamond
                Pointer.VertSize = 3
                Pointer.Visible = True
                XValues.DateTime = False
                XValues.Name = 'X'
                XValues.Order = loAscending
                YValues.DateTime = False
                YValues.Name = 'Y'
                YValues.Order = loNone
              end
            end
            object Panel6: TPanel
              Left = 520
              Top = 0
              Width = 111
              Height = 232
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 1
              object Label13: TLabel
                Left = 8
                Top = 8
                Width = 85
                Height = 16
                Caption = 'Total variation'
              end
              object Label14: TLabel
                Left = 8
                Top = 24
                Width = 52
                Height = 16
                Caption = ' kept [%]'
              end
              object Label15: TLabel
                Left = 8
                Top = 96
                Width = 94
                Height = 16
                Caption = 'Recommended'
              end
              object Label16: TLabel
                Left = 8
                Top = 112
                Width = 97
                Height = 16
                Caption = 'factor number is:'
              end
              object lRecomFactN: TLabel
                Left = 48
                Top = 136
                Width = 9
                Height = 16
                Caption = '?'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object seVarLevel: TSpinEdit
                Left = 16
                Top = 48
                Width = 81
                Height = 26
                MaxValue = 100
                MinValue = 1
                TabOrder = 0
                Value = 90
                OnChange = seVarLevelChange
              end
            end
          end
          object tsScores: TTabSheet
            Caption = 'Scores'
            ImageIndex = 4
            object Panel5: TPanel
              Left = 552
              Top = 0
              Width = 79
              Height = 232
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 0
              object Label9: TLabel
                Left = 8
                Top = 16
                Width = 44
                Height = 16
                Caption = 'X factor'
              end
              object Label10: TLabel
                Left = 8
                Top = 88
                Width = 45
                Height = 16
                Caption = 'Y factor'
              end
              object seXFactor: TSpinEdit
                Left = 8
                Top = 40
                Width = 65
                Height = 26
                MaxValue = 2
                MinValue = 1
                TabOrder = 0
                Value = 1
                OnChange = seXFactorChange
              end
              object seYFactor: TSpinEdit
                Left = 8
                Top = 112
                Width = 65
                Height = 26
                MaxValue = 2
                MinValue = 1
                TabOrder = 1
                Value = 2
                OnChange = seXFactorChange
              end
            end
            object Chart5: TChart
              Left = 0
              Top = 0
              Width = 552
              Height = 232
              Legend.Visible = False
              MarginBottom = 2
              MarginLeft = 2
              MarginRight = 2
              MarginTop = 2
              Title.Alignment = taRightJustify
              Title.Text.Strings = (
                '')
              BottomAxis.Grid.Color = clSilver
              BottomAxis.LabelStyle = talValue
              BottomAxis.TickOnLabelsOnly = False
              LeftAxis.Grid.Color = clSilver
              LeftAxis.Grid.Visible = False
              LeftAxis.LabelStyle = talValue
              View3D = False
              View3DWalls = False
              Zoom.Brush.Color = 15400959
              Zoom.Brush.Style = bsSolid
              Zoom.Pen.Color = clAppWorkSpace
              Align = alClient
              Color = clWhite
              TabOrder = 1
              object srsPoints5: TPointSeries
                Depth = 0
                Marks.Arrow.Visible = False
                Marks.ArrowLength = 5
                Marks.Frame.Visible = False
                Marks.Transparent = True
                Marks.Visible = True
                SeriesColor = clRed
                ClickableLine = False
                Pointer.HorizSize = 3
                Pointer.InflateMargins = True
                Pointer.Style = psDiamond
                Pointer.VertSize = 3
                Pointer.Visible = True
                XValues.DateTime = False
                XValues.Name = 'X'
                XValues.Order = loAscending
                YValues.DateTime = False
                YValues.Name = 'Y'
                YValues.Order = loNone
              end
            end
          end
        end
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 863
    Height = 25
    ButtonWidth = 121
    Caption = 'ToolBar1'
    EdgeBorders = [ebTop, ebBottom]
    EdgeOuter = esNone
    Flat = True
    Images = ImageList2
    Indent = 4
    List = True
    ShowCaptions = True
    TabOrder = 0
    object tbOpenSpec: TToolButton
      Left = 4
      Top = 0
      Hint = '|Open spectrum of a training sample'
      Caption = ' Open Spec '
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
      OnClick = mOpenSpecClick
    end
    object ToolButton3: TToolButton
      Left = 125
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbOpenTraining: TToolButton
      Left = 133
      Top = 0
      Hint = '|Open traning setting'
      Caption = '  Open Training '
      ImageIndex = 1
      OnClick = mOpenTrainingClick
    end
    object tbSaveTraining: TToolButton
      Left = 254
      Top = 0
      Hint = 'Save traning setting'
      Caption = ' Save Training '
      Enabled = False
      ImageIndex = 2
      OnClick = mSaveTrainingClick
    end
    object ToolButton1: TToolButton
      Left = 375
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object tbCalculate: TToolButton
      Left = 383
      Top = 0
      Hint = '|Calculate PCA for opened set of spectra'
      Caption = '   Calculate '
      ImageIndex = 3
      OnClick = mCalculateClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 784
    Width = 863
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object pnlCommand: TPanel
    Left = 0
    Top = 25
    Width = 201
    Height = 759
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pnlCommand'
    TabOrder = 1
    Visible = False
    object gbOptim: TGroupBox
      Left = 0
      Top = 0
      Width = 201
      Height = 169
      Align = alTop
      Caption = ' Optimizition '
      TabOrder = 0
      object sbOptim: TSpeedButton
        Left = 120
        Top = 128
        Width = 73
        Height = 30
        AllowAllUp = True
        Caption = 'Optimize'
      end
      object Label2: TLabel
        Left = 16
        Top = 72
        Width = 31
        Height = 16
        Caption = 'From'
      end
      object Label3: TLabel
        Left = 16
        Top = 104
        Width = 17
        Height = 16
        Caption = 'To'
      end
      object Label4: TLabel
        Left = 16
        Top = 136
        Width = 28
        Height = 16
        Caption = 'Step'
      end
      object nsFrom: TAbNumSpin
        Left = 56
        Top = 64
        Width = 65
        Height = 26
        ColorDefault = clWindow
        DigitsBool = 0
        DigitsHex = 0
        FormatStr = '#0.#'
        Increment = 1
        Options = []
        TabOrder = 0
        Text = '1'
        Interval = 100
        StartDelay = 500
      end
      object nsTo: TAbNumSpin
        Left = 56
        Top = 96
        Width = 65
        Height = 26
        ColorDefault = clWindow
        DigitsBool = 0
        DigitsHex = 0
        FormatStr = '#0.#'
        Increment = 1
        Options = []
        TabOrder = 1
        Text = '2'
        Interval = 100
        StartDelay = 500
      end
      object nsStep: TAbNumSpin
        Left = 56
        Top = 128
        Width = 57
        Height = 26
        ColorDefault = clWindow
        DigitsBool = 0
        DigitsHex = 0
        FormatStr = '#0.#'
        Increment = 1
        Options = []
        TabOrder = 2
        Text = '0.1'
        Interval = 100
        StartDelay = 500
      end
      object cbOptimWhat: TComboBox
        Left = 16
        Top = 24
        Width = 169
        Height = 24
        ItemHeight = 16
        TabOrder = 3
        Items.Strings = (
          'Increasing sensitivity')
      end
    end
    object mmScript: TMemo
      Left = 0
      Top = 186
      Width = 201
      Height = 573
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object Panel1: TPanel
      Left = 0
      Top = 169
      Width = 201
      Height = 17
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
  object MainMenu1: TMainMenu
    Left = 552
    Top = 32
    object mFile: TMenuItem
      Caption = 'File'
      OnClick = mFileClick
      object mOpenSpec: TMenuItem
        Caption = 'Open Specrum...'
        Hint = 'Open unknown spectrum'
        ShortCut = 16463
        OnClick = mOpenSpecClick
      end
      object mCloseSpec: TMenuItem
        Caption = 'Close Spectrum'
        Hint = 'Close unknown'
        object mCloseActiveSpec: TMenuItem
          Caption = 'Active'
          Hint = 'Close all unknown'
          ShortCut = 16471
          OnClick = mCloseActiveSpecClick
        end
        object mCloseAllSpec: TMenuItem
          Caption = 'All'
          Hint = 'Close current unknown'
          OnClick = mCloseAllSpecClick
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mNewTraning: TMenuItem
        Caption = 'New Traning'
        OnClick = mNewTraningClick
      end
      object mOpenTraining: TMenuItem
        Caption = 'Open Training'
        OnClick = mOpenTrainingClick
      end
      object mSaveTraining: TMenuItem
        Caption = 'Save Training'
        OnClick = mSaveTrainingClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mExit: TMenuItem
        Caption = 'Exit'
        Hint = 'Exit the program'
        ShortCut = 32883
        OnClick = mExitClick
      end
    end
    object mEdit: TMenuItem
      Caption = 'Edit'
      object mCopyImage: TMenuItem
        Caption = 'Copy Image'
        Hint = 
          'Create report for the active hit-list and copy it into the clipb' +
          'road'
        OnClick = mCopyImageClick
      end
      object mCopyData: TMenuItem
        Caption = 'Copy Data'
        OnClick = mCopyDataClick
      end
      object N3: TMenuItem
        Caption = '-'
        Visible = False
      end
      object mOptions: TMenuItem
        Caption = 'Options...'
        Visible = False
        OnClick = mOptionsClick
      end
    end
    object mPCA: TMenuItem
      Caption = 'PCA'
      Enabled = False
      object mOpimizing: TMenuItem
        Caption = 'Optimize Param.'
        OnClick = mOpimizingClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object mCalculate: TMenuItem
        Caption = 'Calculate PC'#39's'
        Hint = '|Perform single search with the active spec.'
        ShortCut = 120
        OnClick = mCalculateClick
      end
    end
    object mHelp: TMenuItem
      Caption = 'Help'
      object mHelpContents: TMenuItem
        Caption = 'Contents'
        Hint = 'Contents of the help'
        ShortCut = 112
      end
      object mTopicSearch: TMenuItem
        Caption = 'Topic Search'
        Hint = 'Topic search in the help'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mAbout: TMenuItem
        Caption = 'About...'
        OnClick = mAboutClick
      end
    end
  end
  object ImageList1: TImageList
    Left = 548
    Top = 104
    Bitmap = {
      494C01010A000E00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000000000000000000000000000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000000000000000000000000000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000000000FFFFFF00FFFFFF0000000000FFFF0000BFBF00000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000000000FFFFFF00FFFFFF0000000000FFFF0000BFBF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000BF0000000000FFFFFF0000000000FFFF0000BFBF00000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000BF0000000000FFFFFF0000000000FFFF0000BFBF00000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000BF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000BF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000FFFFFF0000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000000000000000000000000000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000000000000000000000000000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000000000000000000000000000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000000000000000000000000000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000000000FFFFFF00FFFFFF0000000000FFFF0000BFBF00000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000000000FFFFFF00FFFFFF0000000000FFFF0000BFBF00000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000000000FFFFFF00FFFFFF0000000000FFFF0000BFBF00000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000000000FFFFFF00FFFFFF0000000000FFFF0000BFBF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000BF0000000000FFFFFF0000000000FFFF0000BFBF00000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000BF0000000000FFFFFF0000000000FFFF0000BFBF00000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000BF0000000000FFFFFF0000000000FFFF0000BFBF00000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000BF0000000000FFFFFF0000000000FFFF0000BFBF00000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000BF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000BF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000BF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000BF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF000000000000000000FFFF
      FF00000000000000000000000000FFFFFF0000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000FFFF0000FFFF0000BFBF0000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000000000000000000000000000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000000000000000000000000000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000000000000000000000000000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000000000000000000000000000000000FFFF0000BFBF00000000
      000000BFBF0000BFBF00000000000000000000000000000000000000FF000000
      BF000000000000000000FFFFFF00FFFFFF0000000000FFFF0000BFBF00000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000000000FFFFFF00FFFFFF0000000000FFFF0000BFBF00000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000000000FFFFFF00FFFFFF0000000000FFFF0000BFBF00000000
      00000000000000000000000000000000000000000000000000000000FF000000
      BF000000000000000000FFFFFF00FFFFFF0000000000FFFF0000BFBF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000BF0000000000FFFFFF0000000000FFFF0000BFBF00000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000BF0000000000FFFFFF0000000000FFFF0000BFBF00000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000BF0000000000FFFFFF0000000000FFFF0000BFBF00000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000BF0000000000FFFFFF0000000000FFFF0000BFBF00000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000BF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000BF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000BF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000BF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFF000000000001000100000000
      0000000000000000000000000000000080008000000000008000800000000000
      8000800000000000800080000000000080008000000000008000800000000000
      8000800000000000800080000000000080008000000000008000800000000000
      C103C10300000000E183E18300000000FFFFFFFFFFFFFFFF0001000100010001
      0000000000000000000000000000000080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      C103C103C103C103E183E183E183E183FFFFFFFFFFFFFFFF0001000100010001
      0000000000000000000000000000000080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      C103C103C103C103E183E183E183E18300000000000000000000000000000000
      000000000000}
  end
  object OpenDialog1: TOpenDialog
    Filter = 'XY text (*.txt)|*.txt'
    Options = [ofHideReadOnly, ofNoChangeDir, ofAllowMultiSelect, ofPathMustExist, ofEnableSizing]
    Title = 'Open XY Spec File(s) - multiselect '
    Left = 464
    Top = 34
  end
  object ImageList2: TImageList
    Left = 552
    Top = 153
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0080000000800000000000
      0000800000008000000080000000000000008000000080000000800000008000
      000080000000800000008000000000000000FFFFFF0000008000000080000000
      0000000080000000800000008000000000000000800000008000000080000000
      8000000080000000800000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00000000000000000000000000FFFFFF0000000000800000008000
      000000000000800000008000000000000000FFFFFF00FF000000808080008080
      800080808000000000008080800000000000FFFFFF0000000000000080000000
      800000000000000080000000800000000000FFFFFF000000FF00808080008080
      8000808080000000000080808000000000000000000000000000000000008080
      8000000000000000000080808000000000000000000080808000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FF000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF000000FF00808080000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00000000000000000000000000FFFFFF00FF000000FF000000FFFF
      FF00FF000000FF000000FF00000000000000FF000000FF000000808080000000
      000000000000000000000000000000000000FFFFFF000000FF000000FF00FFFF
      FF000000FF000000FF000000FF00000000000000FF000000FF00808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      80000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FF000000FF000000FF000000FF000000FF00000080808000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF000000FF000000FF000000FF000000FF000000FF0080808000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000080808000000000000000000080808000000000000000
      00008080800000000000000000000000000000000000000000000000000000FF
      FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FF000000FF00000080808000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF000000FF000000FF00808080000000FF000000
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF0000000000000000000000000000000000000000000000000000FF
      FF008080800000FFFF008080800000FFFF00FFFF000000FF00000000000000FF
      FF000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FFFFFF00FF00000000000000FF000000FF000000FF000000FF000000FF00
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF000000FF00000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF008080800000FFFF000000000000FF0000FFFF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000FFFF000000FF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FF00000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000FF0080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF0000FFFF
      000000FF00000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF00000000000000FF000000FF000000FF000000808080000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF00000000000000FF000000FF000000FF00808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFF110111018000
      C0077FFF7FFFBFFEC00349054905A492C003FF1FFF1FA492C003011F011FBFFE
      C001E03FE03FA492C001FC0FFC0FA492C003820F820FBFFEC10BF83FF83FA00E
      F103FC3FFC3FA00EFF83C21FC21FA00EFFC3FE3FFE3FBFFEFF03FF7FFF7FC001
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object SaveDialog1: TSaveDialog
    Left = 464
    Top = 88
  end
end
