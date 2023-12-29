library('tidyverse')
library('grid')
library('gridExtra')

# read data file
data<-read.table("household_power_consumption.txt", header = TRUE, sep = ";", quote = "\"'")
dateStart <- as.Date("2007-02-01", format = "%Y-%m-%d")
dateEnd <- as.Date("2007-02-02", format = "%Y-%m-%d")
ind <- which((as.Date(data$Date,format ="%d/%m/%Y")>=dateStart) & (as.Date(data$Date,format = "%d/%m/%Y")<=dateEnd))
subData <- data[ind,]
names(subData) <- names(data)
TS <- strptime(paste(subData$Date, subData$Time), format="%d/%m/%Y %H:%M:%S")
subData <- data.frame(TS,subData[,-c(1,2)])

# Plot 4
dev.new()

# subplot 1
plot4_1 <- ggplot(data=subData,mapping=aes(x=TS,y=as.numeric(Global_active_power)))+
  geom_line() + 
  xlab("") + 
  ylab("Global Active Power(kW)") +
  scale_x_datetime(date_breaks = "day", date_labels = "%a") +
  theme_bw()

# subplot 2
plot4_2 <- ggplot(data=subData,mapping=aes(x=TS,y=as.numeric(Voltage)))+
  geom_line() + 
  xlab("") + 
  ylab("Voltage") +
  scale_x_datetime(date_breaks = "day", date_labels = "%a") +
  theme_bw()

# subpolt 3
plot4_3 <- ggplot(data=subData, aes(x=TS)) + 
  geom_line(aes(y = as.numeric(Sub_metering_1)),color="black",linetype="solid") +   
  geom_line(aes(y = as.numeric(Sub_metering_2)),color="blue",linetype="solid") +
  geom_line(aes(y = as.numeric(Sub_metering_3)),color="red",linetype="solid")+
  xlab("") +
  ylab("Energy sub meeting") +
  scale_x_datetime(date_breaks = "day", date_labels = "%a") +
  theme_bw()

# Subplot 4
plot4_4 <- ggplot(data=subData,mapping=aes(x=TS,y=as.numeric(Global_reactive_power)))+
  geom_line() + 
  xlab("") + 
  ylab("Voltage") +
  scale_x_datetime(date_breaks = "day", date_labels = "%a") +
  theme_bw()

grid.arrange(plot4_1, plot4_2, plot4_3, plot4_4, ncol=2)
png("plot4.png",width = 480, height = 480)
grid.arrange(plot4_1, plot4_2, plot4_3, plot4_4, ncol=2)
dev.off()