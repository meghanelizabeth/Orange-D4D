library(data.table)
library(reshape)
library(dplyr)
library(doBy)
library(ggplot2)

setwd("/Users/meghanjordan/Workspace/D4D/SET1")

#####################################################
# Diagnostics for sms set 1 data for months 1 and 2 #
#####################################################

#extract siteid from arr_id 15-18
> extract_test <- subset(arr_id_list, arr_id >= 15 & arr_id <= 18)





