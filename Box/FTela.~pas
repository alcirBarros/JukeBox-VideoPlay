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

unit FTela;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, pngimage, jpeg, ExtCtrls, ImgList,
  TFlatPanelUnit, BmsXPLabel, RXCtrls;

type
  TTela = class(TForm)
    Timer1: TTimer;
    FlatPanel1: TFlatPanel;
    Imapri: TImage;
    ListView1: TListView;
    ListView2: TListView;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    Image1: TImage;
    TelaNomeDoAlbum: TLabel;
    Image6: TImage;
      procedure verificaestacao;
      procedure ListarArquivos(Diretorio: string; Sub: Boolean);
      function TemAtributo(Attr, Val: Integer): Boolean;
    procedure FormShow(Sender: TObject);
    procedure controla_mouse_teclado(var Msg: TMsg; var Handled: Boolean);
    procedure ezibecredito;
    procedure adicionamusica;
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tela: TTela;
  ListItemtela: TListItem;
  SubItemtela: TStrings;
  F: TSearchRec;
  palavratela : String;
  Ftmr_ultima_digitacao, Ftmr_agora: TTime;
  SaltoTela :Integer; // Somente pra controle do DBPASTA com o For que mudandao de pagina

implementation

uses StrUtils, Funcoes, Principal, FVideo, DataModule, Tfuncoes, FVolume,
  FProximaLetra, FTocando;

{$R *.dfm}

procedure TTela.adicionamusica;
var
  Item: TListItem;
begin
  Item := ListView1.Selected;
  if Item <> nil then
  begin
        ListItem := Pricipal.ListView2.Items.Add;
        ListItem.Caption := Item.Caption;
        ListItem.ImageIndex := Item.ImageIndex;
        SubItem := TStringList.Create;
        SubItem.Add(Item.SubItems.Strings[0]);
        SubItem.Add(caminhopasta);
        ListItem.SubItems.AddStrings(SubItem);
        FreeAndNil(SubItem);
        credito:=credito-1;
   end;
end;




procedure TTela.ListarArquivos(Diretorio: string; Sub: Boolean);
var
 Ret: Integer;
 TempNome: string;

