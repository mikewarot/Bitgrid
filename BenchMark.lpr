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
begin
  SetConsoleOutputCP(CP_UTF8);     // so we can print   µSec
  WriteLn('Creating ',x,'*',y,' bitgrid');
  Grid.Init(X,Y);
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

