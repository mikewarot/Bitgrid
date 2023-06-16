Mike Warot's Bitgrid Engine in Pascal, with GUI

Started (finally!) 6/12/2023

A bitgrid is a Cartesian Array of cells, each having 4 bits of input from neighboring cells, and 4 outputs to them. To make this universal, each cell requires 4 look up tables, each with 16 entries to match all possible input states. The easiest way to represent this is a 16 character long hex number, one digit per possibilitity.

Thus, a compact display of the program contents of a bitgrid might be a table of such entries

the choice of bit order from neighbors is arbitrary, so we pick one here

  Up	- 1 (bit 0)
  Right	- 2 (bit 1)
  Below	- 4 (bit 2)
  Left	- 8 (bit 3)
  
So, a cell programmed to repeat its inputs back to its neighbors would be   FEDCBA9876543210
a cell programmed to pass through all inputs to the next cell would be      FB73EA62D951C840

this should be the default for all cells, or all zeros, I'm not sure yet

Evaluation:
  Cells will be evaluated in two phases, to avoid race conditions, and make it easier to understand, in the manner of coloring a chessboard, starting with 0,0
  
Probes:
  It should be possible to force a stream of bits to a given cell input, again this is arbitrary
  
  It could be done between evaluation phases
  
  The same could be done with sensing outputs, either serial bits, or parallel across a given set of locations
  
Data Structure:
  Each cell will have 4 bits (a nibble) of input, 4 bits of output, and 16 nibbles of program
  It turns out, it's easier to just use a uint64 for the implementation, for now
  
  
6/15/2023 - Code looks awful, but I can ripple bits accross a bitgrid
  
6/16/2023 - MAW - First benchmarks
  
Creating 1024*1024 bitgrid
Running 100 full cycles
Done
Time Elapsed :    8.682 Seconds
Time/Layer   :    0.087 Seconds
Time/Cell    :    0.083 µSec

How far can I optimize this?
First pass, saving the address of the next cell, and only doing an OR or an AND, instead of both
Creating 1024*1024 bitgrid
Running 100 full cycles
Done
Time Elapsed :    5.840 Seconds
Time/Layer   :    0.058 Seconds
Time/Cell    :    0.056 µSec
