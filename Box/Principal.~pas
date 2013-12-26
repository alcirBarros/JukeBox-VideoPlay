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


unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, pngimage, StdCtrls, jpeg, ExtCtrls, StrUtils, ImgList,
  mmSystem, BmsXPLabel, RxGIF, Animate, GIFCtrl, BmsXPForm, Buttons, Grids,
  DBGrids, TFlatPanelUnit,ShellApi;

type
  TPricipal = class(TForm)
    Label9: TLabel;
    ima2: TImage;
    ima5: TImage;
    ima6: TImage;
    ima3: TImage;
    ima4: TImage;
    ima7: TImage;
    Bord2: TImage;
    Bord3: TImage;
    Bord4: TImage;
    Bord7: TImage;
    Bord6: TImage;
    Bord5: TImage;
    Bord1: TImage;
    imapri: TImage;
    BordaPric: TImage;
    ListView1: TListView;
    ima1: TImage;
    Labeil1: TLabel;
    ImageList2: TImageList;
    Image2: TImage;
    Image3: TImage;
    Panel1: TPanel;
    Label4: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label5: TLabel;
    Panel4: TPanel;
    Timer1: TTimer;
    RxGIFAnimator2: TRxGIFAnimator;
    TNomedaMusica: TLabel;
    TNomedoAlbum: TLabel;
    Timer2: TTimer;
    ListView2: TListView;
    Timer3: TTimer;
    FlatPanel1: TFlatPanel;
    FlatPanel2: TFlatPanel;
    Label6: TLabel;
    Label7: TLabel;
    ima8: TImage;
    Bord8: TImage;
    Timer4: TTimer;
    Timer5: TTimer;
    RxGIFAnimator1: TRxGIFAnimator;
    Label10: TLabel;
    Label8: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure adicionacredito;
    procedure LocalizaImagem;
    procedure ListarArquivos(Diretorio: string; Sub: Boolean);
    function TemAtributo(Attr, Val: Integer): Boolean;
    procedure adicionamusica;
    procedure setadireita;
    procedure setaesquerda;
    procedure caminhodapasta (tipo:Boolean; ProximaLetra:Boolean);
    procedure excluimusica;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer3Timer(Sender: TObject);
    procedure controla_mouse_teclado(var Msg: TMsg; var Handled: Boolean);
    procedure CreditoEspecial;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer4Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure HistBox(nome:string);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Pricipal: TPricipal;
  i, totGru, credito: Integer;
  im1, im2, im3, im4, im5, im6, im7, im8: string; // Caminho De cada Imagem
 // palavra: string; // Nome Do album que esta selecionado na tela
  ListItem: TListItem;
  SubItem: TStrings;
  F: TSearchRec;
  BloqueiaMusicapraToca: Integer;//Conta as Musicas no Listiwil2 pra travar pra nao excloulas depois de ter apertado enter
  caminhopasta:String; //Caminho Da Pasta Completo
  Salto :Integer; // Somente pra controle do DBPASTA com o For que mudandao de pagina
  T:String;   // Guarda o Caminho Para a Pasta Musicas e Nao Tem o Nome do Album
  TelaVerificaVideo:Boolean = False ;// guarda se e video ou nao ''
  conta:Integer; // teste / saber onde a borda estar
  Tempo:string;
  TempoTotalMusica:string = '00:00:00';
  CreEspecial :Integer = 0;

    ///////////////
  TelaVideo:Boolean  = False;
  TelaVolume:Boolean = False;
  TelaTela:Boolean  = False;
  TProximaLetra:Boolean  = False;

  //////////////////
  CreditoParcial:Integer = 0;
  CreditoTotal:Integer;
  NomeMaquina:String;

  /////////////////
  PropragandaNome:String;
  PropragandaTel:String;

  ///////////////// tempo de espera que aparece o contato
  UltimaDigitacaoContato , TempoAgoraContato: TTime;

implementation

uses Funcoes, FVideo, MaskUtils, Tfuncoes, DataModule, FTela,
  FVolume, FCredEspecial, DB, FProximaLetra, FTocando, FAdministracao,
  FMusicaEscolida;

{$R *.dfm}

function TPricipal.TemAtributo(Attr, Val: Integer): Boolean;
begin
  Result := Attr and Val = Val;
end;

