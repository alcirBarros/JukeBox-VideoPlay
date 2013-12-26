////////////////////////////////////////////////////////
//                                                    //
//            Programa Box ( Video Play )             //
//       Sistema Gerenciador de Maquina de Musica     //
//                                                    //
//         Desenvolvido Por: Alcir Barros             //
//           alcirbarros@hotmail.com.br               //
//               (32) 9227 - 7676                     //
//                                                    //
////////////////////////////////////////////////////////

unit DataModule;

interface

uses
  SysUtils, Classes, DB, DBClient, DBXpress, FMTBcd, SqlExpr, Provider;

type
  TDMG = class(TDataModule)
    TBPASTAS: TClientDataSet;
    TBPASTASCODIGO: TIntegerField;
    TBPASTASPASTA: TStringField;
    DataSource1: TDataSource;
    SQLConnection1: TSQLConnection;
    SQLDataSet1: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    TBHistBox: TClientDataSet;
    DSHostBox: TDataSource;
    SQLDataSet1NOME: TStringField;
    SQLDataSet1NUMERO: TIntegerField;
    TBHistBoxNOME: TStringField;
    TBHistBoxNUMERO: TIntegerField;
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
