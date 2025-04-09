unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmNhapGiaHan = class(TForm)
    lblNgayHienTai: TLabel;
    lblNgayHenTraHienTai: TLabel;
    lblNgayHenTraMoi: TLabel;
    dtpNgayHenTraMoi: TDateTimePicker;
    btnXacNhanGiaHan: TButton;
    btnHuyGiaHan: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FNgayHenTraHienTai: TDate;
    procedure SetNgayHenTraHienTai(const Value: TDate);
  public
    { Public declarations }
    property NgayHenTraHienTai: TDate read FNgayHenTraHienTai write SetNgayHenTraHienTai;
  end;

var
  frmNhapGiaHan: TfrmNhapGiaHan;

implementation

{$R *.dfm}
procedure TfrmNhapGiaHan.FormCreate(Sender: TObject);
begin
  dtpNgayHenTraMoi.Date := Date;
end;

procedure TfrmNhapGiaHan.SetNgayHenTraHienTai(const Value: TDate);
begin
  FNgayHenTraHienTai := Value;
  lblNgayHenTraHienTai.Caption := FormatDateTime('dd/mm/yyyy', FNgayHenTraHienTai);
  dtpNgayHenTraMoi.Date := FNgayHenTraHienTai + 7; // Gợi ý ngày mới là 7 ngày sau
  dtpNgayHenTraMoi.MinDate := FNgayHenTraHienTai + 1; // Ngày tối thiểu là ngày sau ngày hiện tại
  dtpNgayHenTraMoi.MaxDate := FNgayHenTraHienTai + 7; // Ngày tối đa là 7 ngày sau
end;

end.
