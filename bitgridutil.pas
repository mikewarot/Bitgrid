unit BitGridUtil;

{$mode ObjFPC}{$H+}

interface
{
  A set of tools that help the programmer deal with a bitgrid
}

uses
  Classes, SysUtils, BitGridEngine;

  function DumpCode(Code : Int64):String;

implementation

  Const
    Hex : Array[0..15] of Char = '0123456789ABCDEF';

  function DumpCode(Code : Int64):String;
  var
    i,j,k : integer;
    s : string;
  begin
    s := 'Up:';
    for i := 15 downto 0 do
      s := s + Hex[(Code SHR (i*4)) AND $01];

    s := s + ' Right:';
    for i := 15 downto 0 do
      s := s + Hex[(Code SHR ((i*4)+1)) AND $01];

    s := s + ' Down:';
    for i := 15 downto 0 do
      s := s + Hex[(Code SHR ((i*4)+2)) AND $01];

    s := s + ' Left:';
    for i := 15 downto 0 do
      s := s + Hex[(Code SHR ((i*4)+3)) AND $01];

    DumpCode := 'Code : '+s;
  end;

end.

