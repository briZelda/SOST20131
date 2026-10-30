suppressPackageStartupMessages(library(dplyr))
# read csv file
companyd <- read.csv("https://tanjakec.github.io/mydata/SHARE_PRICE.csv", header=T)
# look at the data
glimpse(companyd)

# convert into factor type variables
companyd[, 5] <- as.factor(companyd[, 5])
companyd[, 6] <- as.factor(companyd[, 6])
companyd[, 7] <- as.factor(companyd[, 7])
# glance at data: what's the difference between the following two functions?
summary(companyd)
glimpse(companyd)
# glimpse provides information about the structure of the dataset, such as variable
# types and number of rows and columns, whereas summary gives information on the 
# values of the variables themselves; means, medians, quartiles, max and min values

attach(companyd)
names(companyd)

# task 1. 
  #----------investigating relationship for share_price vs RD 
  
  reg1 <- lm(Share_Price ~ RD)
  plot(Share_Price ~ RD, cex = .6, main = "Share Price = f(RD) + e")
  abline(reg1, lty = 2, col = 2)
  # evidence (visually) of some positive correlation, but a lot of scatter, though
  # line of best fit ia positive
  
  summary(reg1)
  coef(reg1)
  # "f" of RD seems to be positive=positive coefficient:
  # In this sample, an increase in company annual spending on research and development 
  # by £1000 is associated with a predicted increase in Share price by £4.10 on average.
  
  
  summary(reg1)$r.squared # this is = 0.311763
  # The R^2 tells us that Approximately 31% of variation in Share price in this model
  # is explained by annual spending on r&d in £1000
  
  # hypothesis testing of this outcome, assumed 5% level
  # H0: R^2 = 0 (there is no relationship between share price and RD annual spending)
  # H1: R^2 =/ 0 (there is indeed a relationship between them)
  
  summary(reg1) # the f statistic = 26.27 with dof 58 = one regressor and intercept, 
  # n-k-1 so 60 - 1 - 1 = 58
  
  # Rejection conditions:
  # If F stat < F critical value => Fail to reject H0
  # If F stat > F critical value => Reject H0
  
  F_crit <- qf(0.95, 1, 58)
  F_crit # 4.006873
  # In this case fstat > fcrit, 26.27>4.007, therefore there is sufficient evidence to 
  # reject H0 and thus conclude that there is indeed a relationship between share price and RD annual spending
  # at the 5% level.

  #----------investigating relationship for share_price vs Turnover
reg2 <- lm(Share_Price ~ Turnover)
plot(Share_Price~Turnover, cex = .6, main = "Share Price = f(Turnover) + e")
abline(reg2, lty = 2, col = 3) 
# there appears to be a positive correlation between the 2 variables

summary(reg2)
coef(reg2)
# In this sample, an increase in total company annual revenue by 1000000 is associated with a predicted increase in share price by 1.76 pounds

summary(reg2)$r.squared
# The R^2 value for this reg2 is 56.53% meaning that turnover explains 56.53% of variation in share price

# Rejection conditions:
# If F stat < F critical value => Fail to reject H0
# If F stat > F critical value => Reject H0

F_crit <- qf(0.95, 1, 58)
F_crit # 4.006873
# In this case fstat > fcrit, 75.43>4.007, therefore there is sufficient evidence to 
# reject H0 and thus conclude that there is indeed a relationship between share price and turnover
# at the 5% level.


  
  