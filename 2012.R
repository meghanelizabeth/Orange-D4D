#evalution for 2012 Health Data

#change for your working directory
setwd("/Users/meghanjordan/Desktop/HealthData")

#read in 
data2011 <- read.csv(file="2011final.csv") #needed because 15 days before festival includes dates from 2011
data3 <- read.csv(file="2012final.csv") #2012

#categorize 2012
View(head(data3))

#rename headers for 2012
names(data3) <- c("Region", "Department", "District", "Reason", "Age", "Gender","Marital Status", "Date")
data3$Department <- NULL #delete Department Column for consistency

#change format of timestamp to date with mm/dd/yy for 2012
data3$newdate <-strptime(as.character(data3$Date), "%m/%d/%y")
data3$Date <- format(data3$newdate, "%m/%d/%y")
data3$newdate <- NULL

#rename and format 2011 
names(data2011) <- c("Region", "Department", "District", "Age", "Gender", "Marital Status", "Date", "Reason")
data2011$Department <- NULL #delete Department Column for consistency
data2011$newdate <-strptime(as.character(data2011$Date), "%m/%d/%y")
data2011$Date <- format(data2011$newdate, "%m/%d/%y")
data2011$newdate <- NULL

#merge 2010 and 2011 for further use
data2012 <- rbind(data2011, data3)

#view
summary(data2012) 
cbind(summary(data2012$"Reason"))
str(data2012)

#looking at the data from day of Magal 
jan12 <- subset(data2012, Date == "01/12/12")
summary(jan12)
str(jan12)
cbind(summary(jan12$Reason))

#day of Magal and by diourbel
jan12_2 <- subset(jan12, Regions =="Diourbel")
summary(jan12_2)
str(jan12_2)

#reasons just for day of and diourbel
#cbind(summary(jan12_2$Reason) # was not working 
sumofjan12_2 <- summary(jan12_2$Reason)
View(sumofjan12_2)

#looking at the data from day of to 15 days after
jan12After <- subset(data2012, Date >= "01/12/12" & Date <= "01/27/12")
cbind(summary(jan12After$Reason))
summary(jan12After)
str(jan12After)

#looking at the data from day of to 15 days before
jan12Before <- subset(data2012, Date >= "12/28/11" & Date <= "01/12/12") 
cbind(summary(jan12Before$Reason))
summary(jan12Before)
str(jan12Before)

#frequency of phone calls per day 
days <- (unique(data2012$Date)) #to get each day indivdually 
freq <-as.data.frame(table(data2012$Date)) #includes merge

#plot for freq of calls per day 2012 exclusive
freq3 <- as.data.frame(table(data3$Date))
plot(freq3, main="Frequency of calls per day for 2012", xlab="Days", ylab="Freq")

#plot for freq of calls per day for month of Jan 2012
monthOfJan12 <- subset(data3, Date >= "01/01/12" & Date <= "01/31/12")
freqJan12 <- as.data.frame(table(monthOfJan12$Date))
plot(freqJan12, main="Frequency of calls per day for Jan 2012", xlab="Days", ylab="Freq")
names(freqJan12) <-c("Date", "Freq")
freqJan12$newdate <-strptime(as.character(freqJan12$Date), "%m/%d/%y")
freqJan12$Date <- format(freqJan12$newdate, "%d")
freqJan12$newdate <- NULL

Jan2012 <- ggplot(freqJune, aes(x=Date, y=Freq, group=1)) + geom_line() 
Jan2012 + ggtitle("Frequency of phone calls per day for Jan 2012")


