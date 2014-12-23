#plots for set12SMStouba.csv
#Set 1 month 12 SMS, data already subsetting

#read in file 
set12s <- read.csv(file="set12SMStouba.csv")
View(head(set12s))

#install packages 
install.packages("data.table")
library(data.table)
install.packages("reshape")
library(reshape)
install.packages("dplyr")
library(dplyr)



#plot for sms with Touba as incoming site, the sites ids are:
#1043, 1054, 1046, 1049, 1055, 1050

#touba as incoming city of origin 
toubaIncoming2 <- subset(set12s, incoming_site_id == 1043 | incoming_site_id == 1054 | incoming_site_id == 1046 
                         | incoming_site_id == 1049 | incoming_site_id == 1055 
                         | incoming_site_id == 1050)
#view
View(toubaIncoming2)
nrow(toubaIncoming2)
#[1] 90447

grpIncomingCity2 <- group_by(toubaIncoming2, timestamp)
grpincomingcity12 <- summarize(grpIncomingCity2, number_of_SMS = sum(number_of_SMS))
plot(grpincomingcity12$timestamp, grpincomingcity12$number_of_SMS, main="Frequency of SMS messages with Touba as receiving city", xlab="Time", ylab="Nb SMS")
points(grpincomingcity12[c(8),][1], grpincomingcity12[c(8),][2], col=2)

#touba as outgoing city of origin 
toubaOutgoing2 <- subset(set12s, outgoing_site_id == 1043 | outgoing_site_id == 1054 | outgoing_site_id == 1046 
                         | outgoing_site_id == 1049 | outgoing_site_id == 1055 
                         | outgoing_site_id == 1050)

grpOutgoingCity2 <- group_by(toubaOutgoing2, timestamp)
grpoutgoingcity12 <- summarize(grpOutgoingCity2, number_of_SMS = sum(number_of_SMS))
plot(grpoutgoingcity12$timestamp, grpoutgoingcity12$number_of_SMS, main="Frequency of SMS messages with Touba as originating city", xlab="Time", ylab="Nb SMS") 
points(grpoutgoingcity12[c(8),][1], grpoutgoingcity12[c(8),][2], col=2)


#Dr Scharff's approach 1
incomingCityNotTouba1 <- subset(toubaIncoming2, outgoing_site_id != 1043 & outgoing_site_id != 1054 & outgoing_site_id != 1046 & outgoing_site_id != 1049 & outgoing_site_id != 1055 & outgoing_site_id != 1050)
nrow(incomingCityNotTouba1)
#[1] 86114

#Dr Scharff's approach 2
incomingCityNotTouba2 <- subset(set12s, 
                                (outgoing_site_id != 1043 & outgoing_site_id != 1054 & outgoing_site_id != 1046 & outgoing_site_id != 1049 & outgoing_site_id != 1055 & outgoing_site_id != 1050) & 
                                  (incoming_site_id == 1043 | incoming_site_id == 1054 | incoming_site_id == 1046 | incoming_site_id == 1049 | incoming_site_id == 1055 | incoming_site_id == 1050)
)
nrow(incomingCityNotTouba2)
#[1] 86114

#install SQL to R translator package
install.packages("sqldf")
require(sqldf)

#testing sqldf 
s01 <- sqldf("select incoming_site_id, timestamp from set12s")
View(s01)

#BOTH using sqldf
both <- sqldf("SELECT timestamp, sum(number_of_SMS) FROM set12s 
              where (outgoing_site_id = 1043 or outgoing_site_id = 1054 or outgoing_site_id = 1046 or outgoing_site_id = 1049 or outgoing_site_id = 1055 or outgoing_site_id = 1050) and 
              (incoming_site_id = 1043 or incoming_site_id = 1054 or incoming_site_id = 1046 or incoming_site_id = 1049 or incoming_site_id = 1055 or incoming_site_id = 1050)
              group by timestamp")

View(both)
plot(both, main = "Frequency of SMS messages with Touba as receiving and originating city", xlab="Time", ylab="Nb SMS")
points(both[c(8),][1], both[c(8),][2], col=2)

nrow(both)
#[1] 15
