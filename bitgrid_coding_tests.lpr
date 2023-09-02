program bitgrid_coding_tests;
uses
  SysUtils, BitGridEngine, BitGridUtil;

  function StringNot(S : String):String;
  var
    i : integer;
    t : string;
  begin
    t := '';
    for i := 1 to length(S) do
      if s[i] = '0' then t := t + '1'
                    else t := t + '0';
    StringNot := t;
  end;

  function StringEqual(A,B : String):Boolean;
  var
    i : integer;
    match : boolean;
  begin
    match := true;
    if length(A) <> length(B) then
    begin
      WriteLn('Mismatch string length in StringEqual');
      Match := False;
    end
    else
      for i := 1 to length(A) do
        if A[i] <> B[i] then
          Match := False;
    StringEqual := Match;
  end;

  Procedure StringSplit(Source, Mask : string;
                        Var A,B : string);
  var
    i : integer;
  begin
    A := '';
    B := '';
    if length(Source) <> length(Mask) then
      WriteLn('Mismatch string length in SplitString')
    else
      for i := 1 to Length(Source) do
        if Mask[i] = '1' then B := B + Source[i]
                         else A := A + Source[i];
  end;

var
  x,y,z : uInt64;
  i,j,k : integer;
  a,b,c,s,t : string;
begin
  a := '1010';
  b := '1100';

  for i := 0 to 15 do
  begin
    c := '';
    if (i AND 8) <> 0 then C := C + '1' else C := C + '0';
    if (i AND 4) <> 0 then C := C + '1' else C := C + '0';
    if (i AND 2) <> 0 then C := C + '1' else C := C + '0';
    if (i AND 1) <> 0 then C := C + '1' else C := C + '0';

    WriteLn('Iteration : ',C);

    StringSplit(C,A,S,T);
    If StringEqual(S,T) then WriteLn('A is not involved')
                        else WriteLn('A splits ',c,' into ',S,' and ',T);
    StringSplit(C,B,S,T);
    If StringEqual(S,T) then WriteLn('B is not involved')
                        else WriteLn('B splits ',c,' into ',S,' and ',T);
  end;


  WriteLn;
  WriteLn(' AllPass code is ',IntToHex(PassThrough));
  WriteLn;
  WriteLn('The left output bits are ',IntToHex((PassThrough SHR 3) AND ($1111111111111111)));

  X := (PassThrough SHR 0) AND ($1111111111111111);

  y := 0;
  z := 0;
  for i := 15 downto 0 do
    if ((LeftBits shr (i*4)) AND 1)=1 then
      y := (y SHL 4) or ((x SHR (i*4)) AND 1)
    else
      z := (z SHL 4) or ((x SHR (i*4)) AND 1);

  If (Y=Z) then
    WriteLn('LeftBits not involved')
  else
    WriteLn('LeftBits ARE Involved : ',IntToHex(Y),' ',IntToHex(Z));

  y := 0;
  z := 0;
  for i := 15 downto 0 do
    if ((RightBits shr (i*4)) AND 1)=1 then
      y := (y SHL 4) or ((x SHR (i*4)) AND 1)
    else
      z := (z SHL 4) or ((x SHR (i*4)) AND 1);

  If (Y=Z) then
    WriteLn('RightBits not involved')
  else
    WriteLn('RightBits ARE Involved : ',IntToHex(Y),' ',IntToHex(Z));


  y := 0;
  z := 0;
  for i := 15 downto 0 do
    if ((UpBits shr (i*4)) AND 1)=1 then
      y := (y SHL 4) or ((x SHR (i*4)) AND 1)
    else
      z := (z SHL 4) or ((x SHR (i*4)) AND 1);

  If (Y=Z) then
    WriteLn('UpBits not involved')
  else
    WriteLn('UpBits ARE Involved : ',IntToHex(Y),' ',IntToHex(Z));


  y := 0;
  z := 0;
  for i := 15 downto 0 do
    if ((DownBits shr (i*4)) AND 1)=1 then
      y := (y SHL 4) or ((x SHR (i*4)) AND 1)
    else
      z := (z SHL 4) or ((x SHR (i*4)) AND 1);

  If (Y=Z) then
    WriteLn('DownBits not involved')
  else
    WriteLn('DownBits ARE Involved : ',IntToHex(Y),' ',IntToHex(Z));



  readln;
end.

