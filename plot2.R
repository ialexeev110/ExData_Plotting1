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

# Plot 2
dev.new()
plot2 <- ggplot(data=subData,mapping=aes(x=TS,y=as.numeric(Global_active_power))) +
  geom_line() + 
  xlab("") + 
  ylab("Global Active Power(kW)") +
  scale_x_datetime(date_breaks = "day", date_labels = "%a") +
  theme_bw()
plot2
png("plot2.png",width = 480, height = 480)
plot2
dev.off()