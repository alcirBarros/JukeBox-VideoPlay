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

unit FCredEspecial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TFlatPanelUnit;

type
  TCreditosEspeciais = class(TForm)
    Timer1: TTimer;
    Panel2: TPanel;
    Panel1: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure controla_mouse_teclado(var Msg: TMsg; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CreditosEspeciais: TCreditosEspeciais;
  Ftmr_ultima_digitacaoCreEspecial, Ftmr_agoraCreEspecial: TTime;

implementation

uses Principal, Tfuncoes, Funcoes, FVolume, FTela;

{$R *.dfm}

procedure TCreditosEspeciais.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if key = AdicionaCreditos then
  begin
    Pricipal.adicionacredito;
    Pricipal.CreditoEspecial;
  end;

    if key = 27 then
    begin
     Application.Terminate;
    end;

end;

procedure TCreditosEspeciais.controla_mouse_teclado(var Msg: TMsg; var Handled: Boolean);
begin
  //Função que testa se alguma tecla foi digitada
  // ou se o mouse foi movimentado ou pressionado
  If (Msg.message = WM_KEYDOWN) or
    (Msg.message = VK_LBUTTON) or
    (Msg.message = VK_RBUTTON) or
    (Msg.message = VK_MBUTTON) or
    (Msg.message = WM_MOUSEMOVE) then
  begin
    Ftmr_ultima_digitacao := Time;
 end;
end;

procedure TCreditosEspeciais.Timer1Timer(Sender: TObject);
begin
  Ftmr_agoraCreEspecial := time;
  if (Ftmr_agoraCreEspecial - Ftmr_ultima_digitacaoCreEspecial) >= strtotime('00:00:01') then //A tela de login aparecerá em 03 minutos
  begin
  Timer1.Enabled:=False;
  CreditosEspeciais.Close;
  end;
end;

procedure TCreditosEspeciais.FormShow(Sender: TObject);
begin
  Application.OnMessage := controla_mouse_teclado;
  Ftmr_ultima_digitacaoCreEspecial := Time;
  Timer1.Enabled:=True;
  DoubleBuffered:=True;
end;

end.
