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
rm(allData)

#plot and save png
plot2Data = plotData[!is.na(plotData$Global_active_power) & !is.na(plotData$Date), ]
lines(as.Date(plot2Data$Date), plot2Data$Global_active_power)
plotDev = dev.copy(png, filename = "plot2.png", width = 480, height = 480, units = "px")
dev.off(plotDev)