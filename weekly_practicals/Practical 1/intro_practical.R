# introduction-first practical

# setting working trajectory
setwd("C:/Users/brise/Desktop/Uni/econ(26-27)/Answering social statistics questions/practicals/P_1")

# installing packages = install.packages() with the name of the package in ()

#-----CALCULATING IN R-----------
2+2 # the [1] indicates that there is only 1 number in the answer

#calculation table
# + addition
# - subtraction
# * multiplication
# / division
# ^ or ** for exponentiation/raising powers
# x %% y modulus (xmody)--> 5%%2 = 1 5 divided by 2 is 2 with a remainder of 1
# x %/% y integer division 5 %/% 2 is 2 5/2 = 2.5 round down to integer.

# logic operators 
#  < less than
# <= less than or equal to
# > greater than 
# >= greater than or equal to
# == exactly equal to 
# != not equal to
# !x not x
# x|y x or y
# x&y x and y
# isTRUE(x) test if X is true

# objects
x <- 5 #assignment shortcut is alt + -
y <- 6
z <- x*y
z

ls() # lists all objects
# mathematical functions
# sqrt(144)
# log10(8)
# log10(100)
# log(100)
# exp(1)
# pi
# sin(pi/2)
# abs(-7)
# factorial(3)
# exp(x)
# log(y, 2)

trunc(x^2 + z/y)

# nested functions and functions used in creating new objects
round(exp(x), 2) # ROUND THE EXPONENTIAL OF X TO 2 SIG FIG

# to obtain description of function type question mark ? infront of name of function
?lm()

#-----vectors-----------
#  variables with one or more values of the same type = VECTORS
# variable with single value = scalar so vector of length 1

# assigning vectors
#  colon symbol
x <- 1:10 # vector with 10 values
x
# or rep() for replicating given number for a given number of times
x <- rep(1,10)
x
# or using concatenation function c() allowing you to enter one number at a time
x <- c(2, 3, 7)
x

# or created as a sequence of numbers 
# for sequence of numbers from 1 to 10 with increments of 0.2:
seq(1, 10, 0.2)

x <- rep(1,10)
y <- 1:10
c(x, y) # concatenates these vectors into 1 by putting thenumbers in order

x+y # adds each value of one vector to the respective value at that positioned
x+2*y # multiplies each value of y by 2 and adds it to the value at corresponding position in x vector

# to access a vector's element use index inside []
y[5]

# evaluating functions over entire vector helps avoid looping
y <- c(5,3,1,x)
max(y)
range(y)
mean(y)
var(y)
sort(y)
cumsum(y)
y

# NA in a vector is shown when an index is out of range

# matrix
ma1 <- matrix(c(1, 0, -20, 0, 1, -15, 1, -1, 0),
              nrow = 3, ncol = 3, 
              byrow = TRUE) #when false the matrix is filled row by row, when true the matrix is filled column by column
ma1

dim(ma1) #dimension of matrix 3x3
# finding specific element of matrix [ith row, jth column]
ma1[1, 3] # -20 at first row 3rd column
#finding whole 2nd row
ma1[2,]
# finding whole 1st column
ma1[ ,1]
