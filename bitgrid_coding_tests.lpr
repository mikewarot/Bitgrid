program bitgrid_coding_tests;
uses
  SysUtils, BitGridEngine, BitGridUtil;

const
  a : string = '1010101010101010';
  b : string = '1100110011001100';
  c : string = '1111000011110000';
  d : string = '1111111100000000';


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

  Function StringMerge(Source1,Source2, Mask : String):String;
  var
    i : integer;
    s : string;
  begin
    s := '';
    for i := 1 to length(Mask) do
      if Mask[i] = '1' then
        begin
          s := s + Source2[1];
          Delete(Source2,1,1);
        end
      else
        begin
          s := s + Source1[1];
          Delete(Source1,1,1);
        end;
    StringMerge := S;
  end;

var
  x,y,z : uInt64;
  i,j,k : integer;
  s,t,Q : string;
  mask : uInt64;
begin
  for i := 0 to 65535 do
  begin
    Q := '';
    Mask := 32768;
    while Mask <> 0 do
    begin
      if (i AND Mask) <> 0 then Q := Q + '1' else Q := Q + '0';
      Mask := Mask shr 1;
    end;

    WriteLn('Iteration : ',Q);

    StringSplit(Q,A,S,T);
    If StringEqual(S,T) then WriteLn('A is not involved')
                        else WriteLn('A ',A,' splits ',Q,' into ',S,' and ',T);

    If (S = '00000000') AND  (T <> '00000000') then
      WriteLn('Logical Expression A AND ',T);

    If StringEqual(S,StringNot(T)) then
      WriteLn('XOR found');

    StringSplit(Q,B,S,T);
    If StringEqual(S,T) then WriteLn('B is not involved')
                        else WriteLn('B ',B,' splits ',Q,' into ',S,' and ',T);
    If StringEqual(S,StringNot(T)) then
      WriteLn('XOR found');

    StringSplit(Q,C,S,T);
    If StringEqual(S,T) then WriteLn('C is not involved')
                        else WriteLn('C ',C,' splits ',Q,' into ',S,' and ',T);
    If StringEqual(S,StringNot(T)) then
      WriteLn('XOR found');

    StringSplit(Q,D,S,T);
    If StringEqual(S,T) then WriteLn('D is not involved')
                        else WriteLn('D ',D,' splits ',Q,' into ',S,' and ',T);
    If StringEqual(S,StringNot(T)) then
      WriteLn('XOR found');
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

