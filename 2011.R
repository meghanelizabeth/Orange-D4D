#evalution of 2011 R data 

setwd("/Users/meghanjordan/Desktop/HealthData")

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

#age
mean(data2$Age)
median(data2$Age)
summary(data2$Age)

#vcd
install.packages("vcd")
library(vcd)

#dplyr
install.packages("dplyr")
library(dplyr)


#filtering and subsetting by date and region 
jan6 <- filter(data2, Date == "01/06/11")
jan6_2 <- filter(jan6, Regions =="Diourbel")

jan6range <- subset(data2, Date >= "01/06/11" & Date <= "01/21/11")

cbind(summary(jan6range$Reasons_English))

