object CreditosEspeciais: TCreditosEspeciais
  Left = 288
  Top = 292
  BorderStyle = bsNone
  ClientHeight = 148
  ClientWidth = 488
  Color = clMenuBar
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 488
    Height = 68
    Align = alTop
    Caption = 'Premiado!!!'
    Color = clGrayText
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -35
    Font.Name = 'Perpetua Titling MT'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 80
    Width = 488
    Height = 68
    Align = alBottom
    Caption = 'Voc'#234' ganhou 1 Credito!!!'
    Color = clGrayText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 1
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5
    OnTimer = Timer1Timer
  end
end
