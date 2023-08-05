program BenchMark;
uses
  SysUtils, DateUtils, Windows, BitgridEngine;
const
  X = 1024;  // size of the bitgrid to build
  Y = 1024;
  T = 100;    // how many times to run it
var
  Grid : TBitGrid;
  i : integer;
  T1,T2 : tDateTime;
  TimeElapsed, TimePerCell : Double;
  dx,dy : integer;
begin
  SetConsoleOutputCP(CP_UTF8);     // so we can print   µSec
  WriteLn('Creating ',x,'*',y,' bitgrid');
  Grid.Init(X,Y);

  for dy := 0 to Grid.Height-1 do
    for dx := 0 to Grid.Width-1 do
      Grid.Cells[dx,dy].lookup :=  Passthrough;

  Grid.Cells[Grid.Width-1,0].lookup:= $0000000088888888;
  For dx := 0 to Grid.Width-2 do
    Grid.Cells[dx,0].lookup := $FF08FF0877807780;

  For dx := 0 to Grid.Width-1 do
    Grid.Cells[dx,Grid.Height-1].lookup := $4444000044440000;  // reflect down, otherwise 0

  WriteLn('Running ',T,' full cycles');
  T1 := SysUtils.Now;
  For i := 1 to T do
    Grid.DoClock;
  T2 := SysUtils.Now;
  WriteLn('Done');
  TimeElapsed := MilliSecondsBetween(T2,T1)/1000.0;
  WriteLn('Time Elapsed : ',TimeElapsed:8:3,' Seconds');
  WriteLn('Time/Layer   : ',(TimeElapsed/T):8:3,' Seconds, or ',(T/TimeElapsed):4:3,' Hz effective clock rate');
  WriteLn('Time/Cell    : ',(TimeElapsed*1000000.0/(X*Y*T)):8:3,' µSec');
end.

