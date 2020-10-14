package csvreadwrite
import scala.io.StdIn
import scala.util.matching.Regex
import java.io.FileNotFoundException


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
        println("open [csv file] : select .csv file to open/parse/read")
        println("view: view DB contacts")
        println("exit : exit the application")

       /** FEATURES BELOW THAT HAVE YET TO BE IMPLEMENTED
        println("upload: Upload .csv contacts to DB")
       */

    }

    def userMenu(): Unit = {

        printWelcome()
        var userMenuLoop = true

        while(userMenuLoop) {
            printMenuOptions()

            StdIn.readLine() match {
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("open") =>
                    try CSVParser.getCSVContent(arg) catch {
                        case arr : ArrayIndexOutOfBoundsException => println(s"ArrayOutOfBounds -- $arg")
                        case fnf : FileNotFoundException => println(s"Failed to find .CSV file '$arg'")
                    }
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("view") => DBDriver
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("upload") => DBDriver
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("exit") => userMenuLoop = false
            }
        }

    }
}
