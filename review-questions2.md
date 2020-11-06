- How do we specify dependencies using sbt?
### You state the dependancies in the libraryDependencies section of the build.sbt file.

- Why do we use databases instead of just writing to file?
### Databases provide long term storage and the functionality to access data frequently and efficiently. Data in a file is stored sequentially without any useful structure. Databases provide additional functionality. 

- What is a port number?
### A port number is a way to identify specific processes to a network message thats being forwarded to a server.

- What's the default port for MongoDB?
## The default port is 27017

- What is a database?
### An organized, sometimes relational application that provides storage for long-term data.

- What is a collection?
### A database in MongoDB can contains multiple collections. Collections hold together documents. Collections are used to organize documents of similar types. 

- What is a document?
### Documents are the level that actually contain the data in the structuring of MongoDB. Databases hold collections. While collections hold documents where are the actual data.

- What rules does Mongo enforce about the structure of documents inside a collection?
### Out of the box, there are no restrictions on what different types of documents can be placed in a collection. So in a single collection, we can put different types of data inside of those documents.

- What is JSON?
### An object with properties (key-value pairs) that demonstrates JSON-specific data types.

- What are JSON data types?
## JSON data types are: String, Number, Object, Array, Boolean, Null, Value and Whitspace

- What is BSON?
### BSON is binary JSON. BSON is a data format like JSON but it accepts more data types in it's structure. It makes our document an arbitrary object with fields.

- What are some of the data types included in BSON?
### RegEx, Binary Data, ObjectID, Date, DBPointer, Javascript, Timestamp, Double and a lot more.

- What is an ObjectId?
### An ObjectID is a unique identifier for a single document. It is a number that is considered arbitrary. It is contained in a special "_id" field that all documents have. 

- What is the _id field for in mongo?
### The "_id" field is used to store the ObjectID of a document.

- What does find() do?
### The find() query instructs MongoDB to find all documents in a collection.

- What is a filter in a mongodb query?
### The filter query gives you the option to filter through documents and their fields. Using the index is a faster filter than checking every document.

- What are some examples of filters?
### Using the eq, gt, gte, lt, lte, ne, and more. You would use parenthesis and declare on the left side the field type you're searching for then the actual data inputed in the document of which you are looking for

- What do sort and limit do?
### The sort method sorts the result in a certain order given by the user. Results like ascending and descending are expected from the Sort method. A limit method limits the number of documents it provides in it's results. 

- What is a projection in a mongodb query?
### A projection will limit the amount of data that MongoDB sends to application. Queries typically will return all fields in a matching document. With a projection, you can retrieve only the data you care about.

!--- What is multiplicity?  Examples of 1-to-1, 1-to-N, N-to-N?
### Multiplicity is an attribute of a relationship that specifies the number of instances that can be associated with instances of another type.
### An example of 1 to 1 would be one person having one birth certificate or one social security number.
### An example of 1 to N would be each movie has a director but a director can have multiple movies.
### An example of N to N would be Songs and playlists. Each song can appear in many playlist and each playlist can contain many songs.

- What is cardinality?
### Cardinality is the size of a set. Cardinality is slightly different than multiplicity in that it takes in data modeling and database query optimization. Data modeling - Cardinality between two tables is the numerical relationship between rows of one table and rows of another table.

- What are some advantages of handling document relationships by embedding documents?
### Two documents that are modified at the same time should be embedded. Embedded documents are atomic and can be modified at the same time. Atomicity is part of ACID where all operations occur or none occur. It is also indivisible and irreducible. Embedded documents also provides access efficiently to two related objects in a database.

!--- Disadvantages of the same?
### Disadvantages of embedding documents 

!--- What about handling document relationships using references -- advantages and disadvantages?
### References are when a document has another documents ObjectID in it. This creates an embeded object or an array of references. Disadvantages would be that references are non-atomic. 

- What is an Index?  
### An index is like a book. It lets us find a document based on one or more of their fields. This is quicker than iterating over multiple documents.

!--- What advantages does creating an Index give us? Disadvantages?
### The advantages of a Index lets us find documents and the fields in documents faster. Using the _id property to find a document is quicker. We can also create indexes on fields which make it faster to find specific data inside a document. Disadvantages are with every add/modification of a document it increases the time to process.

- What is CRUD?
### CRUD stands for Create, Read/Retrieve, Update and Delete. This is in respects to an operation a database.

- Some example CRUD methods for Mongo? (The Scala methods mostly match mongo shell syntax)
### deleteMany(), find(), replaceOne(), insertMany(), and more...

- What is a distributed application?  A distributed data store?
### A distributed application is two or more databases located on different sites on the same network. This means the databases have multiple phyisical locations and the processes are distributed between them. A distributed data store is data stored on more than one node that's replicated across the network. 

