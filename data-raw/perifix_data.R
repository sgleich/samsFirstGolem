periData <- read.csv("data-raw/data.csv")
head(periData)
usethis::use_data(periData,overwrite=TRUE)
