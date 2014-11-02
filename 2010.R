#evalution of the health data for 2010

#set to your own working directory
setwd("/Users/meghanjordan/Desktop/HealthData")


#read in 
data1 <- read.csv(file="2010final.csv")

#categorize 
View(head(data1))

#rename headers 
names(data1) <- c("Region", "District", "Age", "Gender", "Marital Status", "Date", "Reason")

#change format of timestamp to date with month/day/year with no hour
data1$newdate <-strptime(as.character(data1$Date), "%m/%d/%y %H")
data1$Date <- format(data1$newdate, "%m/%d/%y")
data1$newdate <- NULL

#view
summary(data1) 
cbind(summary(data1$"Reason"))
str(data1)

#looking at the data from day of Magal
june3 <- subset(data1, Date == "06/03/10")
summary(june3)
str(june3)
cbind(summary(june3$Reason))

#Looking at data from day of and by Diourbel
june3_2 <- subset(june3, Regions =="Diourbel")
summary(june3_2)
str(june3_2)

#reasons just for day of Magal and Diourbel
cbind(summary(june3_2$Reason)
sumofjune3_2 <- summary(june3_2$Reason)
View(sumofjune3_2)

#view by date range day of Magal to 15 days after 
june3After <-subset(data1, Date >= "06/03/10" & Date <= "06/18/10")
cbind(summary(june3After$Reason))
summary(june3After)
str(june3After)

#view by date range day of Magal to 15 days before
june3Before <-subset(data1, Date >= "05/19/10" & Date <= "06/03/10")
cbind(summary(june3Before$Reason))
summary(june3Before)
str(june3Before)

#ggplot
install.packages("ggplot2")
library(ggplot2)

#plot for freq of phone calls per day for Month of June 
monthOfJune <- subset(data1, Date >= "06/01/10" & Date <= "06/30/10")
freqJune <- as.data.frame(table(monthOfJune$Date))
plot(freqJune, main="Frequency of calls per day for June 2010", xlab="Days", ylab="Freq")
names(freqJune) <-c("Date", "Freq")
freqJune$newdate <-strptime(as.character(freqJune$Date), "%m/%d/%y")
freqJune$Date <- format(freqJune$newdate, "%d")
freqJune$newdate <- NULL

June2010 <- ggplot(freqJune, aes(x=Date, y=Freq, group=1)) + geom_line() 
June2010 + ggtitle("Frequency of phone calls per day for June 2010")

#frequency of phone calls per day for entire year 
days <- (unique(data1$Date)) #to get each day indivdually 
freq <-as.data.frame(table(data1$Date))
plot(freq, main="Frequency of calls per day for 2010", xlab="Days", ylab="Freq")


