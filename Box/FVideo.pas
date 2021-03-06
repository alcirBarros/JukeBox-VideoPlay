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

unit FVideo;

interface

uses    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, ExtCtrls, DBXpress, FMTBcd, DB, DBClient,
  Provider, SqlExpr, StdCtrls, TimerLst, MPlayer, MMSystem, ComCtrls,
  WMPLib_TLB;

   const 
  MCI_SETAUDIO = $0873; 
  MCI_DGV_SETAUDIO_VOLUME = $4002; 
  MCI_DGV_SETAUDIO_ITEM = $00800000; 
  MCI_DGV_SETAUDIO_VALUE = $01000000; 
  MCI_DGV_STATUS_VOLUME = $4019; 
type 
  MCI_DGV_SETAUDIO_PARMS = record 
    dwCallback: DWORD; 
    dwItem: DWORD; 
    dwValue: DWORD; 
    dwOver: DWORD; 
    lpstrAlgorithm: PChar; 
    lpstrQuality: PChar; 
  end; 
type 
  MCI_STATUS_PARMS = record 
    dwCallback: DWORD; 
    dwReturn: DWORD; 
    dwItem: DWORD;
    dwTrack: DWORD; 
  end;

type
  TVideo = class(TForm)
    Timer1: TTimer;
    WindowsMediaPlayer1: TWindowsMediaPlayer;
    MediaPlayer1: TMediaPlayer;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MPSetVolume(MP: TMediaPlayer; Volume: Integer) ;
    function MPGetVolume(MP: TMediaPlayer): Integer;
    procedure TerminaVideo;
    procedure Timer1Timer(Sender: TObject);
    function MSecToTime (const intTime: integer): string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Video: TVideo;

implementation

uses Principal, FTela, Funcoes, DataModule, FVolume, Tfuncoes, FTocando,
  StrUtils;

{$R *.dfm}
  function TVideo.MSecToTime (const intTime: integer): string;
    const
      intMSec = 1 / 24 / 60 / 60 / 1000;
    begin
      result := TimeToStr (intTime * intMSec);
    end;
 
 procedure TVideo.MPSetVolume(MP: TMediaPlayer; Volume: Integer) ;
 var
    p: MCI_DGV_SETAUDIO_PARMS;
 begin
    p.dwCallback := 0;
    p.dwItem := MCI_DGV_SETAUDIO_VOLUME;
    p.dwValue := Volume;
    p.dwOver := 0;
    p.lpstrAlgorithm := nil;
    p.lpstrQuality := nil;
    mciSendCommand(MP.DeviceID, MCI_SETAUDIO, MCI_DGV_SETAUDIO_VALUE or MCI_DGV_SETAUDIO_ITEM, Cardinal(@p)) ;
 end;
 
 {Get Volume, range 0 - 1000}
 function TVideo.MPGetVolume(MP: TMediaPlayer): Integer;
 var
    p: MCI_STATUS_PARMS;
 begin
    p.dwCallback := 0;
    p.dwItem := MCI_DGV_STATUS_VOLUME;
    mciSendCommand(MP.DeviceID, MCI_STATUS, MCI_STATUS_ITEM, Cardinal(@p)) ;
    Result := p.dwReturn;
 end;

procedure TVideo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   if key = 69 then
    begin
    Application.CreateForm(TTela,Tela);
    try
    Tela.ShowModal;
    finally
    Tela.Release;
    Tela := nil;
    end;
    end;

            //222
           //111
  if key = AdicionaCreditos then
    begin
    Pricipal.adicionacredito;
    Application.CreateForm(TTela,Tela);
      try
        Tela.ShowModal;
       finally
         Tela.Release;
         Tela := nil;
       end;
    end;

  if key = 27 then
    begin
       Application.Terminate;
    end;

 {almenta o Volume}
  if key = MaisVolume then
    begin
    Volume.ShowModal;
    end;

  {abaixa o volume}
  if key = MenosVolume  then
    begin
    Volume.ShowModal;
    end;

end;

procedure TVideo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      TelaVerificaVideo:=False;
      TelaVideo := False;
      FRC.FocaBorda;
end;

procedure TVideo.FormShow(Sender: TObject);
begin
  TelaVideo := True;
 // Mediaplayer1.Display := Video.Panel1;
 // Mediaplayer1.displayRect := Panel1.ClientRect;
 // MediaPlayer1.Height:= Video.Height;
 // MediaPlayer1.Width:=Video.Width;

end;

  procedure TVideo.TerminaVideo;
    begin
   {  if not (MediaPlayer1.Mode = mpPlaying) then
     begin
        Timer1.Enabled:=False;
        MediaPlayer1.Stop;
        Mediaplayer1.Close;
        MediaPlayer1.FileName:='';
        MediaPlayer1.Realign;
        Pricipal.ListView2.Repaint;
     if Pricipal.ListView2.Items.Count = 0 then
       begin
         Pricipal.RxGIFAnimator2.Visible:=False;
         Pricipal.TNomedaMusica.Visible:=False;
         Pricipal.TNomedoAlbum.Visible:=False;
         Pricipal.Labeil1.Caption:=AnsiReplaceStr(caminhopasta,T+'\','');
         TelaVerificaVideo:=False;
         Pricipal.Tag:=0;
         Video.Tag:=0;
         FRC.ValidaTela;
         Pricipal.Show;
         Pricipal.ListView1.SetFocus;
         Pricipal.Timer1.Interval:=8000;
       end
      else
       begin
         Pricipal.Timer1.Enabled:=True;
       end;
    end;    }
    end;

  procedure TVideo.Timer1Timer(Sender: TObject);
    begin
  //  Video.Mediaplayer1.displayRect := Panel1.ClientRect;
  if Pricipal.Tag = 1 then
    begin
     if TelaVerificaVideo = False then
        begin
          try
       //     Pricipal.Panel4.Caption:= Video.MSecToTime(Video.MediaPlayer1.Position-Video.MediaPlayer1.Length);
          except
        end;
      end
      else
      begin
    //     TimerVideo.Panel4.Caption:= Video.MSecToTime(Video.MediaPlayer1.Position-Video.MediaPlayer1.Length);
      end;
    end;
       TerminaVideo;
   end;
end.
