program GeradorBox;

uses
  Forms,
  FProtecao in 'FProtecao.pas' {Proteger},
  FSobre in 'FSobre.pas' {Contato};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TProteger, Proteger);
  Application.CreateForm(TContato, Contato);
  Application.Run;
end.
