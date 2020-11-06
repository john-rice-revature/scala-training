MapReduce Whitepaper:

- What does the Map part of MapReduce take in?  What does it output?
### Takes an input key/value pairs and produces/generates a set of intermediate key/value pairs. 
### Maps are the individual tasks that transform input records into intermediate records. The transformed intermediate records do not need to be of the same type as the input records.
### A given input pair may map to zero or many output pairs.
### This is useful for processing and generating large data sets. The MapReduce programming model runs on a large cluster of commodity machines and is highly scalable.   

- What about the Reduce part of MapReduce?
### It Accepts an intermediate key 'I' and a set of values for that key. It merges together these values to form a possibly smaller set of values. Typically just zero or one output value is produced per Reduce invocation.

- What is GFS?                
### Google File System, a propriety distributed file system. It has one master node and multiple chunk servers. Chunk servers store fixed-size chunk opf data is given a 64-bit lavel by the master node. 

- How many replications of data does GFS provide by default?  Block size?
### GFS Provides 3 replications of data and Default Block Size = 64 MB
### HDFS, Hadoop Distributed FileSystem Default Block Size = 128MB

- What is the optional Combiner step?
### The optional combiner step conducts partial merging of this data before it is sent over the network. This combiner function is executed on each machine that performs a map task.
### The same code may be used to implement both the 'Combiner' and 'Reduce' functions but the difference is how the MapReduce library handles the output of the function.
### The output of the *combiner function* is written to an intermediate file that is then sent to the reduce task while the *reduce function* is written to the output file. 
### Partial combining significantly speeds up certain classes of MapReduce operation.


- Why is the Combiner step useful in the case of a wordcount?
### Where theres a significant repetition of intermediate keys produced by the map task, a combiner task can be very useful. A combiner task is a reduce function that takes place before it reaches the official reduce function. This happens before the intermediate file save and well before the reduce workers. 

- Is the Master fault tolerant?  Why or why not?
### The master is not fault tolerant but it doesn't have a very high chance of fault or failure. Although you can have a secondary and stand by master.

- Are the workers fault tolerant?  Why or why not?
### Yes, workers are fault tolerant. They can be replaced by the name node and used to completely re-work the tasks they were originally submitted. Workers will fail more often than masters, hence, why they're built to be fault tolerant. 

- What happens to the output of completed Map tasks on failed worker nodes?
### This data is discarded as a workers output is stored on the failed machine so it is inaccessible. This same data has been replicated though. It will then be assigned to another worker to then be completed.

- What is Data Locality?  Why is it important?
### Data Locality means ... It is important because when running task/deploying workers you want to be as close to the disk space where the data is stored. This saves resources and reduces the bandwidth being used. 

- How does MapReduce increase processing speed when some machines in the cluster are running slowly but don't fail?
### If some machines are lagging on a cluster, the master will then create a new worker and duplicate the processing. Whichever worker finishes first will be used. 

- What does a custom partitioning function change about how your MapReduce job runs?
### There exists a default partitioning function. The custom partitions lets you explicity delcarew how many reduce split/tasks you have as well as map.

- What is a hashcode?  How are hashcodes used in (default) partitions?
### A hashcode is a fixed-size integer

### A hashcode is used to calculate a value upon which data is divided into partitions. The default partitioning function is a hash key mod R, which takes the hash of a key and takes the remainder of the division by the number of Reduce tasks/output files desired.  

- What does it mean that side effects should be atomic and idempotent?
### Idempotent is a property applied to operations which can be applied multiple times with the same result. 

- What are Counters for?
### Counters are a way to count occurences of events that happen during a MapReduce job. The master counts values from the different machines and will return these values to the user when the operation is completed

- Where do Map tasks read from?  Write to?
### Map tasks are read from the input split files and are written to disk as a intermediate task/file.

- Where do Reduce tasks read from?  Write to?
### Reduce tasks are read from disk from the intermediate files and write to the output files

- Which of the above I/O steps would you expect to take the longest?
### Transferring across a network would take the longest in terms of I/O. When accesing local data this is the fastest I/O step you can commence.

