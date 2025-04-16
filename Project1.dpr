program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {frmLogin},
  Unit2 in 'Unit2.pas' {frmMain},
  Unit3 in 'Unit3.pas' {frmDoiMatKhau},
  Unit4 in 'Unit4.pas' {DM_DuLieu: TDataModule},
  Unit5 in 'Unit5.pas' {frmNhapYeuCauMuon},
  Unit6 in 'Unit6.pas' {frmNhapGiaHan},
  uPasswordUtils in 'uPasswordUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmDoiMatKhau, frmDoiMatKhau);
  Application.CreateForm(TDM_DuLieu, DM_DuLieu);
  Application.CreateForm(TfrmNhapYeuCauMuon, frmNhapYeuCauMuon);
  Application.CreateForm(TfrmNhapGiaHan, frmNhapGiaHan);
  Application.Run;
end.
