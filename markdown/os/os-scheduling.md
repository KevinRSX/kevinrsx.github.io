---
title: Operating Systems - Process Scheduling
---



## Overview

Process scheduling, obviously, means that OS should schedule the running of processes. This includes:

- Which process should run
- How long the process may run
- What CPU should the process be running on
- Where to pick a process that can run

```
           run queue                                   
                                              +-------+
    +-----+-----+-----+-----+ pick_next_task()|       |
+-->|     |     |     |     |---------------->|  CPU  |
|   +-----+-----+-----+-----+                 |       |
|                                             +-------+
|                                                     
|------------------------                             
      enqueue_task()                                   
```

Above is the simplest model for single-CPU process scheduling:

- The OS maintains a run queue, in which all runable processes are stored
- By calling `enqueue_task()`, a process will be added to run queue
- CPU will pick a task to run in `pick_next_task()`