- Walk thorugh a MapReduce job that counts words in the sentence : "the quick brown fox jumped over the lazy dog"
  - How does this work for 2 input blocks (so 2 Map tasks) and 1 reduce task?  What if we had 2 Reduce tasks?

- What was the "Hadoop Explosion"?
### Where many many specific tools were created to use MapReduce in different contexts. Originally MapReduce was a Google thing. Hadoop turned this into an open-source project with different tools that help with this process.

- What about CDH?
### Cloudera Distribution Hadoop is what CDH stands for. A product that bundled these tools together alongside cluster management tools.

- What are some differences between hard disk space and RAM?
### Hard Disk Space is for long-term storage and is NOT forgotten when the computer is shut down, while, RAM is for short term and is forgotten when the computer is shut down.

- What is a VM? (short)
### Virtual Machine

- What is AWS? (short)
### Amazon Web Services

- What is/was Unix?  Why is Ubuntu a Unix-like operating system?
### An OS originally developed at Bell Labs in the 70s. Unix became popular among hobbyists and academics. It was originally sold open source. Ubuntu is a unix-like system because its build on the Linux kernel and GNU OS and tools. Linux distributions were created to provide free and open source software in light of the UNIX licensing/copyright.

- Know basic file manipulation and navigation commands in Unix:
  - ls -al
  ### ls -al will list all files in a directory, their permissions and their hidden files. This lists all files in a LONG format.

  - cd
  ### This command is to change directories.

  - pwd
  ### Print working directory, prints your current directory

  - mkdir
  ### This command is to make directory.

  - touch
  ### The touch command is used to create a 0-byte file.

  - nano
  ### This is a Unix text editor. 

  - man 
  ### This mean manual. The help function in Ubuntu. Also can use --help after the command.

  - less
  ### A way to display a files content 10 lines at at time.

  - cat
  ### This is short for concatenate. Create single or multiple files, view contain of a file, concatenate files and redirect output in a terminal. Prints content to a screen without pagination.

  - mv
  ### This is to move a file or directory to another directory. 

  - cp
  ### This is to copy a file to a directory. 

  - rm
  ### This is to remove a file or directory. To remove a directory using -r is a recursive command that removes the directory and it's content. 

  - history
  ### Displays the last commands or string of commands entered into the command line of Ubuntu. This is a good way to track what you've just done. 

- What's the difference between an absolute and a relative path?
###  A relative path has a ~ in front of it. A relative path are where things are relative to where you are. An absolute path is where things are from the root location. 

- How do permissions work in Unix?
### They work in three sections: Owner, Group, User. In each section there are three permissions that can be assigned: read, write, execute.

- What are users, what are groups?
### Linux uses Role-Based Access Control. Users are assigned to groups and groups are given permissions. These permissions are basically read, write and Execute.

- How does the chmod command change file permissions?
### There are three numbers in chmod commands. 4 is read, 2 is write, 1 is execute. Each number in order is for Owner, Group, User. 

- What is a package manager? what package manager do we have on Ubuntu?
### Apt is our package manager in Ubuntu. It stands for Advanced Packing Tool. It allows us to update and upgrade our packages and install applications. 

- What is ssh?
### Secure Shell that likes us shell into a server or another machine under an encrypted fashion. 

- Be able to explain the significance of Mapper[LongWritable, Text, Text, IntWritable] and Reducer[Text, IntWritable, Text, IntWritable]

- What needs to be true about the types contained in the above generics?
### The input to the mapper must be relative to the data types that are being process. The output generics of the mapper need to be the same as the Reducers input. 

- What are the 3 Vs of big data?
### Variety = this data can be in different formats and types
### Velocity = data is constantly being created, like on line content
### Volume = massive quantities of data usually more than 1 machine can store

- What are some examples of structured data?  Unstructured data?
### Unstructured data is raw text input, jpeg or audio files.
### Semi-Structured are like JSON, HTML or CSV files
### Structured Data would be record or tables in a Database

- What is a daemon?
### A long running process. In Ubuntu, these daemons are marked with a ".d" at the end.

