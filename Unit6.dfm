object frmNhapGiaHan: TfrmNhapGiaHan
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gia h'#7841'n t'#224'i li'#7879'u'
  ClientHeight = 287
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object lblNgayHienTai: TLabel
    Left = 96
    Top = 72
    Width = 186
    Height = 28
    Caption = 'Ng'#224'y h'#7865'n tr'#7843' hi'#7879'n t'#7841'i:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblNgayHenTraHienTai: TLabel
    Left = 296
    Top = 72
    Width = 128
    Height = 28
    Caption = '[Ng'#224'y hi'#7879'n t'#7841'i]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblNgayHenTraMoi: TLabel
    Left = 96
    Top = 128
    Width = 156
    Height = 28
    Caption = 'Ng'#224'y h'#7865'n tr'#7843' m'#7899'i:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object dtpNgayHenTraMoi: TDateTimePicker
    Left = 288
    Top = 124
    Width = 186
    Height = 36
    Date = 45747.000000000000000000
    Time = 0.577179270832857600
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnXacNhanGiaHan: TButton
    Left = 124
    Top = 192
    Width = 117
    Height = 49
    Caption = 'X'#225'c nh'#7853'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
  object btnHuyGiaHan: TButton
    Left = 312
    Top = 192
    Width = 116
    Height = 49
    Caption = 'Hu'#7927
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
end
