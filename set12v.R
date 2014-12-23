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


#Dr Scharff's approach 1
incomingCityNotTouba1 <- subset(toubaIncoming, outgoing_site_id != 1043 & outgoing_site_id != 1054 & outgoing_site_id != 1046 & outgoing_site_id != 1049 & outgoing_site_id != 1055 & outgoing_site_id != 1050)
nrow(incomingCityNotTouba1)
#[1] 314827

#Dr Scharff's approach 2
incomingCityNotTouba2 <- subset(set12v, 
                                (outgoing_site_id != 1043 & outgoing_site_id != 1054 & outgoing_site_id != 1046 & outgoing_site_id != 1049 & outgoing_site_id != 1055 & outgoing_site_id != 1050) & 
                                  (incoming_site_id == 1043 | incoming_site_id == 1054 | incoming_site_id == 1046 | incoming_site_id == 1049 | incoming_site_id == 1055 | incoming_site_id == 1050)
)
nrow(incomingCityNotTouba2)
#[1] 314827

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
plot(both, main = "Frequency of calls with Touba as receiving and originating city")
points(both[c(8),][1], both[c(8),][2], col=2)



nrow(both)