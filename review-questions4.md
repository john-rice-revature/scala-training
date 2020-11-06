### Hive

#### What is Hive?
- A data warehouse that's built on Apache Hadoop which provides a SQL-like way of interacting with files stored in HDFS. It allows us to query and centralize data in a warehouse where operations & functions like MapReduce can be executed. 

#### Where is the default location of Hive's data in HDFS?
- The default location for Hive's data is /user/hive/warehouse. This location is where the databases are stored. 

#### What is an External table?
- An external table is a table that is not managed by Hive. This means Hive also does not have control of the database. It can't guarantee 
the structure or behavior it may have in the Hive warehouse. If deleted out of Hive, it only deletes the metadata. The biggest advantage of an external table is that it protects again accidental "drops".

#### What is a managed table?
- A managed table is a table that Hive controls and can guarantee the structure of the data. If a managed table is deleted out of Hive, both the metadata and actual data since Hive is what manages the table.

#### What is a Hive partition?
- A Hive partition help separate and organize the data in a table. A partition is organized by a column or multiple columns that are frequently queried. It's important to big data because it makes processing more efficient. Low cardinality

#### Provide an example of a good column or set of columns to partition on.
- You'd want to partition on a low cardinality column(s). For example, If you have a customer database, which had columns of Name, SSN, City and State. You'd want to pick State or Name for example. This has low-cardinality and provides a reasonable amount of data for that partition. 

#### What's the benefit of partitioning?
*- The benefit of partitioning provides efficient processing of big data. 

#### What does a partitioned table look like in HDFS?
- When you partion on a database to a table, it is stored like a folder in the directory of the database. It is important to understand that a partioned table has it's own directories in that database while a bucket will split these type portions of the database into files stored in that database.

#### What is a Hive bucket?
- Is a subset of data but is different from partitions. With high cardinality in mind, we want to create buckets that aren't too important to our analysis. This helps us split up data into smaller, representations of a larget dataset. 

#### What does it mean to have data skew and why does this matter when bucketing?
- If you bucket using low-cardinality columns you take the chance to skew the data in your small dataset. When bucketing, you want a solid representation of your larger dataset so using a column with more uniqueness to provide random, non-patternistic nature to your bucket.

#### What does a bucketed table look like in HDFS?
- A bucket is going to appear as files in our HDFS. A partition will view a directory. 

#### What is the Hive metastore?
*- The Hive metastore stores the metadata, the schema, where it's located on the HDFS and database type and configuration of your Hive warehouse. 

#### What is beeline?
- Beeline is the replacement for HiveCLI. Beeline is the tool we use to query and interact with databases, and run HQL queries that, in return runs MapReduce functions. It also manipulates data in the Hive warehouse. Beeline connects directly to HiveServer 2 which provides server functionality and more features.
- A beeline is a command line interface that allows for querying of a hive database via HQL queries. 



### Hive Syntax questions: How do we....

#### create a table?
- Create Table tablename_db;

#### load data into a table?
- LOAD DATA INPATH '/path/to/file' INTO TABLE my_db; Use LOCAL to provide a path locally on your machine.

#### query data in a table?
- SELECT * FROM table;

#### filter the records from a query?
- WHERE statements, Order By statements and Limit statements

#### group records and find the count in each group?
- Group By groups rows that have the same value into summary rows
- Count(*) statement counts the columns that you specify
- SELECT COUNT(*) title FROM table GROUP BY title;
 
#### write the output of a query to HDFS?
- INSERT OVERWRITE DIRECTORY '/user/hive/output' SELECT * FROM table;

### specify we're reading from a csv file?
- FIELDS TERMINATED BY ','



### Spark : Cluster Computing with Working Sets

#### What does Cluster Computing refer to?
- Cluster Computing is the process of running a computation across a cluster. Spark uses a driver program that communications with the executors across the cluster. 

#### What is a Working Set?
- A dataset that is stored in memory so that analysis, processes and computations can be run on it efficiently. This data set is stored in RAM using .cache and .persist.

#### What does RDD stand for?
- Resilient Distributed Dataset

#### What does it mean when we say an RDD is a collection of objects partitioned across a set of machines?
- An RDD is broken up in partitions that are broken up across machine. It a fault tolerent dataset that gets partitioned across a cluster. 

#### Why do we say that MapReduce has an acyclic data flow?
- Acyclic means without cycles. MapReduce goes through a serious of phases and produce an end output. It's particularly linear in this fashion.

#### Explain the deficiency in using Hive for interactive analysis on datasets.  How does Spark alleviate this problem?
- With Hive you can't run an iterative set of processes on a dataset. With Spark, once the RDD is instatiated, you can continuously run proccesses on a dataset as the RDD remains in memory for speed and easy access until they are removed when you're done using them.

#### What is the *lineage* of an RDD?
- RDDs must be resilent. Lineage means it stores information about it's parent and how it was built so it can remain in service and acheive fault tolerance and remain working when requested. It points to the data and the transformation of the data.

