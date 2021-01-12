---
title: OS Concept Essentials 01 - Introduction
---



# OS Concepts Essentials 01 - Introduction

*Date of creation: 2021-1-12*

This is a study guide for an OS textbook:

*[Operating System Concepts Essentials **(2nd Edition)**](http://os-book.com/)*, Avi Silberschatz, Peter Galvin, and Greg Gagne, John Wiley and Sons, New York, NY, 2013, pp. 3-54.



## What Operating Systems Do?

Computer System: hardware, OS, application programs, users

- Users view: ease of use
- System view: resource allocation/utilization

No clear definition of Operating Systems. Sometimes OS=kernel.

- Kernel: the one program running at all times on the computer.



## Computer-System Organization

- Boot: bootstrap programs
  - stored in ROM
  - initialize CPU registers, device controllers, memory, etc.
  - load OS kernel to memory
  - then wait for events
- Events: signaled by an interrupt
  - hardware: sending signal to CPU
  - software: system call
  - CPU transfer execution to the service routing upon interrupt
- Storage
  - volatile/non-volatile
  - secondary
  - principle: use only as much expensive memory as necessary while providing as much inexpensive, nonvolatile memory as possible (11)
- I/O
  - device - device controller - device driver - OS - application
  - device controller: moves data between devices and its local storage
  - device driver: understands the device controller and provides **OS** with a uniform interface **to the device**
  - device controller notifies device driver via interrupt



## Computer-System Architecture

- Single-processor systems: general + special
- Multicore/Multiprocessor systems
  - asymmetric multiprocessing/symmetric multiprocessing
  - shared memory, separate registers and cache
  - non-uniform memory access (NUMA)
- Clustered systems



## Operating-System Structure

Important aspect of OS: multiprogramming. Keep CPU busy.

- Time sharing: CPU switches so frequently that users can interact with each program while it is running, requiring
  - interactive: user is given impression that the entire system is dedicated to his use (20)
  - several jobs kept simultaneously in memory: job scheduling and virtual memory



## Operating-System Operations

Goal: to prevent one erraneous program to corrupt the whole system

- Dual/multimode
  - user/kernel: controlled by mode bit
  - privileged instructions are only allowed to be operated in kernel mode
  - system calls:
    - users use system calls to request action by the operating system
    - take form of trap
    - treated by hardware as a software interrupt
- Timer: stop programs from running too long



## Process Management, Memory Management, Storage Management

Omitted



## Protection and Security

- Protection: mechanism for controlling the access of processes of users to the resources defined by a computer system.

- Security: defend a system from internal/external attacks.

- User identifiers, group identifiers



## Kernel Data Structures

List, stacks, queues, trees, hash functions, hash maps, bitmaps



## Computing Environments

- Traditional computing
- Mobile computing
- Distributed systems
- Client-server computing
- Peer-to-peer computing
- Virtualization
- Cloud computing
- Real-Time embedded systems



## Open-Source Operating Systems

Linux is open-source, Microsoft is closed-source, Mac OS X/iOS are hybrid.

- Linux
- BSD Linux
- Solaris

