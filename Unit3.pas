unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit4, Unit1,
    FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Phys,
  System.Hash,
  System.NetEncoding;

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

procedure TfrmDoiMatKhau.btnDoiMatKhauClick(Sender: TObject);
var
  MatKhauMoi, XacNhanMatKhauMoi, MatKhauHash: string;
  SQL: string;
  QueryDoiMatKhau: TFDQuery;
  HashBytes: TBytes; // Biến để lưu hash dạng byte
begin
  MatKhauMoi := edtMatKhauMoi.Text;
  XacNhanMatKhauMoi := edtXacNhanMatKhauMoi.Text;

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

  // **Hash mật khẩu mới bằng SHA-256**


  // Cập nhật mật khẩu trong CSDL
  QueryDoiMatKhau := TFDQuery.Create(nil);
  try
    QueryDoiMatKhau.Connection := DM_DuLieu.FDConnection;
    SQL := 'UPDATE SinhVien SET MatKhau = :MatKhauMoi WHERE MSSV = :MSSV';
    //SQL := 'UPDATE SinhVien SET MatKhau = :MatKhauMoiHash WHERE MSSV = :MSSV';
    QueryDoiMatKhau.SQL.Text := SQL;
    QueryDoiMatKhau.Params.ParamByName('MatKhauMoi').AsString := MatKhauMoi;
    //QueryDoiMatKhau.Params.ParamByName('MatKhauMoiHash').AsString := MatKhauHash;
    QueryDoiMatKhau.Params.ParamByName('MSSV').AsString := FMSSV_DangNhap; // Sử dụng MSSV đã được truyền từ form login

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
