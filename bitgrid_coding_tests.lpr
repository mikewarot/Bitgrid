program bitgrid_coding_tests;
uses
  SysUtils, BitGridEngine, BitGridUtil;
var
  x : uInt64;

begin
  WriteLn;
  WriteLn(' AllPass code is ',IntToHex(PassThrough));
  WriteLn;
  WriteLn('The left output bits are ',IntToHex((PassThrough SHR 3) AND ($1111111111111111)));

  readln;
end.

