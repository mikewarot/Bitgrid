program Expressor;
uses
  sysutils;
const
  _Up	 = 1; // (bit 0)
  _Right = 2; // (bit 1)
  _Down  = 4; // (bit 2)
  _Left	 = 8; // (bit 3)
var
  up, down, left, right  : Boolean;
  out_up,out_down,out_left,out_right : Boolean;
  i,X : integer;
  ZZ : Int64;

begin
  ZZ := 00;
  for i := 15 downto 0 do
  begin
    up    := (i AND _Up) <> 0;
    right := (i AND _right) <> 0;
    down  := (i AND _down) <> 0;
    left  := (i AND _left) <> 0;

    //  User stuff goes here

    out_up := up;                  // simple flow through example
    out_down := down;
    out_left := left;
    out_right := right;

    // back to normal stuff here

    x := 0;
    if out_up then inc(x,_up);
    if out_down then inc(x,_down);
    if out_left then inc(x,_left);
    if out_right then inc(x,_right);

    ZZ := (ZZ SHL 4) OR X;

  end;
  WriteLn('Result = ',IntToHex(ZZ,16));
  ReadLn;
end.

