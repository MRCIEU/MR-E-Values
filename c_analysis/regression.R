###################
# SET ENVIRONMENT #
###################

#Import HOME variable from Bash
HOME=Sys.getenv("HOME")

#Put path in variable
DATA=paste(HOME, "/scratch/MR-E-Value/data/", sep="")

#Load data.table package
library(data.table)

################
# PREPARE DATA #
################

#Read
setwd(DATA)
data<-fread("data-reg.txt", header=TRUE, data.table=F)

##############
# REGRESSION #
##############

#Prevelance
print(nrow(data[data$Schz==1,])/nrow(data))
print(nrow(data[data$Smoke==1,])/nrow(data))

#MR-E-Value input
fit <- glm(Schz ~ scale(Smoke), data=data, family = "gaussian")
print(coef(fit)["scale(Smoke)"])
print(confint(fit, "scale(Smoke)", level=0.95))
print(sd(data$Smoke))

