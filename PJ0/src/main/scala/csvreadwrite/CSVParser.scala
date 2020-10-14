package csvreadwrite
import org.mongodb.scala.bson.collection.mutable.Document
import DBDriver.collection.insertOne
import csvreadwrite.DBDriver.collection
import csvreadwrite.Contact
import org.bson.types.ObjectId
import scala.io.BufferedSource
import scala.io.Source
import scala.collection.mutable.ArrayBuffer

object CSVParser {
    def parseCSV(filename: String) {
        // each row is an array of strings (the columns in the csv file)
        val rows = ArrayBuffer[Array[String]]()

        // parse csv + format for DB
        using(io.Source.fromFile(filename)) { source =>
            for (line <- source.getLines) {
                rows += line.split(",").map(_.trim)

            }

        }

        // print one by one to DB
        for (row <- rows) {
            DBDriver.printResults(collection.insertOne(Contact(name = row(0), phone = row(1), group = row(2))))

        }

        def using[A <: {def close(): Unit}, B](resource: A)(f: A => B): B =
            try {
                f(resource)
            } finally {
                resource.close()

            }

    }

}
