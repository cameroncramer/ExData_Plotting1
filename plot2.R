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

# This produced plot 2
plot(HHE$DATE, HHE$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# Prints plot 2 to a png
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
plot(HHE$DATE, HHE$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()