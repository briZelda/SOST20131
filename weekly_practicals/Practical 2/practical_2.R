# practical 2-intro to r
# ---BASIC STATS CONCEPTS 

# definitions
# Population - set of all people/objects of interest in the study being undertaken
# whole data set = population representing perfect info
# but we take sample to make inferences about pop.

# samples chosen in such a way that each item in the population has an equal
# chance of being included in random sample

# Attribute variables: are variables that have their outcomes described in terms of their characteristics or attributes.
# WAY OF HANDLING: give numerical code so often referred to as coded vars

# Measured variables: are variables that have their outcomes taken from a numerical scale; the resulting outcome is expressed in numerical terms
# types of measured variables = continuous variables and discrete variables

# concept of stat distributions (usually bar charts)
# attribute variable the number of occurrences of each attribute is obtained
# measured variable the sample descriptive statistics describing the centre, width and symmetry of the distribution are calculated. #i.e., normal dist

# what does a distribution SHOW
# attribute var: frequency of occurence of each level of the attribute variable
# measured var: area under the curve from one value to another measures the relative proportion of the population having the outcome value in that range.

# stat dist uses centre width and symmetry of dist
# centre measures: mean median
# width measures: sd and iqr
# Q1 is the value of the variable that divides the distribution 25% to the left and 75% to the right.
# Q2 is the value of the variable that divides the distribution 50% to the left and 50% to the right. This is the median by definition.
# Q3 is the value of the variable that divides the distribution 75% to the left and 25% to the right.
# The inter-quartile range is the value Q3 - Q1
# Pearson's coefficient of Skewness = 3(mean - median) / standard deviation
# Quartile Measure of Skewness  = [(Q1 - Q3) - (Q2 - Q1)]/(Q3 - Q1)

# # relationships between vars
# A response variable is a variable that measures either directly or indirectly the objectives of the analysis.
# 
# An explanatory variable is a variable that may influence the response variable



# ----------DATA TYPES
# checking the mode and class of objects

x <- 1:10 # vector
mode(x) # mode tells us if an object is numeric
class(x) # class tells us the type of variable we are dealing with

ice_cream_flavours <- c("chocolate", "banana", "strawberry", "vanilla")
mode(ice_cream_flavours) #character data

# categorical vars = factors, if we want it to be split into categories we use factor
# Note that R codes the factor levels in their alphabetical order. However, attribute variables are usually coded and you would usually enter them as such

ice_cream_flavours <- factor(ice_cream_flavours) # 4 levels


quality <- factor(c(3, 3, 4, 2, 2, 4, 0, 1)) 
levels(quality)

is.numeric(ice_cream_flavours) # logical data type, meaning TRUE OR FALSE
# false because ice cream flavours is not numeric
is.factor(ice_cream_flavours) # is factor -> as it object includes character type data and is encoded as having levels due to factor func.


# data frame example
# study: random sample where n=15
share_price <- c(880, 862, 850, 840, 838, 799, 783, 777, 767, 746, 692, 689, 683, 661, 658)
profit <- c(161.3, 170.5, 140.7, 115.7, 107.9, 135.2, 142.7, 114.9, 110.4, 98.9, 90.2, 80.6, 85.4, 91.7, 137.8)
sector <- factor(c(3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1)) # 1:IT, 2:Finance, 3:Pharmaceutical

# better to keep these related objects in a data frame instead of as individual objects
share.data <- data.frame(share_price, profit, sector)
# accessing individual sectors from dataframe involves using $:
share.data$share_price


# --------------IMporting data to R
# can import data via online link
#leedsLib <- read.csv("https://datamillnorth.org/download/leeds-libraries/cfc9f345-4916-4b74-aa9e-cecc78db9075/library%2520locations.csv", 
        #             stringsAsFactors = FALSE, fileEncoding = "latin1")

#head(leedsLib, 10)

# or actually download it
leedslib <- read.csv("library locations.csv", stringsAsFactors = FALSE,
                     fileEncoding = "latin1")

# reading excel file = 1. download it
## If you don't have readr installed yet, uncomment and run the line below
install.packages("readxl")
library(readxl)
df_xl <- read_excel("Dec 2018 - YouGov GLA poll results.xls", sheet = 1)

#reading json files
## If you don't have readxl installed yet, uncomment the line below and run it 
install.packages("jsonlite")
library(jsonlite)

my_url <-"https://coronavirus.data.gov.uk/downloads/msoa_data/MSOAs_latest.json"
covid_uk <- fromJSON(my_url)
# fromJson() is function we use to extract json file data


# to speed up the reading process of txt, csv data files you can use data.table::fread() func
# You should only pass to the function the name of the data file you want to import, and fread() will try to work out the appropriate data structure. 
