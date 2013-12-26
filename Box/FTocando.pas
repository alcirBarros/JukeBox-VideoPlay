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

unit FTocando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TFlatPanelUnit, ExtCtrls;

type
  TTimerVideo = class(TForm)
    Label1: TLabel;
    Panel4: TPanel;
    FlatPanel1: TFlatPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TimerVideo: TTimerVideo;

implementation

{$R *.dfm}

end.
