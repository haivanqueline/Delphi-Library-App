object DM_DuLieu: TDM_DuLieu
  Height = 1080
  Width = 1440
  PixelsPerInch = 144
  object FDConnection: TFDConnection
    Params.Strings = (
      'Server=HARIQUEF'
      'Database=KhoaLuan'
      'User_Name=sa'
      'Password=qwe123qwe'
      'DriverID=MSSQL')
    Connected = True
    Left = 504
    Top = 320
  end
  object FDQuery_TaiLieuTongHop: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT TOP 100'
      '    ID, MaTaiLieu, TenTaiLieu, TenTacGia, NhaXB, NamXB,'
      
        '    TenLoaiTL, Khoa, Nganh, MoTa, SoLuong, SoLuongCon, NgayCapNh' +
        'at'
      'FROM TaiLieuTongHop'
      'ORDER BY NEWID();')
    Left = 880
    Top = 192
  end
  object DataSource_TaiLieuTongHop: TDataSource
    DataSet = FDQuery_TaiLieuTongHop
    Left = 784
    Top = 88
  end
  object FDQuery_InsertYeuCauMuon: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'INSERT INTO MuonTraTaiLieu (MSSV, TaiLieuID, NgayHenMuon, NgayHe' +
        'nTra) '
      'VALUES (:MSSV, :TaiLieuID, :NgayHenMuon, :NgayHenTra)')
    Left = 104
    Top = 360
    ParamData = <
      item
        Name = 'MSSV'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TaiLieuID'
        DataType = ftLargeint
        ParamType = ptInput
      end
      item
        Name = 'NgayHenMuon'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'NgayHenTra'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object DataSource_LichSuMuonTra: TDataSource
    Left = 624
    Top = 176
  end
  object FDQuery_HuyYeuCauQuaHan: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'UPDATE YeuCauMuon'
      'SET TrangThai = 5, -- 5 l'#224' tr'#7841'ng th'#225'i "'#272#227' h'#7911'y"'
      '    LyDo = N'#39'T'#7921' '#273#7897'ng h'#7911'y do qu'#225' h'#7841'n ch'#7901' duy'#7879't'#39
      'WHERE TrangThai = 1 -- Ch'#7881' x'#7917' l'#253' y'#234'u c'#7847'u "Ch'#7901' duy'#7879't"'
      '  AND MSSV = :MSSV_Login -- Ch'#7881' x'#7917' l'#253' y'#234'u c'#7847'u c'#7911'a sinh vi'#234'n n'#224'y'
      
        '  AND NgayHenMuon < CAST(GETDATE() AS DATE) -- Ng'#224'y h'#7865'n m'#432#7907'n nh'#7887 +
        ' h'#417'n ng'#224'y hi'#7879'n t'#7841'i ('#273#227' qua)')
    Left = 696
    Top = 600
    ParamData = <
      item
        Name = 'MSSV_LOGIN'
        ParamType = ptInput
      end>
  end
  object FDQuery_DangMuon: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      '--SELECT'
      '  --  yc.ID AS YeuCauMuonID,'
      ' --   yc.MaYeuCau,'
      ' --   yc.TaiLieuID,'
      '  --  tl.MaTaiLieu,'
      '  --  tl.TenTaiLieu,'
      '  --  yc.NgayHenMuon,'
      '  --  yc.NgayHenTra,'
      ' --  yc.GhiChu'
      '--FROM YeuCauMuon yc'
      '--JOIN TaiLieuTongHop tl ON yc.TaiLieuID = tl.ID'
      '--WHERE yc.MSSV = :MSSV_Login'
      '--  AND yc.TrangThai = 4 '
      '--ORDER BY yc.NgayHenTra ASC'
      'SELECT '
      
        '    mt.ID, mt.MaYeuCau, tl.MaTaiLieu, tl.TenTaiLieu, mt.NgayHenM' +
        'uon, mt.NgayHenTra, mt.GhiChu '
      'FROM MuonTraTaiLieu mt '
      'JOIN TaiLieuTongHop tl ON mt.TaiLieuID = tl.ID '
      'WHERE mt.MSSV = :MSSV_Login '
      'AND mt.TrangThai = 4')
    Left = 88
    Top = 248
    ParamData = <
      item
        Name = 'MSSV_Login'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDQuery_InsertYeuCauTra: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'INSERT INTO YeuCauTra (MSSV, TaiLieuID, YeuCauMuonID, NgayHenTra' +
        ')'
      'VALUES (:MSSV, :TaiLieuID, :YeuCauMuonID, :NgayHenTra)')
    Left = 936
    Top = 624
    ParamData = <
      item
        Name = 'MSSV'
        ParamType = ptInput
      end
      item
        Name = 'TAILIEUID'
        ParamType = ptInput
      end
      item
        Name = 'YEUCAUMUONID'
        ParamType = ptInput
      end
      item
        Name = 'NGAYHENTRA'
        ParamType = ptInput
      end>
  end
  object FDQuery_UpdateGiaHan: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'UPDATE MuonTraTaiLieu '
      'SET NgayHenTra = :NgayHenTraMoi, '
      '    SoLanGiaHan = SoLanGiaHan + 1, '
      
        '    GhiChu = ISNULL(GhiChu + CHAR(13) + CHAR(10), '#39#39') + N'#39#272#227' gia' +
        ' h'#7841'n '#273#7871'n '#39' + CONVERT(NVARCHAR, :NgayHenTraMoi, 103) '
      'WHERE ID = :ID AND TrangThai = 4')
    Left = 304
    Top = 328
    ParamData = <
      item
        Name = 'NgayHenTraMoi'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'ID'
        DataType = ftLargeint
        ParamType = ptInput
      end>
  end
  object FDQuery_UpdateYeuCauMuonTra: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'UPDATE YeuCauMuon'
      'SET TrangThai = 7 '
      'WHERE ID = :YeuCauMuonID'
      '  AND TrangThai = 4 ')
    Left = 920
    Top = 552
    ParamData = <
      item
        Name = 'YEUCAUMUONID'
        ParamType = ptInput
      end>
  end
  object FDQuery_QuaHan: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT '
      
        '    mt.ID, mt.MaYeuCau, tl.MaTaiLieu, tl.TenTaiLieu, mt.NgayHenT' +
        'ra, '
      
        '    DATEDIFF(DAY, mt.NgayHenTra, GETDATE()) AS SoNgayTre, mt.Tie' +
        'nPhat '
      'FROM MuonTraTaiLieu mt '
      'JOIN TaiLieuTongHop tl ON mt.TaiLieuID = tl.ID '
      'WHERE mt.MSSV = :MSSV_Login '
      'AND mt.TrangThai = 8 '
      'AND mt.TienPhat > 0')
    Left = 168
    Top = 480
    ParamData = <
      item
        Name = 'MSSV_Login'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDQuery_MuonTra: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT'
      
        '    ID, MaYeuCau, MSSV, TenSinhVien, TaiLieuID, MaTaiLieu, TenTa' +
        'iLieu, TenTacGia,'
      
        '    NgayYeuCau, NgayHenMuon, NgayHenTra, NgayMuonThucTe, NgayTra' +
        'ThucTe,'
      
        '    TrangThai, TenTrangThai, TenThuThu, NgayDuyet, TinhTrangSach' +
        ','
      '    TienPhat, LyDoPhat, GhiChu, SoNgayTre'
      'FROM v_ChiTietMuonTraTaiLieu'
      'WHERE MSSV = :MSSV_Login -- L'#7885'c theo sinh vi'#234'n '#273#259'ng nh'#7853'p'
      '-- '#272'i'#7873'u ki'#7879'n l'#7885'c tr'#7841'ng th'#225'i s'#7869' th'#234'm b'#7857'ng code'
      'ORDER BY NgayYeuCau DESC'
      '')
    Left = 864
    Top = 408
    ParamData = <
      item
        Name = 'MSSV_LOGIN'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object FDQuery_MuonTraID: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object FDQuery_MuonTraMaYeuCau: TStringField
      FieldName = 'MaYeuCau'
      Origin = 'MaYeuCau'
      ReadOnly = True
      Size = 8
    end
    object FDQuery_MuonTraMSSV: TWideStringField
      FieldName = 'MSSV'
      Origin = 'MSSV'
      Required = True
      Size = 8
    end
    object FDQuery_MuonTraTenSinhVien: TWideStringField
      FieldName = 'TenSinhVien'
      Origin = 'TenSinhVien'
      ReadOnly = True
      Size = 121
    end
    object FDQuery_MuonTraTaiLieuID: TLargeintField
      FieldName = 'TaiLieuID'
      Origin = 'TaiLieuID'
      Required = True
    end
    object FDQuery_MuonTraTenTaiLieu: TWideStringField
      FieldName = 'TenTaiLieu'
      Origin = 'TenTaiLieu'
      Required = True
      Size = 500
    end
    object FDQuery_MuonTraTenTacGia: TWideStringField
      FieldName = 'TenTacGia'
      Origin = 'TenTacGia'
      Size = 400
    end
    object FDQuery_MuonTraNgayYeuCau: TSQLTimeStampField
      FieldName = 'NgayYeuCau'
      Origin = 'NgayYeuCau'
      Required = True
    end
    object FDQuery_MuonTraNgayHenMuon: TDateField
      FieldName = 'NgayHenMuon'
      Origin = 'NgayHenMuon'
      Required = True
    end
    object FDQuery_MuonTraNgayHenTra: TDateField
      FieldName = 'NgayHenTra'
      Origin = 'NgayHenTra'
      Required = True
    end
    object FDQuery_MuonTraNgayMuonThucTe: TSQLTimeStampField
      FieldName = 'NgayMuonThucTe'
      Origin = 'NgayMuonThucTe'
    end
    object FDQuery_MuonTraNgayTraThucTe: TSQLTimeStampField
      FieldName = 'NgayTraThucTe'
      Origin = 'NgayTraThucTe'
    end
    object FDQuery_MuonTraTrangThai: TByteField
      FieldName = 'TrangThai'
      Origin = 'TrangThai'
      Required = True
    end
    object FDQuery_MuonTraTenTrangThai: TWideStringField
      FieldName = 'TenTrangThai'
      Origin = 'TenTrangThai'
      ReadOnly = True
      Required = True
    end
    object FDQuery_MuonTraTenThuThu: TWideStringField
      FieldName = 'TenThuThu'
      Origin = 'TenThuThu'
      Size = 100
    end
    object FDQuery_MuonTraNgayDuyet: TSQLTimeStampField
      FieldName = 'NgayDuyet'
      Origin = 'NgayDuyet'
    end
    object FDQuery_MuonTraTinhTrangSach: TWideStringField
      FieldName = 'TinhTrangSach'
      Origin = 'TinhTrangSach'
      Size = 500
    end
    object FDQuery_MuonTraTienPhat: TBCDField
      FieldName = 'TienPhat'
      Origin = 'TienPhat'
      Precision = 10
      Size = 2
    end
    object FDQuery_MuonTraLyDoPhat: TWideStringField
      FieldName = 'LyDoPhat'
      Origin = 'LyDoPhat'
      Size = 500
    end
    object FDQuery_MuonTraGhiChu: TWideStringField
      FieldName = 'GhiChu'
      Origin = 'GhiChu'
      Size = 500
    end
    object FDQuery_MuonTraSoNgayTre: TIntegerField
      FieldName = 'SoNgayTre'
      Origin = 'SoNgayTre'
      ReadOnly = True
    end
    object FDQuery_MuonTraMaTaiLieu: TWideStringField
      FieldName = 'MaTaiLieu'
      Origin = 'MaTaiLieu'
      Required = True
    end
  end
  object DataSource_MuonTra: TDataSource
    DataSet = FDQuery_MuonTra
    Left = 120
    Top = 48
  end
  object FDQuery_YeuCauMuon: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'INSERT INTO MuonTraTaiLieu (MSSV, TaiLieuID, NgayHenMuon, NgayHe' +
        'nTra, TrangThai)'
      
        'VALUES (:MSSV, :TaiLieuID, :NgayHenMuon, :NgayHenTra, 1) -- Tran' +
        'gThai = 1 (Ch'#7901' duy'#7879't m'#432#7907'n)')
    Left = 288
    Top = 48
    ParamData = <
      item
        Name = 'MSSV'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TAILIEUID'
        DataType = ftLargeint
        ParamType = ptInput
      end
      item
        Name = 'NGAYHENMUON'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'NGAYHENTRA'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object FDQuery_YeuCauTra: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'UPDATE MuonTraTaiLieu'
      'SET TrangThai = 7, -- 7 l'#224' tr'#7841'ng th'#225'i "Ch'#7901' duy'#7879't tr'#7843'"'
      
        '    NgayYeuCau = GETDATE() -- C'#243' th'#7875' c'#7853'p nh'#7853't NgayYeuCau l'#224' ng'#224'y' +
        ' y'#234'u c'#7847'u tr'#7843
      'WHERE ID = :ID -- D'#249'ng ID c'#7911'a b'#7843'n ghi MuonTraTaiLieu'
      
        '  AND TrangThai = 4 -- Ch'#7881' cho ph'#233'p y'#234'u c'#7847'u tr'#7843' khi '#273'ang '#7903' tr'#7841'ng' +
        ' th'#225'i "'#272#227' m'#432#7907'n"'
      
        '  AND MSSV = :MSSV -- Th'#234'm '#273'i'#7873'u ki'#7879'n MSSV '#273#7875' b'#7843'o m'#7853't h'#417'n (t'#249'y ch' +
        #7885'n)')
    Left = 288
    Top = 144
    ParamData = <
      item
        Name = 'ID'
        DataType = ftLargeint
        ParamType = ptInput
      end
      item
        Name = 'MSSV'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDQuery_GiaHan: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT '
      
        '    mt.ID, mt.MaYeuCau, tl.MaTaiLieu, tl.TenTaiLieu, mt.NgayHenT' +
        'ra, '
      
        '    DATEDIFF(DAY, mt.NgayHenTra, GETDATE()) AS SoNgayTre, mt.Tie' +
        'nPhat '
      'FROM MuonTraTaiLieu mt '
      'JOIN TaiLieuTongHop tl ON mt.TaiLieuID = tl.ID '
      'WHERE mt.MSSV = :MSSV_Login '
      'AND mt.TrangThai = 8 '
      'AND mt.TienPhat > 0')
    Left = 296
    Top = 240
    ParamData = <
      item
        Name = 'MSSV_Login'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDQuery_LichSuMuonTra: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT '
      
        '    mt.ID, mt.MaYeuCau, mt.MSSV, sv.HoLot + '#39' '#39' + sv.Ten AS TenS' +
        'inhVien, '
      
        '    mt.TaiLieuID, tl.MaTaiLieu, tl.TenTaiLieu, mt.NgayYeuCau, mt' +
        '.NgayHenMuon, mt.NgayHenTra, '
      
        '    mt.TrangThai, mt.TenTrangThai, mt.LyDo, mt.GhiChu, mt.ThuThu' +
        'ID, tt.HoTen AS TenThuThu, mt.NgayDuyet '
      'FROM MuonTraTaiLieu mt '
      'JOIN SinhVien sv ON mt.MSSV = sv.MSSV '
      'JOIN TaiLieuTongHop tl ON mt.TaiLieuID = tl.ID '
      'LEFT JOIN ThuThu tt ON mt.ThuThuID = tt.ID '
      'WHERE mt.MSSV = :MSSV_Login')
    Left = 88
    Top = 160
    ParamData = <
      item
        Name = 'MSSV_Login'
        DataType = ftString
        ParamType = ptInput
      end>
  end
end
