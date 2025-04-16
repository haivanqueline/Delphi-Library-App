unit uPasswordUtils;

interface

uses
  System.SysUtils, System.NetEncoding, System.Hash, System.Math;

type
  TPasswordUtils = class
  private
    const
      SALT_LENGTH = 16; // Độ dài salt: 16 bytes
      ITERATIONS = 100000; // Số vòng lặp PBKDF2
      KEY_LENGTH = 32; // Độ dài khóa đầu ra: 32 bytes (256 bit)
    class function PBKDF2(const Password, Salt: TBytes; Iterations, KeyLength: Integer): TBytes;
  public
    class function GenerateSalt: TBytes;
    class function HashPassword(const Password: string; const Salt: TBytes): string;
    class function GenerateHashedPassword(const Password: string; out Salt: TBytes): string; overload;
    class function GenerateHashedPassword(const Password: string): string; overload;
    class function VerifyPassword(const Password, StoredHash: string; const Salt: TBytes): Boolean;
  end;

implementation

class function TPasswordUtils.GenerateSalt: TBytes;
var
  I: Integer;
begin
  SetLength(Result, SALT_LENGTH);
  for I := 0 to SALT_LENGTH - 1 do
    Result[I] := Random(256); // Sinh ngẫu nhiên từng byte
end;

class function TPasswordUtils.PBKDF2(const Password, Salt: TBytes; Iterations, KeyLength: Integer): TBytes;
var
  BlockCount, I, J, K: Integer;
  Block: TBytes;
  Temp: TBytes;
  Counter: TBytes;
  DerivedKey: TBytes;
  SaltWithCounter: TBytes;
begin
  // Số block cần thiết (mỗi block 32 bytes với SHA256)
  BlockCount := Ceil(KeyLength / 32); // 32 bytes là độ dài đầu ra của SHA256

  SetLength(DerivedKey, KeyLength);
  SetLength(Counter, 4); // Bộ đếm 4 bytes cho block index

  // Lặp qua từng block
  for I := 1 to BlockCount do
  begin
    // Chuẩn bị bộ đếm
    Counter[0] := (I shr 24) and $FF;
    Counter[1] := (I shr 16) and $FF;
    Counter[2] := (I shr 8) and $FF;
    Counter[3] := I and $FF;

    // Kết hợp salt và counter
    SetLength(SaltWithCounter, Length(Salt) + 4);
    Move(Salt[0], SaltWithCounter[0], Length(Salt));
    Move(Counter[0], SaltWithCounter[Length(Salt)], 4);

    // Khởi tạo block với giá trị ban đầu
    Block := THashSHA2.GetHMACAsBytes(SaltWithCounter, Password, THashSHA2.TSHA2Version.SHA256);
    Temp := Copy(Block); // Giữ bản sao để XOR

    // Lặp qua các vòng lặp
    for J := 1 to Iterations - 1 do
    begin
      Block := THashSHA2.GetHMACAsBytes(Block, Password, THashSHA2.TSHA2Version.SHA256);
      for K := 0 to Length(Block) - 1 do
        Temp[K] := Temp[K] xor Block[K];
    end;

    // Ghi block vào DerivedKey
    if I = BlockCount then
      Move(Temp[0], DerivedKey[(I - 1) * 32], KeyLength - (I - 1) * 32)
    else
      Move(Temp[0], DerivedKey[(I - 1) * 32], 32);
  end;

  Result := DerivedKey;
end;

class function TPasswordUtils.HashPassword(const Password: string; const Salt: TBytes): string;
var
  PasswordBytes: TBytes;
  DerivedKey: TBytes;
begin
  // Chuyển mật khẩu thành mảng bytes (UTF-8)
  PasswordBytes := TEncoding.UTF8.GetBytes(Password);

  // Sử dụng PBKDF2 với HMAC-SHA256
  DerivedKey := PBKDF2(PasswordBytes, Salt, ITERATIONS, KEY_LENGTH);

  // Chuyển kết quả thành Base64
  Result := TNetEncoding.Base64.EncodeBytesToString(DerivedKey);
end;

class function TPasswordUtils.GenerateHashedPassword(const Password: string; out Salt: TBytes): string;
begin
  // Sinh salt ngẫu nhiên
  Salt := GenerateSalt;

  // Băm mật khẩu với salt
  Result := HashPassword(Password, Salt);
end;

class function TPasswordUtils.GenerateHashedPassword(const Password: string): string;
var
  Salt: TBytes;
begin
  Result := GenerateHashedPassword(Password, Salt);
end;

class function TPasswordUtils.VerifyPassword(const Password, StoredHash: string; const Salt: TBytes): Boolean;
var
  ComputedHash: string;
begin
  // Băm lại mật khẩu với salt đã lưu
  ComputedHash := HashPassword(Password, Salt);

  // So sánh kết quả băm với hash đã lưu
  Result := ComputedHash = StoredHash;
end;

initialization
  // Khởi tạo seed cho Random
  Randomize;

end.
