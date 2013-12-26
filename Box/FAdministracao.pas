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

unit FAdministracao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IniFiles;

type
  TAdministracao = class(TForm)
    ListView1: TListView;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Memo1: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LabelData: TLabel;
    LabelDataUltimoAcesso: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    Procedure GravaDataHoraIni(Texto : String);
    Procedure GravaCreditoTotalIni(CreditoTotal : Longint);
    Procedure LeIni(Var CreditoTotal : Longint ; Var Texto : String );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Administracao: TAdministracao;
  //////////////////////////
  CreditoTotal:Integer=0;
  DataUltimoAcesso:String;

implementation

uses Principal;

{$R *.dfm}


Procedure TAdministracao.GravaDataHoraIni(Texto : String);
var
ArqIni : TIniFile;
begin
ArqIni := TIniFile.Create('D:\Box\CreditoTotal.Ini');
Try
ArqIni.WriteString('Creditos', 'Texto', Texto);
Finally
ArqIni.Free;
end;
end;

Procedure TAdministracao.GravaCreditoTotalIni(CreditoTotal : Longint);
var
ArqIni : TIniFile;
begin
  ArqIni := TIniFile.Create('D:\Box\CreditoTotal.Ini');
Try
  ArqIni.WriteInteger('CreditoTotal', 'CreditoTotal', CreditoTotal);
Finally
  ArqIni.Free;
end;
end;

Procedure TAdministracao.LeIni(Var CreditoTotal : Longint ; Var Texto : String );
var
ArqIni : tIniFile;
begin
ArqIni := tIniFile.Create('D:\Box\CreditoTotal.Ini');
Try
CreditoTotal := ArqIni.ReadInteger('CreditoTotal', 'CreditoTotal', CreditoTotal );
Texto := ArqIni.ReadString('Creditos', 'Texto', Texto );
Finally
ArqIni.Free;
end;
end;

procedure TAdministracao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

    if key = 106 then
  begin
     Administracao.Close;
  end;

end;

procedure TAdministracao.FormShow(Sender: TObject);
begin
 LeIni(CreditoTotal,DataUltimoAcesso);

 LabelDataUltimoAcesso.Caption:= DataUltimoAcesso;

 GravaDataHoraIni(datetostr(now)+' '+timetostr(now));

 Label7.Caption:=NomeMaquina;
 LabelData.Caption:= datetostr(now)+' '+timetostr(now);
 Label6.Caption:=IntToStr(CreditoParcial);
end;

end.
