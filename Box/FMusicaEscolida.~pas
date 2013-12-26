unit FMusicaEscolida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TMusicaEscolida = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MusicaEscolida: TMusicaEscolida;

implementation

{$R *.dfm}

procedure TMusicaEscolida.Timer1Timer(Sender: TObject);
begin
  MusicaEscolida.Close;
  Timer1.Enabled:=False;
end;

end.
