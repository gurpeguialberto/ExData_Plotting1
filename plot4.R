plot4 <- function(){
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
      png(filename = "plot4.png", width = 480, height = 480)
      #plots will be drawn by columns
      par(mfcol=c(2,2))
      #cex: amount by which plotting text and symbols should be magnified relative to the default
      #cex.lab: The magnification to be used for x and y labels relative to the current setting of cex.
      par(cex = 0.8, cex.lab = 0.9)
      #first plot
      with(data, plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
      #second plot
      with(data, plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
      plot_colors <- c("black","red","blue")
      names <- colnames(data)[7:9]
      lines(data$Time, data$Sub_metering_2, col = plot_colors[2] )
      lines(data$Time, data$Sub_metering_3, col = plot_colors[3])
      #lty adds little line to each legend. bty = "n" remove legend's box 
      legend("topright", legend=names, col=plot_colors, lty=1, bty="n")
      #third plot
      with(data, plot(Time, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
      #fourth plot
      with(data, plot(Time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
      dev.off()
}