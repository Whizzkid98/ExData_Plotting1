p <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(p) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subp <- subset(p,p$Date=="1/2/2007" | p$Date =="2/2/2007")

subp$Date <- as.Date(subp$Date, format="%d/%m/%Y")
subp$Time <- strptime(subp$Time, format="%H:%M:%S")
subp[1:1440,"Time"] <- format(subp[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subp[1441:2880,"Time"] <- format(subp[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

par(mfrow=c(2,2))
with(subp,{
  plot(subp$Time,as.numeric(as.character(subp$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subp$Time,as.numeric(as.character(subp$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(subp$Time,subp$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subp,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subp,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subp,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(subp$Time,as.numeric(as.character(subp$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

dev.copy(png, file = "plot4.png")
dev.off()