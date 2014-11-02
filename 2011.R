#evalution of 2011 Health Data 

#change for your working directory
setwd("/Users/meghanjordan/Desktop/HealthData")

#read in 
data2010 <- read.csv(file="2010final.csv") #needed because 15 days before festival includes dates from 2010
data2 <- read.csv(file="2011final.csv") #2011

#categorize 
View(head(data2))

#rename headers for 2011
names(data2) <- c("Region", "Department", "District", "Age", "Gender", "Marital Status", "Date", "Reason")
data2$Department <- NULL #delete Department Column for consistency

#change format of timestamp to date with mm/dd/yyyy for 2011
data2$newdate <-strptime(as.character(data2$Date), "%m/%d/%y")
data2$Date <- format(data2$newdate, "%m/%d/%y")
data2$newdate <- NULL

#rename and format 2010 
names(data2010) <- c("Region", "District", "Age", "Gender", "Marital Status", "Date", "Reason")
data2010$newdate <-strptime(as.character(data2010$Date), "%m/%d/%y %H")
data2010$Date <- format(data2010$newdate, "%m/%d/%y")
data2010$newdate <- NULL

#merge 2010 and 2011 for further use
data2011 <- rbind(data2010, data2)

#view
summary(data2011) 
cbind(summary(data2011$"Reason"))
str(data2011)

#looking at the data from day of Magal 
jan6 <- subset(data2011, Date == "01/06/11")
summary(jan6)
str(jan6)
cbind(summary(jan6$Reason))

#day of Magal and by diourbel
jan6_2 <- subset(jan6, Regions =="Diourbel")
summary(jan6_2)
str(jan6_2)

#reasons just for day of and diourbel
#cbind(summary(jan6_2$Reason) # was not working 
sumofjan6_2 <- summary(jan6_2$Reason)
View(sumofjan6_2)

#looking at the data from day of to 15 days after
jan6After <- subset(data2011, Date >= "01/06/11" & Date <= "01/21/11")
cbind(summary(jan6After$Reason))
summary(jan6After)
str(jan6After)

#looking at the data from day of to 15 days before
jan6Before <- subset(data2011, Date >= "12/22/10" & Date <= "01/06/11") 
cbind(summary(jan6Before$Reason))
summary(jan6Before)
str(jan6Before)

#frequency of phone calls per day 
days <- (unique(data2011$Date)) #to get each day indivdually will include the merge from 2010
freq <-as.data.frame(table(data2011$Date)) #includes merge from 2010

#plot for freq of calls per day 2011 exclusive
freq2 <- as.data.frame(table(data2$Date))
plot(freq2, main="Frequency of calls per day for 2011", xlab="Days", ylab="Freq")

#plot for month of January 
monthOfJan <- subset(data2, Date >= "01/01/11" & Date <= "01/31/11")
freqJan <- as.data.frame(table(monthOfJan$Date))
plot(freqJan, main="Frequency of calls per day for Jan 2011", xlab="Days", ylab="Freq")
names(freqJan) <-c("Date", "Freq")
freqJan$newdate <-strptime(as.character(freqJan$Date), "%m/%d/%y")
freqJan$Date <- format(freqJan$newdate, "%d")
freqJan$newdate <- NULL

Jan2011 <- ggplot(freqJune, aes(x=Date, y=Freq, group=1)) + geom_line() 
Jan2011 + ggtitle("Frequency of phone calls per day for Jan 2011")