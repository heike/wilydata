
#' Station information for the Scripps stations
#'
#' Information on all active Scripps stations (on Accessed data, see data).
#' The data is scraped from the Scripps Project at \url{http://scrippsco2.ucsd.edu/}.
#' @format A data frame with 10 rows and 8 variables:
#' \describe{
#'   \item{Station Name}{name of the station and country/state.}
#'   \item{Station Code}{three letter station abbreviation. }
#'   \item{Latitude}{geographic latitude in degrees North.}
#'   \item{Longitude}{geographic longitude in degrees East.}
#'   \item{Elevation}{elevation above sea level in meters.}
#'   \item{Dates}{Period of active status.}
#'   \item{Page}{URL of station information.}
#'   \item{Accessed}{Date last accessed.}
#' }
#' @keywords data
"scripps_stations"

#' CO2 daily flask data from Scripps stations
#'
#' CO2 flask data of all active Scripps stations, downloaded on Aug 15 2018.
#' @format A data frame with 12868 rows and 9 variables:
#' \describe{
#'   \item{date}{Date the sample was taken.}
#'   \item{time}{(hms) Time the sample was taken. }
#'   \item{excel.date}{exactly that.}
#'   \item{num.year}{time and date in numeric format.}
#'   \item{n}{Number of samples.}
#'   \item{flag}{Quality flag for the sample: 0 is accepted, negative values are also accepted but with conditions, positive values indicate abnormalities and are rejected.}
#'   \item{co2}{CO2 concentration, measured on the '08A' Calibration Scale.}                   ".}
#'   \item{station_id}{Three letter abbreviation for the station.}
#'   \item{accessed}{Date last accessed.}
#' }
#' @keywords data
"scripps_data_co2"

#' Minimum and Maximum Temperature in Ames, 2008 - present
#'
#' Minimum and maximum temperature from weather stations in Ames, IA. Temperature values are in tenths of a degree celsius.
#' @format A data frame with 5 columns:
#' \describe{
#'   \item{id}{Station ID}
#'   \item{date}{Date, in ymd format}
#'   \item{tmax}{Maximum daily temperature, in tenths of a degree C}
#'   \item{tmin}{Minimum daily temperature, in tenths of a degree C}
#'   \item{Accessed}{Date last accessed.}
#' }
"ames_weather_api"
