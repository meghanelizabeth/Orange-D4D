#evalution of 2011 R data 

setwd("/Users/meghanjordan/Desktop/HealthData")

#vcd
install.packages("vcd")
library(vcd)

#dplyr
install.packages("dplyr")
library(dplyr)

#read in 
data2 <- read.csv(file="2011_health.csv")

#rename headers 
names(data2) <- c("Regions", "Districts", "Age", "Sex", "Marital Status", "Date","Reasons_English")

#categorize 
View(head(data2))

#change format of timestamp to date with month/day/year with no hour
data2$newdate <-strptime(as.character(data2$Date), "%m/%d/%y %H")
data2$Date <- format(data2$newdate, "%m/%d/%y")
data2$newdate <- NULL

#fix encoding error due to the leading space 
pdf.options(encoding='ISOLatin2.enc')

#view
summary(data2) 
cbind(summary(data2$"Reasons_English"))
str(data2)

#looking at the data from day of festival 
jan6 <- subset(data2, Date == "01/06/11")
summary(jan6)
str(jan6)
cbind(summary(jan6$Reasons_English))

#day of and by diourbel
jan6_2 <- subset(jan6, Regions =="Diourbel")
summary(jan6_2)
str(jan6_2)

#reasons just for day of and diourbel
#cbind(summary(jan6_2$Reasons_English) # was not working 
sumofjan6_2 <- summary(jan6_2$Reasons_English)
View(sumofjan6_2)

#looking at the data from day of to 15 days after
jan6After <- subset(data2, Date >= "01/06/11" & Date <= "01/21/11")
cbind(summary(jan6After$Reasons_English))
summary(jan6After)
str(jan6After)

#looking at the data from day of to 15 days before
#jan6Before <- subset(data2, Date >= "12/22/10" & Date <= "01/06/11") # files not currently merged 
jan6Before <- subset(data2, Date >= "01/01/11" & Date <= "01/06/11")
cbind(summary(jan6Before$Reasons_English))
summary(jan6Before)
str(jan6Before)
