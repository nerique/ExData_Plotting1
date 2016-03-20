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

png("plot2.png", width=480, height=480, units="px")

par(mfrow=c(1,1))

plot(my_epc$DateTime, my_epc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()