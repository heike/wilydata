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

scripps_stations <- scripps_stations %>%
  mutate(  # remove degree character
    Latitude = gsub("°", "", Latitude),
    Longitude = gsub("°", "", Longitude),
    dir_lat =  str_detect(Latitude, "S"),
    dir_long =  str_detect(Longitude, "W")
  ) %>%
  mutate(
    Latitude = parse_number(Latitude) * ifelse(dir_lat, -1, 1),
    Longitude = parse_number(Longitude) * ifelse(dir_long, -1, 1),
    Longitude = replace(Longitude, is.na(Longitude), 0)
  ) %>%
  select(- starts_with("dir"))



# save station info into file

save(scripps_stations, file="data/scripps_stations.rda")

##############
get_station_data <- function (stationURL, type = "daily_flask_co2", dataURL="http://scrippsco2.ucsd.edu") {
  station_root <- read_html(stationURL)

  table_urls <- station_root %>% html_nodes(".table-cell-borders a") %>% html_attr("href")
  idx <- grep(type, table_urls)
  if (length(idx) < 1) stop(sprintf("No measurements available for %s", type))
  if (length(idx) > 1) stop(sprintf("Multiple measurement files available for '%s', specify: %s", type, paste(basename(table_urls[idx]), collapse = ", ")))

  # now we only have one option, so let's download that file
  data <- readr::read_csv(file.path(dataURL, table_urls[idx]), skip=69, col_names =FALSE)
  rename(data,
         date = "X1",
         time = "X2",
         excel.date = "X3",
         num.year = "X4",
         n = "X5",
         flag = "X6",
         co2 = "X7")
}

safe_load <- safely(get_station_data)

station_url <- root %>% html_nodes(":nth-child(6) .rollover-links a") %>% html_attr("href")

scripps_data_co2 <- file.path(baseURL, station_url) %>%
  purrr::map_df(.f = function(s) {
    res <- safe_load(s, type="daily_flask_co2")
    if (!is.null(res$result)) res$result$station_id <- basename(s)
    res$result
  })

save(scripps_data_co2, file="data/scripps_data_co2.rda")
