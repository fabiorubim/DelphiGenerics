program Generics;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {frmGenerics};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGenerics, frmGenerics);
  Application.Run;
end.
