program bitgrid_coding_tests;
uses
  SysUtils, BitGridEngine, BitGridUtil;
var
  x,y,z : uInt64;
  i,j,k : integer;

begin
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

