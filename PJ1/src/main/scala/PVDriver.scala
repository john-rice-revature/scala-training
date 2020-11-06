package pvcounter
import org.apache.hadoop.fs.Path
import org.apache.hadoop.io.{IntWritable, Text}
import org.apache.hadoop.mapreduce.Job
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat

/**
 * WordDriver is a entry point for our MapReduce job.
 * In this class we configure input and output data formats, configure Mapper and Reducer classes,
 * and specify intermediate data formats.
 *
 * Were going to make use of command line arguments here which can be accessed in the args array
 *
 */

object PVDriver extends App {

    if(args.length != 2) {
        println("Usage: WordDriver <input dir> <output dir>")
        System.exit(-1)
    }

    // instantiating a Job object we can configure
    val job = Job.getInstance()

    // Set the jar file that contains driver, mapper, and reducer.
    // This jar file will be transferred to nodes that run tasks
    job.setJarByClass(PVDriver.getClass)

    // Specify a job name for us and other devs
    job.setJobName("Clickstream Link Count")

    // Specify input and output paths based on command line args
    //This line sets the input to be from the files specified in the first arg received

    FileInputFormat.setInputPaths(job, new Path(args(0)))
    // this line sets output based on the second
    FileOutputFormat.setOutputPath(job, new Path(args(1)))

    //Specify Mapper and Reducer
    job.setMapperClass(classOf[PVMapper])
    job.setReducerClass(classOf[PVReducer])

    // Specify the job's output key and value classes. We're making use of some defaults
    // to not have to specify input and intermediate
    job.setOutputKeyClass(classOf[Text])
    job.setOutputValueClass(classOf[IntWritable])

    val success = job.waitForCompletion(true)
    System.exit(if (success) 0 else 1)

}
