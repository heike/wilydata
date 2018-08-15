library(xml2)
library(readr)
library(rvest)
library(tidyverse)

baseURL <- "http://scrippsco2.ucsd.edu/data/atmospheric_co2"
# station data available at http://scrippsco2.ucsd.edu/data/atmospheric_co2/sampling_stations
stations <- "sampling_stations"

root <- read_html(file.path(baseURL, stations))
tables <- root %>% html_table(fill=TRUE)

scripps_stations <- tables[[1]]

# clean up station info

XXXX



# save station info into file

save(scripps_stations, file="data/scripps_stations.rda")

##############

station_url <- root %>% html_nodes(":nth-child(6) .rollover-links a") %>% html_attr("href")

stationURL <- file.path(baseURL, station_url)

get_daily_flask <- function (stationURL, type = "co2") {
  station_root <- read_html(stationURL)
  tables <- station_root %>% html_table(fill=TRUE)

  table_urls <- station_root %>% html_nodes(".table-cell-borders a") %>% html_attr("href")
  length(tables)
}
