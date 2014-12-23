#plots for set12vdec15latlongsmall.csv
#Set 1 month 12 voice, data already subsetting

#read in file 
set12v <- read.csv(file="set12vdec15latlongsmall.csv")
View(head(set12v))

#install packages 
install.packages("data.table")
library(data.table)
install.packages("reshape")
library(reshape)
install.packages("dplyr")
library(dplyr)



#plot for calls with Touba as incoming site, the sites ids are:
#1043, 1054, 1046, 1049, 1055, 1050

#touba as incoming city of origin 
toubaIncoming2 <- subset(set12v, incoming_site_id == 1043 | incoming_site_id == 1054 | incoming_site_id == 1046 
                 | incoming_site_id == 1049 | incoming_site_id == 1055 
                 | incoming_site_id == 1050)
#view
View(toubaIncoming2)
nrow(toubaIncoming2)
#[1] 324496

grpIncomingCity2 <- group_by(toubaIncoming2, timestamp)
grpincomingcity12 <- summarize(grpIncomingCity2, number_of_calls = sum(number_of_calls), total_call_duration = sum(total_call_duration))
plot(grpincomingcity12$timestamp, grpincomingcity12$number_of_calls, main="Frequency of calls with Touba as receiving city", xlab="Time", ylab="Nb calls")
points(grpincomingcity12[c(8),][1], grpincomingcity12[c(8),][2], col=2)

#touba as outgoing city of origin 
toubaOutgoing2 <- subset(set12v, outgoing_site_id == 1043 | outgoing_site_id == 1054 | outgoing_site_id == 1046 
                    | outgoing_site_id == 1049 | outgoing_site_id == 1055 
                    | outgoing_site_id == 1050)

grpOutgoingCity2 <- group_by(toubaOutgoing2, timestamp)
grpoutgoingcity12 <- summarize(grpOutgoingCity2, number_of_calls = sum(number_of_calls), total_call_duration = sum(total_call_duration))
plot(grpoutgoingcity12$timestamp, grpoutgoingcity12$number_of_calls, main="Frequency of calls with Touba as originating city", xlab="Time", ylab="Nb calls") 
points(grpoutgoingcity12[c(8),][1], grpoutgoingcity12[c(8),][2], col=2)


#install SQL to R translator package
install.packages("sqldf")
require(sqldf)

#testing sqldf 
s01 <- sqldf("select incoming_site_id, timestamp from set12v")
View(s01)

#BOTH using sqldf
both <- sqldf("SELECT timestamp, sum(number_of_calls) FROM set12v 
where (outgoing_site_id = 1043 or outgoing_site_id = 1054 or outgoing_site_id = 1046 or outgoing_site_id = 1049 or outgoing_site_id = 1055 or outgoing_site_id = 1050) and 
(incoming_site_id = 1043 or incoming_site_id = 1054 or incoming_site_id = 1046 or incoming_site_id = 1049 or incoming_site_id = 1055 or incoming_site_id = 1050)
group by timestamp")

View(both)
plot(both, main = "Frequency of calls with Touba as receiving and originating city", xlab="Time", ylab="Nb Calls")
points(both[c(8),][1], both[c(8),][2], col=2)

nrow(both)


#for line graph
#installation required R session restart for me 
install.packages("ggplot2")
library(ggplot2)
install.packages("reshape")
library(reshape2)
install.packages("RColorBrewer")
library(RColorBrewer)


#tivaoune
tiv <- read.csv(file="set1vjan16tivaounaelatlongsmall.csv")
View(head(tiv))


#plot for calls with Touba as incoming site, the sites ids are:
#604, 605, 606, 609

#touba as incoming city of origin 
tivIncoming2 <- subset(tiv, incoming_site_id == 604 | incoming_site_id == 605 | incoming_site_id == 606 
                         | incoming_site_id == 609)
#view
View(tivIncoming2)
nrow(tivIncoming2)

grpIncomingCity <- group_by(tivIncoming2, timestamp)
grpincomingcity <- summarize(grpIncomingCity, number_of_calls = sum(number_of_calls), total_call_duration = sum(total_call_duration))
plot(grpincomingcity$timestamp, grpincomingcity$number_of_calls, main="Frequency of calls with Tivaouane as receiving city", xlab="Time", ylab="Nb calls")
points(grpincomingcity[c(8),][1], grpincomingcity[c(8),][2], col=2)

summary(grpincomingcity$number_of_calls)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#1   25000   50000   50000   75000  100000 

#tiv as outgoing city of origin 
tivOutgoing2 <- subset(tiv, outgoing_site_id == 604 | outgoing_site_id == 605 | outgoing_site_id == 606
                         | outgoing_site_id == 609)

grpOutgoingCity <- group_by(tivOutgoing2, timestamp)
grpoutgoingcity <- summarize(grpOutgoingCity, number_of_calls = sum(number_of_calls), total_call_duration = sum(total_call_duration))
plot(grpoutgoingcity$timestamp, grpoutgoingcity$number_of_calls, main="Frequency of calls with Tivaouane as originating city", xlab="Time", ylab="Nb calls") 
points(grpoutgoingcity[c(8),][1], grpoutgoingcity[c(8),][2], col=2)




#install SQL to R translator package
install.packages("sqldf")
require(sqldf)

#testing sqldf 
s01 <- sqldf("select incoming_site_id, timestamp from tiv")
View(s01)

#BOTH using sqldf
bothTiv <- sqldf("SELECT timestamp, sum(number_of_calls) FROM tiv
where (outgoing_site_id = 604 or outgoing_site_id = 605 or outgoing_site_id = 606 or outgoing_site_id = 609) and 
(incoming_site_id = 604 or incoming_site_id = 605 or incoming_site_id = 606 or incoming_site_id = 609)
group by timestamp")

View(bothTiv)
plot(bothTiv, main = "Frequency of calls with Tivaouane as receiving and originating city", xlab="Time", ylab="Nb Calls")
points(bothTiv[c(8),][1], both[c(8),][2], col=2)

summary(bothTiv)
timestamp sum(number_of_calls)
#2013-01-16:1   Min.   : 13930      
#2013-01-17:1   1st Qu.: 18554      
#2013-01-18:1   Median : 23182      
#2013-01-19:1   Mean   : 69443      
#2013-01-20:1   3rd Qu.: 43384      
#2013-01-21:1   Max.   :419278    

nrow(bothTiv)
#[1] 15
