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

# Plot 3
dev.new()
plot3 <- ggplot(data=subData, aes(x=TS)) + 
  geom_line(aes(y = as.numeric(Sub_metering_1)),color="black",linetype="solid") +   
  geom_line(aes(y = as.numeric(Sub_metering_2)),color="blue",linetype="solid") +
  geom_line(aes(y = as.numeric(Sub_metering_3)),color="red",linetype="solid")+
  xlab("") +
  ylab("Energy sub meeting") +
  scale_x_datetime(date_breaks = "day", date_labels = "%a") +
  theme_bw()
plot3
png("plot3.png",width = 480, height = 480)
plot3
dev.off()