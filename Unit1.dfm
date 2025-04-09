object frmLogin: TfrmLogin
  Left = 622
  Top = 314
  Caption = #272#259'ng nh'#7853'p'
  ClientHeight = 325
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object lblMSSV: TLabel
    Left = 136
    Top = 104
    Width = 85
    Height = 15
    Caption = 'M'#227' s'#7889' sinh vi'#234'n:'
  end
  object lblMatKhau: TLabel
    Left = 136
    Top = 200
    Width = 53
    Height = 15
    Caption = 'M'#7853't kh'#7849'u:'
  end
  object lblNgaySinh: TLabel
    Left = 136
    Top = 152
    Width = 137
    Height = 15
    Caption = 'Ng'#224'y sinh (dd/mm/yyyy):'
  end
  object Label1: TLabel
    Left = 224
    Top = 32
    Width = 155
    Height = 45
    Caption = #272#259'ng nh'#7853'p'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object edtMaSV: TEdit
    Left = 279
    Top = 101
    Width = 200
    Height = 23
    MaxLength = 8
    TabOrder = 0
  end
  object edtMatKhau: TEdit
    Left = 279
    Top = 197
    Width = 200
    Height = 23
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnDangNhap: TButton
    Left = 208
    Top = 248
    Width = 75
    Height = 25
    Caption = #272#259'ng nh'#7853'p'
    TabOrder = 2
    OnClick = btnDangNhapClick
  end
  object edtNgaySinh: TEdit
    Left = 279
    Top = 149
    Width = 200
    Height = 23
    MaxLength = 10
    TabOrder = 3
    OnChange = edtNgaySinhChange
    OnKeyPress = edtNgaySinhKeyPress
  end
  object btnThoat: TButton
    Left = 312
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Tho'#225't'
    TabOrder = 4
    OnClick = btnThoatClick
  end
end
