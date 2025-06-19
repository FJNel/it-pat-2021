program frmLogin_p;

uses
  Forms,
  frmLogin_u in 'frmLogin_u.pas' {frmLogIn},
  dmUserLogin_u in 'dmUserLogin_u.pas' {dmUserLogin: TDataModule},
  frmVerify_u in 'frmVerify_u.pas' {frmVerify},
  frmEnd_u in 'frmEnd_u.pas' {frmEnd};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogIn, frmLogIn);
  Application.CreateForm(TdmUserLogin, dmUserLogin);
  Application.CreateForm(TfrmVerify, frmVerify);
  Application.CreateForm(TfrmEnd, frmEnd);
  Application.Run;
end.
