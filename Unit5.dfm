object frmNhapYeuCauMuon: TfrmNhapYeuCauMuon
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Nh'#7853'p Th'#244'ng Tin Y'#234'u C'#7847'u M'#432#7907'n'
  ClientHeight = 279
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object lblNgayHenMuon: TLabel
    Left = 96
    Top = 60
    Width = 145
    Height = 28
    Caption = 'Ng'#224'y h'#7865'n m'#432#7907'n:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblNgayHenTra: TLabel
    Left = 96
    Top = 124
    Width = 117
    Height = 28
    Caption = 'Ng'#224'y h'#7865'n tr'#7843':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object dtpNgayHenMuon: TDateTimePicker
    Left = 242
    Top = 58
    Width = 186
    Height = 36
    Date = 45747.000000000000000000
    Time = 45747.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object dtpNgayHenTra: TDateTimePicker
    Left = 242
    Top = 122
    Width = 186
    Height = 36
    Date = 45747.000000000000000000
    Time = 45747.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object btnXacNhanMuon: TButton
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
    TabOrder = 2
  end
  object btnHuyMuon: TButton
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
    TabOrder = 3
  end
end
