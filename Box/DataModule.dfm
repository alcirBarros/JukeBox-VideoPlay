object DMG: TDMG
  OldCreateOrder = False
  Left = 581
  Top = 375
  Height = 356
  Width = 431
  object TBPASTAS: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CODIGO'
    Params = <>
    ProviderName = 'PVPASTAS'
    Left = 291
    Top = 259
    object TBPASTASCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object TBPASTASPASTA: TStringField
      FieldName = 'PASTA'
      Size = 100
    end
  end
  object DataSource1: TDataSource
    DataSet = TBPASTAS
    Left = 360
    Top = 256
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'IBConnection'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=D:\Box\HISTBOX.GDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'fbclient.dll'
    Left = 32
    Top = 8
  end
  object SQLDataSet1: TSQLDataSet
    CommandText = 'select NOME, NUMERO from ALBOM'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnection1
    Left = 120
    Top = 8
    object SQLDataSet1NOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 80
    end
    object SQLDataSet1NUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = SQLDataSet1
    Constraints = False
    Left = 32
    Top = 64
  end
  object TBHistBox: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 120
    Top = 64
    object TBHistBoxNOME: TStringField
      FieldName = 'NOME'
      Size = 80
    end
    object TBHistBoxNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
  end
  object DSHostBox: TDataSource
    AutoEdit = False
    DataSet = TBHistBox
    Left = 32
    Top = 128
  end
end
