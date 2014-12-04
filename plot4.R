# This pulls in the Data
hhe<-read.csv("household_power_consumption.txt", header=TRUE, sep=c(";"), colClass=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), strip.white=TRUE, na.strings =c("?", ""))
# Rename ? to NA 
hhe[hhe == "?"] = NA
# Removes NAs from the dataframe
hhe2 <- hhe[complete.cases(hhe),]
# Paste together date and time to new variable DATE
hhe2$Date_Time = paste(hhe2$Date, hhe2$Time, sep=" ")
hhe2$Date_Time <- as.POSIXct(strptime(hhe2$Date_Time,format="%d/%m/%Y %H:%M:%S"))
colnames(data)[colnames(data)=="old_name"] <- "new_name"
colnames(hhe2)[colnames(hhe2)=="Date_Time"] <- "DATE"
# Subsets the dates needed
HHE<- subset(hhe2, DATE >= as.POSIXct('2007-02-01 00:00') & DATE <= as.POSIXct('2007-02-02 23:59'))
str(HHE)

# This produced plot 4
par(mar = c(4,4,2,2))
par(mfrow = c(2,2))
plot(HHE$DATE, HHE$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(HHE$DATE, HHE$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(HHE$DATE,HHE$Sub_metering_1 == "sub", type = "l", ylab = "Energy sub metering", xlab = "", ylim=c(0,40))
lines(HHE$DATE,HHE$Sub_metering_1,col="black")
lines(HHE$DATE,HHE$Sub_metering_2,col="red")
lines(HHE$DATE,HHE$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"),lty=1, bty="n")
plot(HHE$DATE, HHE$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")


# Prints plot 4 to a png
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
par(mar = c(4,4,2,2))
par(mfrow = c(2,2))
plot(HHE$DATE, HHE$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(HHE$DATE, HHE$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(HHE$DATE,HHE$Sub_metering_1 == "sub", type = "l", ylab = "Energy sub metering", xlab = "", ylim=c(0,40))
lines(HHE$DATE,HHE$Sub_metering_1,col="black")
lines(HHE$DATE,HHE$Sub_metering_2,col="red")
lines(HHE$DATE,HHE$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"),lty=1, bty="n")
plot(HHE$DATE, HHE$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()