- What is data locality and why is it important?
### Data Locality means the strategy of taking data proximity into account when scheduling tasks. It is important because when running task/deploying workers you want to be as close to the disk space where the data is stored. This saves resources and reduces the bandwidth being used. 

- How many blocks will a 200MB file be stored in in HDFS, if we assume default HDFS block size for Hadoop v2+?
### 2 Blocks, Default HDFS block size is 128MB

- What is the default number of replications for each block?
### There are 3 replications as default for each block

- How are these replications typically distributed across the cluster?  What is *rack awareness*?
### 2 on the default rack, while the other 1 will be distributed on other racks. In this case we're looking for a balance of reliability and network traffic. Rack awareness is a default strategy that makes those decisions knowing how your datacenter is set up in order to achieve a balance of reliability and network traffic.

- What is the job of the NameNode? What about the DataNode?
### The job of the NameNode is to act as a master. It keeps an image of your DFS. It knows the names and directories and it knows wehrre to find their contents on the cluster BUT it doesn't store any actual data. 

### The job of the DataNode is known as the worker. There is one per machine in the cluster in a typical deployment. The datanode should also check-in with the NameNode giving it's status. The DN has the responsibility. The DN keeps actual data + communicates its status to the NN. Doesn't know anything about the actual files its storing on the file system.

- How many NameNodes exist on a cluster?
### One or possibly 3 (which would be the secondary and stand-by NNs). The NN is considered the master and has a very low chance of faults.

- How are DataNodes fault tolerant?
### Their fault tolerance is handled by the NN. Their data is also replicated across the cluster. If the DN goes down, the replicated data will be distrubuted to the remaining DNs. 

- How does a Standby NameNode make the NameNode fault tolerant?
### The NN creates a log of all the tasks/actions its taking. The stand-by NN copies the main NN is doing, so if the main NN goes down the stand-by NN can immediately step in and resume where the main NN failed. 

- What purpose does a Secondary NameNode serve?
### It periodically keeps backups of the NN metadata, once every hour. It cannot step in for the NN but it makes backup copies of metadata files to avoid catastrophic data losss.

- How might we scale a HDFS cluster past a few thousand machines?
### We would use HDFS Federations to create multiple linked HDFS clusters, each with its own NameNode.

- In a typical Hadoop cluster, what's the relationship between HDFS data nodes and YARN node managers?
### HDFS data nodes hold the actual data while the YARN Node Manager manages the actual resources used to perform computation. It reports to the ResourceManager on progress/health. 

- When does the combine phase run, and where does each combine task run?
### The combine phase runs the intermediate key/values from the mapper before it reaches the reducer. The combiner task runs in between the map phase and the intermediate files and before the reduce phase. 

- Know the input and output of the shuffle + sort phase.
### It's a phase that all of the mapper outputs are correctly sent to the proper reducer output. 

- What does the NodeManager do?
### The NodeManager manages bundles of computing resources called containers and reports to the RM on progress/health

- What about the ResourceManager?
### One per cluster, It is responsible for providing resources for jobs. Resources are RAM, CPU, disk, network... the necessities to do tasks like MapReduce.

  - Which responsibilities does the Scheduler have?
  ### Actually allocating containers based on requests made to it. It doesn't know much about computations done on those or the larger jobs.
  - What about the ApplicationsManager?
  ### Accepts job submissions and creates the ApplicationMaster for each submitted job. Also resposible for fault tolerance of the ApplicationMasters. 
- What is an ApplicationMaster?  How many of them are there per job?
### An ApplicationMaster is what requests resources for each task in the job from the scheduler. One AM per job.

- What is a Container in YARN?
### A container in YARN are considered bundles of resources. 

- How do we interact with the distributed filesystem?
### bin/hdfs dfs 

- What do the following commands do?
  - hdfs dfs -get /user/adam/myfile ~
  ### Gets from the DFS and puts to Local file system

  - hdfs dfs -put ~/coolfile /user/adam/
  ### Put takes from the local file system and puts in the DFS

  Input of sort and shuffle faze - intermediate pair
  output is the sorted data that will be sent to the reducer
  a, red
  b, blue
  a, blue
  c, green
  a, (red, blue)

