### ### ### ### ### ### 
### CREATE PACKAGES ###
### ### ### ### ### ### 
# taken from Hilary Parkers blog: https://hilaryparker.com
library(devtools)
library(roxygen2)

setwd("/Users/bryankim/Documents/R/Packages") # set as parent directory
create("cleanly")

setwd("/Users/bryankim/Documents/R/Packages")
setwd("./cleanly")
document()
setwd("..")
install("cleanly")
