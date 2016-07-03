##overall goal here is simply to examine how household energy usage varies over a 2-day period 
##in February, 2007. Your task is to reconstruct the following plots below, all of which were 
##constructed using the base plotting system.
getwd()
setwd("~/JH Data Science/Exploratory Data Analysis/Week1 Peer Graded Assignment Course Project")
getwd()

##?read.table

household_power_consumption <- read.table("household_power_consumption.txt",
                                          sep = ";",
                                          header = TRUE)

household_power_consumption$Date <- as.Date(household_power_consumption$Date, format="%d/%m/%Y")
View(household_power_consumption)

## summary of the Datframe household_power_consumption

head(household_power_consumption)
tail(household_power_consumption)
nrow(household_power_consumption)
ncol(household_power_consumption)
names(household_power_consumption)

## Reading Subset of Data for two days 
household_power_consumption1 <- household_power_consumption[(household_power_consumption$Date=="2007-02-01") | (household_power_consumption$Date=="2007-02-02"),]

## Summary of household_power_consumption1

head(household_power_consumption1)
tail(household_power_consumption1)
nrow(household_power_consumption1)
ncol(household_power_consumption1)
names(household_power_consumption1)

## #Convert global active power column, global reactive power colums, Sub_metering columns, and the Voltage column to numeric

household_power_consumption1$Global_active_power <- as.numeric(as.character(household_power_consumption1$Global_active_power))
household_power_consumption1$Global_reactive_power <- as.numeric(as.character(household_power_consumption1$Global_reactive_power))
household_power_consumption$Voltage <- as.numeric(as.character(household_power_consumption$Voltage))
household_power_consumption1 <- transform(household_power_consumption1, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
household_power_consumption1$Sub_metering_1 <- as.numeric(as.character(household_power_consumption1$Sub_metering_1))
household_power_consumption1$Sub_metering_2 <- as.numeric(as.character(household_power_consumption1$Sub_metering_2))
household_power_consumption1$Sub_metering_3 <- as.numeric(as.character(household_power_consumption1$Sub_metering_3))


### Code for Plot 4- create a function to draw plot
plot4 <- function() {
  par(mfrow=c(2,2))
  
  ##Plot for GLobal active Power
  plot(household_power_consumption1$timestamp,household_power_consumption1$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  ##Plot for Voltage 
  plot(household_power_consumption1$timestamp,household_power_consumption1$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  ##Plot for Energy sub metering
  plot(household_power_consumption1$timestamp,household_power_consumption1$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(household_power_consumption1$timestamp,household_power_consumption1$Sub_metering_2,col="red")
  lines(household_power_consumption1$timestamp,household_power_consumption1$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
  
  #Plot for Blobal reactive power
  plot(household_power_consumption1$timestamp,household_power_consumption1$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  #OUTPUT
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
  cat("plot4.png has been saved in", getwd())
}


### Call plot4()function
plot4()











