#Import HOME variable from Bash
HOME=Sys.getenv("HOME")
LIB=Sys.getenv("LIB")

#Put path in variable
DATA=paste(HOME, "/scratch/MR-E-Value/data/", sep="")

#Load packages
library(data.table)
library(DescTools, lib=LIB)
library(ivreg, lib=LIB)

#############
# READ DATA #
#############

setwd(DATA)
data<-fread("data-mr.txt", header=TRUE, data.table=F)

################
# DESCRIPTIVES #
################

#SD
print(sd(data$Smoke, na.rm=TRUE))

#Prevelance
print(nrow(data[data$Schz==1,])/nrow(data))
print(nrow(data[data$Smoke==1,])/nrow(data))

###############
# RISK TAKING #
###############

#Risk Taking MR
MR <- function(iv, exposure, outcome, data){
	
	#Data
	iv.con<-iv[outcome==0]
	x.con<-exposure[outcome==0]
	data.con<-data[outcome==0,]

	#Strength
	fit <- lm(x.con~iv.con, data=data.con)
	print(summary(fit)$adj.r.squared)
	
	#MR
	m_iv <- glm(outcome~predict(lm(x.con~iv.con, data=data.con), newdata=list(iv.con=iv)), data=data, family="binomial")
	B <- coef(summary(m_iv))[2 ,"Estimate"]
	SE <- coef(summary(m_iv))[2 ,"Std. Error"]
	print(exp(B))
	print(exp(B-(1.96*SE)))
	print(exp(B+(1.96*SE)))
}

MR(data$risk_GRS, scale(data$Risk_Taking), data$Smoke, data)
MR(data$risk_GRS, scale(data$Risk_Taking), data$Schz, data)

####################
# MR-E_VALUE INPUT #
####################

m_iv<-ivreg(Schz ~ scale(Smoke) | smoke_GRS, data = data)
print(summary(m_iv)$diagnostics["Weak instruments","statistic"])
print(R2<-summary(m_iv)$adj.r.squared)
B <- coef(summary(m_iv))[2 ,"Estimate"]
SE <- coef(summary(m_iv))[2 ,"Std. Error"]
print(B)
print(B-(1.96*SE))
print(B+(1.96*SE))


