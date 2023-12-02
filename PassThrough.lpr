program PassThrough;
uses
  SysUtils, DateUtils, Windows, BitgridEngine;
const
  X = 32;  // size of the bitgrid to build
  Y = 32;
var
  Grid : TBitGrid;
  i,t : integer;
  T1,T2 : tDateTime;
  TimeElapsed, TimePerCell : Double;
  dx,dy : integer;
  src,dst : TextFile;
  c : char;
begin
  SetConsoleOutputCP(CP_UTF8);     // so we can print   µSec
  WriteLn('Creating ',x,'*',y,' bitgrid');
  Grid.Init(X,Y);

  for dy := 0 to Grid.Height-1 do
    for dx := 0 to Grid.Width-1 do
      Grid.Cells[dx,dy].lookup := BitGridEngine.PassThrough;

  T1 := SysUtils.Now;

  Assign(Src,'WhyBitGrid.txt');
  Reset(Src);
  While Not Eof(Src) do
  begin
    read(src,c);
    Grid.PutBit(0,0,(((Byte(C) SHR 7) AND 1) <> 0));
    Grid.PutBit(0,1,(((Byte(C) SHR 6) AND 1) <> 0));
    Grid.PutBit(0,2,(((Byte(C) SHR 5) AND 1) <> 0));
    Grid.PutBit(0,3,(((Byte(C) SHR 4) AND 1) <> 0));
    Grid.PutBit(0,4,(((Byte(C) SHR 3) AND 1) <> 0));
    Grid.PutBit(0,5,(((Byte(C) SHR 2) AND 1) <> 0));
    Grid.PutBit(0,6,(((Byte(C) SHR 1) AND 1) <> 0));
    Grid.PutBit(0,7,(((Byte(C) SHR 0) AND 1) <> 0));
    Grid.DoClock;
  end;
  Close(Src);

  T2 := SysUtils.Now;
  T := Grid.CycleCount;
  WriteLn('Done, ',t,' cycles executed');
  TimeElapsed := MilliSecondsBetween(T2,T1)/1000.0;
  WriteLn('Time Elapsed : ',TimeElapsed:8:3,' Seconds');
  WriteLn('Time/Layer   : ',(TimeElapsed/T):8:3,' Seconds, or ',(T*1.0/TimeElapsed):4:3,' Hz effective clock rate');
  WriteLn('Time/Cell    : ',(TimeElapsed*1000000.0/(X*Y*T)):8:3,' µSec');
end.

