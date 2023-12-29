library('tidyverse')


# read data file
data<-read.table("household_power_consumption.txt", header = TRUE, sep = ";", quote = "\"'")
dateStart <- as.Date("2007-02-01", format = "%Y-%m-%d")
dateEnd <- as.Date("2007-02-02", format = "%Y-%m-%d")
ind <- which((as.Date(data$Date,format ="%d/%m/%Y")>=dateStart) & (as.Date(data$Date,format = "%d/%m/%Y")<=dateEnd))
subData <- data[ind,]
names(subData) <- names(data)
TS <- strptime(paste(subData$Date, subData$Time), format="%d/%m/%Y %H:%M:%S")
subData <- data.frame(TS,subData[,-c(1,2)])

# Plot 1
dev.new()
hist(as.numeric(subData$Global_active_power), main = "Global Active Power", xlab = "Global Active Power(kW)", col = "red")
png("plot1.png",width = 480, height = 480)
hist(as.numeric(subData$Global_active_power), main = "Global Active Power", xlab = "Global Active Power(kW)", col = "red")
dev.off()