procedure TPricipal.ListarArquivos(Diretorio: string; Sub: Boolean);
var
 Ret: Integer;
 TempNome: string;
 Musica: String;
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
  ListItem := ListView1.Items.Add;
  Musica := F.Name;
  Musica := AnsiReplaceStr(Musica,'.mp3','');
  if F.Name <> Musica then
  begin
   ListItem.ImageIndex := 1;
  end

  else
  begin
  Musica := FRC.ExtractName(Musica);
  end;
        ListItem.Caption := Musica;
        SubItem := TStringList.Create;
        SubItem.Add(Diretorio + '\' + F.Name);
        ListItem.SubItems.AddStrings(SubItem);
        FreeAndNil(SubItem);
      end;
      Ret := FindNext(F);
    end;
  finally
    begin
      FindClose(F);
    end;
  end;
end;

procedure TPricipal.LocalizaImagem;
begin
     ima8.Picture.LoadFromFile(FRC.ListarArquivos(im8));
     if FRC.ListarArquivos(im8) = ''then
     begin
      ima8.Picture.LoadFromFile('D:\Box\Capa.jpg');
     end;


    ima4.Picture.LoadFromFile(FRC.ListarArquivos(im4));
     if FRC.ListarArquivos(im4) = ''then
     begin
      ima4.Picture.LoadFromFile('D:\Box\Capa.jpg');
     end;


    ima7.Picture.LoadFromFile(FRC.ListarArquivos(im7));
     if FRC.ListarArquivos(im7) = ''then
     begin
      ima7.Picture.LoadFromFile('D:\Box\Capa.jpg');
     end;


    ima3.Picture.LoadFromFile(FRC.ListarArquivos(im3));
     if FRC.ListarArquivos(im3) = ''then
     begin
      ima3.Picture.LoadFromFile('D:\Box\Capa.jpg');
     end;


    ima6.Picture.LoadFromFile(FRC.ListarArquivos(im6));
     if FRC.ListarArquivos(im6) = ''then
     begin
      ima6.Picture.LoadFromFile('D:\Box\Capa.jpg');
     end;


     ima2.Picture.LoadFromFile(FRC.ListarArquivos(im2));
     if FRC.ListarArquivos(im2) = ''then
     begin
      ima2.Picture.LoadFromFile('D:\Box\Capa.jpg');
     end;


    ima5.Picture.LoadFromFile(FRC.ListarArquivos(im5));
     if FRC.ListarArquivos(im5) = ''then
     begin
      ima5.Picture.LoadFromFile('D:\Box\Capa.jpg');
     end;


     ima1.Picture.LoadFromFile(FRC.ListarArquivos(im1));
     if FRC.ListarArquivos(im1) = ''then
     begin
      ima1.Picture.LoadFromFile('D:\Box\Capa.jpg');
     end;

end;

procedure TPricipal.caminhodapasta (tipo:Boolean; ProximaLetra:Boolean);
begin
   // conta := conta + 1;
    if tipo = True then
    begin
    conta := conta + 1;
    end
    else
    begin
    conta := conta - 1;
    end;

   if conta = 8 then
      begin
   if ProximaLetra = False then
      begin
   if TelaVerificaVideo = False then
      begin
      imapri.Picture:=ima8.Picture;
      imapri.Repaint;
      end
      else
      begin
      Tela.Imapri.Picture:=ima8.Picture;
      Tela.Imapri.Repaint;
      end;
      end;
      caminhopasta := im8;
      end;

      if conta = 7 then
      begin
   if ProximaLetra = False then
      begin
   if TelaVerificaVideo = False then
      begin
       imapri.Picture:=ima7.Picture;
       imapri.Repaint;
      end
      else
      begin
      Tela.Imapri.Picture:=ima7.Picture;
      Tela.Imapri.Repaint;
      end;
      end;
      caminhopasta := im7;
      end;

      if conta = 6 then
      begin
   if ProximaLetra = False then
      begin
   if TelaVerificaVideo = False then
      begin
       imapri.Picture:=ima6.Picture;
       imapri.Repaint;
      end
      else
      begin
      Tela.Imapri.Picture:=ima6.Picture;
      Tela.Imapri.Repaint;
      end;
      end;
      caminhopasta := im6;
      end;

      if conta = 5 then
      begin
   if ProximaLetra = False then
      begin
   if TelaVerificaVideo = False then
      begin
       imapri.Picture:=ima5.Picture;
       imapri.Repaint;
      end
      else
      begin
      Tela.Imapri.Picture:=ima5.Picture;
      Tela.Imapri.Repaint;
      end;
      end;
      caminhopasta := im5;
      end;

      if conta = 4 then
      begin
   if ProximaLetra = False then
      begin
   if TelaVerificaVideo = False then
      begin
       imapri.Picture:=ima4.Picture;
       imapri.Repaint;
      end
      else
      begin
      Tela.Imapri.Picture:=ima4.Picture;
      Tela.Imapri.Repaint;
      end;
      end;
      caminhopasta := im4;
      end;

      if conta = 3 then
      begin
   if ProximaLetra = False then
      begin
   if TelaVerificaVideo = False then
      begin
       imapri.Picture:=ima3.Picture;
      end
      else
      begin
      Tela.Imapri.Picture:=ima3.Picture;
      Tela.Imapri.Repaint;
      end;
      end;
      caminhopasta := im3;
      end;

      if conta = 2 then
      begin
   if ProximaLetra = False then
      begin
   if TelaVerificaVideo = False then
      begin
       imapri.Picture:=ima2.Picture;
       imapri.Repaint;
      end
      else
      begin
       Tela.Imapri.Picture:=ima2.Picture;
       Tela.Imapri.Repaint;
      end;
      end;
      caminhopasta := im2;
      end;

   if conta = 1 then
      begin
   if ProximaLetra = False then
      begin
   if TelaVerificaVideo = False then
      begin
       imapri.Picture:=ima1.Picture;
       imapri.Repaint;
      end
      else
      begin
      Tela.Imapri.Picture:=ima1.Picture;
      Tela.Imapri.Repaint;
      end;
      caminhopasta := im1;
      end;
      end;

   if TelaVerificaVideo = False then
      begin
      Labeil1.Caption := AnsiReplaceStr(caminhopasta,T+'\', '');
      ListView1.Items.Clear;
      end
      else
      begin
      Tela.TelaNomeDoAlbum.Caption:=AnsiReplaceStr(caminhopasta,T+'\','');
      Tela.TelaNomeDoAlbum.Repaint;
      Tela.ListView1.Items.Clear;
      end;

  // if ProximaLetra = False then
  //    begin
       FRC.ListarMusicas( caminhopasta );
   //   end;
end;

procedure TPricipal.setaesquerda;
begin
 DMG.TBPASTAS.Prior;
    i := i - 1;
  if TelaVerificaVideo = False then
   begin
    if Bord2.Visible = True then
    begin
      Bord2.Visible := False;
      Bord1.Visible := True;
      Bord1.Repaint;
    end;

    if Bord3.Visible = True then
    begin
      Bord3.Visible := False;
      Bord2.Visible := True;
      Bord2.Repaint;
    end;

    if Bord4.Visible = True then
    begin
      Bord4.Visible := False;
      Bord3.Visible := True;
      Bord3.Repaint;
    end;


    if Bord5.Visible = True then
    begin
      Bord5.Visible := False;
      Bord4.Visible := True;
      Bord4.Repaint;
    end;


    if Bord6.Visible = True then
    begin
      Bord6.Visible := False;
      Bord5.Visible := True;
      Bord5.Repaint;
    end;


    if Bord7.Visible = True then
    begin
      Bord7.Visible := False;
      Bord6.Visible := True;
      Bord6.Repaint;
    end;

    if Bord8.Visible = True then
    begin
      Bord8.Visible := False;
      Bord7.Visible := True;
      Bord7.Repaint;
    end;
 end;

    // Volta Para o Bloco Anterior
    if i = totGru - 9 then
    begin
     conta:= 9 ;
       //  Sleep(1000); Pausa por 1 segundo
      totGru := totGru - 8;
      im8 := DMG.TBPASTAS.Fields[1].AsString;
      DMG.TBPASTAS.Prior;
      im7 :=  DMG.TBPASTAS.Fields[1].AsString;
      DMG.TBPASTAS.Prior;
      im6 := DMG.TBPASTAS.Fields[1].AsString;
      DMG.TBPASTAS.Prior;
      im5 := DMG.TBPASTAS.Fields[1].AsString;
      DMG.TBPASTAS.Prior;
      im4 := DMG.TBPASTAS.Fields[1].AsString;
      DMG.TBPASTAS.Prior;
      im3 := DMG.TBPASTAS.Fields[1].AsString;
      DMG.TBPASTAS.Prior;
      im2 := DMG.TBPASTAS.Fields[1].AsString;
      DMG.TBPASTAS.Prior;
      im1 := DMG.TBPASTAS.Fields[1].AsString;
      for Salto := 1 to 7 do
      begin
      DMG.TBPASTAS.Next;
      end;

      ima2.Visible := True;
      ima3.Visible := True;
      ima4.Visible := True;
      ima5.Visible := True;
      ima6.Visible := True;
      ima7.Visible := True;
      ima8.Visible := True;
    if TelaVerificaVideo = False then
      begin
      Bord1.Visible := False;
      Bord8.Visible := true;
      end;
      LocalizaImagem;  //novo
    end;

    if i = -1 then
    begin
     FRC.ultimobloco;
     LocalizaImagem;  //novo
     //ShowMessage('2');
    end;
    caminhodapasta(false,False);
end;

procedure TPricipal.setadireita;
begin
 i := i + 1;
 DMG.TBPASTAS.Next;
if i < totGru then
begin
 if TelaVerificaVideo = False then
   begin
    if i <> Cont then
      begin
      if Bord7.Visible = True then
      begin
        Bord7.Visible := False;
        Bord8.Visible := True;
        Bord8.Repaint;
      end;

      if Bord6.Visible = True then
      begin
        Bord6.Visible := False;
        Bord7.Visible := True;
        Bord7.Repaint;
      end;

      if Bord5.Visible = True then
      begin
        Bord5.Visible := False;
        Bord6.Visible := True;
        Bord6.Repaint;
      end;

      if Bord4.Visible = True then
      begin
        Bord4.Visible := False;
        Bord5.Visible := True;
        Bord5.Repaint;
      end;

      if Bord3.Visible = True then
      begin
        Bord3.Visible := False;
        Bord4.Visible := True;
        Bord4.Repaint;
      end;

      if Bord2.Visible = True then
      begin
        Bord2.Visible := False;
        Bord3.Visible := True;
        Bord3.Repaint;
      end;

      if Bord1.Visible = True then
      begin
        Bord1.Visible := False;
        Bord2.Visible := True;
        Bord1.Repaint;
      end;
     end;
   end;
 end
   else
  begin
  // ShowMessage('Próximo bloco de '+IntToStr(totGru));
        totGru := totGru + 8;
        im1 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im2 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im3 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im4 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im5 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im6 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im7 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im8 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;

        for Salto := 1 to 8 do
         begin
          DMG.TBPASTAS.Prior;
         end;



        if Cont - i = 1 then
        begin
         for Salto := 1 to 8 do
         begin
         DMG.TBPASTAS.Next;
         end;
       if TelaVerificaVideo = False then
        begin
          ima2.Visible := false;
          ima3.Visible := false;
          ima4.Visible := false;
          ima5.Visible := false;
          ima6.Visible := false;
          ima7.Visible := false;
          ima8.Visible := false;
         end;
        end;

        if Cont - i = 2 then
        begin

         for Salto := 1 to 7 do
          begin
          DMG.TBPASTAS.Next;
          end;
        if TelaVerificaVideo = False then
         begin
          ima3.Visible := false;
          ima4.Visible := false;
          ima5.Visible := false;
          ima6.Visible := false;
          ima7.Visible := false;
          ima8.Visible := false;
          end;
        end;

        if Cont - i = 3 then
        begin
         for Salto := 1 to 7 do
          begin
          DMG.TBPASTAS.Next;
          end;
        if TelaVerificaVideo = False then
         begin
          ima4.Visible := false;
          ima5.Visible := false;
          ima6.Visible := false;
          ima7.Visible := false;
          ima8.Visible := false;
         end;
        end;

        if Cont - i = 4 then
        begin
          DMG.TBPASTAS.Next;
          DMG.TBPASTAS.Next;
          DMG.TBPASTAS.Next;
          DMG.TBPASTAS.Next;
          DMG.TBPASTAS.Next;
        if TelaVerificaVideo = False then
         begin
          ima5.Visible := false;
          ima6.Visible := false;
          ima7.Visible := false;
          ima8.Visible := false;
         end;
        end;

        if Cont - i = 5 then
        begin
          DMG.TBPASTAS.Next;
          DMG.TBPASTAS.Next;
          DMG.TBPASTAS.Next;
          DMG.TBPASTAS.Next;
        if TelaVerificaVideo = False then
         begin
          ima6.Visible := false;
          ima7.Visible := false;
          ima8.Visible := false;
         end;
        end;


        if Cont - i = 6 then
        begin
          DMG.TBPASTAS.Next;
          DMG.TBPASTAS.Next;
          DMG.TBPASTAS.Next;
        if TelaVerificaVideo = False then
         begin
          ima7.Visible := false;
          ima8.Visible := false;
         end;
        end;

        if Cont - i = 7 then
        begin
          DMG.TBPASTAS.Next;
          DMG.TBPASTAS.Next;
         if TelaVerificaVideo = False then
          begin
          ima8.Visible := false;
          end;
        end;

        if Cont - i = 8 then
        begin
          DMG.TBPASTAS.Next;
        end;
     if TelaVerificaVideo = False then
       begin
        Bord8.Visible := False;
        Bord1.Visible := True;
       end;
       LocalizaImagem;
       conta:= 0 ;
end;


 if i = Cont then
      begin
 //  ShowMessage('volte para o começo');
   //  if TelaVerificaVideo = False then
  //     begin
        ima1.Visible := True;
        ima2.Visible := True;
        ima3.Visible := True;
        ima4.Visible := True;
        ima5.Visible := True;
        ima6.Visible := True;
        ima7.Visible := True;
        ima8.Visible := True;
        Bord1.Visible := False;
        Bord2.Visible := False;
        Bord3.Visible := False;
        Bord4.Visible := False;
        Bord5.Visible := False;
        Bord6.Visible := False;
        Bord7.Visible := False;
        Bord8.Visible := False;
        Bord1.Visible := True;
      //  end;
        DMG.TBPASTAS.First;
        i := 0;
        totGru := 8;
        im1 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im2 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im3 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im4 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im5 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im6 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im7 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Next;
        im8 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.First;
        LocalizaImagem;
        conta:= 0 ;
      end;
    caminhodapasta(true,False);
end;

procedure TPricipal.adicionacredito;
begin
  credito:=credito + 2;

  CreditoParcial:=CreditoParcial + 2;
  if credito >= 10 then
  Label2.Caption:=  '0'+IntToStr(credito)
  else
  Label2.Caption:=  '00'+IntToStr(credito);
  FRC.GravaIni(CreditoParcial,credito+ListView2.Items.Count,'Cntrole',True);
  Administracao.GravaCreditoTotalIni(CreditoTotal+credito);
end;

procedure TPricipal.adicionamusica;
var
  Item: TListItem;
begin
  Item := ListView1.Selected;
  if Item <> nil then
  begin
        ListItem := ListView2.Items.Add;
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

  procedure TPricipal.CreditoEspecial;
  begin
    if creEspecial = 18 then
    begin
       credito:=credito + 1;
    if credito >= 10 then
        begin
          Label2.Caption:=  '0'+IntToStr(credito);
        end
          else
        begin
          Label2.Caption:=  '00'+IntToStr(credito);
      end;
        Label2.Repaint;
        CreditosEspeciais.Show;
        CreEspecial:=0;
      end
    else
    begin
      CreEspecial:=CreEspecial + 2;
    end;
    FRC.GravaIni(CreditoParcial,credito+Pricipal.ListView2.Items.Count,'Controle',True);
  end;

procedure TPricipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if key = AdicionaCreditos then
  begin
    adicionacredito;
    CreditoEspecial;
    if Pricipal.Tag = 0 then
     begin
     Video.Mediaplayer1.FileName:='D:\Box\Credito.mp3';
     Video.Mediaplayer1.Open;
     Video.MPSetVolume(Video.MediaPlayer1, 300);
     Volume.RxSlider1.Value:=300;
     Video.Mediaplayer1.Play;
     end;
  end;



  begin
  if key = Direita then
  begin
    setadireita;
  if ListView1.Items.Count >0 then
    begin
    try
    ListView1.SetFocus;
    ListView1.Items.Item[0].Selected := true;
    ListView1.Items.Item[0].Focused := true;
    except
    end;
    end;
   try
    if Pricipal.Tag = 1 then
      begin
       if TelaVerificaVideo = False then
         begin
    //       Panel4.Caption:= Video.MSecToTime(Video.MediaPlayer1.Position-Video.MediaPlayer1.Length);
         end;
      end;
    except
  end;
  end;

  if key = Esquerda then
  begin
   setaesquerda;
 if ListView1.Items.Count >0 then
    begin
    try
    ListView1.SetFocus;
    ListView1.Items.Item[0].Selected := true;
    ListView1.Items.Item[0].Focused := true;
    except
    end;
    end;

   try
    if Pricipal.Tag = 1 then
      begin
       if TelaVerificaVideo = False then
         begin
    //       Panel4.Caption:= Video.MSecToTime(Video.MediaPlayer1.Position-Video.MediaPlayer1.Length);
         end;
      end;
    except
   end;
  end;      //189 note
            //107
  if key = ExcluiMusicas then
  begin
  if ListView2.Items.Count > 0 then
  begin
   excluimusica;
  if credito >= 10 then
  Label2.Caption:=  '0'+IntToStr(credito)
  else
  Label2.Caption:=  '00'+IntToStr(credito);
  end;
  end;
           //107
           //187  note
  if key = AdicionaMusicas then
  begin
    if credito >= 1 then
       begin
      if ListView2.Items.Count = 0 then
        begin
         adicionamusica;
         Label4.Caption:= IntToStr(ListView2.Items.Count);
         Label2.Caption:= IntToStr(credito);
       if credito >= 10 then
         Label2.Caption:=  '0'+IntToStr(credito)
       else
         Label2.Caption:=  '00'+IntToStr(credito);
       end
       else
       begin
           if ListView1.Selected.Caption <>  ListView2.Items.Item[ListView2.Items.Count-1].Caption then
           begin
              adicionamusica;
              Label4.Caption:= IntToStr(ListView2.Items.Count);
              Label2.Caption:= IntToStr(credito);
               if credito >= 10 then
              Label2.Caption:=  '0'+IntToStr(credito)
                else
              Label2.Caption:=  '00'+IntToStr(credito);
           end
           else
           begin
            MusicaEscolida.Show;
            MusicaEscolida.Timer1.Enabled:=True;
           end;
       end;
       end;
     end;
  end;


  if key = Tocar then
  begin

   if Pricipal.Tag = 0 then
     begin
     if ListView2.Items.Count >=1 then
     begin
       BloqueiaMusicapraToca:=ListView2.Items.Count;
       Video.Mediaplayer1.FileName:='D:\Box\VM.MP3';
       Video.Mediaplayer1.Open;
       Video.MPSetVolume(Video.MediaPlayer1, 150);
       Volume.RxSlider1.Value:=150;
       Video.Mediaplayer1.Play;
       Timer1.Enabled:=True;
       Pricipal.Tag:=1;
       end;
    end
     else
       BloqueiaMusicapraToca:=ListView2.Items.Count;
     end;

  if key = 27 then
  begin
  //  FRC.CloseRegistro;
    Application.Terminate;
  end;
              
    if key = 106 then
  begin
     try
       Administracao.Show;
    except
   end;
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

procedure TPricipal.excluimusica;
begin
  if ListView2.Items.Count > BloqueiaMusicapraToca then
  begin
    ListView2.Items.Delete(ListView2.Items.Count-1);
    credito:=credito + 1;
    Label4.Caption:= IntToStr(ListView2.Items.Count);
    Label2.Caption:= IntToStr(credito);
  end;
end;

procedure TPricipal.FormShow(Sender: TObject);
var
N: Integer;
C: Boolean;
begin
  FRC.showForme;
  DoubleBuffered:=True;
  conta := 0;
  FRC.LeIni(CreditoParcial,n,NomeMaquina,c);  // aque ele le o arquivo Ini que fica na pasta Box
  Label9.Caption:= IntToStr(Cont); //conta quantos CD/DVDs tem na maquina
  DMG.TBPASTAS.First;
  credito:= N; // carega os creditos que estao dentro do arquivo ini
  if credito >= 10 then
  Label2.Caption:=  '0'+IntToStr(credito)
  else
  Label2.Caption:=  '00'+IntToStr(credito);
  i := 0;
  totGru := 8;
  im1 := DMG.TBPASTAS.Fields[1].AsString;
  DMG.TBPASTAS.Next;
  im2 := DMG.TBPASTAS.Fields[1].AsString;
  DMG.TBPASTAS.Next;
  im3 := DMG.TBPASTAS.Fields[1].AsString;
  DMG.TBPASTAS.Next;
  im4 := DMG.TBPASTAS.Fields[1].AsString;
  DMG.TBPASTAS.Next;
  im5 := DMG.TBPASTAS.Fields[1].AsString;
  DMG.TBPASTAS.Next;
  im6 := DMG.TBPASTAS.Fields[1].AsString;
  DMG.TBPASTAS.Next;
  im7 := DMG.TBPASTAS.Fields[1].AsString;
  DMG.TBPASTAS.Next;
  im8 := DMG.TBPASTAS.Fields[1].AsString;
  DMG.TBPASTAS.First;
  LocalizaImagem;
  caminhodapasta(True,False);
  ListView1.SetFocus;
  ListView1.Items.Item[0].Selected := true;
  ListView1.Items.Item[0].Focused := true;
  Application.OnMessage := controla_mouse_teclado;
  Ftmr_ultima_digitacao := Time;
  Timer3.Enabled:=True;
end;

procedure TPricipal.HistBox(nome:string);
begin
 { if DMG.TBHistBox.Locate('NOME',nome,[loPartialKey,loCaseInsensitive])= True then
   begin
    DMG.TBHistBox.Edit;
    DMG.TBHistBoxNUMERO.Value:= DMG.TBHistBoxNUMERO.Value + 1;
    DMG.TBHistBox.ApplyUpdates(-1);
  end
    else
  begin
    DMG.TBHistBox.Insert;
    DMG.TBHistBoxNOME.Value:=nome;
    DMG.TBHistBoxNUMERO.Value:=1;
    DMG.TBHistBox.ApplyUpdates(-1);
  end; }
end;

procedure TPricipal.Timer1Timer(Sender: TObject);
begin
    Timer1.Enabled:=False;
  if ListView2.Items.Item[0].Caption <> 'Zera crédito' then
     begin
    TNomedoAlbum.Caption:= AnsiReplaceStr(ListView2.Items[0].SubItems[1],T+'\', '');   // Nome do Album
    TNomedaMusica.Caption:=ListView2.Items.Item[0].Caption; // Nume Da Musica
    TimerVideo.Label1.Caption:= 'Tocando: '+ ListView2.Items.Item[0].Caption; // Nume Da Musica

    try
      HistBox(ListView2.Items[0].SubItems[1]);
    except
    end;

    TNomedaMusica.Left:=40;
    TNomedoAlbum.Left:=40;
    RxGIFAnimator2.Visible:=True;


    Video.WindowsMediaPlayer1.URL:= ListView2.Items.Item[0].SubItems.Strings[0];

  {  Video.Mediaplayer1.FileName:= ListView2.Items.Item[0].SubItems.Strings[0];
    Video.Mediaplayer1.Open;
    Video.MPSetVolume(Video.MediaPlayer1, Volume.RxSlider1.Value);
    Video.Mediaplayer1.Display := Video.Panel1;
    Video.Mediaplayer1.displayRect := Panel1.ClientRect;
    Video.MediaPlayer1.Height:= Video.Height;
    Video.MediaPlayer1.Width:=Video.Width;
    Video.Mediaplayer1.Play; }

    Timer1.Interval:=4000;

    Timer2.Enabled:=True;
     if ListView2.Items.Item[0].ImageIndex = 0 then
       Begin
        TelaVerificaVideo := True;
         if Video.Tag = 0 then
          begin
            FRC.ValidaTela;
            Video.Show;
            Video.Tag := 1;
          end;
       end
        else
       begin
       if Video.Tag = 1 then
          begin
            Video.Tag := 0;
            Video.Close;
            FRC.ValidaTela;
            Pricipal.Show;
            Pricipal.ListView1.SetFocus;
          end;
       end;
     end
     else
     begin

       Video.Mediaplayer1.FileName:='D:\Box\Zera crédito.mp3';
       Video.Mediaplayer1.Open;
       Video.MPSetVolume(Video.MediaPlayer1, 300);
       Volume.RxSlider1.Value:=300;
       Video.Mediaplayer1.Play;
       ListView2.Clear;
       credito:=0;
       Label2.Caption:='000';
       Label4.Caption:='00';
       BloqueiaMusicapraToca:=0;
       Pricipal.Tag:=0;
       Timer1.Interval:=8000;
       FRC.GravaIni(CreditoParcial,credito+Pricipal.ListView2.Items.Count,'Controle',True);
       RxGIFAnimator2.Visible:=False;
       Video.Tag := 0;
       Video.Close;
       FRC.ValidaTela;
       Pricipal.Show;
       Pricipal.ListView1.SetFocus;
     end;
end;

procedure TPricipal.Timer2Timer(Sender: TObject);
 begin
    Timer2.Enabled:=False;
    Timer1.Interval:= 2000;
    ListView2.Items.Item[0].Delete;
    FRC.GravaIni(CreditoParcial,credito+Pricipal.ListView2.Items.Count,'Controle',True);
    Label4.Caption:= IntToStr(ListView2.Items.Count);
    BloqueiaMusicapraToca:=ListView2.Items.Count;
    Video.Timer1.Enabled:=True;
  end;

procedure TPricipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Administracao.GravaCreditoTotalIni(CreditoTotal+CreditoParcial);
 Application.Terminate;
end;

procedure TPricipal.controla_mouse_teclado(var Msg: TMsg; var Handled: Boolean);
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

procedure TPricipal.Timer3Timer(Sender: TObject);
begin
  Ftmr_agora := time;
  if (Ftmr_agora - Ftmr_ultima_digitacao) >= strtotime('00:30:00') then //A tela de login aparecerá em 03 minutos
  begin
    Ftmr_ultima_digitacao := Time;
    Video.Mediaplayer1.FileName:='D:\Box\Audio.mp3';
    Video.Mediaplayer1.Open;
    Video.MPSetVolume(Video.MediaPlayer1, 150);
    Video.Mediaplayer1.Play;
    Tempo := '00:00:00';
  end;
end;

procedure TPricipal.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

    if key = 65 then
      begin
        FRC.ProximaLetra;
        ABC.Show;
      end;

      
end;

procedure TPricipal.Timer4Timer(Sender: TObject);
begin
if Pricipal.Tag = 0 then
  begin
  TempoAgoraContato := time;
  if (TempoAgoraContato - Ftmr_ultima_digitacao) > strtotime('00:00:01') then //A tela de login aparecerá em 03 minutos
  begin
    TNomedaMusica.Caption:=PropragandaNome;
    TNomedoAlbum.Caption:=PropragandaTel;
    TNomedaMusica.Left:=5;
    TNomedoAlbum.Left:=5;
    TNomedaMusica.Visible:=True;
    TNomedoAlbum.Visible:=True;
  end;
 end;
end;

  function GetDirSize(dir: string; subdir: Boolean): Longint;
    var
       rec: TSearchRec;
       found: Integer;
   begin
      Result := 0;
        if dir[Length(dir)] <> '\' then dir := dir + '\';
           found := FindFirst(dir + '*.*', faAnyFile, rec);
           while found = 0 do
        begin
           Inc(Result, rec.Size);
        if (rec.Attr and faDirectory > 0) and (rec.Name[1] <> '.') and (subdir = True)
         then
           Inc(Result, GetDirSize(dir + rec.Name, True));
           found := FindNext(rec);
        end;
      FindClose(rec);
   end;


 function CopiaDirs(DirFonte,DirDest : String) : Boolean;
  var
  ShFileOpStruct : TShFileOpStruct;
begin
  Result := False;
  if DirFonte = '' then
    raise Exception.Create(
      'Diretório fonte não pode ficar em branco');
  if DirDest = '' then
    raise Exception.Create(
      'Diretório destino não pode ficar em branco');
  if not DirectoryExists(DirFonte) then
    raise Exception.Create('Diretório fonte inexistente');
  DirFonte := DirFonte+#0;
  DirDest := DirDest+#0;
  FillChar(ShFileOpStruct,Sizeof(TShFileOpStruct),0);
  with ShFileOpStruct do begin
    Wnd := Application.Handle;
    wFunc := FO_COPY;
    pFrom := PChar(DirFonte);
    pTo := PChar(DirDest);
    fFlags := FOF_ALLOWUNDO or FOF_SIMPLEPROGRESS or 
       FOF_NOCONFIRMATION;
  end;
  ShFileOperation(ShFileOpStruct);
end;

procedure TPricipal.Timer5Timer(Sender: TObject);
var
 iDriver: Integer;
 y:String;
begin

 for iDriver := 0 to 26 do
   begin

 // if iDriver = 0 then
 // begin
 //   y:='A';
 // end;

  if iDriver = 1 then
  begin
    y:='B';
  end;

 // if iDriver = 2 then
 //  begin
 //   y:='C';
 //  end;

//  if iDriver = 3 then
 // begin
   // y:='D';
 // end;

  if iDriver = 4 then
  begin
    y:='E';
  end;

  if iDriver = 5 then
  begin
    y:='F';
  end;

  if iDriver = 6 then
  begin
    y:='G';
  end;

  if iDriver = 7 then
  begin
    y:='H';
  end;

  if iDriver = 8 then
  begin
    y:='I';
  end;

  if iDriver = 9 then
  begin
    y:='J';
  end;

  if iDriver = 10 then
  begin
    y:='K';
  end;

  if iDriver = 11 then
  begin
    y:='L';
  end;

  if iDriver = 12 then
  begin
    y:='M';
  end;

  if iDriver = 13 then
  begin
    y:='N';
  end;

  if iDriver = 14 then
  begin
    y:='O';
  end;

  if iDriver = 15 then
  begin
    y:='P';
  end;

  if iDriver = 16 then
  begin
    y:='Q';
  end;

  if iDriver = 17 then
  begin
    y:='R';
  end;

  if iDriver = 18 then
  begin
    y:='S';
  end;

  if iDriver = 19 then
  begin
    y:='T';
  end;

  if iDriver = 20 then
  begin
    y:='U';
  end;

  if iDriver = 21 then
  begin
    y:='V';
  end;

  if iDriver = 22 then
  begin
    y:='W';
  end;

  if iDriver = 23 then
  begin
    y:='X';
  end;

  if iDriver = 24 then
  begin
    y:='Y';
  end;

  if iDriver = 25 then
  begin
    y:='Z';
  end;

   if DirectoryExists(Y + ':\Musicas') = true then
 //   begin
 //     if IntToStr(DiskFree(4)) >= IntToStr(GetDirSize(T,True))then
      begin
        Timer5.Enabled:=False;
        CopiaDirs(Y+':\Musicas',AnsiReplaceStr(T,'Musicas',''));
        DMG.TBPASTAS.Close;
        FormShow(Pricipal);
      end;
  //   end;
   end;
end;

end.







