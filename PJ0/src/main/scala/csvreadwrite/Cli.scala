package csvreadwrite
import scala.io.StdIn
import scala.util.matching.Regex
import java.io.FileNotFoundException

class Cli {

    val commandArgPattern : Regex = "(\\w+)\\s*(.*)".r

    def printWelcome(): Unit = {
        println("Welcome to the CSV Parser / Reader. This CSV Parser/Reader can also connect to MongoDB and store" +
            " your contacts in the database!")
    }

    def printMenuOptions(): Unit = {
        println("SELECT AN OPTION FROM BELOW")
        println("open [csv file] : select .csv file to open/parse/read")
        println("upload: Upload .csv contacts")
        println("exit : exit the application")

       /** println("FEATURES BELOW ARE NOT READY")
        println("view contacts")
        println("add contact")
        println("remove contact") */

    }

    def userMenu(): Unit = {

        printWelcome()
        var userMenuLoop = true

        while(userMenuLoop) {
            printMenuOptions()

            StdIn.readLine() match {
                case commandArgPattern(cmd, arg) if cmd.equalsIgnoreCase("open") =>
                    try CSVParser.getCSVContent(arg) catch {
                        case fnf : FileNotFoundException => println(s"Failed to find .CSV file '$arg'")
                    }
                case commandArgPattern(cmd) if cmd.equalsIgnoreCase("exit") => userMenuLoop = false
            }
        }

    }
}
