unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmNhapYeuCauMuon = class(TForm)
    lblNgayHenMuon: TLabel;
    dtpNgayHenMuon: TDateTimePicker;
    lblNgayHenTra: TLabel;
    dtpNgayHenTra: TDateTimePicker;
    btnXacNhanMuon: TButton;
    btnHuyMuon: TButton;
    pnlMain: TPanel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNhapYeuCauMuon: TfrmNhapYeuCauMuon;

implementation

{$R *.dfm}


procedure TfrmNhapYeuCauMuon.FormCreate(Sender: TObject);
begin
  dtpNgayHenMuon.Date := Date;
  dtpNgayHenTra.Date := Date + 1;
end;

end.
