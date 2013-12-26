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

unit Tfuncoes;

interface

uses
  StdCtrls, ComCtrls, Classes, SysUtils, Forms, ShellAPI, Windows, DBColorEdit, Dialogs, IniFiles, StrUtils, DBGrids,Graphics,
  ExtCtrls, JPEG, Registry;

type
  TFRC = class(TObject)
    procedure ultimobloco;
    procedure GetDirList(Directory: string; var Result: TStrings; IsRecursive: Boolean);
    function ExtractName(const Filename: String): String;
    function MouseShowCursor(const Show: boolean): boolean;
    Procedure LeIni(Var CredtidoParcial : Longint ; Var Numero : Longint ; Var NomedaMaquina : String ; Var Condicao : Boolean);
    Procedure LeIniconfig(Var AdicionaCredito : Longint ; Var Direita : Longint ;Var Esquerda : Longint ;Var AdicionaMusica : Longint ;Var ExcluiMusica : Longint ;Var Tocar : Longint ;Var MaisVolume : Longint ;Var MenosVolume : Longint ; Var Texto : String);
    Procedure GravaIni(CredtidoParcial : Longint ; Numero : Longint ; Texto : String ; Condicao : Boolean);
    procedure RedimencionaImage;
    Function ListarArquivos(Diretorio: string):String;
    procedure ListarMusicas(Diretorio: string);
    function TemAtributo(Attr, Val: Integer): Boolean;
    Function ListarImagens(Diretorio: string; Sub: Boolean):String;
    function tratanome(aux: string): String;
    procedure showForme;
    procedure Local(tipo:Boolean);
    procedure FocaBorda;
    procedure ProximaLetra;
    procedure ValidaTela;
    procedure CloseRegistro;
    procedure GravaRegistro(Raiz: HKEY; Chave, Valor, Endereco: string);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  FRC : TFRC;   // chama pelo    FRC
  Cont: Integer; // Conta Quantos albuns a Na Pasta Musicas
 // ProsimaPagina :Integer; // Somente pra controle do DBPASTA com o For que muda a pagina
 ////////Teclado/////////
   AdicionaCreditos:Integer;
   Direita:Integer;
   Esquerda:Integer;
   AdicionaMusicas:Integer;
   ExcluiMusicas:Integer;
   Tocar:Integer;
   MaisVolume:Integer;
   MenosVolume:Integer;
   Pasta:String;
///////////////////////
  ListBox2:TListBox;
  b:Integer;// Numero da Letra // ABC


implementation

uses Principal, Funcoes, DataModule, FTela, FVideo, FVolume, FProximaLetra;

  procedure TFRC.ValidaTela;
  begin
    if TelaVolume = True then
    begin
      Volume.Close;
    end;

    if TelaVideo = True then
    begin
      Video.Close;
    end;

    if TelaTela = True then
    begin
      Tela.Close;
    end;

    if TProximaLetra = True then
    begin
      ABC.Close;
    end;

  end;

  procedure TFRC.GravaRegistro(Raiz: HKEY; Chave, Valor, Endereco: string);
    var
     Registro: TRegistry;
    begin
     Registro := TRegistry.Create(KEY_WRITE); // Chama o construtor do objeto
     Registro.RootKey := Raiz;
     Registro.OpenKey(Chave, True); //Cria a chave
     Registro.WriteString(Valor, '"' + Endereco + '"'); //Grava o endereço da sua aplicação no Registro
     Registro.CloseKey; // Fecha a chave e o objeto
     Registro.Free;
   end;

  procedure TFRC.CloseRegistro;
  begin
     try
       GravaRegistro(HKEY_LOCAL_MACHINE, '\Software\Microsoft\Windows NT\CurrentVersion\Winlogon',
      'Shell','Explorer.exe');
     except
       MessageDlg('Erro ao gravar registro contate o desenvolvedor do sistema Alcir  Barros alcirbarros@hotmail.com (32) 9127 - 7676 !', mtInformation, [mbOk], 0);
     end;
  end;

  function TFRC.tratanome(aux: string): String;
  { Coloca a Primeira Letra da String Maiuscula }
    var
     i: integer;
  begin
     aux:=lowercase(aux);
   if length(aux)<>0
     then Begin
          aux[1]:=Upcase(aux[1]);
          for i:=2 to length(aux) do
            if aux[i]=' '
            then aux[i+1]:=Upcase(aux[i+1]);
          tratanome:=aux;
        End
   else
   tratanome:='';
  end;

