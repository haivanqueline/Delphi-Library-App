object frmMain: TfrmMain
  Left = 352
  Top = 219
  Caption = 'Qu'#7843'n l'#253' m'#432#7907'n tr'#7843' t'#224'i li'#7879'u'
  ClientHeight = 605
  ClientWidth = 1040
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1040
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 1034
    object lblHoTen: TLabel
      Left = 0
      Top = 0
      Width = 229
      Height = 41
      Margins.Right = 10
      Align = alLeft
      Caption = '[H'#7885' T'#234'n Ng'#432#7901'i D'#249'ng]'
      Font.Charset = 163
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object btnDangXuat: TButton
      Left = 896
      Top = 0
      Width = 80
      Height = 41
      Margins.Left = 5
      Align = alRight
      Caption = #272#259'ng xu'#7845't'
      TabOrder = 0
      OnClick = btnDangXuatClick
      ExplicitLeft = 890
    end
    object btnDoiMatKhau_Header: TButton
      Left = 816
      Top = 0
      Width = 80
      Height = 41
      Margins.Left = 5
      Align = alRight
      Caption = #272#7893'i m'#7853't kh'#7849'u'
      TabOrder = 1
      ExplicitLeft = 810
    end
    object btnThoat: TButton
      Left = 976
      Top = 0
      Width = 64
      Height = 41
      Margins.Left = 5
      Align = alRight
      Caption = 'Tho'#225't'
      TabOrder = 2
      OnClick = btnThoatClick
      ExplicitLeft = 970
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 1040
    Height = 564
    ActivePage = TabSheet1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = PageControl1Change
    ExplicitWidth = 1034
    ExplicitHeight = 547
    object TabSheet1: TTabSheet
      Caption = 'Tra c'#7913'u t'#224'i li'#7879'u'
      object pnlTraCuu_TimKiem: TPanel
        Left = 0
        Top = 0
        Width = 1032
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlTraCuu_TimKiem'
        TabOrder = 0
        object lblTraCuu_NhanTimKiem: TLabel
          Left = 0
          Top = 0
          Width = 183
          Height = 41
          Align = alLeft
          Caption = 'T'#236'm ki'#7871'm t'#224'i li'#7879'u:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitHeight = 32
        end
        object edtTraCuu_TuKhoa: TEdit
          Left = 183
          Top = 0
          Width = 733
          Height = 41
          Margins.Left = 5
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TextHint = 'Nh'#7853'p t'#7915' kh'#243'a (t'#234'n t'#224'i li'#7879'u, t'#225'c gi'#7843', m'#227' t'#224'i li'#7879'u,...)'
          ExplicitHeight = 40
        end
        object btnTraCuu_TimKiem: TButton
          Left = 916
          Top = 0
          Width = 116
          Height = 41
          Margins.Left = 5
          Align = alRight
          Caption = 'T'#236'm Ki'#7871'm'
          TabOrder = 1
          OnClick = btnTraCuu_TimKiemClick
        end
      end
      object lstvTraCuu_DanhSachTaiLieu: TListView
        Left = 0
        Top = 41
        Width = 1032
        Height = 480
        Align = alClient
        BevelOuter = bvNone
        Columns = <
          item
            Caption = 'TT'
            Width = 35
          end
          item
            Caption = 'M'#227' t'#224'i li'#7879'u'
            Width = 105
          end
          item
            Caption = 'T'#234'n t'#224'i li'#7879'u'
            Width = 400
          end
          item
            Caption = 'T'#234'n t'#225'c gi'#7843
            Width = 150
          end
          item
            Caption = 'Nh'#224' XB'
            Width = 120
          end
          item
            Caption = 'N'#259'm XB'
            Width = 90
          end
          item
            Caption = 'Lo'#7841'i t'#224'i li'#7879'u'
            Width = 120
          end
          item
            Caption = 'Khoa'
            Width = 60
          end
          item
            Caption = 'Ng'#224'nh'
            Width = 100
          end
          item
            Caption = 'M'#244' t'#7843
            Width = 200
          end
          item
            Caption = 'S'#7889' l'#432#7907'ng'
            Width = 100
          end
          item
            Caption = 'S'#7889' l'#432#7907'ng c'#242'n'
            Width = 120
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'L'#7883'ch s'#7917' m'#432#7907'n tr'#7843
      ImageIndex = 2
      object lstvTra_LichSuMuonTra: TListView
        Left = 0
        Top = 41
        Width = 1032
        Height = 480
        Align = alClient
        Columns = <
          item
            Caption = 'TT'
            Width = 40
          end
          item
            Caption = 'M'#227' y'#234'u c'#7847'u'
            Width = 100
          end
          item
            Caption = 'M'#227' t'#224'i li'#7879'u'
            Width = 100
          end
          item
            AutoSize = True
            Caption = 'T'#234'n t'#224'i li'#7879'u'
          end
          item
            Caption = 'Ng'#224'y y'#234'u c'#7847'u'
            Width = 130
          end
          item
            Caption = 'Ng'#224'y h'#7865'n m'#432#7907'n'
            Width = 130
          end
          item
            Caption = 'Ng'#224'y h'#7865'n tr'#7843
            Width = 130
          end
          item
            Caption = 'Tr'#7841'ng th'#225'i'
            Width = 130
          end
          item
            Caption = 'L'#253' do'
            Width = 150
          end
          item
            Caption = 'Ghi ch'#250
            Width = 150
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        GridLines = True
        ReadOnly = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
      end
      object pnlLichSu_BoLoc: TPanel
        Left = 0
        Top = 0
        Width = 1032
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 1026
        object lblLichSu_NhanTrangThai: TLabel
          Left = 0
          Top = 0
          Width = 90
          Height = 41
          Align = alLeft
          Caption = 'Tr'#7841'ng th'#225'i:'
          Layout = tlCenter
          ExplicitHeight = 28
        end
        object cboLichSu_TrangThai: TComboBox
          Left = 95
          Top = 3
          Width = 656
          Height = 36
          Margins.Left = 5
          Style = csDropDownList
          TabOrder = 0
          Items.Strings = (
            'T'#7845't c'#7843
            'Ch'#7901' duy'#7879't m'#432#7907'n'
            #272#227' duy'#7879't m'#432#7907'n'
            #272#227' t'#7915' ch'#7889'i'
            #272#227' m'#432#7907'n t'#224'i li'#7879'u'
            #272#227' h'#7911'y'
            #272#227' tr'#7843' t'#224'i li'#7879'u'
            'Ch'#7901' duy'#7879't tr'#7843
            'Qu'#225' h'#7841'n tr'#7843)
        end
        object btnLichSu_Loc: TButton
          Left = 764
          Top = -6
          Width = 75
          Height = 41
          Margins.Left = 10
          Caption = 'L'#7885'c'
          TabOrder = 1
          OnClick = btnLichSu_LocClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'T'#224'i li'#7879'u '#273'ang m'#432#7907'n'
      ImageIndex = 1
      PopupMenu = PopupMenu2
      object pnlMuon_TimKiem: TPanel
        Left = 0
        Top = 0
        Width = 1032
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlTraCuu_TimKiem'
        TabOrder = 0
        object lblMuon_NhanTimKiem: TLabel
          Left = 0
          Top = 0
          Width = 314
          Height = 41
          Align = alLeft
          Caption = 'T'#236'm ki'#7871'm t'#224'i li'#7879'u '#273'ang m'#432#7907'n:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitHeight = 32
        end
        object edtMuon_TuKhoa: TEdit
          Left = 314
          Top = 0
          Width = 614
          Height = 41
          Margins.Left = 5
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TextHint = 'Nh'#7853'p t'#7915' kh'#243'a (t'#234'n t'#224'i li'#7879'u, m'#227' y'#234'u c'#7847'u, m'#227' t'#224'i li'#7879'u,...)'
          ExplicitHeight = 40
        end
        object btnMuon_TimKiem: TButton
          Left = 928
          Top = 0
          Width = 104
          Height = 41
          Margins.Left = 5
          Align = alRight
          Caption = 'T'#236'm Ki'#7871'm'
          TabOrder = 1
        end
      end
      object lstvDangMuon_DanhSach: TListView
        Left = 0
        Top = 41
        Width = 1032
        Height = 480
        Align = alClient
        BevelOuter = bvNone
        Columns = <
          item
            Caption = 'TT'
            Width = 35
          end
          item
            Caption = 'M'#227' y'#234'u c'#7847'u'
            Width = 100
          end
          item
            Caption = 'M'#227' t'#224'i li'#7879'u'
            Width = 100
          end
          item
            AutoSize = True
            Caption = 'T'#234'n t'#224'i li'#7879'u'
          end
          item
            Caption = 'Ng'#224'y h'#7865'n m'#432#7907'n'
            Width = 150
          end
          item
            Caption = 'Ng'#224'y h'#7865'n tr'#7843
            Width = 150
          end
          item
            Caption = 'Ghi ch'#250
            Width = 150
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        PopupMenu = PopupMenu2
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'T'#224'i li'#7879'u qu'#225' h'#7841'n'
      ImageIndex = 4
      object pnlThanhToan_Button: TPanel
        Left = 0
        Top = 471
        Width = 1032
        Height = 50
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object btnThanhToan_QuaHan: TButton
          Left = 905
          Top = 0
          Width = 127
          Height = 50
          Margins.Left = 10
          Align = alRight
          Caption = 'Thanh to'#225'n'
          TabOrder = 0
          OnClick = btnThanhToan_QuaHanClick
        end
      end
      object lstvQuaHan_DanhSach: TListView
        Left = 0
        Top = 0
        Width = 1032
        Height = 471
        Align = alClient
        Columns = <
          item
            Caption = 'TT'
            Width = 40
          end
          item
            Caption = 'M'#227' y'#234'u c'#7847'u'
            Width = 130
          end
          item
            Caption = 'M'#227' t'#224'i li'#7879'u'
            Width = 130
          end
          item
            AutoSize = True
            Caption = 'T'#234'n t'#224'i li'#7879'u'
          end
          item
            Caption = 'Ng'#224'y h'#7865'n tr'#7843
            Width = 130
          end
          item
            Caption = 'S'#7889' ng'#224'y qu'#225' h'#7841'n'
            Width = 160
          end
          item
            Caption = 'Ti'#7873'n ph'#7841't'
            Width = 130
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Segoe UI'
        Font.Style = []
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 72
    Top = 344
    object mnuTraCuu_MuonTaiLieu: TMenuItem
      Caption = '&M'#432#7907'n t'#224'i li'#7879'u n'#224'y'
      OnClick = mnuTraCuu_MuonTaiLieuClick
    end
  end
  object PopupMenu2: TPopupMenu
    OnPopup = PopupMenu2Popup
    Left = 156
    Top = 387
    object mnuDangMuon_TraTaiLieu: TMenuItem
      Caption = '&Tr'#7843' t'#224'i li'#7879'u n'#224'y'
      OnClick = mnuDangMuon_TraTaiLieuClick
    end
    object mnuDangMuon_GiaHanTaiLieu: TMenuItem
      Caption = '&Gia h'#7841'n t'#224'i li'#7879'u n'#224'y'
      OnClick = mnuDangMuon_GiaHanTaiLieuClick
    end
  end
end
