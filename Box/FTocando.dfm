object TimerVideo: TTimerVideo
  Left = 88
  Top = 112
  Align = alTop
  BorderStyle = bsNone
  Caption = 'TimerVideo'
  ClientHeight = 40
  ClientWidth = 588
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 10
    Width = 70
    Height = 20
    Caption = 'Tocando'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel4: TPanel
    Left = 485
    Top = 5
    Width = 99
    Height = 23
    BevelOuter = bvNone
    Caption = '00:00:00'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object FlatPanel1: TFlatPanel
      Left = 2
      Top = -1
      Width = 36
      Height = 25
      ParentColor = True
      ColorHighLight = clBlack
      ColorShadow = clBlack
      TabOrder = 0
    end
  end
end
