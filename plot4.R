# install data.table package
    install.packages("data.table")
    library(data.table)

# check current work directory and download file and unzip it
    getwd()
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, "datafile.zip")
    unzip(zipfile = "datafile.zip")

# read data file for only lines for 2017/2/1 and 2017/2/2
    datasub = read.table("household_power_consumption.txt", sep=";", skip = 66637, nrow=2880, 
                       na="?", col.names = names(read.table("household_power_consumption.txt",
                                                         nrow=1, header=TRUE, sep=";")))
    fwrite(datasub, "datasub.txt", row.name=FALSE)
    
# plot1
    png(file="plot4.png", width = 480, height = 480, units = "px")
    date_time = paste(as.Date(as.character(datasub$Date),format="%d/%m/%Y"),datasub$Time)
    dates = strptime(date_time,"%Y-%m-%d %H:%M:%S")
    par(mfrow=c(2,2),mar=c(4,4,2,1))
    
    with(datasub, {
        plot(dates,Global_active_power,type="n",xlab="",ylab ="GlobalActive Power")
            lines(dates, Global_active_power)
        plot(dates,Voltage,type="n",xlab="datetime",ylab ="Voltage")
            lines(dates, Voltage)
    
        plot(dates,c(Sub_metering_1),type="n",xlab="",ylab ="Energy sub metering")
            lines(dates,c(Sub_metering_1),col="black")
            lines(dates,c(Sub_metering_2),col="red")
            lines(dates,c(Sub_metering_3),col="blue")
    })
    
    legend("topright",col=c("black","red","blue"),lty=1
           ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    
    with(datasub,{
        plot(dates,Global_reactive_power,type="n",xlab="datetime",ylab ="Global_reactive_power")
            lines(dates, Global_reactive_power)
            })
    axis(side=2,at=seq(0,0.5,by=0.1))
    
    dev.off()
    
    
    