#### RDDs are lazy and ephemeral.  What does this mean?
- RDDs are lazy because it don't touch or read data until it has to. RDDs are ephemeral because they're removed from memory once they're done being used.

#### What are the 4 ways to construct an RDD?
- Parallelizing a Scala collection
- Transforming a previous dataset
- From a file
- Changing the persistence of an RDD - adding a .cache or .persist

#### What does it mean to transform an RDD?
- It means that you perform some type of function or some operation that changes the RDD. For example, adding two to every element in a list would instatiate a new RDD via transformation.

#### What does it mean to cache an RDD?
- This means you .cache an RDD to ensure it persists once it's completed work. This means it's no longer ephemeral and it stay in memory.

#### What does it mean to perform a parallel operation on an RDD?
- An *action* is something that causes your RDD To actually be evaluated to produce or have some effect. Reduce, collect, foreach are forms of parallel operations.
- We partition our RDD across a cluster, which is ultimately a collection of read-only objects. On each node we contain only a partition of the RDD - we perform an operation. So there for the operations performed across a cluster create parallelized operations. 

#### Why does Spark need special tools for shared variables, instead of just declaring, for instance, var counter=0?
- Spark uses Scala closures. Scala closures are functions that operate on variables outside of their scope. Broadcast variables and accumulators are tools we use to we use to escape these. These are tools used outside of closures and they are global variables. 

#### What is a broadcast variable?
- Are useful to pass global read-only values to each worker/task efficiently. Broadcast variable are immutable.

#### What is an accumulator?
- An accumluator it exists to deal with scope issues with each worker. It also has it's own local runtime. This exists application-wide so workers can communicate values to it.

#### How would the Logistic Regession example function differently if we left off the call to .cache() on the points parsed from file?
- .cache() would make sure the points are left in memory so when we need to iterate over those points we can, without having to recalculate these points. This saves processing time and makes analysis more efficient.


#### RDD
= A resilent Distributed Dataset

#### Action
- An action is a function call that acts upon our RDD and thus instantiates our RDD. Our RDD is lazy until this action is initiated.

#### Transformation
- Spark transformation is a function that produces a new RDD from the existing RDDs. It takes an existing RDD as input and produces one or more RDD as an output. 

#### lineage
- Lineage refers to the history of transformations on an RDD. This lets us easily reproduce lost partitions. It points to the data and the transformation of the data.

#### cache
- Caching persists our RDD in memory. We call .cache on an RDD to do so. This makes it easy to reiterate upon instead of calling the RDD wasting efficiency. 

#### lazy evaluation
- Data is not read until a action is performed. A Lazy evaluation is data that is not actually read or acted upon until an object has an action called upon it.

#### broadcast variable
- A global, read-only, immutable variable that is passed to all workers in a Spark job. 

#### accumulator
- A mutable global variable that is sent to each node and the passed to the program driver to be aggregated. Throughout this process the accumulator is potentially being changed during this process.

#### What are some transformations available on an RDD?
- A Spark transformation is a function that produces a new RDD from the existing RDDs. It takes an existing RDD as input and produces one or more RDDs as an output. 
- There are narrow transformations where all the elements are required to compute the records in a single partitions of a parent RDD live in the same parititon.
- Wide Transformation are when all the elements that are required to compute the records may live in many partitions of parent RDD. 
- Examples would be the: map(func), flatMap(), filter(func), mapPartitions(func), union(dataset), reduceByKey()


#### What are some actions available on an RDD?
- .Reduce, .collect, .take, .foreach can be considered actions that can be ran on an RDD. 

#### What is a shuffle in Spark?
- .ReduceByKey, .SortBy, .RePartition are used like MapReduce, which will shuffle our data into proper partitions. So once this data is called upon, the correct partitions are available for output.

#### What's the difference in output between MapReduce wordcount in Hadoop and .map followed by .reduceByKey in Spark?
- These two technologies both perform the same transformations. The differences between the two is: when you call .map and a .reduceByKey in Spark is not actually calling an action upon an RDD. But once you call a .collect the action instatiates the RDD and produces an outcome. This would give you the same result as a MapReduce outcome. 

#### Why should we be careful about using accumulators outside of an action?
- Using an accumulator outside of an action can be dangerous because if that action fails, or a speculative execution is conducted can ultimately cause redundent values to the accumulator. This means that re-excuted actions can be added to the accumulator more than once.

#### What is the closure of a task?  Can we use variables in a closure?
- A closure is a function in Spark that is passed to a worker node. This is essentially an operation. Since closures are designed to work on a variables outside of their scope, if we give it a variable inside of it's scope it won't actually be change, updated or returned.

#### How can we see the lineage of an RDD?
- We can see a lineage of an RDD by making a call to .toDebugString. 


.cache() stores in RAM. persist() stores in RAM plus disk.
- cache() = ram
- persist( ) = ram then disk
- save() = disk
