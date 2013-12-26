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

unit FVolume;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RXSlider, ExtCtrls, TFlatPanelUnit;

type
  TVolume = class(TForm)
    FlatPanel2: TFlatPanel;
    Label1: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    RxSlider1: TRxSlider;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure controla_mouse_teclado(var Msg: TMsg; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RxSlider1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Volume: TVolume;

implementation

uses FVideo, FTela, Tfuncoes, Principal;

{$R *.dfm}

procedure TVolume.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

{almenta o Volume}
  if key = MaisVolume then
    begin
      RxSlider1.Value:= RxSlider1.Value + 20
    end;

  {abaixa o volume}
  if key = MenosVolume then
    begin
        RxSlider1.Value:= RxSlider1.Value - 20;
    end;

 if key = AdicionaCreditos then
    begin
      Pricipal.adicionacredito;
    end;

  if key = 27 then
    begin
     Application.Terminate;
    end;
end;

procedure TVolume.controla_mouse_teclado(var Msg: TMsg; var Handled: Boolean);
begin
  //Função que testa se alguma tecla foi digitada
  // ou se o mouse foi movimentado ou pressionado
  If (Msg.message = WM_KEYDOWN) or
    (Msg.message = VK_LBUTTON) or
    (Msg.message = VK_RBUTTON) or
    (Msg.message = VK_MBUTTON) then
  begin
    Ftmr_ultima_digitacao := Time;
 end;
end;

procedure TVolume.Timer1Timer(Sender: TObject);
begin
  Ftmr_agora := time;
  if (Ftmr_agora - Ftmr_ultima_digitacao) >= strtotime('00:00:02') then //A tela de login aparecerá em 03 minutos
  begin
  Timer1.Enabled:=False;
  Volume.Close;
  end;
end;

procedure TVolume.FormShow(Sender: TObject);
begin
  TelaVolume:=True;
  Application.OnMessage := controla_mouse_teclado;
  Ftmr_ultima_digitacao := Time;
  Timer1.Enabled:=True;
end;

procedure TVolume.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TelaVolume := false;
  Volume.Tag:=0;
end;

procedure TVolume.RxSlider1Change(Sender: TObject);
begin
 //  Video.MPSetVolume(Video.MediaPlayer1, RxSlider1.Value);

   Label1.Caption:=  'Volume '+IntToStr(RxSlider1.Value Div 10 )+'%';
   RxSlider1.Repaint;
   Label1.Repaint;
end;

end.
