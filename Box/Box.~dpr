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

program Box;

uses
  Forms,
  Principal in 'Principal.pas' {Pricipal},
  Funcoes in 'Funcoes.pas' {Inicio},
  FVideo in 'FVideo.pas' {Video},
  FTela in 'FTela.pas' {Tela},
  Tfuncoes in 'TFuncoes.pas',
  DataModule in 'DataModule.pas' {DMG: TDataModule},
  FVolume in 'FVolume.pas' {Volume},
  FCredEspecial in 'FCredEspecial.pas' {CreditosEspeciais},
  FProximaLetra in 'FProximaLetra.pas' {ABC},
  FTocando in 'FTocando.pas' {TimerVideo},
  FAdministracao in 'FAdministracao.pas' {Administracao},
  FMusicaEscolida in 'FMusicaEscolida.pas' {MusicaEscolida};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPricipal, Pricipal);
  Application.CreateForm(TDMG, DMG);
  Application.CreateForm(TInicio, Inicio);
  Application.CreateForm(TVideo, Video);
  Application.CreateForm(TTela, Tela);
  Application.CreateForm(TVolume, Volume);
  Application.CreateForm(TCreditosEspeciais, CreditosEspeciais);
  Application.CreateForm(TABC, ABC);
  Application.CreateForm(TTimerVideo, TimerVideo);
  Application.CreateForm(TAdministracao, Administracao);
  Application.CreateForm(TMusicaEscolida, MusicaEscolida);
  Application.Run;
end.
