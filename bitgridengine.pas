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

  tBoolFunction = Function : Boolean;
  pBoolFunction = ^tBoolFunction;

  tBooleanInput = record
    X,Y : Integer;
    Source : pBoolFunction;
  end;

  TBitGrid = object
      Cells : array of array of TBitCell;
      Height,Width : integer;
      CycleCount   : UInt64;
      IOtest       : tBooleanInput;
      constructor Init(Xsize, YSize : integer);
      destructor Done;
      procedure DoClock;
      procedure DoPhaseA;
      procedure DoPhaseB;
  end;


Const
  PassThrough = $FB73EA62D951C840;

  LeftBits    = $1111111100000000;            LeftBit     = 8;
  RightBits   = $1100110011001100;            RightBit    = 2;
  UpBits      = $1010101010101010;            UpBit       = 1;
  DownBits    = $1111000011110000;            DownBit     = 4;
  AllBits     = (LeftBits * RightBit) or (RightBits * LeftBit) OR (UpBits * DownBit) or (DownBits * UpBit);

  Reflector   = $FEDCBA9876543210;
  Counter     = $5DA25DA25DA25DA2;

implementation

Function Wrap(N,Bound : Integer):Integer;
begin
  While N >= Bound do
    N := N - Bound;
  While N < 0 do
    N := N + Bound;
  Wrap := N;
end;

Constructor TBitGrid.Init(Xsize, YSize : integer);
var
  x,y : integer;
begin
  CycleCount := 0;
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
  IOtest.X := 3;
  IOtest.Y := 7;
  IOtest.Source := nil;
end;

Destructor TBitGrid.Done;
begin
  SetLength(Cells,0,0);
end;

Procedure TBitGrid.DoClock;
var
  x,y,next : integer;
begin
  DoPhaseA;
  DoPhaseB;
end;

procedure TBitGrid.DoPhaseA;
var
  x,y,next : integer;
begin
  // process the override list (one item for now)
  If IOtest.Source <> nil then
  begin
    If IOtest.Source^() then
      Cells[IOtest.X, IOtest.Y].input := $0f
    else
      Cells[IOtest.X, IOtest.Y].input := 00; ;
  end;

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
            next := wrap((x+1),width);
            if (output AND 2) <> 0 then
              cells[next,y].input := cells[next,y].input OR $08
            else
              cells[next,y].input := cells[next,y].input AND $07;

            //   left
            next := wrap(x-1,width);
            if (output AND 8) <> 0 then
              cells[next,y].input := cells[next,y].input OR $02
            else
              cells[next,y].input := cells[next,y].input AND $0d;

            //   down
            next := wrap(y+1,height);
            if (output AND 4) <> 0 then
              cells[x,next].input := cells[x,next].input OR $01
            else
              cells[x,next].input := cells[x,next].input AND $0e;

            //   up
            next := wrap(y-1,height);
            if (output AND 1) <> 0 then
              cells[x,next].input := cells[x,next].input OR $04
            else
              cells[x,next].input := cells[x,next].input AND $0b;
          end;
end; // DoPhaseA

procedure TBitGrid.DoPhaseB;
var
  x,y,next : integer;
begin
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
            next := wrap((x+1),width);
            if (output AND 2) <> 0 then
              cells[next,y].input := cells[next,y].input OR $08
            else
              cells[next,y].input := cells[next,y].input AND $07;

            //   left
            next := wrap(x-1,width);
            if (output AND 8) <> 0 then
              cells[next,y].input := cells[next,y].input OR $02
            else
              cells[next,y].input := cells[next,y].input AND $0d;

            //   down
            next := wrap(y+1,height);
            if (output AND 4) <> 0 then
              cells[x,next].input := cells[x,next].input OR $01
            else
              cells[x,next].input := cells[x,next].input AND $0e;

            //   up
            next := wrap(y-1,height);
            if (output AND 1) <> 0 then
              cells[x,next].input := cells[x,next].input OR $04
            else
              cells[x,next].input := cells[x,next].input AND $0b;
          end;
  Inc(CycleCount);
end; // DoPhgaseB

end.

