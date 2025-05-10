unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Unit4,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmThongBao = class(TForm)
    memoThongBao: TMemo;
    btnDong: TButton;
    btnDaDoc: TButton;
    pnlFooter: TPanel;
    pnlHeader: TPanel;
    imgLogo: TImage;
    lblTitle: TLabel;
    procedure btnDongClick(Sender: TObject);
    procedure btnDaDocClick(Sender: TObject);
  private
    FMSSV: string;
    procedure CapNhatThoiGianDaDoc;
  public
    property MSSV: string read FMSSV write FMSSV;
  end;

var
  frmThongBao: TfrmThongBao;

implementation

{$R *.dfm}

uses
  Unit2, FireDAC.Comp.Client;

procedure TfrmThongBao.btnDongClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmThongBao.btnDaDocClick(Sender: TObject);
begin
  CapNhatThoiGianDaDoc;
  Close;
end;

procedure TfrmThongBao.CapNhatThoiGianDaDoc;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM_DuLieu.FDConnection;
    // Cập nhật LastNotificationCheck trong bảng SinhVien
    Query.SQL.Text := 'UPDATE SinhVien SET LastNotificationCheck = GETDATE() WHERE MSSV = :MSSV';
    Query.Params.ParamByName('MSSV').DataType := ftWideString;
    Query.Params.ParamByName('MSSV').AsString := FMSSV;
    Query.ExecSQL;

    // Cập nhật trạng thái DaDoc trong bảng ThongBao
    Query.SQL.Text := 'UPDATE ThongBao SET DaDoc = 1 WHERE MSSV = :MSSV AND DaDoc = 0';
    Query.Params.ParamByName('MSSV').DataType := ftWideString;
    Query.Params.ParamByName('MSSV').AsString := FMSSV;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

end.
