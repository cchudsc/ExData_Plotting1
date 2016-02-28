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
plot1Data = plotData$Global_active_power[!is.na(plotData$Global_active_power)]
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(plot1Data,main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")
dev.off()