- What is High Availability? How is it achieved in Mongo?
### High Availability is a property of a system that means the system is almost always available/functional. This is achievable using a replica set. A replica set is at least 3 instances of our database running in a distributed manner. One replica can be primary while the others are considered secondary. 

- What is Scalability? How is it achieved in Mongo?
### Scalability is a property of a system that means the system can exapnd to deal with increased demands. This can be in respect to the network traffic, the amount of data stored and the amount of processing required...

- Explain replica sets and sharding
###  A replica set is at least 3 instances of our database running in a distributed manner. One replica can be primary while the others are considered secondary. Sharding is way to scale a database. In Mongo, we use shard collections. A shard collection is split into multiple pieces called shards. Each shard will be responsible for only a subset of data in the collection. 

- What is the CAP Theorem?
### CAP stands for Consistency, Availibility and Partition Tolerance. The CAP theorem says that we can only ever have 2 of the 3 properties guaranteed in a distributed data store. 
### - Consistecy is every read receives the most recent write OR an error.
### - Availability is every request recieves a non-eror response. It many not contain the most recent write though.
### - Partition Tolerance is the system continues to operate despite some network failfure. 
### When there are no network problems, every data store gives us consistency and Availability.  If a network fails we then need Partition Tolerance. This means we give up either consistency or availability to make this happen.

- What does CAP mean for our distributed data stores when they have network problems?
### When there are no network problems, every data store gives us consistency and Availability.  If a network fails we then need Partition Tolerance. This means we give up either consistency or availability to make this happen.

- What does it mean that an operation or transaction on a data store is atomic?
### If an operation or transaction is atomic, it means it is indivisible or irreducible. Atomicity is part of ACID which is Atomicity, Consistency, Isolation and Durability. 

- In Mongo, are operations on embedded documents atomic?  What about operations on referenced documents?
### Modifications on embedded documents are considered atomic. Operations on referenced documents are not considered atomic.

- What does RDBMS stand for?
### RDMBS is Relational Database System Management. This is a SQL-style database. NoSQL does not follow RDBMS restrictions. Rules to RDBMS are called normalization and are described in a series of normal forms. 

- What about SQL?
### SQL stands for Structured Query Language. This means that it is used to query data from the database. It is considered declarative which means we tell the database the data we want using SQL rather than specifying exactly what we want the DB to do. 

- Do SQL databases have embedded records like mongo has embedded documents?
### SQL does not use embedded documents like Mongo. You would separate the embedded documents into two different tables with primary keys. Each table would have a primary key. To relate the two tables you would have one table with a foreign key in the other related table. 

- Can we freely store any data we like in an RDBMS table the same way we store any data in a mongo collection?
### SQL provides more structure than MongoDB. This means the data types that go into the database are more strict and cannot freely store data like Mongo collection.

- What does ACID stand for?
### ACID stands for Atomicity, Consistency, Isolation and Durability.
### - Atomicity means the operation or transaction is indivisible or irreducible. Either the entire transaction completes or none  of it does.
### - Consistency means that a transaction takes the database from one valid state to another (Not the same as CAP)
### - Isolation means multiple transactions taking place at the same time don't interfere with each other
### - Durability means transcations satisfy ACID even in the case of a disaster
### - Favors Consistency and Partition Tolerance in a distributed database.

- What does BASE stand for?
### BASE stand Basically Available, Soft State, and Eventual Consistency.
### - Basically Available means reads and writes are available as much as possible, using multiple machines in a cluster
### - Soft State means the records stored in the database may be inconsistent across a cluster, and some may be more up to date than others
### - Eventual Consistency means if the databases run long enough, it will achieve consistent data across the cluster BASE - This favors availability & partition tolerance in a distributed database.

- What is a SQL dialect?
### A SQL dialect is the difference between major RDBMSs and how theu execute some SQL functionality. There is "core SQL" that is the same of across the DBs, while each DB provides their own additional functionality outside of this.

- What are DML, DDL, DQL?
### - DML stands for Data Manipulation Language: used to manipulate data - adds/removes/edits records contained within tables
### - DDL stands for Data Definition Language: used to manipulate tables - adds/removes/modifies tables themselves
### - DQL stands for Data Query Language: used to retrieve data - It's sometimes lumped in with DML 

- What does SELECT do?
### SELECT specifies the columns you're looking for in a table.

- FROM?
### FROM specifies the table in the database. 

- WHERE?
### WHERE filters the records

- What is a primary key?
### A primary key is unique identifier for some object. In mongo, the _id field is the primary key. In RDBMS, we create the primary keys.

- What is a foreign key?
### A foreign key is used as a reference and to link two tables together. The table that hold the foreign key is the child table.