object frmPlot: TfrmPlot
  Tag = -1
  Left = 0
  Top = 0
  Width = 1117
  Height = 731
  Align = alClient
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  ParentShowHint = False
  ShowHint = True
  TabOrder = 0
  OnResize = FrameResize
  ExplicitWidth = 586
  ExplicitHeight = 437
  object PropToolBar: TToolBar
    Left = 870
    Top = 0
    Width = 21
    Height = 731
    Align = alRight
    ButtonHeight = 183
    ButtonWidth = 25
    Caption = 'PropToolBar'
    Color = clBtnFace
    EdgeBorders = [ebTop, ebRight]
    Images = ImageList1
    ParentColor = False
    TabOrder = 0
    OnResize = PropToolBarResize
    ExplicitLeft = 339
    ExplicitHeight = 437
    object tbChrom: TToolButton
      Left = 0
      Top = 0
      AllowAllUp = True
      Caption = 'tbChrom'
      ImageIndex = 0
      Wrap = True
      OnClick = tbChromClick
      OnMouseUp = tbChromMouseUp
    end
    object tbCommon: TToolButton
      Left = 0
      Top = 183
      Caption = 'tbCommon'
      ImageIndex = 1
      Wrap = True
      OnClick = tbCommonClick
    end
    object tbMass: TToolButton
      Left = 0
      Top = 366
      Caption = 'tbMass'
      ImageIndex = 2
      OnClick = tbMassClick
      OnMouseUp = tbMassMouseUp
    end
  end
  object pcCommon: TPageControl
    Left = 891
    Top = 0
    Width = 226
    Height = 731
    ActivePage = tsProps
    Align = alRight
    HotTrack = True
    TabHeight = 24
    TabOrder = 1
    Visible = False
    ExplicitLeft = 360
    ExplicitHeight = 437
    object tsProps: TTabSheet
      Caption = 'Properties'
      ExplicitHeight = 403
      object GroupBox7: TGroupBox
        Left = 0
        Top = 0
        Width = 218
        Height = 65
        Align = alTop
        Caption = ' GC/MS Chart Dimentions '
        TabOrder = 0
        object chkDimTabs: TCheckBox
          Left = 8
          Top = 32
          Width = 105
          Height = 17
          Caption = 'Tabs Visible'
          TabOrder = 0
          OnClick = chkDimTabsClick
        end
        object rgDims: TRadioGroup
          Left = 119
          Top = 18
          Width = 97
          Height = 45
          Align = alRight
          Caption = ' Dimentions '
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            '2D'
            '3D')
          TabOrder = 1
          OnClick = rgDimsClick
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 659
        Width = 218
        Height = 38
        Align = alBottom
        BevelOuter = bvLowered
        Caption = 'TheoPlot v1.5 build 10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        ExplicitTop = 365
        object Image1: TImage
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 33
          Height = 30
          Align = alLeft
          Picture.Data = {
            055449636F6E0000010001002020100000000000E80200001600000028000000
            2000000040000000010004000000000080020000000000000000000000000000
            0000000000000000000080000080000000808000800000008000800080800000
            80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
            FFFFFF0000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000008000000000000000B9B9B9B9B00
            00088800000000000009B9B9B9B9B00088888800000000000B9B9B9B9B9B0088
            8888800000000000B9B9B9B9B9000888888800000000000B9B9B9B9B00088888
            8880000000000009B9B9B90008888888880000000000009B9B9B000888888888
            809B0000000000B9B90008888888888809B9000000000B9B0008888888888880
            9B9B9000000009B00888888888888800B9B9B00000000000888888888888800B
            9B9B90000000008888888888888800B9B9B9B000000888888888888888009B9B
            9B9B900000000888888888888009B9B9B9B9B000000000888888888888009B9B
            9B9B90000000000008888888888009B9B9B9B00000000090000888888888009B
            9B9B0000000000B9B900888888888009B9B900000000000B9B90008888888800
            9B90000000000009B9B9B0008888888009B00000000000009B9B9B9000088888
            000000000000000009B9B9B9B90000888800000000000000000B9B9B9B9B9B00
            0880000000000000000009B9B9B9B00000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1FFF803C1FFE00001FF800001
            FF000003FE000007FC00000FFC00000FF8000007F8000007F0000003F0000003
            F0000003C000000380000003C0000003F0000003F0000003F8000007F8000007
            FC00000FFC00000FFE00001FFF00001FFF80000FFFE0010FFFF807FFFFFFFFFF
            FFFFFFFF}
          ExplicitLeft = 3
          ExplicitTop = 2
          ExplicitHeight = 33
        end
      end
      object btnForcedCashe: TButton
        Left = 8
        Top = 72
        Width = 105
        Height = 25
        Caption = 'Forced Cashe'
        TabOrder = 2
        OnClick = btnForcedCasheClick
      end
    end
    object tsFiles: TTabSheet
      Caption = 'Files'
      ImageIndex = 1
      object GroupBox5: TGroupBox
        Left = 0
        Top = 0
        Width = 218
        Height = 65
        Align = alTop
        Caption = ' Data '
        TabOrder = 0
        object bbOpenData: TBitBtn
          Left = 8
          Top = 23
          Width = 89
          Height = 29
          Caption = 'Open '
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
          ParentDoubleBuffered = True
          TabOrder = 0
          OnClick = bbOpenDataClick
        end
        object bbSaveAsData: TBitBtn
          Left = 112
          Top = 24
          Width = 94
          Height = 29
          Caption = 'Save As'
          Glyph.Data = {
            5A010000424D5A01000000000000760000002800000012000000130000000100
            040000000000E400000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            888888000000888888888888888888000000800000000000000888000000800B
            FBFBFBFBFB08880000008070BFBFBFBFBFB08800000080B0FBFBFBFBFBF08800
            00008070BFBFBFBFBFB08800000080B77BFBFBFBFBFB78000000807B7FBFBFBF
            BFBF7800000080B777777777777778000000807B7B7EEEE77B78880000008000
            B7B0EEE77778880000008888000EEEE7888888000000888880EEE0E788888800
            000088880EEE08778888880000008880EEE0888788888800000088880E088888
            888888000000888880888888888888000000888888888888888888000000}
          ParentDoubleBuffered = True
          TabOrder = 1
          OnClick = bbSaveAsDataClick
        end
      end
      object gbAsTemplate: TGroupBox
        Left = 0
        Top = 65
        Width = 218
        Height = 96
        Align = alTop
        Caption = ' Base Template  '
        TabOrder = 1
        object Label12: TLabel
          Left = 32
          Top = 56
          Width = 161
          Height = 33
          AutoSize = False
          Caption = 'On close save changes in a template'
          ShowAccelChar = False
          WordWrap = True
        end
        object bbOpenTml: TBitBtn
          Left = 8
          Top = 24
          Width = 89
          Height = 29
          Caption = 'Open '
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
          ParentDoubleBuffered = True
          TabOrder = 0
          OnClick = bbOpenTmlClick
        end
        object bbSaveAsTml: TBitBtn
          Left = 112
          Top = 24
          Width = 94
          Height = 29
          Caption = 'Save As'
          Glyph.Data = {
            5A010000424D5A01000000000000760000002800000012000000130000000100
            040000000000E400000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            888888000000888888888888888888000000800000000000000888000000800B
            FBFBFBFBFB08880000008070BFBFBFBFBFB08800000080B0FBFBFBFBFBF08800
            00008070BFBFBFBFBFB08800000080B77BFBFBFBFBFB78000000807B7FBFBFBF
            BFBF7800000080B777777777777778000000807B7B7EEEE77B78880000008000
            B7B0EEE77778880000008888000EEEE7888888000000888880EEE0E788888800
            000088880EEE08778888880000008880EEE0888788888800000088880E088888
            888888000000888880888888888888000000888888888888888888000000}
          ParentDoubleBuffered = True
          TabOrder = 1
          OnClick = bbSaveAsTmlClick
        end
        object chkSaveTemplate: TCheckBox
          Left = 8
          Top = 64
          Width = 17
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
      object sgFiles: TStringGrid
        Left = 0
        Top = 161
        Width = 218
        Height = 536
        Align = alClient
        ColCount = 2
        DefaultColWidth = 125
        RowCount = 100
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
        TabOrder = 2
        Visible = False
        RowHeights = (
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24)
      end
    end
    object tsMyTab: TTabSheet
      Caption = 'My Tab'
      ImageIndex = 2
      object Memo1: TMemo
        Left = 0
        Top = 161
        Width = 218
        Height = 536
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 218
        Height = 161
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object chkAcqMode: TCheckBox
          Left = 8
          Top = 32
          Width = 97
          Height = 17
          Caption = 'Acquision'
          TabOrder = 0
          OnClick = chkAcqModeClick
        end
        object chkMassMode: TCheckBox
          Left = 104
          Top = 32
          Width = 97
          Height = 17
          Caption = 'Mass Mode'
          TabOrder = 1
          OnClick = chkMassModeClick
        end
        object btnClear: TButton
          Left = 126
          Top = 64
          Width = 75
          Height = 25
          Caption = 'Clear'
          TabOrder = 2
          OnClick = btnClearClick
        end
        object btnSimulGCMS: TButton
          Left = 8
          Top = 64
          Width = 105
          Height = 25
          Caption = 'Simul GC/MS'
          TabOrder = 3
        end
        object chkCasheOn: TCheckBox
          Left = 16
          Top = 112
          Width = 97
          Height = 17
          Caption = 'CasheOn'
          TabOrder = 4
          OnClick = chkCasheOnClick
        end
      end
    end
  end
  object pcDimentions: TPageControl
    Left = 0
    Top = 0
    Width = 870
    Height = 731
    ActivePage = ts2D
    Align = alClient
    HotTrack = True
    TabHeight = 24
    TabOrder = 2
    OnChange = pcDimentionsChange
    ExplicitWidth = 339
    ExplicitHeight = 437
    object ts2D: TTabSheet
      Caption = '  2D'
      ExplicitWidth = 331
      ExplicitHeight = 403
      object pnlCommon: TPanel
        Left = 0
        Top = 0
        Width = 862
        Height = 697
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 331
        ExplicitHeight = 403
        object Splitter1: TSplitter
          Left = 0
          Top = 300
          Width = 862
          Height = 3
          Cursor = crVSplit
          Align = alTop
          Color = 13432823
          MinSize = 1
          ParentColor = False
          OnMoved = Splitter1Moved
          ExplicitWidth = 331
        end
        object pnlChrom: TPanel
          Left = 0
          Top = 0
          Width = 862
          Height = 300
          Align = alTop
          BevelOuter = bvNone
          Caption = 'chrom pane'
          TabOrder = 0
          ExplicitWidth = 331
          object SplitterChrom: TSplitter
            Left = 681
            Top = 0
            Height = 300
            Align = alRight
            Color = 13432823
            ParentColor = False
            Visible = False
            ExplicitLeft = 150
          end
          object pcChrom: TPageControl
            Left = 684
            Top = 0
            Width = 178
            Height = 300
            ActivePage = tsStatsChrom
            Align = alRight
            Anchors = []
            Constraints.MaxWidth = 200
            Constraints.MinWidth = 150
            HotTrack = True
            MultiLine = True
            TabHeight = 24
            TabOrder = 0
            Visible = False
            ExplicitLeft = 153
            object tsVisualChrom: TTabSheet
              Caption = 'Visual'
              object rgShowChrom: TRadioGroup
                Left = 0
                Top = 0
                Width = 170
                Height = 41
                Align = alTop
                Caption = ' Show '
                Columns = 2
                ItemIndex = 0
                Items.Strings = (
                  'Chart'
                  'Data')
                TabOrder = 0
                OnClick = actDataTableChromExecute
              end
              object rgXUnitsChrom: TRadioGroup
                Left = 0
                Top = 161
                Width = 170
                Height = 41
                Align = alBottom
                Caption = ' X-axis units '
                Columns = 3
                ItemIndex = 1
                Items.Strings = (
                  'scan'
                  'sec'
                  'min')
                TabOrder = 1
                OnClick = rgXUnitsChromClick
              end
              object Panel6: TPanel
                Left = 0
                Top = 41
                Width = 170
                Height = 84
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 2
                object Label14: TLabel
                  Left = 31
                  Top = 36
                  Width = 108
                  Height = 48
                  Caption = 'Include current chart into template setting'
                  Visible = False
                  WordWrap = True
                  OnClick = Label14Click
                end
                object bbEditorChrom: TBitBtn
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 164
                  Height = 25
                  Align = alTop
                  Caption = 'Chart Editor'
                  Glyph.Data = {
                    42010000424D4201000000000000760000002800000011000000110000000100
                    040000000000CC00000000000000000000001000000010000000000000000000
                    BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
                    7777700000007000000000000007700000007077707777770707700000007070
                    707077070707700000007000000000000007700000007770EEEEEEE077777000
                    00007770E0000E077777700000007770E070E0077777700000007770E00EE700
                    7777700000007770E0EE07000777700000007770EEE0770FF077700000007770
                    EE07770FF077700000007770E0777770FF0770000000777007777770F0077000
                    00007770777777770FF070000000777777777777000770000000777777777777
                    777770000000}
                  Spacing = -1
                  TabOrder = 0
                  OnClick = bbEditorChromClick
                end
                object chkSaveChartChrom: TCheckBox
                  Left = 7
                  Top = 48
                  Width = 18
                  Height = 17
                  TabOrder = 1
                  Visible = False
                end
              end
              object rgChromatogram: TRadioGroup
                Left = 0
                Top = 125
                Width = 170
                Height = 36
                Hint = '|Total Ion Current (TIC) or Base Peak Intensity (BPI) '
                Align = alBottom
                Caption = ' Chromatogram '
                Columns = 2
                ItemIndex = 0
                Items.Strings = (
                  'TIC'
                  'BPI')
                TabOrder = 3
                OnClick = rgChromatogramClick
              end
              object GroupBox6: TGroupBox
                Left = 0
                Top = 202
                Width = 170
                Height = 40
                Align = alBottom
                Caption = ' Y-axis units '
                TabOrder = 4
                object chkFixYChrom: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 65
                  Height = 17
                  Caption = 'Fixed Y'
                  TabOrder = 0
                  OnClick = chkFixYChromClick
                end
                object rbAbsYChrom: TRadioButton
                  Left = 80
                  Top = 16
                  Width = 50
                  Height = 17
                  Caption = 'abs.'
                  Checked = True
                  TabOrder = 1
                  TabStop = True
                  OnClick = rgXUnitsChromClick
                end
                object rbPercYChrom: TRadioButton
                  Left = 132
                  Top = 16
                  Width = 35
                  Height = 17
                  Caption = '%'
                  TabOrder = 2
                  OnClick = rgXUnitsChromClick
                end
              end
            end
            object tsSmoothChrom: TTabSheet
              Caption = 'Smooth'
              ImageIndex = 1
              object GroupBox2: TGroupBox
                Left = 0
                Top = 0
                Width = 170
                Height = 57
                Align = alTop
                Caption = 'Savitzky-Golay'
                TabOrder = 0
                object seSGDegreeChrom: TSpinEdit
                  Left = 104
                  Top = 16
                  Width = 57
                  Height = 26
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                end
              end
              object chkOSSmoothChrom: TCheckBox
                Left = 8
                Top = 72
                Width = 71
                Height = 17
                Action = actSmoothChrom
                Caption = 'Enabled'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                State = cbChecked
                TabOrder = 1
              end
            end
            object tsBLineChrom: TTabSheet
              Caption = 'B-line'
              ImageIndex = 2
              object GroupBox4: TGroupBox
                Left = 0
                Top = 0
                Width = 170
                Height = 59
                Align = alTop
                Caption = 'Threshold'
                TabOrder = 0
                object chkAutoTSChrom: TCheckBox
                  Left = 8
                  Top = 24
                  Width = 57
                  Height = 17
                  Caption = 'Auto'
                  TabOrder = 0
                  OnClick = chkAutoTSChromClick
                end
                object seTSBlineChrom: TBMDSpinEdit
                  AlignWithMargins = True
                  Left = 71
                  Top = 21
                  Width = 94
                  Height = 28
                  Cursor = crArrow
                  Margins.Bottom = 5
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -15
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  Increment = 1.000000000000000000
                  MaxValue = 100.000000000000000000
                  TrackBarEnabled = False
                  GuageHeight = -1
                end
              end
              object Panel9: TPanel
                Left = 0
                Top = 59
                Width = 170
                Height = 41
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                object chkOSBlineChrom: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 71
                  Height = 17
                  Action = actBLineChrom
                  Caption = 'Enabled'
                  TabOrder = 0
                end
              end
              object chrBHistoChrom: TChart
                Left = 0
                Top = 100
                Width = 170
                Height = 142
                Legend.Visible = False
                Title.Text.Strings = (
                  'TChart')
                Title.Visible = False
                BottomAxis.Grid.Visible = False
                LeftAxis.Labels = False
                View3D = False
                Align = alClient
                Color = clWhite
                TabOrder = 2
                Visible = False
                object srsHistoChrom: TLineSeries
                  Marks.Arrow.Visible = True
                  Marks.Callout.Brush.Color = clBlack
                  Marks.Callout.Arrow.Visible = True
                  Marks.Visible = False
                  Pointer.InflateMargins = True
                  Pointer.Style = psRectangle
                  Pointer.Visible = False
                  XValues.Name = 'X'
                  XValues.Order = loAscending
                  YValues.Name = 'Y'
                  YValues.Order = loNone
                end
                object ChartTool2: TCursorTool
                  Pen.Color = clNavy
                  Pen.Width = 2
                  Pen.EndStyle = esSquare
                  Series = srsHistoChrom
                  Snap = True
                  Style = cssVertical
                end
              end
            end
            object tsPeakChrom: TTabSheet
              Caption = 'Peaks'
              ImageIndex = 3
              object chkOSPeakChrom: TCheckBox
                Left = 3
                Top = 217
                Width = 71
                Height = 17
                Action = actPeaksChrom
                Caption = 'Enabled'
                TabOrder = 0
              end
              object pcPeakMethodChrom: TPageControl
                Left = 0
                Top = 16
                Width = 170
                Height = 65
                ActivePage = SPTabChrom
                Align = alTop
                HotTrack = True
                TabOrder = 1
                OnChange = seSGDegreeChromChange
                object SPTabChrom: TTabSheet
                  Caption = 'Std. Peaking'
                  object Label5: TLabel
                    Left = 0
                    Top = 1
                    Width = 62
                    Height = 32
                    Caption = 'Peak Area Threshold'
                    WordWrap = True
                  end
                  object sePeakAreaChrom: TBMDSpinEdit
                    AlignWithMargins = True
                    Left = 88
                    Top = 5
                    Width = 71
                    Height = 28
                    Cursor = crArrow
                    Margins.Top = 5
                    Margins.Bottom = 5
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    Increment = 1.000000000000000000
                    MaxValue = 1000.000000000000000000
                    TrackBarEnabled = False
                    GuageHeight = -1
                  end
                end
                object FDTabChrom: TTabSheet
                  Caption = 'First Derv.'
                  ImageIndex = 1
                  object chkSeeFDChrom: TCheckBox
                    Left = 7
                    Top = 9
                    Width = 138
                    Height = 17
                    Caption = 'Show First Dev.'
                    TabOrder = 0
                    OnClick = seSGDegreeChromChange
                  end
                end
              end
              object Panel4: TPanel
                Left = 0
                Top = 0
                Width = 170
                Height = 16
                Align = alTop
                Caption = 'Method'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
              end
              object GroupBox9: TGroupBox
                Left = 0
                Top = 122
                Width = 170
                Height = 89
                Align = alTop
                Caption = ' Peak Param. Thresholds '
                TabOrder = 3
                object Label2: TLabel
                  Left = 16
                  Top = 30
                  Width = 36
                  Height = 16
                  Caption = 'Height'
                end
                object Label3: TLabel
                  Left = 6
                  Top = 57
                  Width = 63
                  Height = 16
                  Caption = 'Dist./Width'
                end
                object sePeakHeightChrom: TBMDSpinEdit
                  AlignWithMargins = True
                  Left = 80
                  Top = 21
                  Width = 71
                  Height = 28
                  Cursor = crArrow
                  Margins.Top = 5
                  Margins.Bottom = 5
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -15
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                  Increment = 1.000000000000000000
                  MaxValue = 1000.000000000000000000
                  TrackBarEnabled = False
                  GuageHeight = -1
                end
                object sePeakDistChrom: TBMDSpinEdit
                  Left = 80
                  Top = 55
                  Width = 71
                  Height = 28
                  Cursor = crArrow
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -15
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  Increment = 1.000000000000000000
                  MaxValue = 1000.000000000000000000
                  TrackBarEnabled = False
                  GuageHeight = -1
                end
              end
              object GroupBox11: TGroupBox
                Left = 0
                Top = 81
                Width = 170
                Height = 41
                Align = alTop
                TabOrder = 4
                object Label1: TLabel
                  Left = 16
                  Top = 15
                  Width = 57
                  Height = 16
                  Caption = 'Sensitivity'
                end
                object sePeakSenseChrom: TSpinEdit
                  Left = 95
                  Top = 6
                  Width = 66
                  Height = 26
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                end
              end
            end
            object tsRetTimes: TTabSheet
              Caption = 'Ret.time'
              ImageIndex = 4
              object sgRangesChrom: TStringGrid
                Left = 0
                Top = 0
                Width = 170
                Height = 214
                Align = alClient
                ColCount = 3
                DefaultColWidth = 62
                FixedCols = 0
                RowCount = 50
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goAlwaysShowEditor]
                TabOrder = 0
                OnKeyPress = sgRangesChromKeyPress
                OnSelectCell = sgRangesChromSelectCell
              end
              object Panel2: TPanel
                Left = 0
                Top = 214
                Width = 170
                Height = 28
                Align = alBottom
                BevelOuter = bvNone
                TabOrder = 1
                object bbClearRangesChrom: TBitBtn
                  Left = 0
                  Top = 0
                  Width = 89
                  Height = 25
                  Caption = 'Clear'
                  Enabled = False
                  Glyph.Data = {
                    42010000424D4201000000000000760000002800000011000000110000000100
                    040000000000CC00000000000000000000001000000010000000000000000000
                    BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
                    777770000000777777777777777770000000777777777777770F700000007777
                    0F777777777770000000777000F7777770F770000000777000F777770F777000
                    00007777000F77700F777000000077777000F700F7777000000077777700000F
                    7777700000007777777000F777777000000077777700000F7777700000007777
                    7000F70F7777700000007770000F77700F7770000000770000F7777700F77000
                    00007700F7777777700F70000000777777777777777770000000777777777777
                    777770000000}
                  Spacing = 8
                  TabOrder = 0
                  OnClick = bbClearRangesChromClick
                end
                object bbUpdateRangesChrom: TBitBtn
                  Left = 88
                  Top = 0
                  Width = 81
                  Height = 25
                  Caption = 'Update'
                  Enabled = False
                  Glyph.Data = {
                    F6000000424DF600000000000000760000002800000010000000100000000100
                    0400000000008000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888000000
                    78888888880CCCCC00788888880CCCCCC4088888880CCCCC4C40888888000000
                    C440888888888888004088888888888888008888088888888800888008888888
                    0040880C00000000C44080CCCCCCCCCC4C400CCCCCCCCCCCC40880CCCCCCCCCC
                    0088880C00000000788888800888888888888888088888888888}
                  TabOrder = 1
                  OnClick = bbUpdateRangesChromClick
                end
              end
            end
            object tsStatsChrom: TTabSheet
              Caption = 'Stats'
              ImageIndex = 5
              object lbTotalChrom: TLabel
                Left = 8
                Top = 8
                Width = 33
                Height = 18
                Caption = 'Total'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lbNPointsChrom: TLabel
                Left = 8
                Top = 32
                Width = 48
                Height = 18
                Caption = 'NPoints'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
            end
          end
          inline chrChrom: TvChart
            Left = 0
            Top = 0
            Width = 681
            Height = 300
            Align = alClient
            Anchors = []
            Constraints.MinHeight = 100
            Constraints.MinWidth = 150
            TabOrder = 1
            ExplicitWidth = 150
            ExplicitHeight = 300
            inherited pnlData: TPanel
              Width = 653
              Height = 300
              ExplicitWidth = 122
              ExplicitHeight = 300
              inherited Splitter2: TSplitter
                Height = 271
                Color = 13432823
                ExplicitHeight = 271
              end
              inherited sgData: TStringGrid
                Height = 271
                ExplicitHeight = 271
              end
              inherited sgPeaks: TStringGrid
                Width = 443
                Height = 271
                ExplicitWidth = 234
                ExplicitHeight = 271
              end
              inherited ToolBar2: TToolBar
                Width = 653
                ButtonWidth = 96
                ExplicitWidth = 122
                inherited tbSaveData: TToolButton
                  ExplicitWidth = 96
                end
                inherited tbCopyData: TToolButton
                  Left = 98
                  ExplicitLeft = 98
                  ExplicitWidth = 96
                end
                inherited ToolButton5: TToolButton
                  Left = 194
                  ExplicitLeft = 194
                end
                inherited tbSavePeaks: TToolButton
                  Left = 202
                  ExplicitLeft = 202
                  ExplicitWidth = 96
                end
                inherited tbCopyPeaks: TToolButton
                  Left = 298
                  ExplicitLeft = 298
                  ExplicitWidth = 96
                end
              end
            end
            inherited pnlChart: TPanel
              Width = 653
              Height = 300
              ExplicitWidth = 122
              ExplicitHeight = 300
              inherited chrChart: TChart
                Width = 653
                Height = 300
                OnMouseDown = chrChromchrChartMouseDown
                ExplicitWidth = 122
                ExplicitHeight = 300
                PrintMargins = (
                  15
                  23
                  15
                  23)
                inherited ctlColorBand: TColorBandTool
                  AxisID = 2
                end
              end
            end
            inherited pnlLeft: TPanel
              Height = 300
              ExplicitHeight = 300
              inherited tlbrManip: TToolBar
                AlignWithMargins = True
                Left = 3
                Top = 116
                Width = 25
                Height = 160
                Margins.Right = 0
                ExplicitLeft = 3
                ExplicitTop = 116
                ExplicitWidth = 25
                ExplicitHeight = 160
                inherited tbDataTable: TToolButton
                  Action = actDataTableChrom
                  OnMouseUp = chrChromtbDataTableMouseUp
                end
                inherited tbSmooth: TToolButton
                  Tag = 1
                  Action = actSmoothChrom
                  OnMouseUp = chrChromtbDataTableMouseUp
                end
                inherited tbBLine: TToolButton
                  Tag = 2
                  Action = actBLineChrom
                  OnMouseUp = chrChromtbDataTableMouseUp
                end
                inherited tbPeak: TToolButton
                  Tag = 3
                  Action = actPeaksChrom
                  OnMouseUp = chrChromtbDataTableMouseUp
                end
              end
              inherited Panel1: TPanel
                Top = 279
                ExplicitTop = 279
              end
              inherited ToolBar1: TToolBar
                inherited tbAutoY: TToolButton
                  Caption = 'actAutoYChrom'
                  ImageIndex = 9
                  OnClick = chrChromtbAutoYClick
                end
                inherited tbZoomMode: TToolButton
                  OnClick = chrChromtbZoomModeClick
                end
                inherited tbRangeMode: TToolButton
                  Tag = 4
                  OnClick = chrChromtbZoomModeClick
                end
              end
            end
            inherited ImageList1: TImageList
              Bitmap = {
                494C01010A000E00480010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
                0000000000003600000028000000400000003000000001002000000000000030
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                0000808080000000000080808000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000FF0000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                00000000000000000000FF000000000000000000000000000000000000000000
                000000000000000000000000800000008000000080000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000008080800000000000FF00
                0000000000000000000000000000000000000000FF0000000000000000000000
                000000000000FF00000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF0000000000000000000000000000000000FF0000000000000000000000
                0000FF0000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000FF0000000000000000000000000000000000FF0000000000000000000000
                0000FF0000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000FF00000000000000000000000000FF000000000000000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000FF00000000000000000000000000FF000000000000000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FF000000000000000000FF0000000000FF0000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                00000000000000000000FF000000000000000000FF0000000000FF0000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF0000000000FF00FF000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000000000000000000000000000FF00000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000800000008000000080000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                0000808080000000000080808000000000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                0000808080000000000080808000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FF000000FF000000FF000000FFFF0000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FF000000FF000000FF000000FFFF0000000000000000
                0000000000000000000000000000000000000000000000000000FF000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000000000FF000000
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000FF000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000FF0000000000
                00000000FF000000FF0000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                00000000000000000000000000000000000000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000000000FF00
                000000000000000000000000FF000000FF000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                FF000000000000000000FF000000FF0000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000FF000000000000000000000000000000000000000000FF000000FF000000
                FF00000000000000000000000000000000000000000000000000FF0000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000FF0000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000FF0000000000FF000000FF0000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF0000000000000000000000000000000000000000000000000000000000
                00000000FF000000FF00000000000000000000000000FF000000FF000000FF00
                0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
                0000FF000000FF00000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000FF0000000000000000000000000000000000FF000000FF00
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000FF00000000000000000000000000000000000000000000000000
                000000000000000000000000FF000000FF0000000000FFFF0000FF000000FFFF
                0000FFFF0000FFFF0000FFFF0000FF000000FFFF0000FFFF0000FFFF0000FFFF
                0000FF000000FFFF000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000FF00000000000000000000000000FF000000FF00
                00000000000000000000FF000000FF0000000000000000000000000000000000
                00000000000000000000FF000000000000000000000000000000000000000000
                0000FF000000FF00000000000000000000000000000000000000FFFF00000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000FFFF00000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000FF000000FF000000000000000000FF000000FF000000FF00000000000000
                00000000000000000000FF000000FF0000000000000080808000000000000000
                00000000000000000000FF00000000000000000000000000000000000000FF00
                00000000000000000000FF000000FF0000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF000000FF000000000000000000000000000000000000000000FF000000
                FF000000FF000000FF0000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000000000000000000000000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                000000000000000000000000FF000000FF000000000080808000000000000000
                0000000000000000000000000000FF0000000000000000000000FF0000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FF000000FF000000FF000000FFFF0000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FF000000FF000000FF000000FFFF0000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                0000FF000000FF00000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF000000FF00000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000FF0000000000000000000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000FF0000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000808080000000000000000000000000000000
                0000808080000000000000000000000000000000000000000000000000000000
                0000000000000000FF0000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
                C000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000FF0000000000000000000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000080808000FFFF0000FFFF0000C0C0C000C0C0C000C0C0
                C000C0C0C0008080800000000000000000000000000080808000000000000000
                00000000000000000000000000000000FF0000000000000000000000FF000000
                0000000000000000000080808000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00008080800000000000C0C0C000FFFF0000C0C0C000C0C0C000C0C0C000C0C0
                C000C0C0C000C0C0C00000000000808080000000000000000000000000000000
                0000000000000000FF0000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000C0C0C000FFFF0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
                C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
                000000000000000000000000FF0000000000000000000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
                C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
                00000000000000000000000000000000FF0000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
                C000C0C0C000FFFF0000C0C0C000000000000000000000000000000000000000
                0000000000000000FF0000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
                C000C0C0C000FFFF0000C0C0C000000000000000000080808000000000000000
                000000000000000000000000FF0000000000000000000000FF00000000000000
                0000000000000000000080808000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00008080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
                C000FFFF0000FFFF000000000000808080000000000000000000000000000000
                00000000000000000000000000000000FF0000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000080808000C0C0C000C0C0C000C0C0C000FFFF0000FFFF
                0000FFFF00008080800000000000000000000000000000000000000000000000
                0000000000000000FF0000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
                C000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000FF0000000000000000000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000808080000000000000000000000000000000
                0000808080000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000FF0000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
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
                000000000000000000000000FFFFFF000000FFFF000000005555F01F00000000
                3F7FFE7F000000005F7DFC3F000000002F7BFE7F000000007777FE7F00000000
                3777FE7F000000007B6FFE7F000000003B6FFE7F000000007D5FFE7F00000000
                3D5FFE7F000000007E3FFE7F000000003F7FFE7F000000007F7FFC3F00000000
                3F7FFE7F000000007F7FF01F00000000FFFFFFFF00000000F01FF01F55555555
                FE7FFE7F3FFF3FFFFC3FFC3F4FFF4FFFFE7FFE7F0FFF13FF7E7DFE7F5FFF6C7F
                7E7DFE7F2CFF378F5E75FE7F74FF77F30001FE7F3BCF3BFC0001FE7F7DCC7DF3
                5E75FE7F323C3DEC7E7DFE7F73C37EEFFE7FFE7F3F3C3EDFFC3FFC3F7F337F3F
                FE7FFE7F3FF33FFFF01FF01F7FFF7FFF9FFFF00FFFFFFFFF8FFFF5AFFFFFFFFF
                C7FFF6CFFFFFFFFFE207F36FEF78FFFFF003D5ABEF77C778F80196C9EF6FBB77
                F0008361EF6FBB6FF0007DBEEF6FFB6FF0007EDEEF6FC76FF0008361EF6FBF6F
                F00095A9EF77BB6FF000D6CB8378BB77F801F36FFFFFC778FC03F5AFFFFFFFFF
                FE07F6CFFFFFFFFFFFFFF00FFFFFFFFF00000000000000000000000000000000
                000000000000}
            end
            inherited ImageList2: TImageList
              Bitmap = {
                494C0101060009004C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
                0000000000003600000028000000400000002000000001002000000000000020
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
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
                FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000808080000000
                0000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
                FF0000FFFF000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000FFFFFF00FF000000FF000000FF00
                0000FF000000FF000000FFFFFF00000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000FFFF000000
                000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
                FF00FFFFFF000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000808080000000
                0000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
                FF0000FFFF000000000000000000000000000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FF000000FF000000FF00
                0000FF000000FF000000FFFFFF00000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000FFFF008080
                800000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
                FF00FFFFFF0000FFFF0080808000000000000000000000000000FFFFFF00FF00
                0000FF000000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000008080800000FF
                FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
                FF0000FFFF00FFFFFF0080808000000000000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FF000000FF000000FFFF
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000008080800000FF
                FF0000FFFF0080808000FFFF0000FFFF0000FFFF0000FFFF0000808080008080
                8000808080000000000000000000000000000000000000000000FFFFFF00FF00
                0000FF000000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
                FF0000000000FFFFFF0000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00008080800000FFFF0000000000FFFF0000FFFF0000FFFF0000808080008080
                8000808080000000000000000000000000000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000808080000000
                0000000000000000000000000000000000000000000000000000FFFFFF00FF00
                0000FF000000FFFFFF0000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000FFFF0000FFFF0000FFFF000000000000FFFF0000808080000000
                0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FFFF0000FFFF0000FFFF0000000000000000000080808000808080000000
                0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FFFF00000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF000000BF000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF0000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                0000808080000000000080808000000000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                0000808080000000000080808000000000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                00008080800000000000808080000000000000000000BF000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00BF0000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                00000000000000000000000000000000000000000000BF000000FFFFFF000000
                00000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
                00000000000000000000FFFFFF00BF0000000000000000000000FF000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000000000FF000000
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000FF0000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                00000000000000000000FF0000000000000000000000BF000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00BF0000000000000080808000FF000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000FF0000000000
                00000000FF000000FF0000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000008080800000000000FF00
                0000000000000000000000000000000000000000FF0000000000000000000000
                000000000000FF000000000000000000000000000000BF000000FFFFFF000000
                00000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
                00000000000000000000FFFFFF00BF00000000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000000000FF00
                000000000000000000000000FF000000FF000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF0000000000000000000000000000000000FF0000000000000000000000
                0000FF00000000000000000000000000000000000000BF000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00BF0000000000000080808000000000000000
                FF000000000000000000FF000000FF0000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000FF000000000000000000000000000000000000000000FF000000FF000000
                FF00000000000000000000000000000000000000000080808000000000000000
                0000FF0000000000000000000000000000000000FF0000000000000000000000
                0000FF00000000000000000000000000000000000000BF000000FFFFFF000000
                00000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
                00000000000000000000FFFFFF00BF0000000000000000000000000000000000
                00000000FF0000000000FF000000FF0000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF0000000000000000000000000000000000000000000000000000000000
                00000000FF000000FF0000000000000000000000000000000000000000000000
                000000000000FF00000000000000000000000000FF000000000000000000FF00
                00000000000000000000000000000000000000000000BF000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00BF0000000000000080808000000000000000
                0000000000000000FF0000000000000000000000000000000000FF000000FF00
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000FF00000000000000000000000000000000000000000000000000
                000000000000000000000000FF000000FF000000000080808000000000000000
                000000000000FF00000000000000000000000000FF000000000000000000FF00
                00000000000000000000000000000000000000000000BF000000FFFFFF000000
                00000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
                00000000000000000000FFFFFF00BF0000000000000000000000000000000000
                000000000000000000000000FF00000000000000000000000000FF000000FF00
                00000000000000000000FF000000FF0000000000000000000000000000000000
                00000000000000000000FF000000000000000000000000000000000000000000
                0000FF000000FF00000000000000000000000000000000000000000000000000
                00000000000000000000FF000000000000000000FF0000000000FF0000000000
                00000000000000000000000000000000000000000000BF000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00BF0000000000000080808000000000000000
                0000FF000000FF000000000000000000FF000000FF000000FF00000000000000
                00000000000000000000FF000000FF0000000000000080808000000000000000
                00000000000000000000FF00000000000000000000000000000000000000FF00
                00000000000000000000FF000000FF0000000000000080808000000000000000
                00000000000000000000FF000000000000000000FF0000000000FF0000000000
                00000000000000000000000000000000000000000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF000000BF000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF0000000000000000000000000000000000
                0000FF000000FF000000000000000000000000000000000000000000FF000000
                FF000000FF000000FF0000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000000000000000000000000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF0000000000FF00FF000000000000000000
                00000000000000000000000000000000000000000000BF000000FFFFFF00BF00
                0000BF000000BF000000FFFFFF00BF000000BF000000BF000000FFFFFF00BF00
                0000BF000000BF000000FFFFFF00BF0000000000000080808000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                000000000000000000000000FF000000FF000000000080808000000000000000
                0000000000000000000000000000FF0000000000000000000000FF0000000000
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000000000000000000000000000FF00000000000000000000000000
                00000000000000000000000000000000000000000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF000000BF000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF0000000000000000000000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                0000FF000000FF00000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF000000FF00000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                000000000000000000000000000000000000424D3E000000000000003E000000
                2800000040000000200000000100010000000000000100000000000000000000
                000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFE0000000000
                8007FE00000000008003FE000000000080038000000000008003800000000000
                8001800000000000800180000000000080078001000000008007800300000000
                F01F800700000000F01F807F00000000F09F80FF00000000F3FF81FF00000000
                F7FFFFFF00000000FFFFFFFF00000000FFFF0000000000008000555555555555
                80003FFF3FFF3F7F80004FFF4FFF5F7D80000FFF13FF2F7B80005FFF6C7F7777
                80002CFF378F3777800074FF77F37B6F80003BCF3BFC3B6F80007DCC7DF37D5F
                8000323C3DEC3D5F800073C37EEF7E3F80003F3C3EDF3F7F80007F337F3F7F7F
                FFFF3FF33FFF3F7FFFFF7FFF7FFF7F7F00000000000000000000000000000000
                000000000000}
            end
            inherited SaveDialog1: TSaveDialog
              Left = 360
              Top = 152
            end
          end
        end
        object pnlMass: TPanel
          Left = 0
          Top = 303
          Width = 862
          Height = 394
          Align = alClient
          BevelOuter = bvNone
          Caption = 'mass pane'
          ParentColor = True
          TabOrder = 1
          ExplicitWidth = 331
          ExplicitHeight = 100
          object SplitterMass: TSplitter
            Left = 681
            Top = 0
            Height = 394
            Align = alRight
            Color = 13432823
            ParentColor = False
            Visible = False
            ExplicitLeft = 150
            ExplicitHeight = 100
          end
          object pcMass: TPageControl
            Left = 684
            Top = 0
            Width = 178
            Height = 394
            ActivePage = tsVisualMass
            Align = alRight
            Constraints.MaxWidth = 200
            Constraints.MinWidth = 150
            HotTrack = True
            MultiLine = True
            TabHeight = 24
            TabOrder = 0
            Visible = False
            ExplicitLeft = 153
            ExplicitHeight = 100
            object tsVisualMass: TTabSheet
              Caption = 'Visual'
              ImageIndex = -1
              ExplicitHeight = 42
              object rgShowMass: TRadioGroup
                Left = 0
                Top = 0
                Width = 170
                Height = 65
                Align = alTop
                Caption = ' Show '
                ItemIndex = 0
                Items.Strings = (
                  'Chart'
                  'Data/Peak tables')
                TabOrder = 0
                OnClick = actDataTableMassExecute
              end
              object Panel8: TPanel
                Left = 0
                Top = 65
                Width = 170
                Height = 96
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                DesignSize = (
                  170
                  96)
                object Label13: TLabel
                  Left = 32
                  Top = 40
                  Width = 108
                  Height = 48
                  Caption = 'Include current chart into template setting'
                  Visible = False
                  WordWrap = True
                  OnClick = Label13Click
                end
                object chkSaveChartMass: TCheckBox
                  Left = 8
                  Top = 47
                  Width = 17
                  Height = 17
                  TabOrder = 0
                  Visible = False
                end
                object bbEditorMass: TBitBtn
                  Left = 4
                  Top = 8
                  Width = 157
                  Height = 28
                  Anchors = [akLeft, akTop, akRight]
                  Caption = 'Chart Editor'
                  Glyph.Data = {
                    42010000424D4201000000000000760000002800000011000000110000000100
                    040000000000CC00000000000000000000001000000010000000000000000000
                    BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
                    7777700000007000000000000007700000007077707777770707700000007070
                    707077070707700000007000000000000007700000007770EEEEEEE077777000
                    00007770E0000E077777700000007770E070E0077777700000007770E00EE700
                    7777700000007770E0EE07000777700000007770EEE0770FF077700000007770
                    EE07770FF077700000007770E0777770FF0770000000777007777770F0077000
                    00007770777777770FF070000000777777777777000770000000777777777777
                    777770000000}
                  Spacing = 20
                  TabOrder = 1
                  OnClick = bbEditorMassClick
                end
              end
              object grpOpenMass: TGroupBox
                Left = 0
                Top = 201
                Width = 170
                Height = 53
                Align = alBottom
                Caption = ' Open MS from Text '
                TabOrder = 2
                Visible = False
                ExplicitTop = -93
                DesignSize = (
                  170
                  53)
                object bbOpenSMass: TBitBtn
                  Left = 4
                  Top = 19
                  Width = 77
                  Height = 30
                  Anchors = [akLeft, akTop, akRight]
                  Caption = ' File'
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
                  TabOrder = 0
                  OnClick = bbOpenDataClick
                end
                object bbPasteSMass: TBitBtn
                  Left = 88
                  Top = 19
                  Width = 75
                  Height = 30
                  Caption = 'Paste'
                  Glyph.Data = {
                    76010000424D7601000000000000760000002800000020000000100000000100
                    04000000000000010000130B0000130B00001000000000000000000000000000
                    800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003333330FFFFF
                    FFF03333337F3FFFF3F73333330F0000F0F03333337F777737373333330FFFFF
                    FFF033FFFF7FFF33FFF77000000007F00000377777777FF777770BBBBBBBB0F0
                    FF037777777777F7F3730B77777BB0F0F0337777777777F7F7330B7FFFFFB0F0
                    0333777F333377F77F330B7FFFFFB0009333777F333377777FF30B7FFFFFB039
                    9933777F333377F777FF0B7FFFFFB0999993777F33337777777F0B7FFFFFB999
                    9999777F3333777777770B7FFFFFB0399933777FFFFF77F777F3070077007039
                    99337777777777F777F30B770077B039993377FFFFFF77F777330BB7007BB999
                    93337777FF777777733370000000073333333777777773333333}
                  NumGlyphs = 2
                  TabOrder = 1
                  OnClick = bbPasteSMassClick
                end
              end
              object rgXUnitsMass: TRadioGroup
                Left = 0
                Top = 254
                Width = 170
                Height = 41
                Align = alBottom
                Caption = ' X-axis units (amu) '
                Columns = 2
                ItemIndex = 0
                Items.Strings = (
                  'raw'
                  'nominal')
                TabOrder = 3
                OnClick = rgXUnitsMassClick
                ExplicitTop = -40
              end
              object GroupBox8: TGroupBox
                Left = 0
                Top = 295
                Width = 170
                Height = 41
                Align = alBottom
                Caption = ' Y-axis units '
                TabOrder = 4
                ExplicitTop = 1
                object chkFixYMass: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 65
                  Height = 17
                  Caption = 'Fixed Y'
                  TabOrder = 0
                  OnClick = chkFixYMassClick
                end
                object rbAbsYMass: TRadioButton
                  Left = 80
                  Top = 16
                  Width = 50
                  Height = 17
                  Caption = 'abs.'
                  Checked = True
                  TabOrder = 1
                  TabStop = True
                  OnClick = rgYUnitsMassClick
                end
                object rbPercYMass: TRadioButton
                  Left = 128
                  Top = 15
                  Width = 35
                  Height = 17
                  Caption = '%'
                  TabOrder = 2
                  OnClick = rgYUnitsMassClick
                end
              end
            end
            object tsSmoothMass: TTabSheet
              Caption = 'Smooth'
              ImageIndex = 1
              object GroupBox1: TGroupBox
                Left = 0
                Top = 0
                Width = 170
                Height = 57
                Align = alTop
                Caption = 'Savitzky-Golay'
                TabOrder = 0
                object seSGDegreeMass: TSpinEdit
                  Left = 104
                  Top = 16
                  Width = 57
                  Height = 26
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                end
              end
              object chkOSSmoothMass: TCheckBox
                Left = 8
                Top = 72
                Width = 81
                Height = 17
                Action = actSmoothMass
                Caption = 'Enabled'
                TabOrder = 1
              end
            end
            object tsBLineMass: TTabSheet
              Caption = 'B-line'
              ImageIndex = 2
              object chkOSBlineMass: TCheckBox
                Left = 8
                Top = 64
                Width = 71
                Height = 17
                Action = actBLineMass
                Caption = 'Enabled'
                TabOrder = 0
              end
              object GroupBox3: TGroupBox
                Left = 0
                Top = 0
                Width = 170
                Height = 58
                Align = alTop
                Caption = 'Threshold'
                TabOrder = 1
                object chkAutoTSMass: TCheckBox
                  Left = 8
                  Top = 24
                  Width = 57
                  Height = 17
                  Caption = 'Auto'
                  TabOrder = 0
                  OnClick = chkAutoTSMassClick
                end
                object seTSBlineMass: TBMDSpinEdit
                  AlignWithMargins = True
                  Left = 71
                  Top = 21
                  Width = 94
                  Height = 28
                  Cursor = crArrow
                  Margins.Bottom = 5
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -15
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  Increment = 1.000000000000000000
                  MaxValue = 100.000000000000000000
                  TrackBarEnabled = False
                  GuageHeight = -1
                end
              end
            end
            object tsPeakMass: TTabSheet
              Caption = 'Peak'
              ImageIndex = 3
              object chkOSPeakMass: TCheckBox
                Left = 8
                Top = 230
                Width = 89
                Height = 17
                Action = actPeaksMass
                Caption = 'Enabled'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object pcPeakMethodMass: TPageControl
                Left = 0
                Top = 16
                Width = 170
                Height = 65
                ActivePage = tsAdaptMethod
                Align = alTop
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = []
                HotTrack = True
                ParentFont = False
                TabOrder = 1
                OnChange = seSGDegreeMassChange
                object tsStdMethod: TTabSheet
                  Caption = 'Standr.'
                  object Label10: TLabel
                    Left = 6
                    Top = 1
                    Width = 62
                    Height = 32
                    Caption = 'Peak Area Threshold'
                    Transparent = True
                    WordWrap = True
                  end
                  object sePeakAreaMass: TBMDSpinEdit
                    Left = 87
                    Top = 2
                    Width = 67
                    Height = 28
                    Cursor = crArrow
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    Increment = 1.000000000000000000
                    MaxValue = 1000.000000000000000000
                    TrackBarEnabled = False
                    GuageHeight = -1
                  end
                end
                object ts1DivMethod: TTabSheet
                  Caption = '1st Drv.'
                  ImageIndex = 1
                  object chkSeeFDMass: TCheckBox
                    Left = 7
                    Top = 8
                    Width = 146
                    Height = 17
                    Caption = 'Show First Dev.'
                    TabOrder = 0
                    OnClick = seSGDegreeMassChange
                  end
                end
                object tsAdaptMethod: TTabSheet
                  Caption = 'Adapt.'
                  ImageIndex = 2
                  object Label11: TLabel
                    Left = 8
                    Top = 8
                    Width = 131
                    Height = 16
                    Caption = 'Adaptive to mass scale'
                  end
                end
              end
              object Panel3: TPanel
                Left = 0
                Top = 0
                Width = 170
                Height = 16
                Align = alTop
                Caption = 'Method'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
              end
              object gbPeakParamMass: TGroupBox
                Left = 0
                Top = 123
                Width = 170
                Height = 88
                Align = alTop
                Caption = ' Peak Param. Thresholds '
                TabOrder = 3
                object Label6: TLabel
                  Left = 24
                  Top = 30
                  Width = 36
                  Height = 16
                  Caption = 'Height'
                end
                object Label7: TLabel
                  Left = 7
                  Top = 59
                  Width = 63
                  Height = 16
                  Caption = 'Dist./Width'
                end
                object sePeakHeightMass: TBMDSpinEdit
                  AlignWithMargins = True
                  Left = 80
                  Top = 21
                  Width = 71
                  Height = 28
                  Cursor = crArrow
                  Margins.Top = 5
                  Margins.Bottom = 5
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -15
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                  Increment = 1.000000000000000000
                  MaxValue = 1000.000000000000000000
                  TrackBarEnabled = False
                  GuageHeight = -1
                end
                object sePeakDistMass: TBMDSpinEdit
                  Left = 80
                  Top = 55
                  Width = 71
                  Height = 28
                  Cursor = crArrow
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -15
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  Increment = 1.000000000000000000
                  MaxValue = 1000.000000000000000000
                  TrackBarEnabled = False
                  GuageHeight = -1
                end
              end
              object gbPeakSensivMass: TGroupBox
                Left = 0
                Top = 81
                Width = 170
                Height = 42
                Align = alTop
                TabOrder = 4
                object Label4: TLabel
                  Left = 24
                  Top = 15
                  Width = 57
                  Height = 16
                  Caption = 'Sensitivity'
                end
                object sePeakSenseMass: TSpinEdit
                  Left = 87
                  Top = 6
                  Width = 65
                  Height = 26
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                end
              end
            end
            object tsSIC: TTabSheet
              Caption = 'SIC'
              ImageIndex = 4
              object sgRangesMass: TStringGrid
                Left = 0
                Top = 0
                Width = 170
                Height = 308
                Align = alClient
                ColCount = 3
                DefaultColWidth = 62
                FixedCols = 0
                RowCount = 50
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goAlwaysShowEditor]
                TabOrder = 0
                OnKeyPress = sgRangesMassKeyPress
                OnSelectCell = sgRangesChromSelectCell
              end
              object Panel1: TPanel
                Left = 0
                Top = 308
                Width = 170
                Height = 28
                Align = alBottom
                BevelOuter = bvNone
                TabOrder = 1
                object bbClearRangesMass: TBitBtn
                  Left = 0
                  Top = 0
                  Width = 89
                  Height = 25
                  Caption = 'Clear'
                  Enabled = False
                  Glyph.Data = {
                    42010000424D4201000000000000760000002800000011000000110000000100
                    040000000000CC00000000000000000000001000000010000000000000000000
                    BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
                    777770000000777777777777777770000000777777777777770F700000007777
                    0F777777777770000000777000F7777770F770000000777000F777770F777000
                    00007777000F77700F777000000077777000F700F7777000000077777700000F
                    7777700000007777777000F777777000000077777700000F7777700000007777
                    7000F70F7777700000007770000F77700F7770000000770000F7777700F77000
                    00007700F7777777700F70000000777777777777777770000000777777777777
                    777770000000}
                  Spacing = 8
                  TabOrder = 0
                  OnClick = bbClearRangesMassClick
                end
                object bbUpdateRangesMass: TBitBtn
                  Left = 88
                  Top = 0
                  Width = 81
                  Height = 25
                  Caption = 'Update'
                  Enabled = False
                  Glyph.Data = {
                    F6000000424DF600000000000000760000002800000010000000100000000100
                    0400000000008000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888000000
                    78888888880CCCCC00788888880CCCCCC4088888880CCCCC4C40888888000000
                    C440888888888888004088888888888888008888088888888800888008888888
                    0040880C00000000C44080CCCCCCCCCC4C400CCCCCCCCCCCC40880CCCCCCCCCC
                    0088880C00000000788888800888888888888888088888888888}
                  TabOrder = 1
                  OnClick = bbUpdateRangesMassClick
                end
              end
            end
            object tsStatsMass: TTabSheet
              Caption = 'Stats'
              ImageIndex = 5
              object lbRetTime: TLabel
                Left = 8
                Top = 8
                Width = 55
                Height = 18
                Caption = 'RetTime'
                Color = clBtnFace
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentColor = False
                ParentFont = False
              end
              object lbNPointsMass: TLabel
                Left = 8
                Top = 32
                Width = 48
                Height = 18
                Caption = 'NPoints'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lbFromMass: TLabel
                Left = 8
                Top = 56
                Width = 34
                Height = 18
                Caption = 'From'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lbToMass: TLabel
                Left = 78
                Top = 56
                Width = 18
                Height = 18
                Caption = 'To'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lbNPeaksMass: TLabel
                Left = 8
                Top = 104
                Width = 48
                Height = 18
                Caption = 'NPoints'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lbTotalMass: TLabel
                Left = 8
                Top = 80
                Width = 33
                Height = 18
                Caption = 'Total'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clNavy
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
            end
          end
          inline chrMass: TvChart
            Left = 0
            Top = 0
            Width = 681
            Height = 394
            Align = alClient
            Anchors = []
            Constraints.MinHeight = 100
            Constraints.MinWidth = 150
            Ctl3D = True
            ParentCtl3D = False
            TabOrder = 1
            ExplicitWidth = 150
            ExplicitHeight = 100
            inherited pnlData: TPanel
              Width = 653
              Height = 394
              ExplicitWidth = 122
              ExplicitHeight = 100
              inherited Splitter2: TSplitter
                Height = 365
                Color = 13432823
                ExplicitHeight = 71
              end
              inherited sgData: TStringGrid
                Height = 365
                ExplicitHeight = 71
              end
              inherited sgPeaks: TStringGrid
                Width = 443
                Height = 365
                ExplicitWidth = 234
                ExplicitHeight = 71
              end
              inherited ToolBar2: TToolBar
                Width = 653
                ButtonWidth = 96
                ExplicitWidth = 122
                inherited tbSaveData: TToolButton
                  ExplicitWidth = 96
                end
                inherited tbCopyData: TToolButton
                  Left = 98
                  ExplicitLeft = 98
                  ExplicitWidth = 96
                end
                inherited ToolButton5: TToolButton
                  Left = 194
                  ExplicitLeft = 194
                end
                inherited tbSavePeaks: TToolButton
                  Left = 202
                  ExplicitLeft = 202
                  ExplicitWidth = 96
                end
                inherited tbCopyPeaks: TToolButton
                  Left = 298
                  ExplicitLeft = 298
                  ExplicitWidth = 96
                end
              end
            end
            inherited pnlChart: TPanel
              Width = 653
              Height = 394
              ExplicitWidth = 122
              ExplicitHeight = 100
              inherited chrChart: TChart
                Width = 653
                Height = 394
                OnMouseDown = chrMasschrChartMouseDown
                OnMouseUp = chrMasschrChartMouseUp
                ExplicitWidth = 122
                ExplicitHeight = 100
                PrintMargins = (
                  15
                  23
                  15
                  23)
                inherited ctlColorBand: TColorBandTool
                  AxisID = 2
                end
              end
            end
            inherited pnlLeft: TPanel
              Height = 394
              ExplicitHeight = 100
              inherited tlbrManip: TToolBar
                AlignWithMargins = True
                Left = 3
                Top = 116
                Width = 25
                Height = 254
                Margins.Right = 0
                OnMouseUp = chrMasstlbrManipMouseUp
                ExplicitLeft = 3
                ExplicitTop = 116
                ExplicitWidth = 25
                ExplicitHeight = 156
                inherited tbDataTable: TToolButton
                  Action = actDataTableMass
                  OnMouseUp = chrMasstbDataTableMouseUp
                end
                inherited tbSmooth: TToolButton
                  Tag = 1
                  Action = actSmoothMass
                  OnMouseUp = chrMasstbDataTableMouseUp
                end
                inherited tbBLine: TToolButton
                  Tag = 2
                  Action = actBLineMass
                  OnMouseUp = chrMasstbDataTableMouseUp
                end
                inherited tbPeak: TToolButton
                  Tag = 3
                  Action = actPeaksMass
                  OnMouseUp = chrMasstbDataTableMouseUp
                end
              end
              inherited Panel1: TPanel
                Top = 373
                ExplicitTop = 79
              end
              inherited ToolBar1: TToolBar
                inherited tbAutoY: TToolButton
                  Caption = 'actAutoYMass'
                  ImageIndex = 9
                end
                inherited tbZoomMode: TToolButton
                  OnClick = chrMasstbZoomModeClick
                end
                inherited tbRangeMode: TToolButton
                  Tag = 4
                  OnClick = chrMasstbZoomModeClick
                end
              end
            end
            inherited ImageList1: TImageList
              Bitmap = {
                494C01010A000E00480010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
                0000000000003600000028000000400000003000000001002000000000000030
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                0000808080000000000080808000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000FF0000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                00000000000000000000FF000000000000000000000000000000000000000000
                000000000000000000000000800000008000000080000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000008080800000000000FF00
                0000000000000000000000000000000000000000FF0000000000000000000000
                000000000000FF00000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF0000000000000000000000000000000000FF0000000000000000000000
                0000FF0000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000FF0000000000000000000000000000000000FF0000000000000000000000
                0000FF0000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000FF00000000000000000000000000FF000000000000000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000FF00000000000000000000000000FF000000000000000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FF000000000000000000FF0000000000FF0000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                00000000000000000000FF000000000000000000FF0000000000FF0000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF0000000000FF00FF000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000000000000000000000000000FF00000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000800000008000000080000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000080000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                0000808080000000000080808000000000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                0000808080000000000080808000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FF000000FF000000FF000000FFFF0000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FF000000FF000000FF000000FFFF0000000000000000
                0000000000000000000000000000000000000000000000000000FF000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000000000FF000000
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000FF000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000FF0000000000
                00000000FF000000FF0000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                00000000000000000000000000000000000000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000000000FF00
                000000000000000000000000FF000000FF000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                FF000000000000000000FF000000FF0000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000FF000000000000000000000000000000000000000000FF000000FF000000
                FF00000000000000000000000000000000000000000000000000FF0000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000FF0000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000FF0000000000FF000000FF0000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF0000000000000000000000000000000000000000000000000000000000
                00000000FF000000FF00000000000000000000000000FF000000FF000000FF00
                0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
                0000FF000000FF00000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000FF0000000000000000000000000000000000FF000000FF00
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000FF00000000000000000000000000000000000000000000000000
                000000000000000000000000FF000000FF0000000000FFFF0000FF000000FFFF
                0000FFFF0000FFFF0000FFFF0000FF000000FFFF0000FFFF0000FFFF0000FFFF
                0000FF000000FFFF000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000FF00000000000000000000000000FF000000FF00
                00000000000000000000FF000000FF0000000000000000000000000000000000
                00000000000000000000FF000000000000000000000000000000000000000000
                0000FF000000FF00000000000000000000000000000000000000FFFF00000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000FFFF00000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000FF000000FF000000000000000000FF000000FF000000FF00000000000000
                00000000000000000000FF000000FF0000000000000080808000000000000000
                00000000000000000000FF00000000000000000000000000000000000000FF00
                00000000000000000000FF000000FF0000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF000000FF000000000000000000000000000000000000000000FF000000
                FF000000FF000000FF0000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000000000000000000000000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                000000000000000000000000FF000000FF000000000080808000000000000000
                0000000000000000000000000000FF0000000000000000000000FF0000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FF000000FF000000FF000000FFFF0000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FF000000FF000000FF000000FFFF0000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                0000FF000000FF00000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000FFFF000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF000000FF00000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000FF0000000000000000000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000FF0000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000808080000000000000000000000000000000
                0000808080000000000000000000000000000000000000000000000000000000
                0000000000000000FF0000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
                C000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000FF0000000000000000000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000080808000FFFF0000FFFF0000C0C0C000C0C0C000C0C0
                C000C0C0C0008080800000000000000000000000000080808000000000000000
                00000000000000000000000000000000FF0000000000000000000000FF000000
                0000000000000000000080808000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00008080800000000000C0C0C000FFFF0000C0C0C000C0C0C000C0C0C000C0C0
                C000C0C0C000C0C0C00000000000808080000000000000000000000000000000
                0000000000000000FF0000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000C0C0C000FFFF0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
                C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
                000000000000000000000000FF0000000000000000000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
                C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
                00000000000000000000000000000000FF0000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
                C000C0C0C000FFFF0000C0C0C000000000000000000000000000000000000000
                0000000000000000FF0000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
                C000C0C0C000FFFF0000C0C0C000000000000000000080808000000000000000
                000000000000000000000000FF0000000000000000000000FF00000000000000
                0000000000000000000080808000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00008080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
                C000FFFF0000FFFF000000000000808080000000000000000000000000000000
                00000000000000000000000000000000FF0000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000080808000C0C0C000C0C0C000C0C0C000FFFF0000FFFF
                0000FFFF00008080800000000000000000000000000000000000000000000000
                0000000000000000FF0000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
                C000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000FF0000000000000000000000FF00000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000808080000000000000000000000000000000
                0000808080000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000FF0000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
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
                000000000000000000000000FFFFFF000000FFFF000000005555F01F00000000
                3F7FFE7F000000005F7DFC3F000000002F7BFE7F000000007777FE7F00000000
                3777FE7F000000007B6FFE7F000000003B6FFE7F000000007D5FFE7F00000000
                3D5FFE7F000000007E3FFE7F000000003F7FFE7F000000007F7FFC3F00000000
                3F7FFE7F000000007F7FF01F00000000FFFFFFFF00000000F01FF01F55555555
                FE7FFE7F3FFF3FFFFC3FFC3F4FFF4FFFFE7FFE7F0FFF13FF7E7DFE7F5FFF6C7F
                7E7DFE7F2CFF378F5E75FE7F74FF77F30001FE7F3BCF3BFC0001FE7F7DCC7DF3
                5E75FE7F323C3DEC7E7DFE7F73C37EEFFE7FFE7F3F3C3EDFFC3FFC3F7F337F3F
                FE7FFE7F3FF33FFFF01FF01F7FFF7FFF9FFFF00FFFFFFFFF8FFFF5AFFFFFFFFF
                C7FFF6CFFFFFFFFFE207F36FEF78FFFFF003D5ABEF77C778F80196C9EF6FBB77
                F0008361EF6FBB6FF0007DBEEF6FFB6FF0007EDEEF6FC76FF0008361EF6FBF6F
                F00095A9EF77BB6FF000D6CB8378BB77F801F36FFFFFC778FC03F5AFFFFFFFFF
                FE07F6CFFFFFFFFFFFFFF00FFFFFFFFF00000000000000000000000000000000
                000000000000}
            end
            inherited ImageList2: TImageList
              Bitmap = {
                494C0101060009004C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
                0000000000003600000028000000400000002000000001002000000000000020
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
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
                FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000808080000000
                0000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
                FF0000FFFF000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000FFFFFF00FF000000FF000000FF00
                0000FF000000FF000000FFFFFF00000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000FFFF000000
                000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
                FF00FFFFFF000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000808080000000
                0000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
                FF0000FFFF000000000000000000000000000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FF000000FF000000FF00
                0000FF000000FF000000FFFFFF00000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000FFFF008080
                800000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
                FF00FFFFFF0000FFFF0080808000000000000000000000000000FFFFFF00FF00
                0000FF000000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000008080800000FF
                FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
                FF0000FFFF00FFFFFF0080808000000000000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FF000000FF000000FFFF
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000008080800000FF
                FF0000FFFF0080808000FFFF0000FFFF0000FFFF0000FFFF0000808080008080
                8000808080000000000000000000000000000000000000000000FFFFFF00FF00
                0000FF000000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
                FF0000000000FFFFFF0000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00008080800000FFFF0000000000FFFF0000FFFF0000FFFF0000808080008080
                8000808080000000000000000000000000000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000808080000000
                0000000000000000000000000000000000000000000000000000FFFFFF00FF00
                0000FF000000FFFFFF0000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000FFFF0000FFFF0000FFFF000000000000FFFF0000808080000000
                0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FFFF0000FFFF0000FFFF0000000000000000000080808000808080000000
                0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FFFF00000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF000000BF000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF0000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                0000808080000000000080808000000000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                0000808080000000000080808000000000000000000000000000808080000000
                0000808080000000000080808000000000008080800000000000808080000000
                00008080800000000000808080000000000000000000BF000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00BF0000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                00000000000000000000000000000000000000000000BF000000FFFFFF000000
                00000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
                00000000000000000000FFFFFF00BF0000000000000000000000FF000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000000000FF000000
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000FF0000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                00000000000000000000FF0000000000000000000000BF000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00BF0000000000000080808000FF000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000FF0000000000
                00000000FF000000FF0000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000008080800000000000FF00
                0000000000000000000000000000000000000000FF0000000000000000000000
                000000000000FF000000000000000000000000000000BF000000FFFFFF000000
                00000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
                00000000000000000000FFFFFF00BF00000000000000000000000000FF000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000000000FF00
                000000000000000000000000FF000000FF000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF0000000000000000000000000000000000FF0000000000000000000000
                0000FF00000000000000000000000000000000000000BF000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00BF0000000000000080808000000000000000
                FF000000000000000000FF000000FF0000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000FF000000000000000000000000000000000000000000FF000000FF000000
                FF00000000000000000000000000000000000000000080808000000000000000
                0000FF0000000000000000000000000000000000FF0000000000000000000000
                0000FF00000000000000000000000000000000000000BF000000FFFFFF000000
                00000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
                00000000000000000000FFFFFF00BF0000000000000000000000000000000000
                00000000FF0000000000FF000000FF0000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF0000000000000000000000000000000000000000000000000000000000
                00000000FF000000FF0000000000000000000000000000000000000000000000
                000000000000FF00000000000000000000000000FF000000000000000000FF00
                00000000000000000000000000000000000000000000BF000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00BF0000000000000080808000000000000000
                0000000000000000FF0000000000000000000000000000000000FF000000FF00
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000FF00000000000000000000000000000000000000000000000000
                000000000000000000000000FF000000FF000000000080808000000000000000
                000000000000FF00000000000000000000000000FF000000000000000000FF00
                00000000000000000000000000000000000000000000BF000000FFFFFF000000
                00000000000000000000FFFFFF00000000000000000000000000FFFFFF000000
                00000000000000000000FFFFFF00BF0000000000000000000000000000000000
                000000000000000000000000FF00000000000000000000000000FF000000FF00
                00000000000000000000FF000000FF0000000000000000000000000000000000
                00000000000000000000FF000000000000000000000000000000000000000000
                0000FF000000FF00000000000000000000000000000000000000000000000000
                00000000000000000000FF000000000000000000FF0000000000FF0000000000
                00000000000000000000000000000000000000000000BF000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00BF0000000000000080808000000000000000
                0000FF000000FF000000000000000000FF000000FF000000FF00000000000000
                00000000000000000000FF000000FF0000000000000080808000000000000000
                00000000000000000000FF00000000000000000000000000000000000000FF00
                00000000000000000000FF000000FF0000000000000080808000000000000000
                00000000000000000000FF000000000000000000FF0000000000FF0000000000
                00000000000000000000000000000000000000000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF000000BF000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF0000000000000000000000000000000000
                0000FF000000FF000000000000000000000000000000000000000000FF000000
                FF000000FF000000FF0000000000000000000000000000000000000000000000
                0000000000000000000000000000FF000000000000000000000000000000FF00
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000FF0000000000FF00FF000000000000000000
                00000000000000000000000000000000000000000000BF000000FFFFFF00BF00
                0000BF000000BF000000FFFFFF00BF000000BF000000BF000000FFFFFF00BF00
                0000BF000000BF000000FFFFFF00BF0000000000000080808000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                000000000000000000000000FF000000FF000000000080808000000000000000
                0000000000000000000000000000FF0000000000000000000000FF0000000000
                0000000000000000000000000000000000000000000080808000000000000000
                000000000000000000000000000000000000FF00000000000000000000000000
                00000000000000000000000000000000000000000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF000000BF000000BF000000BF000000BF00
                0000BF000000BF000000BF000000BF0000000000000000000000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                0000FF000000FF00000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000FF000000FF000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000FF000000FF00000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000080808000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000FF0000000000000000000000
                000000000000000000000000000000000000424D3E000000000000003E000000
                2800000040000000200000000100010000000000000100000000000000000000
                000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFE0000000000
                8007FE00000000008003FE000000000080038000000000008003800000000000
                8001800000000000800180000000000080078001000000008007800300000000
                F01F800700000000F01F807F00000000F09F80FF00000000F3FF81FF00000000
                F7FFFFFF00000000FFFFFFFF00000000FFFF0000000000008000555555555555
                80003FFF3FFF3F7F80004FFF4FFF5F7D80000FFF13FF2F7B80005FFF6C7F7777
                80002CFF378F3777800074FF77F37B6F80003BCF3BFC3B6F80007DCC7DF37D5F
                8000323C3DEC3D5F800073C37EEF7E3F80003F3C3EDF3F7F80007F337F3F7F7F
                FFFF3FF33FFF3F7FFFFF7FFF7FFF7F7F00000000000000000000000000000000
                000000000000}
            end
            inherited SaveDialog1: TSaveDialog
              Left = 360
            end
          end
        end
      end
    end
    object ts3D: TTabSheet
      Caption = '  3D'
      ImageIndex = 1
      object chr3D: TChart
        Left = 33
        Top = 0
        Width = 829
        Height = 697
        BackWall.Color = clWhite
        BackWall.Transparent = False
        Legend.Visible = False
        MarginBottom = 2
        MarginLeft = 2
        MarginRight = 2
        MarginTop = 2
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        Chart3DPercent = 30
        Align = alClient
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 0
        object srs3D: TWaterFallSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          ShowInLegend = False
          SideBrush.Color = clWhite
          SideBrush.Style = bsClear
          UseColorRange = False
          UsePalette = True
          XValues.Name = 'X'
          XValues.Order = loNone
          YValues.Name = 'Y'
          YValues.Order = loNone
          ZValues.Name = 'Z'
          ZValues.Order = loNone
        end
        object ChartTool1: TPageNumTool
          Active = False
          Callout.Brush.Color = clBlack
          Callout.Arrow.Visible = False
          Shape.Text = 'Page 1 of 1'
          Text = 'Page 1 of 1'
          DisabledButton.EndColor = clSilver
          DisabledButton.Visible = True
          EnabledButton.EndColor = clSilver
          EnabledButton.StartColor = clBlack
          EnabledButton.Visible = True
        end
      end
      object TeeCommander1: TTeeCommander
        Left = 0
        Top = 0
        Width = 33
        Height = 697
        Panel = chr3D
        Vertical = True
        Align = alLeft
        ParentShowHint = False
        TabOrder = 1
      end
    end
  end
  object ImageList1: TImageList
    Height = 80
    Width = 18
    Left = 864
    Top = 560
    Bitmap = {
      494C010103000400480012005000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000048000000500000000100200000000000005A
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000000000000000000000000000000000000
      0000000000000000800000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      0000000000000000000000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      0000000000000000000000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000000000000000000000000000000000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000000000000000000000000000000000
      0000000000000000000000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000800000008000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000000000000000000000000000000000000
      0000000000000000800000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000800000008000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000080000000
      8000000080000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000000800000008000000080000000
      8000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      2800000048000000500000000100010000000000C00300000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFC0000000000FFFFFFFF
      FFFFFC0000000000FFFFFFFFFFFFFC0000000000FFFFFFFFFFFFFC0000000000
      FFFFFFFFFFFFFC0000000000FFFFFFFFFFFFFC0000000000FFFFFFFFFFFFFC00
      00000000FFFFFFFFFFFFFC0000000000FFFFFFFFFFFFFC0000000000FFFFFFFF
      FFFFFC0000000000FFFFFFFFFFFFFC0000000000FFFFFFFFFFFFFC0000000000
      FFFFFFFFFFFFFC0000000000FFFFFFFFFFFFFC0000000000FFFFFFFFFFFFFC00
      00000000FFFFFFFFFFFFFC0000000000FFFFFFFFFFFFFC0000000000FFFFFFFF
      FFFFFC0000000000FFFFFFFFFFFFFC0000000000FFFFFFFFFFFFFC0000000000
      FFFFFFFFFFFFFC0000000000FFFFF81FFFFFFC0000000000FFFFF80FFFFFFC00
      00000000FFFFFFEFFFFFFC0000000000FFFFFFDFFFFFFC0000000000FFFFF80F
      FFFFFC0000000000FFFFF80FFFFFFC0000000000FFFFFFFFFFFFFC0000000000
      FFFFFFFFFFFFFC0000000000FFFFFC1FFFFFFC0000000000FFFFF80FFFFFFC00
      00000000E7FFFBEFFFFFFC0000000000E7FFFBEFFFFFFC0000000000FFFFF80F
      FFFFFC0000000000FFFFFC1FFFFFFC0000000000E03FFFFFFFFFFC0000000000
      E03FFFFFFFFFFC0000000000FF3FF81FFFFFFC0000000000FF3FF80FFFFFFC00
      00000000E03FFFEFFFFFFC0000000000E03FFFDFFFFFFC0000000000FF3FF80F
      FFFFFC0000000000FF3FF80FFFFFFC0000000000E03FFFEFFF9BFC0000000000
      E03FFFDFFF09FC0000000000FFFFF80FFF4DFC0000000000FFFFF80FFF65FC00
      00000000F07FFFFFFF21FC0000000000E03FFFFFFFB3FC0000000000E73FF81F
      FF9BFC0000000000E73FF80FFF09FC0000000000E03FFFEFFF4DFC0000000000
      F07FFFDFFF65FC0000000000FFFFF80FFF21FC0000000000FFBFF80FFFB3FC00
      00000000FF3FFFEFFFFFFC0000000000E03FFFDFFF03FC0000000000E03FF80F
      FF01FC0000000000FFFFF80FFF75FC0000000000FFFFFFFFFF65FC0000000000
      E03FFFFFFF0DFC0000000000E03FFC1FFF9BFC0000000000FF3FF80FFFFFFC00
      00000000FF3FFBEFFFFFFC0000000000E007FBEFFF003C0000000000E007F80F
      FF003C0000000000FFFFFC1FFFFC3C0000000000E7EFFFFFFF80FC0000000000
      E7E7FDFBFF1FFC0000000000E7E7F9F9FF80FC0000000000EFF7FBFDFFFC3C00
      00000000E7E7FBFDFF003C0000000000E3C7FBFDFF003C0000000000F00FF9F9
      FFFFFC0000000000F81FFC03FFFFFC0000000000FFFFFE07FFFFFC0000000000
      FFFFFFFFFFFFFC0000000000FFFFFFFFFFFFFC0000000000FFFFFFFFFFFFFC00
      00000000FFFFFFFFFFFFFC000000000000000000000000000000000000000000
      000000000000}
  end
  object ColorDialog1: TColorDialog
    Left = 772
    Top = 571
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'Text XY(*.txt)|*.txt|Text Y-only(*.prn)|*.prn|netCDF (*.cdf)|*.c' +
      'df|HD(*.R*)|*.R*|MassLynx(*.dat)|*.dat|All Files (*.*)|*.*'
    FilterIndex = 2
    Title = 'Open data file'
    Left = 766
    Top = 443
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Text (*.txt)|*.txt|netCDF (*.cdf)|*.cdf|HD(*.R*)|*.R*'
    Title = 'Save file as'
    Left = 821
    Top = 171
  end
  object ActionList1: TActionList
    Left = 867
    Top = 427
    object actDataTableChrom: TAction
      Caption = 'actDataTableChrom'
      ImageIndex = 0
      OnExecute = actDataTableChromExecute
    end
    object actSmoothChrom: TAction
      Caption = 'actSmooth'
      Checked = True
      ImageIndex = 1
      OnExecute = actSmoothChromExecute
    end
    object actBLineChrom: TAction
      Caption = 'actBLineChrom'
      ImageIndex = 2
      OnExecute = actBLineChromExecute
    end
    object actPeaksChrom: TAction
      Caption = 'actPeaksChrom'
      ImageIndex = 3
      OnExecute = actPeaksChromExecute
    end
    object actDataTableMass: TAction
      Caption = 'actDataTableMass'
      ImageIndex = 0
      OnExecute = actDataTableMassExecute
    end
    object actSmoothMass: TAction
      Caption = 'actSmoothMass'
      ImageIndex = 1
      OnExecute = actSmoothMassExecute
    end
    object actBLineMass: TAction
      Caption = 'actBLineMass'
      ImageIndex = 2
      OnExecute = actBLineMassExecute
    end
    object actPeaksMass: TAction
      Caption = 'actPeaksMass'
      ImageIndex = 3
      OnExecute = actPeaksMassExecute
    end
  end
  object ChartEditorChrom: TChartEditor
    Chart = chrChrom.chrChart
    HideTabs = [cetLegend, cetPaging, cetWalls, cet3D, cetTools, cetAnimations]
    Options = [ceChange, ceClone, ceTitle, ceHelp]
    Title = 'Chart for chrom editor'
    TreeView = True
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 485
    Top = 131
  end
  object PopupMenu1: TPopupMenu
    AutoPopup = False
    Left = 70
    Top = 562
    object pmMassOnly: TMenuItem
      Caption = 'MassOnly'
      OnClick = pmMassOnlyClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object pmClear: TMenuItem
      Caption = 'Clear'
      OnClick = pmClearClick
    end
    object pmFill: TMenuItem
      Caption = 'Fill with Samples'
      OnClick = pmFillClick
    end
  end
  object OpenDialog2: TOpenDialog
    DefaultExt = 'tml'
    Filter = 'Template|*.tml'
    Title = 'Open template'
    Left = 765
    Top = 507
  end
  object ChartEditorMass: TChartEditor
    Chart = chrMass.chrChart
    HideTabs = [cetLegend, cetPaging, cetWalls, cet3D, cetTools, cetAnimations]
    Options = [ceChange, ceClone, ceTitle, ceHelp]
    Title = 'Chart for mass editor'
    TreeView = True
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 501
    Top = 467
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = 'tml'
    Filter = 'Plot Template (*.tml)|*.tml'
    Left = 824
    Top = 232
  end
end
