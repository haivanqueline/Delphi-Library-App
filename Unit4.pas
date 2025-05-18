unit Unit4;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.ODBC, FireDAC.Phys.ODBCDef;

type
  TDM_DuLieu = class(TDataModule)
    FDConnection: TFDConnection;
    FDQuery_TaiLieuTongHop: TFDQuery;
    DataSource_TaiLieuTongHop: TDataSource;
    FDQuery_InsertYeuCauMuon: TFDQuery;
    DataSource_LichSuMuonTra: TDataSource;
    FDQuery_HuyYeuCauQuaHan: TFDQuery;
    FDQuery_DangMuon: TFDQuery;
    FDQuery_InsertYeuCauTra: TFDQuery;
    FDQuery_UpdateGiaHan: TFDQuery;
    FDQuery_UpdateYeuCauMuonTra: TFDQuery;
    FDQuery_QuaHan: TFDQuery;
    FDQuery_MuonTra: TFDQuery;
    DataSource_MuonTra: TDataSource;
    FDQuery_YeuCauMuon: TFDQuery;
    FDQuery_YeuCauTra: TFDQuery;
    FDQuery_GiaHan: TFDQuery;
    FDQuery_MuonTraID: TLargeintField;
    FDQuery_MuonTraMaYeuCau: TStringField;
    FDQuery_MuonTraMSSV: TWideStringField;
    FDQuery_MuonTraTenSinhVien: TWideStringField;
    FDQuery_MuonTraTaiLieuID: TLargeintField;
    FDQuery_MuonTraTenTaiLieu: TWideStringField;
    FDQuery_MuonTraTenTacGia: TWideStringField;
    FDQuery_MuonTraNgayYeuCau: TSQLTimeStampField;
    FDQuery_MuonTraNgayHenMuon: TDateField;
    FDQuery_MuonTraNgayHenTra: TDateField;
    FDQuery_MuonTraNgayMuonThucTe: TSQLTimeStampField;
    FDQuery_MuonTraNgayTraThucTe: TSQLTimeStampField;
    FDQuery_MuonTraTrangThai: TByteField;
    FDQuery_MuonTraTenTrangThai: TWideStringField;
    FDQuery_MuonTraTenThuThu: TWideStringField;
    FDQuery_MuonTraNgayDuyet: TSQLTimeStampField;
    FDQuery_MuonTraTinhTrangSach: TWideStringField;
    FDQuery_MuonTraTienPhat: TBCDField;
    FDQuery_MuonTraLyDoPhat: TWideStringField;
    FDQuery_MuonTraGhiChu: TWideStringField;
    FDQuery_MuonTraSoNgayTre: TIntegerField;
    FDQuery_MuonTraMaTaiLieu: TWideStringField;
    FDQuery_LichSuMuonTra: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_DuLieu: TDM_DuLieu;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
