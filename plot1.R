plot1 <- function(){
      my_file <- file("household_power_consumption.txt","rt")
      data_aux <- read.table(my_file, 
                             header = TRUE, sep = ";", numerals = "no.loss", na.strings = "?", 
                             colClasses = c("character", "character", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric"),
                             nrows=1, stringsAsFactors = FALSE )
      data <- read.table(my_file , 
                         header = FALSE, sep = ";", numerals = "no.loss", na.strings = "?", 
                         col.names=colnames(data_aux), colClasses = c("character", "character",
                                                                      "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
                         nrows = 2880, skip=66635, stringsAsFactors = FALSE )
      close(my_file)
      data_tmp1 <- subset(data, data$Date == "1/2/2007")
      data_tmp2 <- subset(data, data$Date == "2/2/2007")
      data <- rbind(data_tmp1, data_tmp2)
      data$Time <- lapply(paste(data$Date, data$Time, sep=" "), strptime, "%d/%m/%Y %H:%M:%S")
      data$Date <- lapply(data$Date, as.Date, "%d/%m/%Y")
      png(filename = "plot1.png", width = 480, height = 480)
      hist(data$Global_active_power, col ="red", main=paste("Global Active Power"), xlab=paste("Global Active Power (kilowatts)"))
      dev.off()
}