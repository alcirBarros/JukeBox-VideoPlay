object DMG: TDMG
  OldCreateOrder = False
  Left = 400
  Top = 375
  Height = 150
  Width = 215
  object TBPASTAS: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CODIGO'
    Params = <>
    ProviderName = 'PVPASTAS'
    Left = 35
    Top = 11
    object TBPASTASCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object TBPASTASPASTA: TStringField
      FieldName = 'PASTA'
      Size = 100
    end
  end
end
