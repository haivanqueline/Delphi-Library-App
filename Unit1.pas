unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Unit4,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Phys;

type
  TfrmLogin = class(TForm)
    lblMSSV: TLabel;
    lblMatKhau: TLabel;
    lblNgaySinh: TLabel;
    edtMaSV: TEdit;
    edtMatKhau: TEdit;
    btnDangNhap: TButton;
    Label1: TLabel;
    edtNgaySinh: TEdit;
    btnThoat: TButton;
    procedure btnDangNhapClick(Sender: TObject);
    procedure btnThoatClick(Sender: TObject);
    procedure edtNgaySinhKeyPress(Sender: TObject; var Key: Char);
    procedure edtNgaySinhChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses Unit2, Unit3;

procedure TfrmLogin.btnDangNhapClick(Sender: TObject);
var
  MSSV,HoTenSinhVien, NgaySinh, MatKhauNhap,MatKhauDB: string;
  SQL: string;
  QueryLogin: TFDQuery;
begin
  MSSV := edtMaSV.Text;
  NgaySinh := edtNgaySinh.Text;
  MatKhauNhap := edtMatKhau.Text;

  // Kiểm tra dữ liệu nhập liệu
  if (MSSV = '') or (NgaySinh = '') or (MatKhauNhap = '') then
  begin
    ShowMessage('Vui lòng nhập đầy đủ thông tin đăng nhập.');
    Exit;
  end;

  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  NgaySinh := FormatDateTime('dd/mm/yyyy', StrToDate(NgaySinh));

  // Tạo và thực thi Query để kiểm tra đăng nhập
  QueryLogin := TFDQuery.Create(nil);
  try
    QueryLogin.Connection := DM_DuLieu.FDConnection;
    SQL := 'SELECT MSSV, HoLot, Ten, MatKhau FROM SinhVien WHERE MSSV = :MSSV AND NgaySinh = :NgaySinh';
    QueryLogin.SQL.Text := SQL;
    QueryLogin.Params.ParamByName('MSSV').AsString := MSSV;
    QueryLogin.Params.ParamByName('NgaySinh').AsString := NgaySinh;

    QueryLogin.Open();

    if QueryLogin.RecordCount = 1 then // Tìm thấy sinh viên
    begin
      MatKhauDB := QueryLogin.FieldByName('MatKhau').AsString; // Lấy mật khẩu từ database
      HoTenSinhVien := QueryLogin.FieldByName('HoLot').AsString + ' ' + QueryLogin.FieldByName('Ten').AsString;
      if MatKhauDB = 'DHTN@123' then // **TRƯỜNG HỢP 1: Mật khẩu mặc định**
      begin
        if MatKhauNhap = 'DHTN@123' then // **KIỂM TRA MẬT KHẨU NHẬP VÀO CÓ PHẢI MẬT KHẨU MẶC ĐỊNH KHÔNG**
        begin
          // Hiển thị form đổi mật khẩu (modal) - CHỈ KHI NHẬP ĐÚNG MẬT KHẨU MẶC ĐỊNH
          with frmDoiMatKhau do
          begin
            MSSV_DangNhap := MSSV;
            if ShowModal = mrOk then
            begin
              ShowMessage('Đổi mật khẩu thành công. Chào mừng bạn!');
              Self.Hide;
              frmMain.Show;
            end else
            begin
              ShowMessage('Bạn cần nhập mật khẩu mới để tiếp tục sử dụng ứng dụng.');
            end;
          end;
        end else // Nhập sai mật khẩu mặc định
        begin
          ShowMessage('Mật khẩu mặc định không chính xác.'); // Thông báo rõ ràng là sai mật khẩu mặc định
          edtMatKhau.Clear;
          edtMatKhau.SetFocus;
        end;
      end else // **TRƯỜNG HỢP 2: Mật khẩu đã đổi (không phải mặc định)**
      begin
        if MatKhauDB = MatKhauNhap then // Kiểm tra mật khẩu nhập vào so với mật khẩu đã đổi trong database
        begin
          // Đăng nhập thành công với mật khẩu đã đổi
          ShowMessage('Đăng nhập thành công. Chào mừng bạn!');
          Self.Hide;
          frmMain.HoTenNguoiDung := HoTenSinhVien;
          frmMain.MSSV_DangNhap := MSSV;
          frmMain.Show;
        end else // Nhập sai mật khẩu đã đổi
        begin
          ShowMessage('Mật khẩu không chính xác.'); // Thông báo sai mật khẩu (không phải mặc định)
          edtMatKhau.Clear;
          edtMatKhau.SetFocus;
        end;
      end;
    end else // Không tìm thấy sinh viên
    begin
      ShowMessage('Mã số sinh viên hoặc ngày sinh không đúng.');
      edtMaSV.Clear;
      edtNgaySinh.Clear;
      edtMaSV.SetFocus;
    end;
  finally
    QueryLogin.Free;
  end;
end;
procedure TfrmLogin.btnThoatClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.edtNgaySinhChange(Sender: TObject);
var
  TextWithoutSlash: string;
  FormattedText: string;
  i: Integer;
begin
  // 1. Lấy chuỗi hiện tại trong edtNgaySinh
  TextWithoutSlash := edtNgaySinh.Text;

  // 2. Loại bỏ hết các dấu "/" hiện có trong chuỗi
  TextWithoutSlash := StringReplace(TextWithoutSlash, '/', '', [rfReplaceAll]);

  // 3. Giới hạn độ dài chuỗi số nhập vào (tối đa 8 số - ddmmyyyy)
  if Length(TextWithoutSlash) > 8 then
  begin
    TextWithoutSlash := Copy(TextWithoutSlash, 1, 8);
  end;

  FormattedText := ''; // Chuỗi đã định dạng

  // 4. Định dạng lại chuỗi với dấu "/" tùy theo độ dài
  for i := 1 to Length(TextWithoutSlash) do
  begin
    FormattedText := FormattedText + TextWithoutSlash[i];
    if (i = 2) or (i = 4) then // Thêm "/" sau ký tự thứ 2 và thứ 4
    begin
      FormattedText := FormattedText + '/';
    end;
  end;

  // 5. Cập nhật lại nội dung của edtNgaySinh bằng chuỗi đã định dạng
  edtNgaySinh.Text := FormattedText;
  edtNgaySinh.SelStart := Length(FormattedText); // Đặt con trỏ về cuối chuỗi
end;

procedure TfrmLogin.edtNgaySinhKeyPress(Sender: TObject; var Key: Char);
begin
if not CharInSet(Key, ['0'..'9', #8, #46]) then // #8 là Backspace, #46 là Delete
  begin
    Key := #0; // Chặn các ký tự không phải số
  end;
end;

end.
