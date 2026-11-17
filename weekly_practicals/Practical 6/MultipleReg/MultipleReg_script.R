# If you don't have carData installed yet, uncomment and run the line below
# install.packages(carData)
library(carData)
data(Salaries)
attach(Salaries)
head(Salaries)
summary(Salaries)

boxplot(salary, col=c('chartreuse4'), main="distributions") #outliers in the sample
means <- sapply(salary, mean)
points(means, col="gray", pch=22, lwd=7)
# mean > median

boxplot(Salaries[,3:4], col=c('pink', 'purple'), main="distributions") #based on years since hd and years in service
means <- sapply(Salaries[,3:4], mean)
points(means, col="gray", pch=22, lwd=7) # mean is outside the boxplot


# scatter plot salary versus yrs.since.phd
plot(salary ~ yrs.since.phd, cex=.6, main="salary vs yrs.since.phd", xlab="yrs.since.phd", ylab="salary")

# fit the model
model1 <- lm(salary ~ yrs.since.phd)
# add the line of the best fit on the scatter plot
abline(model1, lty=2, col=2)
summary(model1) # positive correlation
# years since phd explains 17.6% of variation in salary in this sample.

# scatter plot salary versus yrs.since.phd
plot(salary ~ yrs.service, cex=.6, main="salary vs yrs.service", xlab="yrs.service", ylab="salary")
# fit the model
model2 <- lm(salary ~ yrs.service)
# add the line of the best fit on the scatter plot
abline(model2, lty=2, col=2)
summary(model2) # years in service explains about 11.2% of variation in salary in this sample

mr_model <- lm(salary ~ yrs.since.phd + yrs.service)
summary(mr_model) # yrs since hd and yrs in service explain about 18.8% of variation in salary in this sample

summary(model1)$r.squared
summary(model2)$r.squared
summary(mr_model)$r.squared # this is the best model to use as it has the highest r squared

# finding if mr_model#s b1 = 0 for this 
# H0: b1yrssincephd = 0 and b2yrsinservice = 0
# H1: b1 or/and b2 =/ 0
# f stat = 45.71

qf(0.95, 2, 394) # f stat > 3.018626
# there is adequate statistical evidence to conclude that at least one of the 2 regressors are associated with salary earned (accept H0)


qt(0.95, 394)

# 2 tailed test
qt(0.975, 394)
# for both of these, we reject h0 so each regressor is associated with the regressee holding other regressors constant 

Salaries = 89912.2 + 1562.9PHD - 629.1SERVICE
# regression intercept is interpreted as the expected salary when years of service and years since phd are both equal to 0 (this is )

summary(Salaries)
# this however is not possible as the years since service minimum is 1 and not 0 so this does not make sense in this model

# 1562.9 = in this sample, holding years in service constant, for every 1 year increase in phd, the salaries are expected to increase by 1562.9
# in this sample for every extra year since service, comparing individuals with the same years spent doing a phd, salaries decrease by629.1 dollars 