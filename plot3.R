if (!file.exists("epc.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest = "epc.zip") 
}

if (!file.exists("household_power_consumption.txt")) {
    unzip("epc.zip")    
}

if (!is.data.frame(my_epc)) {
    epc <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", dec = ".", colClasses=c("character","character","double","double","double","double","double","double","numeric"))
    epc$DateTime <- strptime(paste(as.Date(epc$Date, "%d/%m/%Y"), epc$Time), "%Y-%m-%d %H:%M:%S")
    my_epc <- subset(epc, epc$Date == "2007-02-01" | epc$Date == "2007-02-02")
}

png("plot3.png", width=480, height=480, units="px")

par(mfrow=c(1,1))

plot(my_epc$DateTime, my_epc$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines(my_epc$DateTime, my_epc$Sub_metering_2, col = "red")
lines(my_epc$DateTime, my_epc$Sub_metering_3, col = "blue")

legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 2)

dev.off()