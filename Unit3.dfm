object frmDoiMatKhau: TfrmDoiMatKhau
  Left = 622
  Top = 287
  Caption = #272#7893'i m'#7853't kh'#7849'u'
  ClientHeight = 310
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 216
    Top = 48
    Width = 166
    Height = 38
    Caption = #272#7893'i m'#7853't kh'#7849'u'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -28
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblMatKhauMoi: TLabel
    Left = 144
    Top = 104
    Width = 125
    Height = 28
    Caption = 'M'#7853't kh'#7849'u m'#7899'i:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblXacNhanMatKhauMoi: TLabel
    Left = 144
    Top = 160
    Width = 169
    Height = 28
    Caption = 'X'#225'c nh'#7853'n m'#7853't kh'#7849'u:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object edtMatKhauMoi: TEdit
    Left = 336
    Top = 112
    Width = 121
    Height = 23
    PasswordChar = '*'
    TabOrder = 0
  end
  object edtXacNhanMatKhauMoi: TEdit
    Left = 336
    Top = 168
    Width = 121
    Height = 23
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnDoiMatKhau: TButton
    Left = 208
    Top = 240
    Width = 75
    Height = 25
    Caption = #272#7893'i m'#7853't kh'#7849'u'
    TabOrder = 2
    OnClick = btnDoiMatKhauClick
  end
  object btnHuyDoiMatKhau: TButton
    Left = 320
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Hu'#7927
    TabOrder = 3
    OnClick = btnHuyDoiMatKhauClick
  end
end
