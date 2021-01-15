---
title: OS Concept Essentials 02 - Operating Systems Structures
---



# OS Concepts Essentials 01 - Operating System Structures

*Date of creation: 2021-1-14*

Source:

*[Operating System Concepts Essentials **(2nd Edition)**](http://os-book.com/)*, Avi Silberschatz, Peter Galvin, and Greg Gagne, John Wiley and Sons, New York, NY, 2013, pp. 3-54.



## Operating System Services

User's perspective:

- User interface
  - batch interface
  - command line interface
  - graphic user interface
- Program execution
- I/O operations
- File-system manipulation
- Communication
  - message passing
  - shared memory
- Error detection

System's perspective:

- Resource allocation
- Accounting
- Protection and security



## User and Operating System Interface

Command execution approaches for CLI:

- Command interpreter itself contains the code to execute the command (58)
- Implements most commands through system programs and call them through shells
  - commands are used to identify files to be loaded into memory and executed



## System Calls

System call: interface to the services made available by an operating system

Example of read and write (62):

- Heavy use of system calls
- Users only use system call APIs. Programming languages provide system-call interfaces that link to the actual system calls.
- Passing parameters to the operating system:
  - registers
  - a block in memory whose address is stored in register
  - pushed onto the stack and popped by OS



## Types of System Calls

- Process control
- File manipulation
- Device manipulation
- Information maintenance
- Communications
- Protection



## System Programs

Divided into:

- File management
- Status information
- File modification
- Programming language support
- Program loading and execution
- Communications
- Background services



## Operating-System Design and Implementation

### Design Goals

Basic: Hardware and system type

Beyond basic: user goals and system goals



### Mechanisms and Policies

Mechanism: how

Policy: what

- Generally, mechanism should be insensitive to changes in policy
- Two approaches:
  - implement only a basic set of primitive building blocks
  - encode policies in the system to enforce a global look and feel



### Implementation

Benefit of higher level languages: easy to port



## Operating-System Structure

### Simple Structure

MS-DOS - No well-defined structures:

- Application programs can access basic I/O routines
- Vulnerable to errant or malicious programs

UNIX: kernel + system programs

- functionalities are combined
- difficult to debug and maintain

Pro: efficient, low overhead



### Layered Approach

- Layer 0: hardware,  Layer 1: user interface
- Layer M calls M - 1 and called by M + 1
- Each layer can be implemented only with operations provided by lower-level layers
- Simple to construct and debug
- Difficult to define the various layers



### Microkernels

Removing all nonessential components from the kernel and implementing them as system and user-level programs (81)

- Main function: provide communication between the client program and the various services that are also running in user space
- Client program and services communicate indirectly by exchanging messages with the microkernel

Pros:

- Makes extending the operating system easier
- Resulting operating system is easier to port from one hardware design to another
- Provides more security and liability

Con:

- Bad performance due to increased system-function overhead



### Modules

Dynamically loading kernel modules instead of recompiling the whole kernel

- vs layered system: more flexible (any module can call any other module)
- vs microkernels: more efficient (do not require message exchanging)



## Operating-System Debugging

Omitted



## Operating-System Generation

Omitted



## System Boot

Bootstrap program/loader locates the kernel and loads it into main memory

- Run diagnostics
- Initialization (registers, device controllers, etc.)

Firmware = ROM + EPROM, slower than RAM

Large operating system

- Bootstrap: firmware
- OS: disk

