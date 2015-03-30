program FixCyrSmb;

uses
  Forms,
  uFixCyrSmb in 'uFixCyrSmb.pas' {fFixCyrSmb};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfFixCyrSmb, fFixCyrSmb);
  Application.Run;
end.
