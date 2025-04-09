unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Unit4, Vcl.Menus, Unit1, Vcl.ToolWin,
  Vcl.Tabs, Vcl.DockTabSet;

type
  TfrmMain = class(TForm)
    pnlHeader: TPanel;
    lblHoTen: TLabel;
    btnDangXuat: TButton;
    btnDoiMatKhau_Header: TButton;
    btnThoat: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    pnlTraCuu_TimKiem: TPanel;
    lblTraCuu_NhanTimKiem: TLabel;
    edtTraCuu_TuKhoa: TEdit;
    btnTraCuu_TimKiem: TButton;
    lstvTraCuu_DanhSachTaiLieu: TListView;
    PopupMenu1: TPopupMenu;
    mnuTraCuu_MuonTaiLieu: TMenuItem;
    pnlMuon_TimKiem: TPanel;
    lblMuon_NhanTimKiem: TLabel;
    edtMuon_TuKhoa: TEdit;
    btnMuon_TimKiem: TButton;
    PopupMenu2: TPopupMenu;
    mnuDangMuon_TraTaiLieu: TMenuItem;
    mnuDangMuon_GiaHanTaiLieu: TMenuItem;
    lstvTra_LichSuMuonTra: TListView;
    pnlThanhToan_Button: TPanel;
    btnThanhToan_QuaHan: TButton;
    lstvQuaHan_DanhSach: TListView;
    pnlLichSu_BoLoc: TPanel;
    lblLichSu_NhanTrangThai: TLabel;
    cboLichSu_TrangThai: TComboBox;
    btnLichSu_Loc: TButton;
    lstvDangMuon_DanhSach: TListView;
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
  private
    FHoTenNguoiDung: string;
    FMSSV_DangNhap: string;
    procedure HienThiDuLieuTraCuu;
    procedure HienThiDuLieuLichSu;
    procedure HienThiDuLieuDangMuon;
    procedure HienThiDuLieuQuaHan;
    procedure CapNhatTrangThaiQuaHan;
  public
    property HoTenNguoiDung: string read FHoTenNguoiDung write FHoTenNguoiDung;
    property MSSV_DangNhap: string read FMSSV_DangNhap write FMSSV_DangNhap;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  FireDAC.Comp.Client, Unit5, Unit6;
procedure TfrmMain.CapNhatTrangThaiQuaHan;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM_DuLieu.FDConnection;

    try
      Query.SQL.Text := 'EXEC [dbo].[sp_XuLyQuaHanMuonTraTaiLieu]';
      Query.ExecSQL;

      Query.SQL.Text := 'EXEC [dbo].[sp_TinhTienPhatQuaHanTaiLieu] @SoNgayTre = 1, @TienPhatMoiNgay = 5000';
      Query.ExecSQL;
    except
      on E: Exception do
      begin
        ShowMessage('Lỗi khi cập nhật trạng thái quá hạn hoặc tính tiền phạt: ' + E.Message);
      end;
    end;

  finally
    Query.Free;
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
  CapNhatTrangThaiQuaHan;
  DM_DuLieu.FDQuery_QuaHan.Close;
  DM_DuLieu.FDQuery_QuaHan.ParamByName('MSSV_Login').AsString := FMSSV_DangNhap;
  try
    DM_DuLieu.FDQuery_QuaHan.Open;
  except
    on E: Exception do
    begin
      ShowMessage('Lỗi khi truy vấn danh sách quá hạn: ' + E.Message);
      Exit;
    end;
  end;

  // Kiểm tra xem truy vấn có trả về dữ liệu không
  if DM_DuLieu.FDQuery_QuaHan.IsEmpty then
  begin
    ShowMessage('Không có tài liệu quá hạn nào được tìm thấy. Kiểm tra trạng thái và tiền phạt trong cơ sở dữ liệu.');
    Exit;
  end;

  if DM_DuLieu.FDQuery_QuaHan.Active then
  begin
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

      for i := 0 to lstvTraCuu_DanhSachTaiLieu.Items.Count - 1 do
      begin
        SelectedItem := lstvTraCuu_DanhSachTaiLieu.Items[i];
        if SelectedItem.Selected then
        begin
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
              ErrorMsg := ErrorMsg + 'Lỗi khi yêu cầu mượn tài liệu ID ' + IntToStr(SelectedTaiLieuID) + ': ' + E.Message + #13#10;
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
      begin
        ShowMessage('Có lỗi xảy ra:' + #13#10 + ErrorMsg);
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
      'SET TrangThai = 7, ' + // Chờ duyệt trả
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

procedure TfrmMain.btnTraCuu_TimKiemClick(Sender: TObject);
var
  TuKhoa: string;
  SQL: string;
begin
  TuKhoa := Trim(edtTraCuu_TuKhoa.Text);

  SQL := 'SELECT TOP 100 ID, MaTaiLieu, TenTaiLieu, TenTacGia, NhaXB, NamXB, TenLoaiTL, Khoa, Nganh, MoTa, SoLuong, SoLuongCon, NgayCapNhat ' +
         'FROM TaiLieuTongHop';
  if TuKhoa <> '' then
  begin
    SQL := SQL + ' WHERE TenTaiLieu LIKE :TuKhoa OR MaTaiLieu LIKE :TuKhoa OR TenTacGia LIKE :TuKhoa OR MoTa LIKE :TuKhoa';
  end;

  DM_DuLieu.FDQuery_TaiLieuTongHop.Close;
  DM_DuLieu.FDQuery_TaiLieuTongHop.SQL.Text := SQL;
  DM_DuLieu.FDQuery_TaiLieuTongHop.Params.Clear;

  if TuKhoa <> '' then
  begin
    DM_DuLieu.FDQuery_TaiLieuTongHop.Params.CreateParam(ftString, 'TuKhoa', ptInput);
    DM_DuLieu.FDQuery_TaiLieuTongHop.ParamByName('TuKhoa').AsString := '%' + TuKhoa + '%';
  end;

  DM_DuLieu.FDQuery_TaiLieuTongHop.Open;
  HienThiDuLieuTraCuu;
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

procedure TfrmMain.FormActivate(Sender: TObject);

begin
  lblHoTen.Caption := 'Chào mừng, ' + HoTenNguoiDung;
  CapNhatTrangThaiQuaHan;


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
begin
  mnuTraCuu_MuonTaiLieu.Enabled := lstvTraCuu_DanhSachTaiLieu.SelCount > 0;
end;

procedure TfrmMain.PopupMenu2Popup(Sender: TObject);
begin
  mnuDangMuon_TraTaiLieu.Enabled := (lstvDangMuon_DanhSach.SelCount = 1);
  mnuDangMuon_GiaHanTaiLieu.Enabled := (lstvDangMuon_DanhSach.SelCount = 1);
end;

end.
