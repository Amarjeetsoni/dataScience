#kya krna hai abhi to

#loading data

# reading the data 
power_data <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
# setting according to the formet 
power_data$Date <- as.Date(power_data$Date, format = "%d/%m/%y")
power_data$Time <- format(power_data$Time, format = "%H:%M:%S")
power_data$Global_active_power = as.numeric(power_data$Global_active_power)
power_data$Global_reactive_power = as.numeric(power_data$Global_reactive_power)
power_data$Voltage = as.numeric(power_data$Voltage)
power_data$Global_intensity = as.numeric(power_data$Global_intensity)
power_data$Sub_metering_1 = as.numeric(power_data$Sub_metering_1)
power_data$Sub_metering_2 = as.numeric(power_data$Sub_metering_2)
power_data$Sub_metering_3 = as.numeric(power_data$Sub_metering_3)

# after that subsetting data set by date 2007-02-01 or 2007-02-02.
subdata <- subset(power_data, Date = "2007-02-01" | Date == "2007-02-02")


#  Making plot

#plot1
png("plot1.png", width = 480, height = 480)
hist(subdata$Global_active_power, col="red", border="black", main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()

#plot2

FullTimeDate <- strptime(paste(power_data$Date, power_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
power_data <- cbind(power_data, FullTimeDate)
png("plot2.png", width=480, height=480)
with(subdata, plot(FullTimeDate, Global_active_power, type="l", xlab="Day", ylab="Global Active Power (kilowatts)"))
dev.off()

#plot3

png("plot3.png", width=480, height=480)
with(subdata, plot(FullTimeDate, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering"))
lines(subdata$FullTimeDate, subdata$Sub_metering_2,type="l", col= "red")
lines(subdata$FullTimeDate, subdata$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
dev.off()

#plot4

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(subdata, plot(FullTimeDate, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(subdata, plot(FullTimeDate, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(subdata, plot(FullTimeDate, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(subdata$FullTimeDate, subdata$Sub_metering_2,type="l", col= "red")
lines(subdata$FullTimeDate, subdata$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(subdata, plot(FullTimeDate, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()
