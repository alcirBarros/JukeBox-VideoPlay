unit DataModule;

interface

uses
  SysUtils, Classes, DB, DBClient;

type
  TDMG = class(TDataModule)
    TBPASTAS: TClientDataSet;
    TBPASTASCODIGO: TIntegerField;
    TBPASTASPASTA: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMG: TDMG;

implementation

{$R *.dfm}

end.
