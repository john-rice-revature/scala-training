package csvreadwrite
import scala.io.BufferedSource

object CSVParser {
    def getCSVContent(filename: String): Unit = {

        var openedFile : BufferedSource = null
        var CSVContent : Option[String] = None
        val bufferedSource = io.Source.fromFile(filename)

        for (line <- bufferedSource.getLines) {
            val cols = line.split(",").map(_.trim)

            // do whatever you want with the columns here
            println(s"${cols(0)} || ${cols(1)} | ${cols(2)}")
        }

        bufferedSource.close
    }: Unit



}
