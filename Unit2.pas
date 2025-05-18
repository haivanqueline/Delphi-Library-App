unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Unit4, Vcl.Menus, Unit1, Vcl.ToolWin,
  Vcl.Tabs, Vcl.DockTabSet, System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage, System.Math,
  Vcl.Buttons;

type
  TfrmMain = class(TForm)
    pnlHeader: TPanel;
    lblHoTen: TLabel;
    btnDangXuat: TBitBtn;
    btnDoiMatKhau_Header: TBitBtn;
    btnThoat: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    pnlTraCuu_TimKiem: TPanel;
    lblTraCuu_NhanTimKiem: TLabel;
    btnTraCuu_TimKiem: TBitBtn;
    lstvTraCuu_DanhSachTaiLieu: TListView;
    PopupMenu1: TPopupMenu;
    mnuTraCuu_MuonTaiLieu: TMenuItem;
    pnlMuon_TimKiem: TPanel;
    lblMuon_NhanTimKiem: TLabel;
    edtMuon_TuKhoa: TEdit;
    btnMuon_TimKiem: TBitBtn;
    PopupMenu2: TPopupMenu;
    mnuDangMuon_TraTaiLieu: TMenuItem;
    mnuDangMuon_GiaHanTaiLieu: TMenuItem;
    lstvTra_LichSuMuonTra: TListView;
    lstvQuaHan_DanhSach: TListView;
    pnlLichSu_BoLoc: TPanel;
    lblLichSu_NhanTrangThai: TLabel;
    cboLichSu_TrangThai: TComboBox;
    btnLichSu_Loc: TBitBtn;
    lstvDangMuon_DanhSach: TListView;
    imgAvatar: TImage;
    Timer1: TTimer;
    btnThongBao: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    edtTraCuu_TenTaiLieu: TEdit;
    edtTraCuu_TenTacGia: TEdit;
    edtTraCuu_NhaXB: TEdit;
    edtTraCuu_MoTa: TEdit;
    procedure btnDangXuatClick(Sender: TObject);
    procedure btnThoatClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnTraCuu_TimKiemClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure mnuTraCuu_MuonTaiLieuClick(Sender: TObject);
    procedure btnLichSu_LocClick(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure mnuDangMuon_TraTaiLieuClick(Sender: TObject);
    procedure mnuDangMuon_GiaHanTaiLieuClick(Sender: TObject);
    procedure btnThanhToan_QuaHanClick(Sender: TObject);
    procedure btnDoiMatKhau_HeaderClick(Sender: TObject);
    procedure btnDangXuatMouseEnter(Sender: TObject);
    procedure btnDangXuatMouseLeave(Sender: TObject);
    procedure btnDoiMatKhau_HeaderMouseEnter(Sender: TObject);
    procedure btnDoiMatKhau_HeaderMouseLeave(Sender: TObject);
    procedure btnThoatMouseEnter(Sender: TObject);
    procedure btnThoatMouseLeave(Sender: TObject);
    procedure btnTraCuu_TimKiemMouseEnter(Sender: TObject);
    procedure btnTraCuu_TimKiemMouseLeave(Sender: TObject);
    procedure btnLichSu_LocMouseEnter(Sender: TObject);
    procedure btnLichSu_LocMouseLeave(Sender: TObject);
    procedure btnMuon_TimKiemMouseEnter(Sender: TObject);
    procedure btnMuon_TimKiemMouseLeave(Sender: TObject);
    procedure lstvTraCuu_DanhSachTaiLieuCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lstvTra_LichSuMuonTraCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lstvDangMuon_DanhSachCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lstvQuaHan_DanhSachCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnThongBaoClick(Sender: TObject);
  private
    FHoTenNguoiDung: string;
    FMSSV_DangNhap: string;
    FThongBaoDaHienThi: TStringList;
    FadeStep: Integer;
    FadeDirection: Integer;
    function RemoveDiacritics(const Input: string): string;
    procedure HienThiDuLieuTraCuu;
    procedure HienThiDuLieuLichSu;
    procedure HienThiDuLieuDangMuon;
    procedure HienThiDuLieuQuaHan;
    procedure CapNhatTrangThaiQuaHan;
    procedure StartFadeIn;
    procedure StartFadeOut;
    procedure HienThiThongBao;
    function LayTatCaThongBao: TStringList;
  public
    property HoTenNguoiDung: string read FHoTenNguoiDung write FHoTenNguoiDung;
    property MSSV_DangNhap: string read FMSSV_DangNhap write FMSSV_DangNhap;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  FireDAC.Comp.Client, Unit5, Unit6, Unit7, Unit8;



function TfrmMain.RemoveDiacritics(const Input: string): string;
var
  i: Integer;
  Temp: string;
begin
  Temp := Input;
  for i := 1 to Length(Temp) do
  begin
    case Temp[i] of
      'á', 'à', 'ả', 'ã', 'ạ': Temp[i] := 'a';
      'Á', 'À', 'Ả', 'Ã', 'Ạ': Temp[i] := 'A';
      'é', 'è', 'ẻ', 'ẽ', 'ẹ': Temp[i] := 'e';
      'É', 'È', 'Ẻ', 'Ẽ', 'Ẹ': Temp[i] := 'E';
      'í', 'ì', 'ỉ', 'ĩ', 'ị': Temp[i] := 'i';
      'Í', 'Ì', 'Ỉ', 'Ĩ', 'Ị': Temp[i] := 'I';
      'ó', 'ò', 'ỏ', 'õ', 'ọ': Temp[i] := 'o';
      'Ó', 'Ò', 'Ỏ', 'Õ', 'Ọ': Temp[i] := 'O';
      'ú', 'ù', 'ủ', 'ũ', 'ụ': Temp[i] := 'u';
      'Ú', 'Ù', 'Ủ', 'Ũ', 'Ụ': Temp[i] := 'U';
      'ý', 'ỳ', 'ỷ', 'ỹ', 'ỵ': Temp[i] := 'y';
      'Ý', 'Ỳ', 'Ỷ', 'Ỹ', 'Ỵ': Temp[i] := 'Y';
      'đ': Temp[i] := 'd';
      'Đ': Temp[i] := 'D';
    end;
  end;
  Result := Temp;
end;

procedure TfrmMain.CapNhatTrangThaiQuaHan;
var
  Query: TFDQuery;
begin
  if not DM_DuLieu.FDConnection.Connected then
    raise Exception.Create('Kết nối cơ sở dữ liệu không hoạt động.');

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM_DuLieu.FDConnection;
    DM_DuLieu.FDConnection.StartTransaction;
    try
      Query.SQL.Text := 'EXEC [dbo].[sp_XuLyQuaHanMuonTraTaiLieu]';
      Query.ExecSQL;

      Query.SQL.Text := 'EXEC [dbo].[sp_TinhTienPhatQuaHanTaiLieu] @SoNgayTre = 1, @TienPhatMoiNgay = 5000';
      Query.ExecSQL;
      DM_DuLieu.FDConnection.Commit;
    except
      on E: Exception do
      begin
        DM_DuLieu.FDConnection.Rollback;
        ShowMessage('Lỗi khi cập nhật trạng thái quá hạn hoặc tính tiền phạt: ' + E.Message);
      end;
    end;
  finally
    Query.Free;
  end;
end;
function TfrmMain.LayTatCaThongBao: TStringList;
var
  Query: TFDQuery;
  ThongBao: string;
  ThongBaoList: TStringList;
begin
  ThongBaoList := TStringList.Create;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM_DuLieu.FDConnection;

    // 1. Truy vấn thông báo từ bảng ThongBao trước (ưu tiên)
    Query.SQL.Text :=
      'SELECT TieuDe, NoiDung, NgayTao ' +
      'FROM ThongBao ' +
      'WHERE MSSV = :MSSV AND NgayTao >= DATEADD(day, -30, GETDATE()) ' +
      'ORDER BY NgayTao DESC';
    Query.Params.ParamByName('MSSV').DataType := ftWideString;
    Query.Params.ParamByName('MSSV').AsString := FMSSV_DangNhap;
    Query.Open;

    // Duyệt qua các thông báo từ bảng ThongBao
    while not Query.EOF do
    begin
      ThongBao := '[' + FormatDateTime('dd/mm/yyyy hh:nn', Query.FieldByName('NgayTao').AsDateTime) + '] ' +
                 Query.FieldByName('TieuDe').AsString + #13#10 +
                 Query.FieldByName('NoiDung').AsString;
      ThongBaoList.Add(ThongBao);
      Query.Next;
    end;

    // 2. Truy vấn thông báo từ v_ChiTietMuonTraTaiLieu (thêm sau)
    Query.Close;
    Query.SQL.Text :=
      'SELECT mt.MaYeuCau, mt.TenTaiLieu, mt.TrangThai, mt.TenTrangThai, mt.NgayDuyet, mt.TienPhat, mt.SoNgayTre ' +
      'FROM v_ChiTietMuonTraTaiLieu mt ' +
      'WHERE mt.MSSV = :MSSV AND mt.TrangThai IN (2, 3, 5, 6, 7, 8, 9) ' +
      'AND mt.NgayDuyet >= DATEADD(day, -30, GETDATE())';
    Query.Params.ParamByName('MSSV').DataType := ftWideString;
    Query.Params.ParamByName('MSSV').AsString := FMSSV_DangNhap;
    Query.Open;

    // Duyệt qua các yêu cầu và tạo thông báo
    while not Query.EOF do
    begin
      ThongBao := '';
      case Query.FieldByName('TrangThai').AsInteger of
        2: // Đã duyệt mượn
          ThongBao := 'Yêu cầu mượn tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đã được duyệt.';
        3: // Đã từ chối mượn
          ThongBao := 'Yêu cầu mượn tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đã bị từ chối.';
        5: // Đã hủy mượn
          ThongBao := 'Yêu cầu mượn tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đã bị hủy.';
        6: // Đã trả tài liệu
          ThongBao := 'Tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đã được ghi nhận trả thành công.';
        7: // Chờ duyệt trả
          ThongBao := 'Yêu cầu trả tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đang chờ duyệt.';
        8: // Quá hạn trả tài liệu
          ThongBao := 'Tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đã quá hạn ' +
                     Query.FieldByName('SoNgayTre').AsString + ' ngày. Tiền phạt: ' +
                     FormatFloat('#,##0', Query.FieldByName('TienPhat').AsFloat) + ' VND.';
        9: // Mất
          ThongBao := 'Tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') được ghi nhận là mất.';
      end;
      if ThongBao <> '' then
        ThongBaoList.Add(ThongBao);
      Query.Next;
    end;

  finally
    Query.Free;
    Result := ThongBaoList;
  end;
