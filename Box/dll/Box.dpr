library Box;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  IniFiles,
  Windows,
  ComCtrls,
  StdCtrls,
  DBGrids,
  Classes,
  FBox in 'FBox.pas' {ForBox},
  DataModule in 'DataModule.pas' {DMG: TDataModule};

var
  Cont: Integer;
  i, totGru, credito: Integer;
  im1, im2, im3, im4, im5, im6, im7, im8: string; // Caminho De cada Imagem
  palavra: string; // Nome Do album que esta selecionado na tela
  ListItem: TListItem;
  SubItem: TStrings;
  F: TSearchRec;
  BloqueiaMusicapraToca: Integer;//Conta as Musicas no Listiwil2 pra travar pra nao excloulas depois de ter apertado enter
  caminhopasta:String; //Caminho Da Pasta Completo 
 // Tempo:TTimer;
  Salto :Integer; // Somente pra controle do DBPASTA com o For que mudandao de pagina  
  T:String;   // Guarda o Caminho Para a Pasta Musicas e Nao Tem o Nome do Album

{$R *.res}

Procedure GravaIni( Numero : Longint ; Texto : String ; Condicao : Boolean);
var
ArqIni : TIniFile;
begin
ArqIni := TIniFile.Create('C:\Box\Controle.Ini');
Try
ArqIni.WriteInteger('Creditos', 'Creditos', Numero);
ArqIni.WriteString('Creditos', 'Texto', Texto);
ArqIni.WriteBool('Creditos', 'Condi��o', Condicao);
Finally
ArqIni.Free;
end;
end;

Procedure LeIni( Var Numero : Longint ; Var Texto : String ; Var Condicao : Boolean);
var
ArqIni : tIniFile;
begin
ArqIni := tIniFile.Create('C:\Box\Controle.Ini');
Try
Numero := ArqIni.ReadInteger('Creditos', 'Creditos', Numero );
Texto := ArqIni.ReadString('Creditos', 'Texto', Texto );
Condicao := ArqIni.ReadBool('Creditos', 'Condi��o', Condicao );
Finally
ArqIni.Free;
end;
end;

function ExtractName(const Filename: String): String;
{Retorna o nome do Arquivo sem extens�o}
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

function MouseShowCursor(const Show: boolean): boolean; Stdcall;
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


procedure GetDirList(Directory: string; var Result: TStrings;
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

function TemAtributo(Attr, Val: Integer): Boolean;
begin
Result := Attr and Val = Val;
end;

Function ListarArquivos(Diretorio: string):String;
var
  Ext:string;
  Ret: Integer;
  imagem:string;
begin
  Ret := FindFirst(Diretorio+'\*.*', faAnyFile, F);
    while Ret = 0 do
    begin
      begin
      Ext := ExtractFileExt(F.Name); //Extrai a Exten��o
      if  Ext = '.jpg'then
      begin
      imagem := Diretorio+'\'+F.Name;
      end;
      end;
        Ret := FindNext(F);
    end;
   Result := imagem;
end;

procedure showForme; Stdcall;
var
   lista: TStrings;
   ListBox1:TListBox;
   DBGrid1:TDBGrid ;
 begin
   ListBox1 := TListBox.Create(ForBox);
   DBGrid1  := TDBGrid.Create(ForBox);
   ListBox1.Parent := ForBox;
   DBGrid1.Parent  := ForBox;
   T := 'C:\Musicas';
   Lista := TStringList.Create;
   GetDirList(T, Lista, true);
   ListBox1.Items.Clear;
   ListBox1.Items := Lista;
   Lista.Free;
 // FRC.MouseShowCursor(false);
 {s:=VDOHddSerial1.SerialNumber;}
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
end;

exports
showForme,
MouseShowCursor ;

begin
end.
