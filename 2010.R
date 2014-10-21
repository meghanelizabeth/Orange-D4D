#evalution of the health data for 2010

setwd("/Users/meghanjordan/Desktop/HealthData")

#read in 
data1 <- read.csv(file="2010translatednew.csv")

#rename headers 
names(data1) <- c("Regions", "Districts", "Age", "Sex", "Marital Status", "Date", "Reasons_French", "Reasons_English")

#categorize 
View(head(data1))

#remove french column 
data1$Reasons_French <- NULL

#change format of timestamp to date with month/day/year with no hour
data1$newdate <-strptime(as.character(data1$Date), "%m/%d/%y %H")
data1$Date <- format(data1$newdate, "%m/%d/%y")
data1$newdate <- NULL

#view
summary(data1) 
cbind(summary(data1$"Reasons_English"))
str(data1)

#fix encoding error due to the leading space 
pdf.options(encoding='ISOLatin2.enc')

#age
mean(data1$Age)
median(data1$Age)
summary(data1$Age)

#vcd
install.packages("vcd")
library(vcd)

#dplyr
install.packages("dplyr")
library(dplyr)
june3 <- filter(data1, Date == "06/03/10")
june3_2 <- filter(june3, Regions =="Diourbel")

#produces no results 
test <- filter(data1, Reasons_English == "cholera" | Reasons_English == "Cholera")

#view by date range day of festival to 15 days after 
june3range <-subset(data1, Date >= "06/03/10" & Date <= "06/18/10")
cbind(summary(june3range$Reasons_English))

