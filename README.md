Mike Warot's Bitgrid Engine in Pascal, with GUI

## What's a BitGrid?

A Bitgrid is a Cartesian Array of cells, each having 4 bits of input from neighboring cells, and 4 outputs to them. To make this universal, each cell requires 4 look up tables, each with 16 entries to match all possible input states. The easiest way to represent this is a 16 character long hex number, one digit per possibilitity.

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

  As of 6/16/2023 - benchmarks show about 60 nanoseconds/cell on a fast processor
  
Probes:
  It should be possible to force a stream of bits to a given cell input, again this is arbitrary
  
  It could be done between evaluation phases
  
  The same could be done with sensing outputs, either serial bits, or parallel across a given set of locations
  
Data Structure:
  Each cell will have 4 bits (a nibble) of input, 4 bits of output, and 16 nibbles of program
  It turns out, it's easier to just use a uint64 for the implementation, for now
  
## How to program a BitGrid - an ongoing adventure in Computer Science

  * Start from the desired output, as an pascal expression (to start)
  * Break that down into an acyclic directed graph that points towards the output, using the standard ops 
  * Break each op down into logic that works on bits, making a new, finer grained graph
  * Break each of those down until it has 4 or fewer bit inputs (ideally 3 or less, for routing)
  * Now it should be possible (if it fits) to route it into the bitgrid, using a table, for each output of a cell (4 outputs/cell in the canonical cell) a pointer to where in the graph that cell is, **How many clock cycles back from the output it is**, and then satisfy each of its inputs.  (Place the output cells first, then work down the tree)

  * Helpful other steps
    * Anywhere you can't fit all the inputs, add routing spacers
    * Anywhere there are equivalent expressions, even if the clocking is different, they can be merged, with a suitable number of spacers
  
  Then work backwards towards the input

## Status
    
As of 6/15/2023 - Code looks awful, but I can ripple bits accross a bitgrid, and it's uploaded to github
  
As of 8/8/2023 - I've built a crude benchmark, and can get a 1024 x 1024 grid simulated at 36 Hz on my desktop machine. And **I've figured out how I'm going to program it**

As of 12/3/2023 - I'm starting to plan the Programming, Debug, I/O subsystems, so I can use the BitGridEngine to in AdventOfCode, which should be quite interesting.
