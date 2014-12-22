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


#FIRST ANALYSIS ATTEMPT WITH CHANGES TO PLOT TITLES

#plot for calls with Touba as incoming site, the sites ids are:
#1043, 1054, 1046, 1049, 1055, 1050

touba1 <- subset(set12v, incoming_site_id == 1043)
touba2 <- subset(set12v, incoming_site_id == 1054)
touba3 <- subset(set12v, incoming_site_id == 1046)
touba4 <- subset(set12v, incoming_site_id == 1049)
touba5 <- subset(set12v, incoming_site_id == 1055)
touba6 <- subset(set12v, incoming_site_id == 1050)
toubaIncoming <- rbind(touba1, touba2, touba3, touba4, touba5, touba6)

#test combination of the above subsets
View(toubaIncoming)
unique(toubaIncoming$incoming_site_id)

#Produce plots for Touba as incoming city 
grpIncomingCity <- group_by(toubaIncoming, timestamp)
grpincomingcity1 <- summarize(grpIncomingCity, number_of_calls = sum(number_of_calls), total_call_duration = sum(total_call_duration))
plot(grpincomingcity1$timestamp, grpincomingcity1$number_of_calls, main="Calls for Magal Dec 22,2013 with Touba as incoming city for calls", xlab="Time", ylab="Nb calls")

#Next for touba as outgoing city 
toubaA <- subset(set12v, outgoing_site_id == 1043)
toubaB <- subset(set12v, outgoing_site_id == 1054)
toubaC <- subset(set12v, outgoing_site_id == 1046)
toubaD <- subset(set12v, outgoing_site_id == 1049)
toubaE <- subset(set12v, outgoing_site_id == 1055)
toubaF <- subset(set12v, outgoing_site_id == 1050)
toubaOutgoing <- rbind(toubaA, toubaB, toubaC, toubaD, toubaE, toubaF)

#test combination of the above subsets
View(toubaOutgoing)
unique(toubaOutgoing$outgoing_site_id)

#Produce plots for Touba as outgoing city 
grpOutgoingCity <- group_by(toubaOutgoing, timestamp)
grpoutgoingcity1 <- summarize(grpOutgoingCity, number_of_calls = sum(number_of_calls), total_call_duration = sum(total_call_duration))
plot(grpoutgoingcity1$timestamp, grpoutgoingcity1$number_of_calls, main="Calls for Magal Dec 22,2013 with Touba as outcoming city for calls", xlab="Time", ylab="Nb calls")


#touba as both incoming and outgoing 
t1 <- subset(set12v, incoming_site_id == 1043 & outgoing_site_id == 1043)
t2 <- subset(set12v, incoming_site_id == 1054 & outgoing_site_id == 1054)
t3 <- subset(set12v, incoming_site_id == 1046 & outgoing_site_id == 1046)
t4 <- subset(set12v, incoming_site_id == 1049 &  outgoing_site_id == 1049)
t5 <- subset(set12v, incoming_site_id == 1055 & outgoing_site_id == 1055)
t6 <- subset(set12v, incoming_site_id == 1050 & outgoing_site_id == 1050)

withinCity <- rbind(t1, t2, t3, t4, t5, t6)

#test combination of the above subsets
View(withinCity)
unique(withinCity$outgoing_site_id)
unique(withinCity$incoming_site_id)

#produce plots for Touba as both incoming and outgoing city of origin
grpWithinCity <- group_by(withinCity, timestamp)
grpwithincity1 <- summarize(grpWithinCity, number_of_calls = sum(number_of_calls), total_call_duration = sum(total_call_duration))
plot(grpwithincity1$timestamp, grpwithincity1$number_of_calls, main="Calls for Magal Dec 22,2013 with Touba as incoming or outgoing city of origin", xlab="Time", ylab="Nb calls")

#SECOND ANALYSIS ATTEMPT

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
plot(grpincomingcity12$timestamp, grpincomingcity12$number_of_calls, main="Calls for Magal Dec 22,2013 with Touba as incoming city for calls(3rd)", xlab="Time", ylab="Nb calls")

#touba as outgoing city of origin 
toubaOutgoing2 <- subset(set12v, outgoing_site_id == 1043 | outgoing_site_id == 1054 | outgoing_site_id == 1046 
                    | outgoing_site_id == 1049 | outgoing_site_id == 1055 
                    | outgoing_site_id == 1050)

grpOutgoingCity2 <- group_by(toubaOutgoing2, timestamp)
grpoutgoingcity12 <- summarize(grpOutgoingCity2, number_of_calls = sum(number_of_calls), total_call_duration = sum(total_call_duration))
plot(grpoutgoingcity12$timestamp, grpoutgoingcity12$number_of_calls, main="Calls for Magal Dec 22,2013 with Touba as outcoming city for calls(3rd)", xlab="Time", ylab="Nb calls")

#touba as both 
withinCity2 <- subset((set12v, outgoing_site_id == 1043 | outgoing_site_id == 1054 | outgoing_site_id == 1046 
                      | outgoing_site_id == 1049 | outgoing_site_id == 1055 
                      | outgoing_site_id == 1050) & 
                      (set12v, incoming_site_id == 1043 | incoming_site_id == 1054 | incoming_site_id == 1046 
                         | incoming_site_id == 1049 | incoming_site_id == 1055 
                         | incoming_site_id == 1050))

grpWithinCity2 <- group_by(withinCity2, timestamp)
grpwithincity12 <- summarize(grpWithinCity2, number_of_calls = sum(number_of_calls), total_call_duration = sum(total_call_duration))
plot(grpwithincity12$timestamp, grpwithincity12$number_of_calls, main="Calls for Magal Dec 22,2013 with Touba as both(3rd)", xlab="Time", ylab="Nb calls")



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
plot(both, main = "both")

