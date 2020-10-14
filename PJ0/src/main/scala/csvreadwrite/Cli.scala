package csvreadwrite
import scala.io.StdIn
import scala.util.matching.Regex
import java.io.FileNotFoundException

import com.mongodb.client.model.Filters
import csvreadwrite.DBDriver.collection


class Cli {

    val commandArgPattern : Regex = "(\\w+)\\s*(.*)".r

    def printWelcome(): Unit = {
        println("Welcome to the CSV Parser / Reader. This CSV Parser/Reader can also connect to MongoDB and store" +
            " your contacts in the database!")
        println("")
        Thread.sleep(2500)
    }

    def printMenuOptions(): Unit = {
        println("SELECT AN OPTION FROM BELOW")
        println("upload [csv file] : select .csv file to parse & insert into DB")
        println("view: view DB contacts")
        println("exit : exit the application")

       /** FEATURES BELOW THAT HAVE YET TO BE IMPLEMENTED
        println("add [name]: add contact to DB")
        println("remove [name]: remove contact from DB")
       */

    }

    def userMenu(): Unit = {

        printWelcome()
        var userMenuLoop = true

        while(userMenuLoop) {
            printMenuOptions()

            //user input: upload CSV file to DB
            StdIn.readLine() match {
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("upload") =>
                    try CSVParser.parseCSV(arg) catch {
                        case arr : ArrayIndexOutOfBoundsException => println(s"ArrayOutOfBounds -- $arg")
                        case fnf : FileNotFoundException => println(s"Failed to find .CSV file '$arg'")
                    }

                //user input: view contacts in DB
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("view") =>
                    DBDriver.printResults(collection.find())

                //user input: remove all contacts from DB
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("remove all") =>
                    DBDriver.printResults(collection.deleteMany(Filters.exists("name")))

                //user input: exit program
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("exit") =>
                    userMenuLoop = false
            }
        }

    }
}
