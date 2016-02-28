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
png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfcol = c(2, 2))

plot2Data = plotData[!is.na(plotData$Global_active_power) & !is.na(plotData$plotDate), ]
plot(plot2Data$plotDate, plot2Data$Global_active_power, type="n", xlab="", ylab="Global Active Power")
lines(plot2Data$plotDate, plot2Data$Global_active_power, type="l")

plot3Data = plotData[!is.na(plotData$Sub_metering_1) & !is.na(plotData$Sub_metering_2) & !is.na(plotData$Sub_metering_3) 
                     & !is.na(plotData$plotDate), ]
plot(plot3Data$plotDate, plot3Data$Sub_metering_1, type="n", xlab="", ylab="Energy Sub metering")
lines(plot3Data$plotDate, plot3Data$Sub_metering_1, type="l")
lines(plot3Data$plotDate, plot3Data$Sub_metering_2, type="l", col="red")
lines(plot3Data$plotDate, plot3Data$Sub_metering_3, type="l", col="blue")
legend("topright",lty=c(1,1,1), bty = "n", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot4Data = plotData[!is.na(plotData$Voltage) & !is.na(plotData$plotDate), ]
plot(plot4Data$plotDate, plot4Data$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(plot4Data$plotDate, plot4Data$Voltage, type="l")

plot5Data = plotData[!is.na(plotData$Global_reactive_power) & !is.na(plotData$plotDate), ]
plot(plot4Data$plotDate, plot4Data$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(plot4Data$plotDate, plot4Data$Global_reactive_power, type="l")

dev.off()