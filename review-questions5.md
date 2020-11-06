### What is the lineage of an RDD?
- RDDs must be resilent. Lineage means it stores information about it's parent and how it was built so it can remain in service and acheive fault tolerance. It points to the data and the transformation of the data.

### How can we see the Lineage?
- We can see a lineage of an RDD by making a call to .toDebugString. 

### What do the indentations mean in the printed lineage?
- The indents represent the logical steps of each stage of our execution. 

### What is the logical plan?  The physical plan?
- The logical plan is what we see when we look at lineage. The physical plan is the actual stages and tasks.

### How many partitions does a single task work on?
- A single task can work on one at a time.

### What’s the difference between cluster mode and client mode on YARN?
- Cluster mode is when the driver program in Spark runs inside the ApplicationMaster in YARN.
- Client mode is when the driver program runs outside of YARN and communicates with the ApplicationMaster. 

### What is an executor?  What are executors when we run Spark on YARN?
- Our executors are like worker nodes and they appear as containers on YARN.

### What is AWS?
- AWS stands for Amazon Web Services. It is a cloud service platform that offers a varitey of services. For example, running FTP servers like S3. It also provides platforms as a service.

### EC2?
- Elastic Cloud Computing is the virtualization of their servers. This is feature that provide virtual machines with virtual resources that compute data for us. 

### S3?
- S3 is Simple Storage Service. It's essentially an FTP server from Amazon.

### EMR?
- EMR is Elastic MapReduce is a virtualized Hadoop cluster built upon an EC2. The resources can be expanded or reduced as needed and on demand.

### What does it mean to run an EMR Step Execution?
- This is where the clustor is create, runs one or more steps of a submitted job, and then terminates. This option saves costs by using EMR on demand.

### What are some benefits to using the cloud?
- Using virtualized computer power and storage without having to maintain it
- Scalable on-demand, can be increased/decreased on demand which saves money
- Data Loss becomes a minimal issue
- Availibility 99.99%

### What is the Spark History Server?
- The Spark History Server keeps track of all the Spark jobs executed and gives you a Directed Acyclic Graphic as a visual.

### What does it mean to “spill to disk” when executing spark tasks?
- Whenever you're caching something in RAM, if it's too large the excess gets written to disk instead of being deleted.

### Why can Spark skip entire stages if they are the same between jobs?
--------- STILL NEEDS AN ANSWER -----------
### What is a reasonable number of partitions for Spark?
- At least twice as many cores on the machine. 

### When during a Job do we need to pay attention to the number of partitions and adjust if necessary?
- During a Shuffle stage and at the beginning of the job before execution

### What is spark.driver.memory?  What about spark.executor.memory?
- What are some steps we can take to debug a Spark Application?

### What is a Spark Application? Job? Stage? Task?
-
- When we cache an RDD, can we use it across Tasks? Stages? Jobs?
  - NOTE: Adam had this question wrong in Wed notes! it's fixed now
- What are Persistence Storage Levels in Spark?
  - Some levels have _SER, what does this mean?
  - Some levels have _2, what does this mean?
  - If the storage level for a persist is MEMORY_ONLY and there isn't enough memory, what happens?
- What is the storage level for .cache()?