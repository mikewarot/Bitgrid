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

A+B,B,A,0

3210  A=1, B=2
0000 - False
0001 - not (a or b)
0010 - a AND (not B)
0011 - NOT b
0100 - b AND (not a)
0101 - NOT a
0110 - a XOR b
0111 - NOT (a AND b)
1000 - a AND b
1001 - NOT (a XOR b)
1010 - a
1011 - a OR (NOT b)
1100 - b
1101 - b or (NOT a)
1110 - a OR b
1111 - True

8/14/2023 - More thinking about how to proceed

Expression --> Abstract Syntax Tree --> Binary Expression Tree --> Binary Logical Expression Tree --> Routing/Placement

Expression Examples

  Output = InputA + InputB
  
AST - Abstract Syntax Tree Examples

  Assign(Output,Sum(InputA,InputB))
  
Binary Expression Tree Examples

  Output = Sum(A,B)
  
Binary Logical Expression Tree

  Sum0   = A0 XOR B0
  Carry0 = A0 AND B0
  Sum1   = A1 XOR B1 XOR Carry0
  Carry1 = (Carry0 AND A1) OR (Carry0 AND B1) OR (A1 AND B1)
   ...
  Sum(N)   = A(N) XOR B(N) XOR Carry(N-1)
  Carry(N) = (Carry(N-1) AND A(N)) OR (Carry(N-1) AND B(N)) OR (A(N) AND B(N))
  
Routing and Placement

  Use A* algorithm for actual routing
  
-----

  December 3, 2023
  Long dormant, time to collide bitgrid against advent of code
  
  Need an I/O subsystem, but it has to have some features
    everything queued, so that it can happen at each clock cycle asynchronously
	Input and output queues
	Overwrite queues
	
	StartCycle - cycle number for the start of an I/O
	EndCycle - if provided, the last cycle to listen to
	Cell, Port - which I/O channel should a bit come from?
	The queues should be ring buffers for performance
	
	Start thinking about BitGrid chip actual I/O signals/performance, etc.
	
 Need a programming/debug subsystem
    StartCycle - cycle number to write code at
	Cell address, LUT values
	Could make it async, ok... let's do that
	  This would allow reuse on the fly of sections to handle multiple tasks
	Map range of I/O or cells to display for debug, monitoring, etc.
	
 Need a logging subsystem
   Log all programming, debug, and I/O operations
	
	
 December 8, 2023
   Short term tasks:
     Build an acyclic directed graph from random choices, get it out on a text file
     Figure out how to map those to nodes in a grid, with 0 cost spacers
     Figure out how to count for delays
     Figure out how to map into bitgrid cells
     Figure out logic mapping through the above   
	 Compute delays
	 Can we do cyclic graphs?
	 Can we take a mapped graph and work backwards
	 Can we route around a bad cell?
	 Fill the bitgrid with random numbers
	   Make that into a graph
	     Remove unlinked nodes
		   Show updated grid without unlinked nodes
		   