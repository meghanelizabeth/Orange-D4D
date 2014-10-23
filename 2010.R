#evalution of the health data for 2010

setwd("/Users/meghanjordan/Desktop/HealthData")

#vcd
install.packages("vcd")
library(vcd)

#dplyr
install.packages("dplyr")
library(dplyr)

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

#looking at the data from day of
june3 <- subset(data1, Date == "06/03/10")
summary(june3)
str(june3)
cbind(summary(june3$Reasons_English))

#day of and by diourbel
june3_2 <- subset(june3, Regions =="Diourbel")
summary(june3_2)
str(june3_2)

#reasons just for day of and diourbel
cbind(summary(june3_2$Reasons_English)
sumofjune3_2 <- summary(june3_2$Reasons_English)
View(sumofjune3_2)

#view by date range day of festival to 15 days after 
june3After <-subset(data1, Date >= "06/03/10" & Date <= "06/18/10")
cbind(summary(june3After$Reasons_English))
summary(june3After)
str(june3After)

#view by date range day of festival to 15 days before
june3Before <-subset(data1, Date >= "05/19/10" & Date <= "06/03/10")
cbind(summary(june3Before$Reasons_English))
summary(june3Before)
str(june3Before)
