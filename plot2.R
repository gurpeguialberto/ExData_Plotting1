plot2 <- function(){
      my_file <- file("household_power_consumption.txt","rt")
      data_aux <- read.table(my_file, 
                             header = TRUE, sep = ";", numerals = "no.loss", na.strings = "?", 
                             colClasses = c("character", "character", "double", "double", 
                                            "double", "double", "double", "double", "double"),
                             nrows=1, stringsAsFactors = FALSE )
      data <- read.table(my_file , 
                         header = FALSE, sep = ";", numerals = "no.loss", na.strings = "?", 
                         col.names=colnames(data_aux), colClasses = c("character", "character",
                                           "double", "double", "double", "double", "double", "double", "double"), 
                         nrows = 2880, skip=66635, stringsAsFactors = FALSE )
      close(my_file)
      Sys.setlocale("LC_TIME", "English")
      data_tmp1 <- subset(data, data$Date == "1/2/2007")
      data_tmp2 <- subset(data, data$Date == "2/2/2007")
      data <- rbind(data_tmp1, data_tmp2)
      data$Time <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
      data$Date <- as.Date(data$Date,"%d/%m/%Y")
      png(filename = "plot2.png", width = 480, height = 480)
      with(data, plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
      dev.off()
}