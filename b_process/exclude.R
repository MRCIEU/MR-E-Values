#Import the Home varible from bash
HOME=Sys.getenv("HOME")

#Put filepaths in variables
DATA=paste(HOME, "/scratch/MR-E-Value/data/", sep="")

#Load packages
library(data.table)

##################
# LOAD AND MERGE #
##################

#Load data
setwd(DATA)
data<-read.table("data-mr.txt", header=TRUE)
dates<-read.table("exclude.txt", header=TRUE)
data<-merge(data, dates)
nrow(dates)

###################################
# EXCLUDE OUTCOME BEFORE BASELINE #
###################################

data_reg <- subset(data, SCHZ_Before_Baseline==0)
print("No Schizophrenia before baseline data")
print(nrow(data_reg))

#######################
# REMOVE MISSING DATA #
#######################

data_reg<-data_reg[!is.na(data_reg$Smoke),]
print("Smoke NAs removed")
print(nrow(data_reg))

########
# SAVE #
########

write.table(data_reg, "data-reg.txt", row.names=FALSE, sep = "\t", quote=FALSE)
