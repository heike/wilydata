#!/usr/bin/Rscript

library(tidyverse)
library(wilyscraper)

ames_weather_api <- noaa_api_data()
save(ames_weather_api, file = "data/ames_weather_api.rda")
