unit HzSpell;
{ version 4.1}

interface

uses
  Windows, Messages, SysUtils, Classes;

type
  THzSpell = class(TComponent)
  protected
    FHzText: AnsiString;
    FSpell: AnsiString;
    FSpellH: AnsiString;
    procedure SetHzText(const Value: AnsiString);
    function GetHzSpell: AnsiString;
    function GetPyHead: AnsiString;
  public
    class function PyOfHz(Hz: AnsiString): AnsiString;
    class function PyHeadOfHz(Hz: AnsiString): AnsiString;
  published
    property HzText: AnsiString read FHzText write SetHzText;
    property HzSpell: AnsiString read GetHzSpell;
    property PyHead: AnsiString read GetPyHead;
  end;

{$I HzSpDat2.inc}

procedure Register;

function GetHzPy(HzChar: PAnsiChar; Len: Integer): string;

function GetHzPyFull(HzChar: AnsiString): AnsiString;

function GetHzPyHead(HzChar: PAnsiChar; Len: Integer): string;

function GetPyChars(HzChar: string): string;

implementation

procedure Register;
begin
  RegisterComponents('System', [THzSpell]);
end;

function GetHzPy(HzChar: PAnsiChar; Len: Integer): string;
var
  C: AnsiChar;
  Index: Integer;
begin
  Result := '';
  if (Len > 1) and (HzChar[0] >= #129) and (HzChar[1] >= #64) then
  begin
    //ÊÇ·ñÎª GBK ×Ö·û
    case HzChar[0] of
      #163:  // È«½Ç ASCII
        begin
          C := AnsiChar(Ord(HzChar[1]) - 128);
          if C in ['a'..'z', 'A'..'Z', '0'..'9', '(', ')', '[', ']'] then
            Result := C
          else
            Result := '';
        end;
      #162: // ÂÞÂíÊý×Ö
        begin
          if HzChar[1] > #160 then
            Result := CharIndex[Ord(HzChar[1]) - 160]
          else
            Result := '';
        end;
      #166: // Ï£À°×ÖÄ¸
        begin
          if HzChar[1] in [#$A1..#$B8] then
            Result := CharIndex2[Ord(HzChar[1]) - $A0]
          else if HzChar[1] in [#$C1..#$D8] then
            Result := CharIndex2[Ord(HzChar[1]) - $C0]
          else
            Result := '';
        end;
    else
      begin  // »ñµÃÆ´ÒôË÷Òý
        Index := PyCodeIndex[Ord(HzChar[0]) - 128, Ord(HzChar[1]) - 63];
        if Index = 0 then
          Result := ''
        else
          Result := PyMusicCode[Index];
      end;
    end;
  end
  else if Len > 0 then
  begin
    //ÔÚ GBK ×Ö·û¼¯Íâ, ¼´°ë½Ç×Ö·û
    if HzChar[0] in ['a'..'z', 'A'..'Z', '0'..'9', '(', ')', '[', ']', '.', '!', '@', '#', '$', '%', '^', '&', '*', '-',
      '+', '<', '>', '?', ':', '"'] then
      Result := HzChar[0]
    else
      Result := '';
  end;
end;

function GetHzPyFull(HzChar: AnsiString): AnsiString;
var
  i, len: Integer;
  Py: string;

  function IsDouByte(C: AnsiChar): Boolean;
  begin
    Result := C >= #129;
  end;

begin
  Result := '';
  i := 1;
  while i <= Length(HzChar) do
  begin
    if IsDouByte(HzChar[i]) and (Length(HzChar) - i > 0) then
      len := 2
    else
      len := 1;
    Py := GetHzPy(@HzChar[i], len);
    Inc(i, len);
    if (Result <> '') and (Py <> '') then
      Result := Result + ' ' + Py
    else
      Result := Result + Py;
  end;
end;

function GetHzPyHead(HzChar: PAnsiChar; Len: Integer): string;
begin
  Result := Copy(GetHzPy(HzChar, Len), 1, 1);
end;

function GetPyChars(HzChar: string): string;
var
  i, len: Integer;
  Py: string;

  function IsDouByte(C: Char): Boolean;
  begin
    Result := C >= #129;
  end;

begin
  Result := '';
  i := 1;
  while i <= Length(HzChar) do
  begin
    if IsDouByte(HzChar[i]) and (Length(HzChar) - i > 0) then
      len := 2
    else
      len := 1;
    Py := GetHzPyHead(@HzChar[i], len);
    Inc(i, len);
    Result := Result + Py;
  end;
end;

{ THzSpell }

function THzSpell.GetHzSpell: AnsiString;
begin
  if FSpell = '' then
  begin
    Result := GetHzPyFull(FHzText);
    FSpell := Result;
  end
  else
    Result := FSpell;
end;

function THzSpell.GetPyHead: AnsiString;
begin
  if FSpellH = '' then
  begin
    Result := GetPyChars(FHzText);
    FSpellH := Result;
  end
  else
    Result := FSpellH;
end;

class function THzSpell.PyHeadOfHz(Hz: AnsiString): AnsiString;
begin
  Result := GetPyChars(Hz);
end;

class function THzSpell.PyOfHz(Hz: AnsiString): AnsiString;
begin
  Result := GetHzPyFull(Hz);
end;

procedure THzSpell.SetHzText(const Value: AnsiString);
begin
  FHzText := Value;
  FSpell := '';
  FSpellH := '';
end;

end.

