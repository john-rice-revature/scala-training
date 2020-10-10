package csvreadwrite

object CSVParser {
    def getCSVContent(filename: String): Unit = {
        val bufferedSource = io.Source.fromFile(filename)
        for (line <- bufferedSource.getLines) {
            val cols = line.split(",").map(_.trim)

            // do whatever you want with the columns here
            println(s"${cols(0)} || ${cols(1)}")
        }
        var openedCSV: Unit = CSVParser.getCSVContent(filename)
        bufferedSource.close
    }: Unit



}