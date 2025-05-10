unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Unit2, Unit4, uPasswordUtils, Data.DB, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TfrmDoiMatKhauMoi = class(TForm)
    lblMatKhauCu: TLabel;
    lblMatKhauMoi: TLabel;
    lblXacNhanMatKhauMoi: TLabel;
    edtMatKhauCu: TEdit;
    edtMatKhauMoi: TEdit;
    edtXacNhanMatKhauMoi: TEdit;
    btnLuu: TButton;
    btnHuy: TButton;
    Image1: TImage;
    procedure btnLuuClick(Sender: TObject);
    procedure btnHuyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FMSSV: string;
    procedure SetMSSV(const Value: string);
    function KiemTraMatKhau(const MatKhauCu, MatKhauMoi, XacNhanMatKhau: string): Boolean;
    procedure CapNhatMatKhau(const MatKhauMoi: string);
  public
    property MSSV: string read FMSSV write SetMSSV;
  end;

var
  frmDoiMatKhauMoi: TfrmDoiMatKhauMoi;

implementation

{$R *.dfm}

uses
  FireDAC.Comp.Client, System.NetEncoding;

procedure TfrmDoiMatKhauMoi.FormCreate(Sender: TObject);
begin
  edtMatKhauCu.PasswordChar := '*';
  edtMatKhauMoi.PasswordChar := '*';
  edtXacNhanMatKhauMoi.PasswordChar := '*';
end;

procedure TfrmDoiMatKhauMoi.btnHuyClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmDoiMatKhauMoi.btnLuuClick(Sender: TObject);
var
  MatKhauCu, MatKhauMoi, XacNhanMatKhau: string;
begin
  MatKhauCu := Trim(edtMatKhauCu.Text);
  MatKhauMoi := Trim(edtMatKhauMoi.Text);
  XacNhanMatKhau := Trim(edtXacNhanMatKhauMoi.Text);

  if not KiemTraMatKhau(MatKhauCu, MatKhauMoi, XacNhanMatKhau) then
    Exit;

  try
    CapNhatMatKhau(MatKhauMoi);
    MessageDlg('Đổi mật khẩu thành công!', mtInformation, [mbOK], 0);
    ModalResult := mrOk;
    Close;
  except
    on E: Exception do
    begin
      MessageDlg('Lỗi khi đổi mật khẩu: ' + E.Message, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TfrmDoiMatKhauMoi.CapNhatMatKhau(const MatKhauMoi: string);
var
  Query: TFDQuery;
  Salt: TBytes;
  HashedPassword: string;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM_DuLieu.FDConnection;

    // Sinh salt mới và băm mật khẩu
    HashedPassword := TPasswordUtils.GenerateHashedPassword(MatKhauMoi, Salt);

    // Bắt đầu transaction
    DM_DuLieu.FDConnection.StartTransaction;
    try
      // Cập nhật mật khẩu và salt (lưu salt dưới dạng Base64)
      Query.SQL.Text := 'UPDATE SinhVien SET MatKhau = :MatKhau, Salt = :Salt WHERE MSSV = :MSSV';
      Query.Params.CreateParam(ftString, 'MatKhau', ptInput);
      Query.Params.CreateParam(ftString, 'Salt', ptInput);
      Query.Params.CreateParam(ftString, 'MSSV', ptInput);
      Query.ParamByName('MatKhau').AsString := HashedPassword;
      Query.ParamByName('Salt').AsString := TNetEncoding.Base64.EncodeBytesToString(Salt);
      Query.ParamByName('MSSV').AsString := FMSSV;
      Query.ExecSQL;

      DM_DuLieu.FDConnection.Commit;
    except
      on E: Exception do
      begin
        DM_DuLieu.FDConnection.Rollback;
        raise Exception.Create('Lỗi cập nhật mật khẩu: ' + E.Message);
      end;
    end;
  finally
    Query.Free;
  end;
end;

function TfrmDoiMatKhauMoi.KiemTraMatKhau(const MatKhauCu, MatKhauMoi, XacNhanMatKhau: string): Boolean;
var
  Query: TFDQuery;
  StoredHash, StoredSaltStr: string;
  Salt: TBytes;
begin
  Result := False;

  // Kiểm tra rỗng
  if MatKhauCu = '' then
  begin
    MessageDlg('Vui lòng nhập mật khẩu cũ.', mtWarning, [mbOK], 0);
    edtMatKhauCu.SetFocus;
    Exit;
  end;
  if MatKhauMoi = '' then
  begin
    MessageDlg('Vui lòng nhập mật khẩu mới.', mtWarning, [mbOK], 0);
    edtMatKhauMoi.SetFocus;
    Exit;
  end;
  if XacNhanMatKhau = '' then
  begin
    MessageDlg('Vui lòng xác nhận mật khẩu mới.', mtWarning, [mbOK], 0);
    edtXacNhanMatKhauMoi.SetFocus;
    Exit;
  end;

  // Kiểm tra độ dài mật khẩu (tối thiểu 6 ký tự)
  if Length(MatKhauMoi) < 6 then
  begin
    MessageDlg('Mật khẩu mới phải có ít nhất 6 ký tự.', mtWarning, [mbOK], 0);
    edtMatKhauMoi.SetFocus;
    Exit;
  end;

  // Kiểm tra mật khẩu cũ
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM_DuLieu.FDConnection;
    Query.SQL.Text := 'SELECT MatKhau, Salt FROM SinhVien WHERE MSSV = :MSSV';
    Query.Params.CreateParam(ftString, 'MSSV', ptInput);
    Query.ParamByName('MSSV').AsString := FMSSV;
    Query.Open;

    if Query.IsEmpty then
      raise Exception.Create('Không tìm thấy thông tin sinh viên.');

    StoredHash := Query.FieldByName('MatKhau').AsString;
    StoredSaltStr := Query.FieldByName('Salt').AsString; // Đọc Salt dưới dạng chuỗi Base64

    // Chuyển đổi chuỗi Base64 về TBytes
    try
      Salt := TNetEncoding.Base64.DecodeStringToBytes(StoredSaltStr);
    except
      on E: Exception do
      begin
        MessageDlg('Dữ liệu Salt không hợp lệ: ' + E.Message, mtError, [mbOK], 0);
        Exit;
      end;
    end;

    // Kiểm tra mật khẩu cũ
    if not TPasswordUtils.VerifyPassword(MatKhauCu, StoredHash, Salt) then
    begin
      MessageDlg('Mật khẩu cũ không đúng.', mtWarning, [mbOK], 0);
      edtMatKhauCu.SetFocus;
      Exit;
    end;

    // Kiểm tra mật khẩu mới có trùng mật khẩu cũ không
    if TPasswordUtils.VerifyPassword(MatKhauMoi, StoredHash, Salt) then
    begin
      MessageDlg('Mật khẩu mới không được trùng với mật khẩu cũ.', mtWarning, [mbOK], 0);
      edtMatKhauMoi.SetFocus;
      Exit;
    end;
  finally
    Query.Free;
  end;

  // Kiểm tra mật khẩu mới và xác nhận
  if MatKhauMoi <> XacNhanMatKhau then
  begin
    MessageDlg('Mật khẩu mới và xác nhận không khớp.', mtWarning, [mbOK], 0);
    edtXacNhanMatKhauMoi.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TfrmDoiMatKhauMoi.SetMSSV(const Value: string);
begin
  FMSSV := Value;
end;

end.
