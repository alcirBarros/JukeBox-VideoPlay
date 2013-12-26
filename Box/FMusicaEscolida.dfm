object MusicaEscolida: TMusicaEscolida
  Left = 332
  Top = 355
  BorderStyle = bsNone
  ClientHeight = 52
  ClientWidth = 308
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = -6
    Top = -4
    Width = 881
    Height = 95
    Align = alCustom
    Alignment = taRightJustify
    BevelOuter = bvLowered
    BiDiMode = bdRightToLeftNoAlign
    Color = clBlack
    ParentBiDiMode = False
    TabOrder = 0
    object Label1: TLabel
      Left = 30
      Top = 11
      Width = 265
      Height = 37
      Alignment = taCenter
      Caption = 'Musica j'#225' Escolida'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      Layout = tlCenter
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 280
  end
end