end;

procedure TfrmMain.HienThiThongBao;
var
  Query: TFDQuery;
  LastCheck: TDateTime;
  ThongBaoList: TStringList;
  ThongBao: string;
  TatCaThongBao: string;
  SoLuongHienThi: Integer;
  SoLuongConLai: Integer;
  frmThongBao: TfrmThongBao;
begin
  Query := TFDQuery.Create(nil);
  ThongBaoList := TStringList.Create;
  try
    Query.Connection := DM_DuLieu.FDConnection;

    // Lấy thời gian kiểm tra thông báo cuối cùng
    Query.SQL.Text := 'SELECT LastNotificationCheck FROM SinhVien WHERE MSSV = :MSSV';
    Query.Params.ParamByName('MSSV').DataType := ftWideString;
    Query.Params.ParamByName('MSSV').AsString := FMSSV_DangNhap;
    Query.Open;

    if Query.IsEmpty then
    begin
      ShowMessage('Không tìm thấy thông tin sinh viên.');
      Exit;
    end;

    LastCheck := Query.FieldByName('LastNotificationCheck').AsDateTime;
    if LastCheck = 0 then
      LastCheck := EncodeDate(2000, 1, 1); // Giá trị mặc định nếu chưa có

    // 1. Truy vấn thông báo từ bảng ThongBao có NgayTao sau LastCheck
    Query.Close;
    Query.SQL.Text :=
      'SELECT TieuDe, NoiDung, NgayTao ' +
      'FROM ThongBao ' +
      'WHERE MSSV = :MSSV AND NgayTao > :LastCheck ' +
      'ORDER BY NgayTao DESC';
    Query.Params.ParamByName('MSSV').DataType := ftWideString;
    Query.Params.ParamByName('MSSV').AsString := FMSSV_DangNhap;
    Query.Params.ParamByName('LastCheck').DataType := ftDateTime;
    Query.Params.ParamByName('LastCheck').AsDateTime := LastCheck;
    Query.Open;

    // Duyệt qua các thông báo và thêm vào danh sách
    while not Query.EOF do
    begin
      ThongBao := '[' + FormatDateTime('dd/mm/yyyy hh:nn', Query.FieldByName('NgayTao').AsDateTime) + '] ' +
                 Query.FieldByName('TieuDe').AsString + #13#10 +
                 Query.FieldByName('NoiDung').AsString;
      ThongBaoList.Add(ThongBao);
      Query.Next;
    end;

    // 2. Truy vấn các yêu cầu mượn/trả có thay đổi trạng thái sau LastCheck
    Query.Close;
    Query.SQL.Text :=
      'SELECT mt.MaYeuCau, mt.TenTaiLieu, mt.TrangThai, mt.TenTrangThai, mt.NgayDuyet, mt.TienPhat, mt.SoNgayTre ' +
      'FROM v_ChiTietMuonTraTaiLieu mt ' +
      'WHERE mt.MSSV = :MSSV AND (mt.NgayDuyet > :LastCheck OR mt.NgayDuyet IS NULL) ' +
      'AND mt.TrangThai IN (2, 3, 5, 6, 7, 8, 9)';
    Query.Params.ParamByName('MSSV').DataType := ftWideString;
    Query.Params.ParamByName('MSSV').AsString := FMSSV_DangNhap;
    Query.Params.ParamByName('LastCheck').DataType := ftDateTime;
    Query.Params.ParamByName('LastCheck').AsDateTime := LastCheck;
    Query.Open;

    // Duyệt qua các yêu cầu và tạo thông báo
    while not Query.EOF do
    begin
      ThongBao := '';
      case Query.FieldByName('TrangThai').AsInteger of
        2: // Đã duyệt mượn
          ThongBao := 'Yêu cầu mượn tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đã được duyệt.';
        3: // Đã từ chối mượn
          ThongBao := 'Yêu cầu mượn tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đã bị từ chối.';
        5: // Đã hủy mượn
          ThongBao := 'Yêu cầu mượn tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đã bị hủy.';
        6: // Đã trả tài liệu
          ThongBao := 'Tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đã được ghi nhận trả thành công.';
        7: // Chờ duyệt trả
          ThongBao := 'Yêu cầu trả tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đang chờ duyệt.';
        8: // Quá hạn trả tài liệu
          ThongBao := 'Tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') đã quá hạn ' +
                     Query.FieldByName('SoNgayTre').AsString + ' ngày. Tiền phạt: ' +
                     FormatFloat('#,##0', Query.FieldByName('TienPhat').AsFloat) + ' VND.';
        9: // Mất
          ThongBao := 'Tài liệu "' + Query.FieldByName('TenTaiLieu').AsString +
                     '" (Mã yêu cầu: ' + Query.FieldByName('MaYeuCau').AsString + ') được ghi nhận là mất.';
      end;
      if ThongBao <> '' then
        ThongBaoList.Add(ThongBao);
      Query.Next;
    end;

    // Gộp và hiển thị thông báo
    if ThongBaoList.Count > 0 then
    begin
      SoLuongHienThi := Min(50, ThongBaoList.Count); // Hiển thị tối đa 50 thông báo
      TatCaThongBao := 'Bạn có ' + IntToStr(ThongBaoList.Count) + ' thông báo mới:' + #13#10 + #13#10;
      TatCaThongBao := TatCaThongBao + ThongBaoList.Text;

      // Lưu thông báo mới vào biến toàn cục
      FThongBaoDaHienThi.Clear;
      FThongBaoDaHienThi.Assign(ThongBaoList);

      // Nếu có nhiều hơn 50 thông báo, thêm thông báo tràn
      if ThongBaoList.Count > 50 then
      begin
        SoLuongConLai := ThongBaoList.Count - 50;
        TatCaThongBao := TatCaThongBao + #13#10 + '...và ' + IntToStr(SoLuongConLai) + ' thông báo khác.';
      end;

      frmThongBao := TfrmThongBao.Create(Self);
      try
        frmThongBao.MSSV := FMSSV_DangNhap;
        frmThongBao.memoThongBao.Text := Copy(TatCaThongBao, 1, Length(TatCaThongBao));
        frmThongBao.ShowModal;
      finally
        frmThongBao.Free;
      end;
    end;
  finally
    Query.Free;
    ThongBaoList.Free;
  end;
