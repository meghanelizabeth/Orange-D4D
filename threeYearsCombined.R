data2010 <- read.csv(file="2010final.csv")
data2011 <- read.csv(file="2011final.csv")
data2012 <- read.csv(file="2012final.csv")
names(data2010) <- c("Region", "District", "Age", "Gender", "Maritalstatus", "Date", "Reason")
names(data2011) <- c("Region", "District", "Age", "Gender", "Maritalstatus", "Date", "Reason")
names(data2012) <- c("Region", "District", "Age", "Gender", "Maritalstatus", "Date", "Reason")
is.character(data2010$Date) #False same for other

data2010$newdate <-strptime(as.character(data2010$Date), "%m/%d/%y")
data2010$Date <- data2010$newdate
data2010$newdate <-NULL

data2011$newdate <-strptime(as.character(data2011$Date), "%m/%d/%y")
data2011$Date <- data2011$newdate
data2011$newdate <-NULL

data2012$newdate <-strptime(as.character(data2012$Date), "%m/%d/%y")
data2012$Date <- data2012$newdate
data2012$newdate <-NULL

is.character(data2012$Date)

data20102011 <- rbind(data2010,data2011)
data20112012 <- rbind(data2011, data2012)

magal2011jan6beforeafter <- subset(data20102011, Date >= "2010-12-22" & Date <= "2011-01-21")
days <- (unique(magal2011jan6beforeafter$Date))
magal2011jan6beforeafter$Date <- as.POSIXct(magal2011jan6beforeafter$Date) 
freq <-as.data.frame(table(magal2011jan6beforeafter$Date)) 
plot(freq, main="Frequency of calls per day for the 2011 Magal", xlab="Days", ylab="Freq")

#better not to use 16 but for now...
points(freq[c(16),][1], freq[c(16),][2], col=2)

#reasons of the day with the most calls. Day 18 (2011-01-08) and 164 phones calls
summary

freq[c(18),][1]
reasonscalls <- subset(data20102011,Date=="2011-01-08")

#freq sample
freq[1]
freq[2]
freq[c(16),]

#date sample
a = Sys.Date()
a
is.character(a)
a < "2014-12-01"
#false
a < "2015-12-01"
#true

#getting the data of reasons for before the festival 
jan12Before <- subset(data2012, Date >= "2011-12-28" & Date <= "2012-01-12") 
jan6Before <- subset(data2011, Date >= "2010-12-22" & Date <= "2011-01-06") 

#for 2011
magal2012jan12beforeafter <- subset(data20112012, Date >= "2011-12-28" & Date <= "2012-01-28")
days <- (unique(magal2012jan12beforeafter$Date))
magal2012jan12beforeafter$Date <- as.POSIXct(magal2012jan12beforeafter$Date) 
freq <-as.data.frame(table(magal2012jan12beforeafter$Date))
plot(freq, main="Frequency of calls per day for the 2012 Magal", xlab="Days", ylab="Freq")
points(freq[c(15),][1], freq[c(15),][2], col=2)


#2010
magal2010feb3beforeafter <- subset(data2010, Date >= "2010-01-19" & Date <= "2010-03-18")
days <- (unique(magal2010feb3beforeafter$Date))
magal2010feb3beforeafter$Date <- as.POSIXct(magal2010feb3beforeafter$Date) 
freq <-as.data.frame(table(magal2010feb3beforeafter$Date))
plot(freq, main="Frequency of calls per day for the 2010 Magal", xlab="Days", ylab="Freq")
points(freq[c(15),][1], freq[c(15),][2], col=2)