begin
 Ret := FindFirst(Diretorio  + '\*.mp*', faAnyFile, F);
 try
 while Ret = 0 do
 begin
 if TemAtributo(F.Attr, faDirectory) then
 begin
 if (F.Name <> '.') and (F.Name <> '..') then
 if Sub = True then
 begin
 TempNome := Diretorio + '\' + F.Name;
 ListarArquivos(TempNome, True);
 end;
 end
      else
      begin
        ListItemtela := ListView1.Items.Add;
        verificaestacao;
        ListItemtela.Caption := palavratela;
        SubItemtela := TStringList.Create;
        SubItemtela.Add(Diretorio + '\' + F.Name);
        ListItemtela.SubItems.AddStrings(SubItemtela);
        FreeAndNil(SubItemtela);
      end;

      Ret := FindNext(F);
    end;
  finally
    begin
      FindClose(F);
    end;
  end;
end;

procedure TTela.verificaestacao;
begin
  palavratela := F.Name;
  palavratela := AnsiReplaceStr(palavratela,'.mp3','');
  if F.Name <> palavratela then
  begin
   ListItemtela.ImageIndex := 1;
  end
  else
  begin
  palavratela := AnsiReplaceStr(palavratela,'.mpg','');
 end;
end;

function TTela.TemAtributo(Attr, Val: Integer): Boolean;
begin
  Result := Attr and Val = Val;
end;

procedure TTela.ezibecredito;
var
credito2 : String;
begin
  credito2 := IntToStr(credito);
  Label2.Caption:=credito2;
end;


procedure TTela.FormShow(Sender: TObject);
begin
    TimerVideo.Show;
    TelaTela := True;
    Tela.Tag:=1;
    ezibecredito;
    TelaNomeDoAlbum.Caption:=AnsiReplaceStr(caminhopasta,T+'\','');
    Imapri.Picture.LoadFromFile(FRC.ListarArquivos(caminhopasta));
    if FRC.ListarArquivos(caminhopasta) = ''then
     begin
      Imapri.Picture.LoadFromFile('D:\Box\Capa.jpg');
     end;

    FRC.ListarMusicas( caminhopasta );
    ListView2.Items:=Pricipal.ListView2.Items;
    if ListView1.Items.Count >0 then
      begin
        try
          ListView1.SetFocus;
          ListView1.Items.Item[0].Selected := true;
          ListView1.Items.Item[0].Focused := true;
       except
       end;
      end;
    Application.OnMessage := controla_mouse_teclado;
    Ftmr_ultima_digitacao := Time;
    Timer1.Enabled:=True;
    DoubleBuffered:=True;
end;


procedure TTela.controla_mouse_teclado(var Msg: TMsg; var Handled: Boolean);
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

procedure TTela.Timer1Timer(Sender: TObject);
begin
 // Label3.Caption:=Pricipal.Panel4.Caption;
 // Label5.Caption:=Video.WindowsMediaPlayer1.status;
  Ftmr_agora := time;
  if (Ftmr_agora - Ftmr_ultima_digitacao) >= strtotime('00:00:10') then //A tela de login aparecerá em 03 minutos
  begin
  Timer1.Enabled:=False;
  Tela.Tag:=0;
  Tela.Close;
  end;
end;


procedure TTela.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 if Volume.Tag = 0 then
 begin
  {almenta o Volume}
  if key = MenosVolume then
    begin
    Volume.ShowModal;
    end;

  {abaixa o volume}
  if key = MaisVolume then
    begin
    Volume.ShowModal;
    end;
  end;

 if key = Direita then
 begin
  Pricipal.setadireita;

 if ListView1.Items.Count >0 then
    begin
    try
    ListView1.SetFocus;
    ListView1.Items.Item[0].Selected := true;
    ListView1.Items.Item[0].Focused := true;
    except
    end;
    end;

 end;


  if key = Esquerda then
  begin
  //ListView1.DoubleBuffered:=False;   // esta duas linhas estao com erro...
  ListView1.Repaint;
  Pricipal.setaesquerda;
 if ListView1.Items.Count >0 then
    begin
    try
    ListView1.SetFocus;
    ListView1.Items.Item[0].Selected := true;
    ListView1.Items.Item[0].Focused := true;
    except
    end;
    end;

  end;


  if key = AdicionaCreditos then
 begin
  Pricipal.adicionacredito;

  if creEspecial = 18 then
    begin
       credito:=credito + 1;
       CreEspecial:=0;
    end
    else
    begin
      CreEspecial:=CreEspecial + 2;
    end;
       ezibecredito;
  end;

  if key = AdicionaMusicas then
  begin
    if credito >= 1 then
      begin
     if Pricipal.ListView2.Items.Count = 0 then
      begin
           adicionamusica;
           ezibecredito;
           ListView2.Items:=Pricipal.ListView2.Items;
           ListView2.Repaint;
       end
       else
       begin
           if ListView1.Selected.Caption <>  Pricipal.ListView2.Items.Item[ListView2.Items.Count-1].Caption then
           begin
             adicionamusica;
             ezibecredito;
             ListView2.Items:=Pricipal.ListView2.Items;
             ListView2.Repaint;
           end;
       end;
      end;
  end;


  if key =Tocar then
  begin
  BloqueiaMusicapraToca:=Pricipal.ListView2.Items.Count;
  ListView2.Items:= Pricipal.ListView2.Items;

  end;

  if key = ExcluiMusicas then
  begin
   Pricipal.excluimusica;
   ListView2.Items:=Pricipal.ListView2.Items;
   ezibecredito;
  end;


    if key = 69 then
      begin
       Timer1.Enabled:=False;
       Tela.Close;
     end;

    if key = 65 then
      begin
       FRC.ProximaLetra;
       ABC.Show;
     end;
     


   if key = 27 then
      begin
       Application.Terminate;
      end;


end;

procedure TTela.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     TelaTela := False;
     TimerVideo.Close;
     Tela.Tag:=0;
     Pricipal.imapri.Picture.LoadFromFile(FRC.ListarArquivos(caminhopasta));
    if FRC.ListarArquivos(caminhopasta) = ''then
     begin
      Pricipal.imapri.Picture.LoadFromFile('D:\Box\Capa.jpg');
     end;
end;

procedure TTela.FormCreate(Sender: TObject);
begin
  top:= 351;
  Left:= -3;
end;

end.