end;

procedure TfrmMain.HienThiDuLieuTraCuu;
var
  STT: Integer;
  ListItem: TListItem;
  TaiLieuID: Int64;
begin
  lstvTraCuu_DanhSachTaiLieu.Items.Clear;
  if DM_DuLieu.FDQuery_TaiLieuTongHop.Active then
  begin
    DM_DuLieu.FDQuery_TaiLieuTongHop.First;
    STT := 1;
    while not DM_DuLieu.FDQuery_TaiLieuTongHop.EOF do
    begin
      ListItem := lstvTraCuu_DanhSachTaiLieu.Items.Add;
      ListItem.Caption := IntToStr(STT);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('MaTaiLieu').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('TenTaiLieu').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('TenTacGia').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('NhaXB').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('NamXB').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('TenLoaiTL').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('Khoa').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('Nganh').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('MoTa').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('SoLuong').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('SoLuongCon').AsString);
      TaiLieuID := DM_DuLieu.FDQuery_TaiLieuTongHop.FieldByName('ID').AsLargeInt;
      ListItem.Data := Pointer(TaiLieuID);
      Inc(STT);
      DM_DuLieu.FDQuery_TaiLieuTongHop.Next;
    end;
  end;
end;

procedure TfrmMain.lstvDangMuon_DanhSachCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Item.Index mod 2 = 0 then
    Sender.Canvas.Brush.Color := clWhite
  else
    Sender.Canvas.Brush.Color := $00F5F5F5;
  DefaultDraw := True;
end;

procedure TfrmMain.lstvQuaHan_DanhSachCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Item.Index mod 2 = 0 then
    Sender.Canvas.Brush.Color := clWhite
  else
    Sender.Canvas.Brush.Color := $00F5F5F5;
  DefaultDraw := True;
end;

procedure TfrmMain.lstvTraCuu_DanhSachTaiLieuCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  SoLuongCon: Integer;
begin
  if Item.Index mod 2 = 0 then
    Sender.Canvas.Brush.Color := clWhite
  else
    Sender.Canvas.Brush.Color := $00F5F5F5;

  SoLuongCon := StrToIntDef(Item.SubItems[10], -1);
  if SoLuongCon = 0 then
    Sender.Canvas.Font.Color := clRed // Đổi màu chữ thành đỏ nếu hết tài liệu
  else
    Sender.Canvas.Font.Color := clBlack;

  DefaultDraw := True;
end;

procedure TfrmMain.lstvTra_LichSuMuonTraCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Item.Index mod 2 = 0 then
    Sender.Canvas.Brush.Color := clWhite
  else
    Sender.Canvas.Brush.Color := $00F5F5F5;
  DefaultDraw := True;
end;

procedure TfrmMain.HienThiDuLieuLichSu;
var
  STT: Integer;
  ListItem: TListItem;
