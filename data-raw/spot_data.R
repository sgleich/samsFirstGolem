spotData <- read.csv("data-raw/spot_data.csv")

usethis::use_data(spotData,overwrite=TRUE)
