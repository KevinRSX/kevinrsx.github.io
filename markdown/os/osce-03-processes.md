---
title: OS Concept Essentials 03 - Processes
---



# OS Concepts Essentials 03 - Processes

*Date of creation: 2021-1-28*

Source:

*[Operating System Concepts Essentials **(2nd Edition)**](http://os-book.com/)*, Avi Silberschatz, Peter Galvin, and Greg Gagne, John Wiley and Sons, New York, NY, 2013, pp. 105-162.



## Concept

Process:

- Program code (text section)
- Current activity (program counter)
- Stack, heap
- Data section (for global variables)

States:

- New
- Running
- Waiting
- Ready
- Terminated

Stored in OS by Process Contral Block (PCB):

- Process state
- Program counter
- CPU registers
- CPU-scheduling information
- Memory management information
- Accounting information
- I/O status information

Threads: one process can have multiple threads



## Process Scheduling

Different queues:

- Job queue: all processes in the system (including in disks)
- Ready queue: processes in main memory and ready to execute
- Device queue: waiting for a particular I/O device



### Schedulers

Long-term scheduler: select processes from the process pool and loads them in memory for execution

- Controls the degree of multiprogramming
- Select a mix of I/O-bound and CPU-bound processes

Short-term scheduler: selects from among the processes that are ready to execute and allocates the CPU to one of them

-  Must be fast to reduce overhead

Medium-term scheduler: swapping



Context switch

- Context: represented in PCB
- State save the current state of the CPU and then a state restore to resume operations



## Operations on Processes

### Creation

- Identified by pid
- Each process can create process: process tree
- `init`: root process for all user processes `pid=1`
- Linux: `ps -el`

Upon creation, two possibilities for execution:

1. Parent continues to execute concurrently with its children (117)
2. Parent waits until some or all of its children have terminated

Two possibilities for address space

1. Child process is a duplicate of the parent process (has the same program and data as the parent)
2. Child process has a new program loaded into it (Linux `exec()`)



### Termination

- Child asks OS to delete it by using `exit()` system call
- Returns a value to its parent by `wait()`
- Cascading termination: happens in systems that disallow children to exist without parents. Terminating parents result in termination of all its descendants
- Zombie: terminated process whose parent has not called `wait()`:
  - resources deallocated upon termination, but entry in process table remains
- Orphan: process whose parent terminates without calling `wait()`:
  - Linux: assign `init` as its parent
  - `init` periodically calls `wait()`



## Interprocess Communication

- Shared-memory
- Message-passing



## Communication in Client-Server Systems

- Sockets ([Advanced Programming](http://www.cs.columbia.edu/~jae/3157/?asof=20210111))
- Remote Procedure Call (RPC) ([Distributed Systems](https://columbia.github.io/ds1-class/))
- Pipe (Advanced Programming)
  - anonymous pipe
  - named pipe