begin
  lstvTra_LichSuMuonTra.Items.Clear;
  if DM_DuLieu.FDQuery_LichSuMuonTra.Active then
  begin
    DM_DuLieu.FDQuery_LichSuMuonTra.First;
    STT := 1;
    while not DM_DuLieu.FDQuery_LichSuMuonTra.EOF do
    begin
      ListItem := lstvTra_LichSuMuonTra.Items.Add;
      ListItem.Caption := IntToStr(STT);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_LichSuMuonTra.FieldByName('MaYeuCau').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_LichSuMuonTra.FieldByName('MaTaiLieu').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_LichSuMuonTra.FieldByName('TenTaiLieu').AsString);
      ListItem.SubItems.Add(FormatDateTime('dd/mm/yyyy hh:nn', DM_DuLieu.FDQuery_LichSuMuonTra.FieldByName('NgayYeuCau').AsDateTime));
      ListItem.SubItems.Add(FormatDateTime('dd/mm/yyyy', DM_DuLieu.FDQuery_LichSuMuonTra.FieldByName('NgayHenMuon').AsDateTime));
      ListItem.SubItems.Add(FormatDateTime('dd/mm/yyyy', DM_DuLieu.FDQuery_LichSuMuonTra.FieldByName('NgayHenTra').AsDateTime));
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_LichSuMuonTra.FieldByName('TenTrangThai').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_LichSuMuonTra.FieldByName('LyDo').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_LichSuMuonTra.FieldByName('GhiChu').AsString);
      Inc(STT);
      DM_DuLieu.FDQuery_LichSuMuonTra.Next;
    end;
  end;
end;

procedure TfrmMain.HienThiDuLieuDangMuon;
var
  STT: Integer;
  ListItem: TListItem;
  MuonTraID: Int64;
begin
  lstvDangMuon_DanhSach.Items.Clear;
  if DM_DuLieu.FDQuery_DangMuon.Active then
  begin
    DM_DuLieu.FDQuery_DangMuon.First;
    STT := 1;
    while not DM_DuLieu.FDQuery_DangMuon.EOF do
    begin
      ListItem := lstvDangMuon_DanhSach.Items.Add;
      ListItem.Caption := IntToStr(STT);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_DangMuon.FieldByName('MaYeuCau').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_DangMuon.FieldByName('MaTaiLieu').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_DangMuon.FieldByName('TenTaiLieu').AsString);
      ListItem.SubItems.Add(FormatDateTime('dd/mm/yyyy', DM_DuLieu.FDQuery_DangMuon.FieldByName('NgayHenMuon').AsDateTime));
      ListItem.SubItems.Add(FormatDateTime('dd/mm/yyyy', DM_DuLieu.FDQuery_DangMuon.FieldByName('NgayHenTra').AsDateTime));
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_DangMuon.FieldByName('GhiChu').AsString);
      MuonTraID := DM_DuLieu.FDQuery_DangMuon.FieldByName('ID').AsLargeInt;
      ListItem.Data := Pointer(MuonTraID);
      Inc(STT);
      DM_DuLieu.FDQuery_DangMuon.Next;
    end;
  end;
end;

procedure TfrmMain.HienThiDuLieuQuaHan;
var
  STT: Integer;
  ListItem: TListItem;
  MuonTraID: Int64;
begin
  lstvQuaHan_DanhSach.Items.Clear;
  try
    CapNhatTrangThaiQuaHan;
    DM_DuLieu.FDQuery_QuaHan.Close;
    DM_DuLieu.FDQuery_QuaHan.ParamByName('MSSV_Login').AsString := FMSSV_DangNhap;
    DM_DuLieu.FDQuery_QuaHan.Open;

    if DM_DuLieu.FDQuery_QuaHan.IsEmpty then
    begin
      ShowMessage('Không có tài liệu quá hạn nào được tìm thấy.');
      Exit;
    end;

    DM_DuLieu.FDQuery_QuaHan.First;
    STT := 1;
    while not DM_DuLieu.FDQuery_QuaHan.EOF do
    begin
      ListItem := lstvQuaHan_DanhSach.Items.Add;
      ListItem.Caption := IntToStr(STT);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_QuaHan.FieldByName('MaYeuCau').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_QuaHan.FieldByName('MaTaiLieu').AsString);
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_QuaHan.FieldByName('TenTaiLieu').AsString);
      ListItem.SubItems.Add(FormatDateTime('dd/mm/yyyy', DM_DuLieu.FDQuery_QuaHan.FieldByName('NgayHenTra').AsDateTime));
      ListItem.SubItems.Add(DM_DuLieu.FDQuery_QuaHan.FieldByName('SoNgayTre').AsString);
      ListItem.SubItems.Add(FormatFloat('#,##0', DM_DuLieu.FDQuery_QuaHan.FieldByName('TienPhat').AsFloat) + ' VND');
      MuonTraID := DM_DuLieu.FDQuery_QuaHan.FieldByName('ID').AsLargeInt;
      ListItem.Data := Pointer(MuonTraID);
      Inc(STT);
      DM_DuLieu.FDQuery_QuaHan.Next;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Lỗi khi hiển thị danh sách quá hạn: ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.mnuTraCuu_MuonTaiLieuClick(Sender: TObject);
var
  frmNhap: TfrmNhapYeuCauMuon;
  i: Integer;
  SelectedItem: TListItem;
  SelectedTaiLieuID: Int64;
  NgayHenMuonValue, NgayHenTraValue: TDate;
  SuccessCount: Integer;
  ErrorMsg: string;
  SoLuongCon: Integer; // Biến để lưu số lượng còn lại