Procedure TFRC.GravaIni(CredtidoParcial : Longint ; Numero : Longint ; Texto : String ; Condicao : Boolean);
var
ArqIni : TIniFile;
begin
ArqIni := TIniFile.Create('D:\Box\Controle.Ini');
Try
ArqIni.WriteInteger('Creditos', 'Creditos', Numero);
ArqIni.WriteString('Creditos', 'Texto', Texto);
ArqIni.WriteBool('Creditos', 'Condição', Condicao);
ArqIni.WriteInteger('Creditos', 'CredtidoParcial', CredtidoParcial);
Finally
ArqIni.Free;
end;
end;

Procedure TFRC.LeIni(Var CredtidoParcial : Longint ; Var Numero : Longint ; Var NomedaMaquina : String ; Var Condicao : Boolean);
var
ArqIni : tIniFile;
begin
ArqIni := tIniFile.Create('D:\Box\Controle.Ini');
Try
Numero := ArqIni.ReadInteger('Creditos', 'Creditos', Numero );
NomedaMaquina := ArqIni.ReadString('Creditos', 'NomedaMaquina', NomedaMaquina );
Condicao := ArqIni.ReadBool('Creditos', 'Condição', Condicao );
CredtidoParcial := ArqIni.ReadInteger('Creditos', 'CredtidoParcial', Numero );
PropragandaNome := ArqIni.ReadString('Contato', 'ContatoNome', PropragandaNome );
PropragandaTel := ArqIni.ReadString('Contato', 'ContatoTel', PropragandaTel );

Finally
ArqIni.Free;
end;
end;

Procedure TFRC.LeIniconfig(Var AdicionaCredito : Longint ; Var Direita : Longint ;Var Esquerda : Longint ;Var AdicionaMusica : Longint ;Var ExcluiMusica : Longint ;Var Tocar : Longint ;Var MaisVolume : Longint ;Var MenosVolume : Longint ; Var Texto : String);
var
ArqIni : tIniFile;
begin
ArqIni := tIniFile.Create('D:\Box\Controle.Ini');
Try

AdicionaCredito := ArqIni.ReadInteger('Controle', 'AdicionarCreditos', AdicionaCreditos );
Direita := ArqIni.ReadInteger('Controle', 'Direita', Direita );
Esquerda := ArqIni.ReadInteger('Controle', 'Esquerda', Esquerda );
AdicionaMusica := ArqIni.ReadInteger('Controle', 'AdicionaMusica', AdicionaMusica );
ExcluiMusica := ArqIni.ReadInteger('Controle', 'ExcluiMusica', ExcluiMusica );
Tocar := ArqIni.ReadInteger('Controle', 'Tocar', Tocar );
MaisVolume := ArqIni.ReadInteger('Controle', 'MaisVolume', MaisVolume );
MenosVolume := ArqIni.ReadInteger('Controle', 'MenosVolume', MenosVolume );
Texto := ArqIni.ReadString('Config', 'Pasta', Texto );
Finally
ArqIni.Free;
end;
end;


function TFRC.ExtractName(const Filename: String): String;
{Retorna o nome do Arquivo sem extensão}
var
aExt : String;
aPos : Integer;
begin
aExt := ExtractFileExt(Filename);
Result := ExtractFileName(Filename);
if aExt <> '' then
   begin
   aPos := Pos(aExt,Result);
   if aPos > 0 then
      begin
      Delete(Result,aPos,Length(aExt));
      end;
   end;
end;

function TFRC.MouseShowCursor(const Show: boolean): boolean;
var
  I: integer;
