#!/usr/bin/Rscript

library(wilyscraper)

ames_wunderground <- wUnderground_data()
usethis::use_data(ames_wunderground, file = "data/ames_wunderground.rda",
                  overwrite = T)
