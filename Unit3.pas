unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit4, Unit1,
    FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Phys;

type
  TfrmDoiMatKhau = class(TForm)
    Label1: TLabel;
    lblMatKhauMoi: TLabel;
    lblXacNhanMatKhauMoi: TLabel;
    edtMatKhauMoi: TEdit;
    edtXacNhanMatKhauMoi: TEdit;
    btnDoiMatKhau: TButton;
    btnHuyDoiMatKhau: TButton;
    procedure btnDoiMatKhauClick(Sender: TObject);
    procedure btnHuyDoiMatKhauClick(Sender: TObject);
  private
    { Private declarations }
    FMSSV_DangNhap: string;
  public
    { Public declarations }
    property MSSV_DangNhap: string read FMSSV_DangNhap write FMSSV_DangNhap;
  end;

var
  frmDoiMatKhau: TfrmDoiMatKhau;

implementation

{$R *.dfm}

uses uPasswordUtils, System.NetEncoding;

procedure TfrmDoiMatKhau.btnDoiMatKhauClick(Sender: TObject);
var
  MatKhauMoi, XacNhanMatKhauMoi, MatKhauHash: string;
  Salt: TBytes;
  SQL: string;
  QueryDoiMatKhau: TFDQuery;
begin
  MatKhauMoi := Trim(edtMatKhauMoi.Text);
  XacNhanMatKhauMoi := Trim(edtXacNhanMatKhauMoi.Text);

  // Kiểm tra mật khẩu mới và xác nhận mật khẩu
  if MatKhauMoi = '' then
  begin
    ShowMessage('Vui lòng nhập mật khẩu mới.');
    edtMatKhauMoi.SetFocus;
    Exit;
  end;
  if MatKhauMoi <> XacNhanMatKhauMoi then
  begin
    ShowMessage('Mật khẩu mới và xác nhận mật khẩu không khớp.');
    edtXacNhanMatKhauMoi.Clear;
    edtXacNhanMatKhauMoi.SetFocus;
    Exit;
  end;
  if Length(MatKhauMoi) < 6 then
  begin
    ShowMessage('Mật khẩu mới phải có ít nhất 6 ký tự.');
    edtMatKhauMoi.SetFocus;
    Exit;
  end;

  // Băm mật khẩu mới bằng PBKDF2
  MatKhauHash := TPasswordUtils.GenerateHashedPassword(MatKhauMoi, Salt);

  // Cập nhật mật khẩu và salt trong CSDL
  QueryDoiMatKhau := TFDQuery.Create(nil);
  try
    QueryDoiMatKhau.Connection := DM_DuLieu.FDConnection;
    SQL := 'UPDATE SinhVien SET MatKhau = :MatKhauMoi, Salt = :Salt WHERE MSSV = :MSSV';
    QueryDoiMatKhau.SQL.Text := SQL;
    QueryDoiMatKhau.Params.ParamByName('MatKhauMoi').AsString := MatKhauHash;
    QueryDoiMatKhau.Params.ParamByName('Salt').AsString := TNetEncoding.Base64.EncodeBytesToString(Salt);
    QueryDoiMatKhau.Params.ParamByName('MSSV').AsString := FMSSV_DangNhap;

    QueryDoiMatKhau.ExecSQL; // Thực thi câu lệnh UPDATE

    ModalResult := mrOk; // Đặt ModalResult để form login biết là đổi mật khẩu thành công
    Close; // Đóng form đổi mật khẩu
  finally
    QueryDoiMatKhau.Free;
  end;
end;

procedure TfrmDoiMatKhau.btnHuyDoiMatKhauClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

end.