begin
  I := ShowCursor(LongBool(true));
  if Show then begin
  Result := I >= 0;
  while I < 0 do begin
  Result := ShowCursor(LongBool(true)) >= 0;
  Inc(I);
  end;
  end else begin
  Result := I < 0;
  while I >= 0 do begin
  Result := ShowCursor(LongBool(false)) < 0;
  Dec(I);
  end;
  end;
end;


procedure TFRC.GetDirList(Directory: string; var Result: TStrings;
  IsRecursive: Boolean);
var
  Sr: TSearchRec;

  procedure Recursive(Dir: string); { Sub Procedure, Recursiva }
  var
    SrAux: TSearchRec;
  begin
    if SrAux.Name = EmptyStr then
      FindFirst(Directory + '\' + Dir + '\*.*', faDirectory, SrAux);
    while FindNext(SrAux) = 0 do
      if SrAux.Name <> '..' then
        if DirectoryExists(Directory + '\' + Dir + '\' + SrAux.Name) then
        begin
          Result.Add(Directory + '\' + Dir + '\' + SrAux.Name);
          Recursive(Dir + '\' + SrAux.Name);
        end;
  end;
begin
 FindFirst(Directory + '\*.*', faDirectory, Sr);
 while FindNext(Sr) = 0 do
    if Sr.Name <> '..' then
    if DirectoryExists(Directory + '\' + Sr.Name) then
    begin
    Result.Add(Directory + '\' + Sr.Name);
    if IsRecursive then
    Recursive(Sr.Name);
 end;
end;

function TFRC.TemAtributo(Attr, Val: Integer): Boolean;
begin
Result := Attr and Val = Val;
end;

Function TFRC.ListarArquivos(Diretorio: string):String;
var
  Ext:string;
  Ret: Integer;
  imagem:string;
begin
  Ret := FindFirst(Diretorio+'\*.*', faAnyFile, F);
    while Ret = 0 do
    begin
      begin
      Ext := ExtractFileExt(F.Name); //Extrai a Extenção
      if  Ext = '.jpg'then
      begin
        Result := Diretorio+'\'+F.Name;
      end;

      if  Ext = '.JPG'then
      begin
        Result := Diretorio+'\'+F.Name;
      end;

       if  Ext = '.bmp'then
      begin
        Result := Diretorio+'\'+F.Name;
      end;

       if  Ext = '.BMP'then
      begin
        Result := Diretorio+'\'+F.Name;
      end;

      end;
        Ret := FindNext(F);
    end;
end;

procedure TFRC.showForme;
var
   lista: TStrings;
   ListBox1:TListBox;
   DBGrid1:TDBGrid ;
 begin
   FRC.LeIniconfig(AdicionaCreditos,Direita,Esquerda,AdicionaMusicas,ExcluiMusicas,Tocar,MaisVolume,MenosVolume,Pasta);
   ListBox1 := TListBox.Create(Inicio);
   ListBox1.Parent := Inicio;
   ListBox1.Visible:=False;
   T := Pasta;
   Lista := TStringList.Create;
   FRC.GetDirList(T, Lista, true);
   ListBox1.Items.Clear;
   ListBox1.Items := Lista;
   Lista.Free;
   FRC.MouseShowCursor(false);
   DMG.TBPASTAS.CreateDataSet;
   DMG.TBPASTAS.Open;
   DMG.TBPASTAS.EmptyDataSet;
  for Cont := 0 to ListBox1.Items.Count - 1 do
  begin
    DMG.TBPASTAS.insert;
    DMG.TBPASTASCODIGO.Value := DMG.TBPASTAS.RecordCount + 1;
    DMG.TBPASTASPASTA.Value := ListBox1.Items.Strings[Cont];
    DMG.TBPASTAS.post;
  end;
      ListBox2 := TListBox.Create(Inicio);
      ListBox2.Parent := Inicio;
   //   ListarImagens(Pasta,True);
   //   RedimencionaImage;
  {  try
      Pricipal.ShowModal;
    except
   end; }
end;

function PadronizaTamanho(Imagem: TGraphic; W, H: Integer; Tipo: TGraphicClass = nil): TGraphic;
var
B: TBitmap;
begin
B := TBitmap.Create;
try
B.Width := W;
B.Height := H;
B.Canvas.StretchDraw(Rect(0, 0, W, H), Imagem);
if Tipo = nil then
Result := TGraphic(Imagem.ClassType.Create)
else
Result := Tipo.Create;
Result.Assign(B);
finally
B.Free;
end;
end;

procedure TFRC.RedimencionaImage;
var
  I : Integer;
  NomeOld, NomeNew, Ext : string;
  Nova: TGraphic;
  Image1 :TImage;
  Image2 :TImage;
begin
   Image1 := TImage.Create(Inicio);
   Image2 := TImage.Create(Inicio);
 //  ListBox1.Parent := Inicio;
  for I := 0 to ListBox2.Items.Count - 1 do
  begin
    NomeOld := ListBox2.Items[I];//Ler nome Antigo
    Ext := ExtractFileExt(NomeOld); //Extrai a Extenção
    NomeNew := ExtractFilePath(NomeOld); //Extrai o local do arquivo
    Image1.Picture.LoadFromFile(NomeOld);
    Nova := PadronizaTamanho(Image1.Picture.Graphic, 326, 326, TJPEGImage);
    Image2.Picture.Graphic := Nova;
    NomeNew := NomeNew +'Capa'{+FormatFloat('', I+1)}+Ext;//Monta o nome novo
  //  RenameFile(NomeOld, NomeNew);
    try
  //  ShowMessage(NomeOld);
    Image2.Picture.SaveToFile(NomeOld);
    except
    end;
    Application.ProcessMessages;
  end;
end;

Function TFRC.ListarImagens(Diretorio: string; Sub: Boolean):String;
var
  Ext:string;
  F: TSearchRec;
  Ret: Integer;
  TempNome: string;
  imagem:string;
begin
  Ret := FindFirst(Diretorio+'\*.*', faAnyFile, F);

  try
    while Ret = 0 do
    begin
      if TemAtributo(F.Attr, faDirectory) then
      begin
        if (F.Name <> '.') And (F.Name <> '..') then
          if Sub = True then
          begin
            TempNome := Diretorio+'\' + F.Name;
            ListarImagens(TempNome, True);
          end;
      end
      else
      begin
      Ext := ExtractFileExt(F.Name); //Extrai a Extenção
      if  Ext = '.jpg'then
      begin
     // Label1.Caption:= Diretorio+'\'+F.Name;
      ListBox2.Items.Add(Diretorio+'\'+F.Name);
      imagem := Diretorio+'\'+F.Name;
      end;
      end;
        Ret := FindNext(F);
    end;
  finally
  begin
 //   FindClose(F);
  end;
  end;
   Result := imagem;
end;

procedure TFRC.ListarMusicas(Diretorio: string);
var
 Ret: Integer;
 TempNome: string;
 Musica: String;
begin

 Ret := FindFirst(Diretorio  + '\*.mp*', faAnyFile, F);

 while Ret = 0 do
 begin

 if TemAtributo(F.Attr, faDirectory) then
 begin

   end
   else
  begin


  if TelaVerificaVideo = False then
  begin
    ListItem := Pricipal.ListView1.Items.Add;
    Pricipal.ListView1.Repaint;
  end
  else
  begin
    ListItem := Tela.ListView1.Items.Add;
    Tela.ListView1.Repaint;
  end;
  
  Musica := F.Name;
  Musica := AnsiReplaceStr(Musica,'.mp3','');
  Musica := AnsiReplaceStr(Musica,'.MP3','');

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

end;

  procedure TFRC.ProximaLetra;
    var
      d:Integer;
      c:Integer;
      MinhaString1: String;
      MinhaString2: String;
    begin
         MinhaString1:=FRC.tratanome(AnsiReplaceStr(caminhopasta,T+'\', ''));
         d:=ORD(MinhaString1[1])+1;
       for c := DMG.TBPASTASCODIGO.Value to Cont do
      begin
         ABC.FDireita;
         MinhaString2:=FRC.tratanome(AnsiReplaceStr(DMG.TBPASTASPASTA.Value,T+'\', ''));
         b:=ORD(MinhaString2[1]);
       if b>=d then Break
      end;
         Pricipal.LocalizaImagem;
         FRC.FocaBorda;
         FRC.Local(True);
    end;

  procedure TFRC.Local (tipo:Boolean);
  begin
  
   if conta = 8 then
      begin
   if TelaVerificaVideo = False then
      begin
      Pricipal.imapri.Picture:=Pricipal.ima8.Picture;
      end
      else
      begin
      Tela.Imapri.Picture:=Pricipal.ima8.Picture;
      Tela.Imapri.Repaint;
      end;
      caminhopasta := im8;
      end;

      if conta = 7 then
      begin
   if TelaVerificaVideo = False then
      begin
       Pricipal.imapri.Picture:=Pricipal.ima7.Picture;
      end
      else
      begin
      Tela.Imapri.Picture:=Pricipal.ima7.Picture;
      Tela.Imapri.Repaint;
      end;
      caminhopasta := im7;
      end;

      if conta = 6 then
      begin
   if TelaVerificaVideo = False then
      begin
       Pricipal.imapri.Picture:=Pricipal.ima6.Picture;
      end
      else
      begin
      Tela.Imapri.Picture:=Pricipal.ima6.Picture;
      Tela.Imapri.Repaint;
      end;
      caminhopasta := im6;
      end;

      if conta = 5 then
      begin
   if TelaVerificaVideo = False then
      begin
       Pricipal.imapri.Picture:=Pricipal.ima5.Picture;
      end
      else
      begin
      Tela.Imapri.Picture:=Pricipal.ima5.Picture;
      Tela.Imapri.Repaint;
      end;
      caminhopasta := im5;
      end;

      if conta = 4 then
      begin
   if TelaVerificaVideo = False then
      begin
       Pricipal.imapri.Picture:=Pricipal.ima4.Picture;
      end
      else
      begin
      Tela.Imapri.Picture:=Pricipal.ima4.Picture;
      Tela.Imapri.Repaint;
      end;
      caminhopasta := im4;
      end;

      if conta = 3 then
      begin
   if TelaVerificaVideo = False then
      begin
       Pricipal.imapri.Picture:=Pricipal.ima3.Picture;
      end
      else
      begin
      Tela.Imapri.Picture:=Pricipal.ima3.Picture;
      Tela.Imapri.Repaint;
      end;
      caminhopasta := im3;
      end;

      if conta = 2 then
      begin
   if TelaVerificaVideo = False then
      begin
       Pricipal.imapri.Picture:=Pricipal.ima2.Picture;
      end
      else
      begin
       Tela.Imapri.Picture:=Pricipal.ima2.Picture;
       Tela.Imapri.Repaint;
      end;
      caminhopasta := im2;
      end;

      if conta = 1 then
      begin
   if TelaVerificaVideo = False then
      begin
       Pricipal.imapri.Picture:=Pricipal.ima1.Picture;
      end
      else
      begin
      Tela.Imapri.Picture:=Pricipal.ima1.Picture;
      Tela.Imapri.Repaint;
      end;
      caminhopasta := im1;
      end;

   if TelaVerificaVideo = False then
      begin
      Pricipal.Labeil1.Caption := AnsiReplaceStr(caminhopasta,T+'\', '');
      Pricipal.ListView1.Items.Clear;
      end
      else
      begin
      Tela.TelaNomeDoAlbum.Caption:=AnsiReplaceStr(caminhopasta,T+'\','');
      Tela.TelaNomeDoAlbum.Repaint;
      Tela.ListView1.Items.Clear;
      end;
      FRC.ListarMusicas( caminhopasta );
end;

  procedure TFRC.FocaBorda;
  begin
  //1º bloco
        if conta = 1 then
        begin

        Pricipal.Bord1.Visible := True;
        Pricipal.Bord2.Visible := False;
        Pricipal.Bord3.Visible := False;
        Pricipal.Bord4.Visible := False;
        Pricipal.Bord5.Visible := False;
        Pricipal.Bord6.Visible := False;
        Pricipal.Bord7.Visible := False;
        Pricipal.Bord8.Visible := False;

        end;

           //2º bloco
        if conta = 2 then
        begin

        Pricipal.Bord1.Visible := False;
        Pricipal.Bord2.Visible := True;
        Pricipal.Bord3.Visible := False;
        Pricipal.Bord4.Visible := False;
        Pricipal.Bord5.Visible := False;
        Pricipal.Bord6.Visible := False;
        Pricipal.Bord7.Visible := False;
        Pricipal.Bord8.Visible := False;

        end;

         //3º bloco
        if conta = 3 then
        begin

        Pricipal.Bord1.Visible := False;
        Pricipal.Bord2.Visible := False;
        Pricipal.Bord3.Visible := True;
        Pricipal.Bord4.Visible := False;
        Pricipal.Bord5.Visible := False;
        Pricipal.Bord6.Visible := False;
        Pricipal.Bord7.Visible := False;
        Pricipal.Bord8.Visible := False;

        end;

       //4º bloco
        if conta = 4 then
        begin

        Pricipal.Bord1.Visible := False;
        Pricipal.Bord2.Visible := False;
        Pricipal.Bord3.Visible := False;
        Pricipal.Bord4.Visible := True;
        Pricipal.Bord5.Visible := False;
        Pricipal.Bord6.Visible := False;
        Pricipal.Bord7.Visible := False;
        Pricipal.Bord8.Visible := False;

        end;

          //5º bloco
        if conta = 5 then
        begin

        Pricipal.Bord1.Visible := False;
        Pricipal.Bord2.Visible := False;
        Pricipal.Bord3.Visible := False;
        Pricipal.Bord4.Visible := False;
        Pricipal.Bord5.Visible := True;
        Pricipal.Bord6.Visible := False;
        Pricipal.Bord7.Visible := False;
        Pricipal.Bord8.Visible := False;

        end;

          //6º bloco
        if conta = 6 then
        begin

        Pricipal.Bord1.Visible := False;
        Pricipal.Bord2.Visible := False;
        Pricipal.Bord3.Visible := False;
        Pricipal.Bord4.Visible := False;
        Pricipal.Bord5.Visible := False;
        Pricipal.Bord6.Visible := True;
        Pricipal.Bord7.Visible := False;
        Pricipal.Bord8.Visible := False;

        end;

         //7º bloco
        if conta = 7 then
        begin

        Pricipal.Bord1.Visible := False;
        Pricipal.Bord2.Visible := False;
        Pricipal.Bord3.Visible := False;
        Pricipal.Bord4.Visible := False;
        Pricipal.Bord5.Visible := False;
        Pricipal.Bord6.Visible := False;
        Pricipal.Bord7.Visible := True;
        Pricipal.Bord8.Visible := False;

        end;

               //8º bloco
        if conta = 8 then
        begin

        Pricipal.Bord1.Visible := False;
        Pricipal.Bord2.Visible := False;
        Pricipal.Bord3.Visible := False;
        Pricipal.Bord4.Visible := False;
        Pricipal.Bord5.Visible := False;
        Pricipal.Bord6.Visible := False;
        Pricipal.Bord7.Visible := False;
        Pricipal.Bord8.Visible := True;

        end;

  end;


procedure TFRC.ultimobloco;
 var a:integer; //(declara a variável i)
    b:Integer;
 begin
    b:=8;
    i:=Cont-1;

    for a := 1 to Cont do
     begin
       b:= b+8;
       if b >= Cont-8 then Break
     end;

       If cont <= 16 then
         begin
          b:= b-8;
         end;


       //1º bloco
        if cont-b = 1 then
        begin
        totGru := cont+7;
        conta:= 2 ;
        DMG.TBPASTAS.Last;
        Pricipal.Bord1.Visible := True;
        Pricipal.Bord8.Visible := False;
        Pricipal.ima2.Visible := False;
        Pricipal.ima3.Visible := False;
        Pricipal.ima4.Visible := False;
        Pricipal.ima5.Visible := False;
        Pricipal.ima6.Visible := False;
        Pricipal.ima7.Visible := False;
        Pricipal.ima8.Visible := False;
        im1 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Last;
        end;

           //2º bloco
        if cont-b = 2 then
        begin
        totGru := cont+6;
        conta:= 3 ;
        DMG.TBPASTAS.Last;
        Pricipal.Bord2.Visible := True;
        Pricipal.Bord8.Visible :=False;
        Pricipal.ima3.Visible := False;
        Pricipal.ima4.Visible := False;
        Pricipal.ima5.Visible := False;
        Pricipal.ima6.Visible := False;
        Pricipal.ima7.Visible := False;
        Pricipal.ima8.Visible := False;
        im2 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Prior;
        im1 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Last;
        end;

         //3º bloco
        if cont-b = 3 then
        begin
        totGru := cont+5;
        conta:= 4 ;
        DMG.TBPASTAS.Last;
        Pricipal.Bord3.Visible:= True;
        Pricipal.Bord8.Visible:= False;
        Pricipal.ima4.Visible := False;
        Pricipal.ima5.Visible := False;
        Pricipal.ima6.Visible := False;
        Pricipal.ima7.Visible := False;
        Pricipal.ima8.Visible := False;
        im3 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Prior;
        im2 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Prior;
        im1 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Last;
        end;

       //4º bloco
        if Cont-b = 4 then
        begin
        totGru := cont+4;
        conta:= 5 ;
        DMG.TBPASTAS.Last;
        Pricipal.Bord4.Visible := True;
        Pricipal.Bord8.Visible := False;
        Pricipal.ima5.Visible := False;
        Pricipal.ima6.Visible := False;
        Pricipal.ima7.Visible := False;
        Pricipal.ima8.Visible := False;
        im4 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Prior;
        im3 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Prior;
        im2 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Prior;
        im1 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Last;
        end;

          //5º bloco
        if cont-b = 5 then
        begin
        totGru := cont+3;
        conta:= 6 ;
        DMG.TBPASTAS.Last;
        Pricipal.Bord5.Visible := True;
        Pricipal.Bord8.Visible := False;
        Pricipal.ima6.Visible := False;
        Pricipal.ima7.Visible := False;
        Pricipal.ima8.Visible := False;
        im5 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Prior;
        im4 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Prior;
        im3 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Prior;
        im2 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Prior;
        im1 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Last;
        end;

          //6º bloco
        if cont-b = 6 then
        begin
        totGru := cont+2;
        conta:= 7 ;
        DMG.TBPASTAS.Last;
        Pricipal.Bord6.Visible := True;
        Pricipal.Bord8.Visible := False;
        Pricipal.ima7.Visible := False;
        Pricipal.ima8.Visible := False;
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
        DMG.TBPASTAS.Last;
        end;

         //7º bloco
        if cont-b = 7 then
        begin
        totGru := cont+1;
        conta:= 8 ;
        DMG.TBPASTAS.Last;
        Pricipal.Bord7.Visible := True;
        Pricipal.Bord8.Visible := False;
        Pricipal.ima8.Visible := False;
        im7 := DMG.TBPASTAS.Fields[1].AsString;
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

        DMG.TBPASTAS.Last;
        end;

               //8º bloco
        if cont-b = 8 then
        begin
        totGru := cont;
        conta:= 9 ;
        DMG.TBPASTAS.Last;
        Pricipal.Bord8.Visible := True;
        im8 := DMG.TBPASTAS.Fields[1].AsString;
        DMG.TBPASTAS.Prior;
        im7 := DMG.TBPASTAS.Fields[1].AsString;
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
        DMG.TBPASTAS.Last;
        end;

end;
end.
