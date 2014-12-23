
#tivaoune
tivSms <- read.csv(file="set1SMStivaouane.csv")
View(head(tivSms))


#plot for calls with Touba as incoming site, the sites ids are:
#604, 605, 606, 609

#tiv as incoming city of origin 
tivIncoming2 <- subset(tivSms, incoming_site_id == 604 | incoming_site_id == 605 | incoming_site_id == 606 
                       | incoming_site_id == 609)
#view
View(tivIncoming2)
nrow(tivIncoming2)
#[1] 202884

grpIncomingCity <- group_by(tivIncoming2, timestamp)
grpincomingcity <- summarize(grpIncomingCity, number_of_SMS = sum(number_of_SMS))
plot(grpincomingcity$timestamp, grpincomingcity$number_of_SMS, main="Frequency of SMS messages with Tivaouane as receiving city", xlab="Time", ylab="Nb sms")
points(grpincomingcity[c(8),][1], grpincomingcity[c(8),][2], col=2)

#tiv as outgoing city of origin 
tivOutgoing2 <- subset(tivSms, outgoing_site_id == 604 | outgoing_site_id == 605 | outgoing_site_id == 606
                       | outgoing_site_id == 609)

grpOutgoingCity <- group_by(tivOutgoing2, timestamp)
grpoutgoingcity <- summarize(grpOutgoingCity, number_of_SMS = sum(number_of_SMS))
plot(grpoutgoingcity$timestamp, grpoutgoingcity$number_of_SMS, main="Frequency of SMS messages with Tivaouane as originating city", xlab="Time", ylab="Nb sms") 
points(grpoutgoingcity[c(8),][1], grpoutgoingcity[c(8),][2], col=2)


#install SQL to R translator package
install.packages("sqldf")
require(sqldf)

#testing sqldf 
s01 <- sqldf("select incoming_site_id, timestamp from tivSms")
View(s01)

#BOTH using sqldf
bothTiv <- sqldf("SELECT timestamp, sum(number_of_SMS) FROM tivSms
where (outgoing_site_id = 604 or outgoing_site_id = 605 or outgoing_site_id = 606 or outgoing_site_id = 609) and 
(incoming_site_id = 604 or incoming_site_id = 605 or incoming_site_id = 606 or incoming_site_id = 609)
group by timestamp")

View(bothTiv)
plot(bothTiv, main = "Frequency of SMS with Tivaouane as receiving and originating city",xlab="Time", ylab="Nb sms")
points(bothTiv[c(8),][1], both[c(8),][2], col=2)

nrow(bothTiv)
#[1] 15

