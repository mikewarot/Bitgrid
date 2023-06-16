unit BitGridEngine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

Type
  Nibble =  0..15;

  TBitCell = record
    input, output : nibble;
    lookup : int64;  // 16 nibbles
  end;

  TBitGrid = object
      Cells : array of array of TBitCell;
      Height,Width : integer;
      constructor Init(Xsize, YSize : integer);
      destructor Done;
      procedure DoClock;
  end;

Const
  PassThrough = $FB73EA62D951C840;

implementation

Constructor TBitGrid.Init(Xsize, YSize : integer);
var
  x,y : integer;
begin
  SetLength(Cells,Xsize,Ysize);
  width := Xsize;
  height := Ysize;
  for y := 0 to Height-1 do
    for x := 0 to Width-1 do
      begin
        cells[x,y].input:= 0;
        cells[x,y].output := 0;
        cells[x,y].lookup := PassThrough;
      end;
end;

Destructor TBitGrid.Done;
begin
  SetLength(Cells,0,0);
end;

Procedure TBitGrid.DoClock;
var
  x,y : integer;
begin
  // do phase A, only even cells
  for y := 0 to Height-1 do
    for x := 0 to Width-1 do
      if NOT Odd(x+y) then
        with cells[x,y] do
          begin
            // compute the new output
            output:= lookup SHR (input*4) AND $0f;
            // distribute the output to the inputs of neigbors
            //   right
            cells[(x+1) mod width,y].input := cells[(x+1) mod width,y].input AND $07;
            if (output AND 2) <> 0 then
              cells[(x+1) mod width,y].input := cells[(x+1) mod width,y].input OR $08;
            //   left
            cells[(x+width-1) mod width,y].input := cells[(x+width-1) mod width,y].input AND $0d;
            if (output AND 8) <> 0 then
              cells[(x+width-1) mod width,y].input := cells[(x+width-1) mod width,y].input OR $02;
            //   down
            cells[x,(y+1) mod height].input := cells[x,(y+1) mod height].input AND $0e;
            if (output AND 4) <> 0 then
              cells[x,(y+1) mod height].input := cells[x,(y+1) mod height].input OR $01;
            //   up
            cells[x,(y+height-1) mod height].input := cells[x,(y+height-1) mod height].input AND $0b;
            if (output AND 1) <> 0 then
              cells[x,(y+height-1) mod height].input := cells[x,(y+height-1) mod height].input OR $04;

          end;

  // do phase B, only odd cells
  for y := 0 to Height-1 do
    for x := 0 to Width-1 do
      if Odd(x+y) then
        with cells[x,y] do
          begin
            // compute the new output
            output:= lookup SHR (input*4) AND $0f;
            // distribute the output to the inputs of neigbors
            //   right
            cells[(x+1) mod width,y].input := cells[(x+1) mod width,y].input AND $07;
            if (output AND 2) <> 0 then
              cells[(x+1) mod width,y].input := cells[(x+1) mod width,y].input OR $08;
            //   left
            cells[(x+width-1) mod width,y].input := cells[(x+width-1) mod width,y].input AND $0d;
            if (output AND 8) <> 0 then
              cells[(x+width-1) mod width,y].input := cells[(x+width-1) mod width,y].input OR $02;
            //   down
            cells[x,(y+1) mod height].input := cells[x,(y+1) mod height].input AND $0e;
            if (output AND 4) <> 0 then
              cells[x,(y+1) mod height].input := cells[x,(y+1) mod height].input OR $01;
            //   up
            cells[x,(y+height-1) mod height].input := cells[x,(y+height-1) mod height].input AND $0b;
            if (output AND 1) <> 0 then
              cells[x,(y+height-1) mod height].input := cells[x,(y+height-1) mod height].input OR $04;

          end;


end;

end.

