unit Funcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Grids, DBGrids, StdCtrls, ExtCtrls, DBXpress, FMTBcd, SqlExpr, DB,
  DBClient, Provider, AppProt, pngimage, TLHelp32, Dialogs, Shellapi,
  VDOHddSerial,IniFiles, Cripto;

type
  TInicio = class(TForm)
    VDOHddSerial1: TVDOHddSerial;
    Memo2: TMemo;
    Timer1: TTimer;
    Cripto1: TCripto;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CriptoGrafi;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Inicio: TInicio;
  Serial : string;
  Erro: Boolean =False;

implementation

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

uses Principal, Tfuncoes, DataModule, FVideo, StrUtils;

{$R *.dfm}



procedure TInicio.FormShow(Sender: TObject);
begin
 // FRC.showForme;
end;

procedure TInicio.CriptoGrafi;
var
   pos : integer;
   shift : integer;
begin
    begin
      Serial := memo2.text;
      for pos := 1 to length(Serial) do
        Serial[pos] := chr(ord(Serial[pos]) - 861);
    end;
end;

procedure TInicio.FormCreate(Sender: TObject);
begin
    Serial:='';
    try
      Memo2.Lines.LoadFromFile('C:\WINDOWS\system32\bili.dll');
      CriptoGrafi;
    except
       Serial:='';
    end;


 if AnsiReplaceStr(Serial,'-','') <> VDOHddSerial1.SerialNumber then
   begin
    ShowMessage('Erro I');
    Application.Terminate;
  end
 else
  begin
   Erro:=True;
  end; 
end;

procedure TInicio.Timer1Timer(Sender: TObject);
begin
   //  Serial:='';
  //  try
 //     Memo2.Lines.LoadFromFile('C:\Documents and Settings\All Users\Dados de aplicativos\Microsoft\SUMA\bili.dll');
 //     CriptoGrafi;
 //   except
 //      Serial:='';
 //   end;

// if 'S1RLJ50S680384' <> VDOHddSerial1.SerialNumber then
//   begin
//    ShowMessage('Erro I');
//    Application.Terminate;
//  end
//  else
//  begin
//    Erro:=True;
//  end;
end;

end.








