begin
  if lstvTraCuu_DanhSachTaiLieu.SelCount = 0 then
  begin
    ShowMessage('Vui lòng chọn ít nhất một tài liệu để mượn.');
    Exit;
  end;

  frmNhap := TfrmNhapYeuCauMuon.Create(Self);
  try
    if frmNhap.ShowModal = mrOk then
    begin
      NgayHenMuonValue := frmNhap.dtpNgayHenMuon.Date;
      NgayHenTraValue := frmNhap.dtpNgayHenTra.Date;

      if NgayHenTraValue <= NgayHenMuonValue then
      begin
        ShowMessage('Ngày hẹn trả phải sau ngày hẹn mượn.');
        Exit;
      end;

      SuccessCount := 0;
      ErrorMsg := '';
      DM_DuLieu.FDConnection.StartTransaction;
      try
        for i := 0 to lstvTraCuu_DanhSachTaiLieu.Items.Count - 1 do
        begin
          SelectedItem := lstvTraCuu_DanhSachTaiLieu.Items[i];
          if SelectedItem.Selected then
          begin
            // Lấy số lượng còn lại từ danh sách
            SoLuongCon := StrToIntDef(SelectedItem.SubItems[10], -1); // SubItems[10] là SoLuongCon
            if SoLuongCon = -1 then
            begin
              ErrorMsg := ErrorMsg + 'Không thể xác định số lượng còn lại cho tài liệu "' + SelectedItem.SubItems[1] + '".' + #13#10;
              Continue;
            end;

            // Kiểm tra số lượng còn lại
            if SoLuongCon <= 0 then
            begin
              ErrorMsg := ErrorMsg + 'Tài liệu "' + SelectedItem.SubItems[1] + '" đã hết (số lượng còn lại: 0). Không thể gửi yêu cầu mượn.' + #13#10;
              Continue;
            end;

            // Nếu còn tài liệu, tiến hành gửi yêu cầu mượn
            SelectedTaiLieuID := Int64(SelectedItem.Data);
            try
              DM_DuLieu.FDQuery_InsertYeuCauMuon.ParamByName('MSSV').AsString := FMSSV_DangNhap;
              DM_DuLieu.FDQuery_InsertYeuCauMuon.ParamByName('TaiLieuID').AsLargeInt := SelectedTaiLieuID;
              DM_DuLieu.FDQuery_InsertYeuCauMuon.ParamByName('NgayHenMuon').AsDate := NgayHenMuonValue;
              DM_DuLieu.FDQuery_InsertYeuCauMuon.ParamByName('NgayHenTra').AsDate := NgayHenTraValue;
              DM_DuLieu.FDQuery_InsertYeuCauMuon.ExecSQL;
              Inc(SuccessCount);
            except
              on E: Exception do
              begin
                ErrorMsg := ErrorMsg + 'Lỗi khi yêu cầu mượn tài liệu "' + SelectedItem.SubItems[1] + '": ' + E.Message + #13#10;
              end;
            end;
          end;
        end;

        if SuccessCount > 0 then
        begin
          ShowMessage('Đã gửi ' + IntToStr(SuccessCount) + ' yêu cầu mượn thành công. Vui lòng chờ duyệt.');
          PageControl1.ActivePageIndex := 1;
          cboLichSu_TrangThai.ItemIndex := 1; // Chờ duyệt mượn
          btnLichSu_LocClick(nil);
        end;
        if ErrorMsg <> '' then
          ShowMessage('Kết quả xử lý:' + #13#10 + ErrorMsg);
        DM_DuLieu.FDConnection.Commit;
      except
        on E: Exception do
        begin
          DM_DuLieu.FDConnection.Rollback;
          ShowMessage('Lỗi khi xử lý yêu cầu mượn: ' + E.Message);
        end;
      end;
    end;
  finally
    frmNhap.Free;
  end;
end;

procedure TfrmMain.mnuDangMuon_TraTaiLieuClick(Sender: TObject);
var
  SelectedItem: TListItem;
  SelectedMuonTraID: Int64;
  QueryUpdate: TFDQuery;
begin
  if lstvDangMuon_DanhSach.Selected = nil then Exit;

  SelectedItem := lstvDangMuon_DanhSach.Selected;
  SelectedMuonTraID := Int64(SelectedItem.Data);

  QueryUpdate := TFDQuery.Create(nil);
  try
    QueryUpdate.Connection := DM_DuLieu.FDConnection;
    QueryUpdate.SQL.Text :=
      'UPDATE MuonTraTaiLieu ' +
      'SET TrangThai = 7, ' +
      '    GhiChu = ISNULL(GhiChu + CHAR(13) + CHAR(10), '''') + N''Yêu cầu trả tài liệu vào '' + CONVERT(NVARCHAR, GETDATE(), 103) ' +
      'WHERE ID = :ID AND TrangThai = 4';
    QueryUpdate.Params.CreateParam(ftLargeInt, 'ID', ptInput);
    QueryUpdate.ParamByName('ID').AsLargeInt := SelectedMuonTraID;
    QueryUpdate.ExecSQL;

    ShowMessage('Đã gửi yêu cầu trả tài liệu thành công. Vui lòng chờ duyệt.');
    HienThiDuLieuDangMuon;
    PageControl1.ActivePageIndex := 1;
    cboLichSu_TrangThai.ItemIndex := 7; // Chờ duyệt trả
    btnLichSu_LocClick(nil);
  finally
    QueryUpdate.Free;
  end;
end;

procedure TfrmMain.mnuDangMuon_GiaHanTaiLieuClick(Sender: TObject);
var
  frmGiaHan: TfrmNhapGiaHan;
  SelectedItem: TListItem;
  SelectedMuonTraID: Int64;
  NgayHenTraHienTaiValue, NgayHenTraMoiValue: TDate;
  QueryKiemTra: TFDQuery;
  SoLanGiaHan: Integer;
begin
  if lstvDangMuon_DanhSach.Selected = nil then Exit;

  SelectedItem := lstvDangMuon_DanhSach.Selected;
  SelectedMuonTraID := Int64(SelectedItem.Data);

  QueryKiemTra := TFDQuery.Create(nil);
  try
    QueryKiemTra.Connection := DM_DuLieu.FDConnection;
    QueryKiemTra.SQL.Text := 'SELECT SoLanGiaHan FROM MuonTraTaiLieu WHERE ID = :ID';
    QueryKiemTra.Params.CreateParam(ftLargeInt, 'ID', ptInput);
    QueryKiemTra.ParamByName('ID').AsLargeInt := SelectedMuonTraID;
    QueryKiemTra.Open;

    if QueryKiemTra.IsEmpty then
    begin
      ShowMessage('Không tìm thấy thông tin yêu cầu mượn.');
      Exit;
    end;

    SoLanGiaHan := QueryKiemTra.FieldByName('SoLanGiaHan').AsInteger;
    if SoLanGiaHan >= 1 then
    begin
      ShowMessage('Tài liệu này đã được gia hạn 1 lần. Bạn không thể gia hạn thêm.');
      Exit;
    end;
  finally
    QueryKiemTra.Free;
  end;

  try
    NgayHenTraHienTaiValue := StrToDateDef(SelectedItem.SubItems[4], 0);
    if NgayHenTraHienTaiValue = 0 then raise Exception.Create('Không thể lấy ngày hẹn trả hiện tại.');
  except
    on E: Exception do
    begin
      ShowMessage('Lỗi lấy thông tin ngày hẹn trả: ' + E.Message);
      Exit;
    end;
  end;

  frmGiaHan := TfrmNhapGiaHan.Create(Self);
  try
    frmGiaHan.NgayHenTraHienTai := NgayHenTraHienTaiValue;
    if frmGiaHan.ShowModal = mrOk then
    begin
      NgayHenTraMoiValue := frmGiaHan.dtpNgayHenTraMoi.Date;

      if NgayHenTraMoiValue <= NgayHenTraHienTaiValue then
      begin
        ShowMessage('Ngày hẹn trả mới phải sau ngày hẹn trả hiện tại.');
        Exit;
      end;
      if (NgayHenTraMoiValue - NgayHenTraHienTaiValue) > 7 then
      begin
        ShowMessage('Thời gian gia hạn không được vượt quá 7 ngày.');
        Exit;
      end;

      if MessageDlg('Bạn có chắc chắn muốn gia hạn đến ngày ' + FormatDateTime('dd/mm/yyyy', NgayHenTraMoiValue) + '?',
                     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        try
          DM_DuLieu.FDQuery_UpdateGiaHan.ParamByName('NgayHenTraMoi').AsDate := NgayHenTraMoiValue;
          DM_DuLieu.FDQuery_UpdateGiaHan.ParamByName('ID').AsLargeInt := SelectedMuonTraID;
          DM_DuLieu.FDQuery_UpdateGiaHan.ExecSQL;

          DM_DuLieu.FDConnection.Commit;
          ShowMessage('Gia hạn tài liệu thành công.');
          HienThiDuLieuDangMuon;
        except
          on E: Exception do
          begin
            ShowMessage('Lỗi khi gia hạn tài liệu: ' + E.Message);
          end;
        end;
      end;
    end;
  finally
    frmGiaHan.Free;
  end;
end;

procedure TfrmMain.btnThanhToan_QuaHanClick(Sender: TObject);
var
  SelectedItem: TListItem;
  SelectedMuonTraID: Int64;
  TienPhat: Double;
  QueryUpdate: TFDQuery;
begin
  if lstvQuaHan_DanhSach.Selected = nil then
  begin
    ShowMessage('Vui lòng chọn một tài liệu quá hạn để thanh toán.');
    Exit;
  end;

  SelectedItem := lstvQuaHan_DanhSach.Selected;
  SelectedMuonTraID := Int64(SelectedItem.Data);
  TienPhat := StrToFloatDef(StringReplace(SelectedItem.SubItems[5], ' VND', '', [rfReplaceAll]), 0);

  if TienPhat <= 0 then
  begin
    ShowMessage('Không có phí quá hạn để thanh toán.');
    Exit;
  end;

  if MessageDlg('Bạn có chắc chắn muốn thanh toán phí quá hạn ' + FormatFloat('#,##0', TienPhat) + ' VND cho yêu cầu này?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    QueryUpdate := TFDQuery.Create(nil);
    try
      QueryUpdate.Connection := DM_DuLieu.FDConnection;
      QueryUpdate.SQL.Text :=
        'UPDATE MuonTraTaiLieu ' +
        'SET TienPhat = 0, ' +
        '    GhiChu = ISNULL(GhiChu + CHAR(13) + CHAR(10), '''') + N''Đã thanh toán phí quá hạn ' + FormatFloat('#,##0', TienPhat) + 'đ vào '' + CONVERT(NVARCHAR, GETDATE(), 103) ' +
        'WHERE ID = :ID';
      QueryUpdate.Params.CreateParam(ftLargeInt, 'ID', ptInput);
      QueryUpdate.ParamByName('ID').AsLargeInt := SelectedMuonTraID;
      QueryUpdate.ExecSQL;

      ShowMessage('Thanh toán phí quá hạn thành công.');
      HienThiDuLieuQuaHan;
    finally
      QueryUpdate.Free;
    end;
  end;
end;

procedure TfrmMain.btnDangXuatClick(Sender: TObject);
begin
  frmLogin.Show;
  Self.Hide;
end;

procedure TfrmMain.btnThoatClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.btnThoatMouseEnter(Sender: TObject);
begin
  btnThoat.Font.Color := $00D5E8FF;
end;

procedure TfrmMain.btnThoatMouseLeave(Sender: TObject);
begin
  btnThoat.Font.Color := clBtnFace;
end;

procedure TfrmMain.btnThongBaoClick(Sender: TObject);
var
  frmThongBao: TfrmThongBao;
  TatCaThongBao: string;
  ThongBaoList: TStringList;
  SoLuongConLai: Integer;
begin
  ThongBaoList := LayTatCaThongBao; // Lấy tất cả thông báo từ cơ sở dữ liệu
  try
    if ThongBaoList.Count = 0 then
    begin
      ShowMessage('Không có thông báo nào để hiển thị.');
      Exit;
    end;

    // Gộp lại tất cả thông báo
    TatCaThongBao := 'Bạn có ' + IntToStr(ThongBaoList.Count) + ' thông báo:' + #13#10 + #13#10;
    TatCaThongBao := TatCaThongBao + ThongBaoList.Text;

    // Nếu có nhiều hơn 50 thông báo, thêm thông báo tràn
    if ThongBaoList.Count > 50 then
    begin
      SoLuongConLai := ThongBaoList.Count - 50;
      TatCaThongBao := TatCaThongBao + #13#10 + '...và ' + IntToStr(SoLuongConLai) + ' thông báo khác.';
    end;

    // Hiển thị form thông báo
    frmThongBao := TfrmThongBao.Create(Self);
    try
      frmThongBao.MSSV := FMSSV_DangNhap;
      frmThongBao.memoThongBao.Text := Copy(TatCaThongBao, 1, Length(TatCaThongBao));
      frmThongBao.ShowModal;
    finally
      frmThongBao.Free;
    end;
  finally
    ThongBaoList.Free;
  end;
end;

procedure TfrmMain.btnTraCuu_TimKiemClick(Sender: TObject);
var
  SQL: string;
  TenTaiLieu, TenTacGia, NhaXB, MoTa: string;
  HasCondition: Boolean;
  ChiTiet: string;
begin
  // Lấy giá trị từ các ô nhập liệu
  TenTaiLieu := Trim(edtTraCuu_TenTaiLieu.Text);
  TenTacGia := Trim(edtTraCuu_TenTacGia.Text);
  NhaXB := Trim(edtTraCuu_NhaXB.Text);
  MoTa := Trim(edtTraCuu_MoTa.Text);

  // Chuẩn hóa từ khóa (bỏ dấu)
  if TenTaiLieu <> '' then TenTaiLieu := RemoveDiacritics(TenTaiLieu);
  if TenTacGia <> '' then TenTacGia := RemoveDiacritics(TenTacGia);
  if NhaXB <> '' then NhaXB := RemoveDiacritics(NhaXB);
  if MoTa <> '' then MoTa := RemoveDiacritics(MoTa);

  // Xây dựng truy vấn cơ bản
  SQL := 'SELECT TOP 100 ID, MaTaiLieu, TenTaiLieu, TenTacGia, NhaXB, NamXB, TenLoaiTL, Khoa, Nganh, MoTa, SoLuong, SoLuongCon ' +
         'FROM TaiLieuTongHop';
  HasCondition := False;

  // Thêm điều kiện tìm kiếm
  if TenTaiLieu <> '' then
  begin
    SQL := SQL + ' WHERE dbo.RemoveDiacritics(TenTaiLieu) LIKE :TenTaiLieu';
    HasCondition := True;
  end;
  if TenTacGia <> '' then
  begin
    if HasCondition then
      SQL := SQL + ' AND '
    else
      SQL := SQL + ' WHERE ';
    SQL := SQL + 'dbo.RemoveDiacritics(TenTacGia) LIKE :TenTacGia';
    HasCondition := True;
  end;
  if NhaXB <> '' then
  begin
    if HasCondition then
      SQL := SQL + ' AND '
    else
      SQL := SQL + ' WHERE ';
    SQL := SQL + 'dbo.RemoveDiacritics(NhaXB) LIKE :NhaXB';
    HasCondition := True;
  end;
  if MoTa <> '' then
  begin
    if HasCondition then
      SQL := SQL + ' AND '
    else
      SQL := SQL + ' WHERE ';
    SQL := SQL + 'dbo.RemoveDiacritics(MoTa) LIKE :MoTa';
    HasCondition := True;
  end;

  // Sắp xếp kết quả
  SQL := SQL + ' ORDER BY TenTaiLieu';

  // Thiết lập truy vấn
  try
    DM_DuLieu.FDQuery_TaiLieuTongHop.Close;
    DM_DuLieu.FDQuery_TaiLieuTongHop.SQL.Text := SQL;
    DM_DuLieu.FDQuery_TaiLieuTongHop.Params.Clear;

    // Gán tham số
    if TenTaiLieu <> '' then
    begin
      DM_DuLieu.FDQuery_TaiLieuTongHop.Params.CreateParam(ftString, 'TenTaiLieu', ptInput);
      DM_DuLieu.FDQuery_TaiLieuTongHop.ParamByName('TenTaiLieu').AsString := '%' + TenTaiLieu + '%';
    end;
    if TenTacGia <> '' then
    begin
      DM_DuLieu.FDQuery_TaiLieuTongHop.Params.CreateParam(ftString, 'TenTacGia', ptInput);
      DM_DuLieu.FDQuery_TaiLieuTongHop.ParamByName('TenTacGia').AsString := '%' + TenTacGia + '%';
    end;
    if NhaXB <> '' then
    begin
      DM_DuLieu.FDQuery_TaiLieuTongHop.Params.CreateParam(ftString, 'NhaXB', ptInput);
      DM_DuLieu.FDQuery_TaiLieuTongHop.ParamByName('NhaXB').AsString := '%' + NhaXB + '%';
    end;
    if MoTa <> '' then
    begin
      DM_DuLieu.FDQuery_TaiLieuTongHop.Params.CreateParam(ftString, 'MoTa', ptInput);
      DM_DuLieu.FDQuery_TaiLieuTongHop.ParamByName('MoTa').AsString := '%' + MoTa + '%';
    end;

    // Thực thi truy vấn
    DM_DuLieu.FDQuery_TaiLieuTongHop.Open;
    HienThiDuLieuTraCuu;


  except
    on E: Exception do
    begin
      ShowMessage('Lỗi khi tìm kiếm: ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.btnTraCuu_TimKiemMouseEnter(Sender: TObject);
begin
  btnTraCuu_TimKiem.Font.Color := $00D5E8FF;
end;

procedure TfrmMain.btnTraCuu_TimKiemMouseLeave(Sender: TObject);
begin
  btnTraCuu_TimKiem.Font.Color := clBtnFace;
end;

procedure TfrmMain.btnDangXuatMouseEnter(Sender: TObject);
begin
  btnDangXuat.Font.Color := $00D5E8FF;
end;

procedure TfrmMain.btnDangXuatMouseLeave(Sender: TObject);
begin
  btnDangXuat.Font.Color := clBtnFace;
end;

procedure TfrmMain.btnDoiMatKhau_HeaderClick(Sender: TObject);
var
  frmDoiMatKhau: TfrmDoiMatKhauMoi;
begin
  frmDoiMatKhau := TfrmDoiMatKhauMoi.Create(Self);
  try
    frmDoiMatKhau.MSSV := FMSSV_DangNhap;
    if frmDoiMatKhau.ShowModal = mrOk then
    begin
      // Không cần làm gì thêm vì thông báo đã được hiển thị trong frmDoiMatKhau
    end;
  finally
    frmDoiMatKhau.Free;
  end;
end;

procedure TfrmMain.btnDoiMatKhau_HeaderMouseEnter(Sender: TObject);
begin
  btnDoiMatKhau_Header.Font.Color := $00D5E8FF;
end;

procedure TfrmMain.btnDoiMatKhau_HeaderMouseLeave(Sender: TObject);
begin
  btnDoiMatKhau_Header.Font.Color := clBtnFace;
end;

procedure TfrmMain.btnLichSu_LocClick(Sender: TObject);
var
  SQL: string;
  SelectedTrangThaiIndex: Integer;
  TrangThaiFilter: Integer;
begin
  SQL :=
    'SELECT mt.ID, mt.MaYeuCau, mt.MSSV, sv.HoLot + '' '' + sv.Ten AS TenSinhVien, ' +
    'mt.TaiLieuID, tl.MaTaiLieu, tl.TenTaiLieu, mt.NgayYeuCau, mt.NgayHenMuon, mt.NgayHenTra, ' +
    'mt.TrangThai, mt.TenTrangThai, mt.LyDo, mt.GhiChu, mt.ThuThuID, tt.HoTen AS TenThuThu, mt.NgayDuyet ' +
    'FROM MuonTraTaiLieu mt ' +
    'JOIN SinhVien sv ON mt.MSSV = sv.MSSV ' +
    'JOIN TaiLieuTongHop tl ON mt.TaiLieuID = tl.ID ' +
    'LEFT JOIN ThuThu tt ON mt.ThuThuID = tt.ID ' +
    'WHERE mt.MSSV = :MSSV_Login';

  SelectedTrangThaiIndex := cboLichSu_TrangThai.ItemIndex;

  TrangThaiFilter := -99;
  case SelectedTrangThaiIndex of
    1: TrangThaiFilter := 1; // Chờ duyệt mượn
    2: TrangThaiFilter := 2; // Đã duyệt mượn
    3: TrangThaiFilter := 3; // Đã từ chối mượn
    4: TrangThaiFilter := 4; // Đã mượn tài liệu
    5: TrangThaiFilter := 5; // Đã hủy mượn
    6: TrangThaiFilter := 6; // Đã trả tài liệu
    7: TrangThaiFilter := 7; // Chờ duyệt trả
    8: TrangThaiFilter := 8; // Quá hạn trả tài liệu
    9: TrangThaiFilter := 9; // Mất
  end;

  if TrangThaiFilter <> -99 then
  begin
    SQL := SQL + ' AND mt.TrangThai = :TrangThai';
  end;

  SQL := SQL + ' ORDER BY mt.NgayYeuCau DESC';

  DM_DuLieu.FDQuery_LichSuMuonTra.Close;
  DM_DuLieu.FDQuery_LichSuMuonTra.SQL.Text := SQL;
  DM_DuLieu.FDQuery_LichSuMuonTra.Params.Clear;

  DM_DuLieu.FDQuery_LichSuMuonTra.Params.CreateParam(ftString, 'MSSV_Login', ptInput);
  DM_DuLieu.FDQuery_LichSuMuonTra.ParamByName('MSSV_Login').AsString := FMSSV_DangNhap;

  if TrangThaiFilter <> -99 then
  begin
    DM_DuLieu.FDQuery_LichSuMuonTra.Params.CreateParam(ftInteger, 'TrangThai', ptInput);
    DM_DuLieu.FDQuery_LichSuMuonTra.ParamByName('TrangThai').AsInteger := TrangThaiFilter;
  end;

  DM_DuLieu.FDQuery_LichSuMuonTra.Open;
  HienThiDuLieuLichSu;
end;

procedure TfrmMain.btnLichSu_LocMouseEnter(Sender: TObject);
begin
  btnLichSu_Loc.Font.Color := $00D5E8FF;
end;

procedure TfrmMain.btnLichSu_LocMouseLeave(Sender: TObject);
begin
  btnLichSu_Loc.Font.Color := clBtnFace;
end;

procedure TfrmMain.btnMuon_TimKiemMouseEnter(Sender: TObject);
begin
  btnMuon_TimKiem.Font.Color := $00D5E8FF;
end;

procedure TfrmMain.btnMuon_TimKiemMouseLeave(Sender: TObject);
begin
  btnMuon_TimKiem.Font.Color := clBtnFace;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  lblHoTen.Caption := 'Chào mừng, ' + HoTenNguoiDung;
  CapNhatTrangThaiQuaHan;
  HienThiThongBao; // Gọi thủ tục hiển thị thông báo

  DM_DuLieu.FDQuery_TaiLieuTongHop.Close;
  if not DM_DuLieu.FDQuery_TaiLieuTongHop.Active then
  begin
    DM_DuLieu.FDQuery_TaiLieuTongHop.Open;
  end
  else
  begin
    DM_DuLieu.FDQuery_TaiLieuTongHop.Close;
    DM_DuLieu.FDQuery_TaiLieuTongHop.Open;
  end;

  HienThiDuLieuTraCuu;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FThongBaoDaHienThi := TStringList.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
    FThongBaoDaHienThi.Free;
end;

procedure TfrmMain.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 0 then
  begin
    DM_DuLieu.FDQuery_TaiLieuTongHop.Close;
    DM_DuLieu.FDQuery_TaiLieuTongHop.SQL.Text :=
      'SELECT TOP 100 ID, MaTaiLieu, TenTaiLieu, TenTacGia, NhaXB, NamXB, TenLoaiTL, Khoa, Nganh, MoTa, SoLuong, SoLuongCon ' +
      'FROM TaiLieuTongHop ' +
      'ORDER BY NEWID()';
    DM_DuLieu.FDQuery_TaiLieuTongHop.Params.Clear;

    if not DM_DuLieu.FDQuery_TaiLieuTongHop.Active then
    begin
      DM_DuLieu.FDQuery_TaiLieuTongHop.Open;
    end
    else
    begin
      DM_DuLieu.FDQuery_TaiLieuTongHop.Close;
      DM_DuLieu.FDQuery_TaiLieuTongHop.Open;
    end;

    HienThiDuLieuTraCuu;
  end
  else if PageControl1.ActivePageIndex = 1 then
  begin
    btnLichSu_LocClick(nil);
  end
  else if PageControl1.ActivePageIndex = 2 then
  begin
    DM_DuLieu.FDQuery_DangMuon.Close;
    DM_DuLieu.FDQuery_DangMuon.ParamByName('MSSV_Login').AsString := FMSSV_DangNhap;
    DM_DuLieu.FDQuery_DangMuon.Open;
    HienThiDuLieuDangMuon;
  end
  else if PageControl1.ActivePageIndex = 3 then
  begin
    DM_DuLieu.FDQuery_QuaHan.Close;
    DM_DuLieu.FDQuery_QuaHan.ParamByName('MSSV_Login').AsString := FMSSV_DangNhap;
    DM_DuLieu.FDQuery_QuaHan.Open;
    HienThiDuLieuQuaHan;
  end;
end;

procedure TfrmMain.PopupMenu1Popup(Sender: TObject);
var
  i: Integer;
  SelectedItem: TListItem;
  SoLuongCon: Integer;
  CanBorrow: Boolean;
begin
  CanBorrow := False;
  if lstvTraCuu_DanhSachTaiLieu.SelCount > 0 then
  begin
    for i := 0 to lstvTraCuu_DanhSachTaiLieu.Items.Count - 1 do
    begin
      SelectedItem := lstvTraCuu_DanhSachTaiLieu.Items[i];
      if SelectedItem.Selected then
      begin
        SoLuongCon := StrToIntDef(SelectedItem.SubItems[10], -1);
        if SoLuongCon > 0 then
        begin
          CanBorrow := True;
          Break;
        end;
      end;
    end;
  end;
  mnuTraCuu_MuonTaiLieu.Enabled := (lstvTraCuu_DanhSachTaiLieu.SelCount > 0) and CanBorrow;
end;

procedure TfrmMain.PopupMenu2Popup(Sender: TObject);
begin
  mnuDangMuon_TraTaiLieu.Enabled := (lstvDangMuon_DanhSach.SelCount = 1);
  mnuDangMuon_GiaHanTaiLieu.Enabled := (lstvDangMuon_DanhSach.SelCount = 1);
end;

procedure TfrmMain.StartFadeOut;
begin
  FadeStep := 255;
  FadeDirection := -1;
  Timer1.Enabled := True;
end;

procedure TfrmMain.StartFadeIn;
begin
  FadeStep := 0;
  FadeDirection := 1;
  Timer1.Enabled := True;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
var
  TabSheet: TTabSheet;
begin
  if PageControl1.ActivePage = nil then Exit;

  TabSheet := PageControl1.ActivePage;
  FadeStep := FadeStep + (FadeDirection * 25);

  if FadeStep <= 0 then
  begin
    Timer1.Enabled := False;
    TabSheet.Visible := False;
    StartFadeIn;
  end
  else if FadeStep >= 255 then
  begin
    Timer1.Enabled := False;
    TabSheet.Visible := True;
  end
  else
  begin
    if FadeDirection = -1 then
      TabSheet.Visible := False
    else
      TabSheet.Visible := True;
  end;
end;

end.
