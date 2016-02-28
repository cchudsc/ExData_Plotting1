downloadFile = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
extractFile = "household_power_consumption.txt"

#Download and unzip files
if (!file.exists(extractFile)) {
    download.file(downloadFile,"exdata data household_power_consumption.zip")
    unzip("exdata data household_power_consumption.zip")
}

#Read datafile
allData = read.csv(extractFile, header = TRUE, sep=";", stringsAsFactors = FALSE, na.strings = "?")
plotData = allData[allData$Date %in% c("1/2/2007","2/2/2007"),]
plotData$plotDate <- strptime(paste(plotData$Date, plotData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
rm(allData)

#plot and save png
plot3Data = plotData[!is.na(plotData$Sub_metering_1) & !is.na(plotData$Sub_metering_2) & !is.na(plotData$Sub_metering_3) 
                     & !is.na(plotData$plotDate), ]
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(plot3Data$plotDate, plot3Data$Sub_metering_1, type="n", xlab="", ylab="Energy Sub metering")
lines(plot3Data$plotDate, plot3Data$Sub_metering_1, type="l")
lines(plot3Data$plotDate, plot3Data$Sub_metering_2, type="l", col="red")
lines(plot3Data$plotDate, plot3Data$Sub_metering_3, type="l", col="blue")
legend("topright",lty=c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
