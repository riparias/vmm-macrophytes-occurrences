# load libraries
library(testthat)
library(readr)
library(dplyr)
library(here)

# read proposed new version of the DwC mapping
event_path <- here::here("data", "processed", "event.csv")
occ_path <- here::here("data", "processed", "occurrence.csv")
mof_path <- here::here("data", "processed", "mof.csv")
dwc_event <- readr::read_csv(event_path, guess_max = 10000)
dwc_occurrence <- readr::read_csv(occ_path, guess_max = 10000)
dwc_mof <- readr::read_csv(mof_path, guess_max = 10000)

# test event core
testthat::test_that("Right columns in right order in event core", {
  columns_event <- c(
    "type",
    "language",
    "license",
    "rightsHolder",
    "accessRights",
    "datasetID",
    "institutionCode",
    "datasetName",
    "eventID",
    "eventDate",
    "samplingProtocol",
    "locationID",
    "waterBody",
    "countryCode",
    "stateProvince",
    "municipality",
    "minimumDepthInMeters",
    "maximumDepthInMeters",
    "locationRemarks",
    "decimalLatitude",
    "decimalLongitude",
    "geodeticDatum",
    "coordinateUncertaintyInMeters",
    "verbatimLatitude",
    "verbatimLongitude",
    "verbatimSRS",
    "verbatimCoordinateSystem"
  )
  testthat::expect_equal(names(dwc_event), columns_event)
})

testthat::test_that("eventID is always present and is unique in event core", {
  testthat::expect_true(all(!is.na(dwc_event$eventID)))
  testthat::expect_equal(length(unique(dwc_event$eventID)),
                         nrow(dwc_event))
})

testthat::test_that("eventDate is always filled in", {
  testthat::expect_true(all(!is.na(dwc_event$eventDate)))
})

testthat::test_that("samplingProtocol is always filled in = transect monitoring", {
  testthat::expect_true(all(!is.na(dwc_event$samplingProtocol)))
  testthat::expect_equal(unique(dwc_event$samplingProtocol),
                         "transect monitoring"
  )
})

testthat::test_that("decimalLatitude is always filled in", {
  testthat::expect_true(all(!is.na(dwc_event$decimalLatitude)))
})

testthat::test_that("decimalLatitude is within Flemish boundaries", {
  testthat::expect_true(all(dwc_event$decimalLatitude < 51.65))
  testthat::expect_true(all(dwc_event$decimalLatitude > 50.63))
})

testthat::test_that("decimalLongitude is always filled in", {
  testthat::expect_true(all(!is.na(dwc_event$decimalLongitude)))
})

testthat::test_that("decimalLongitude is within Flemish boundaries", {
  testthat::expect_true(all(dwc_event$decimalLongitude < 5.95))
  testthat::expect_true(all(dwc_event$decimalLongitude > 2.450))
})

testthat::test_that("locationID is always filled in", {
  testthat::expect_true(all(!is.na(dwc_event$locationID)))
})

testthat::test_that("countryCode is always filled in", {
  testthat::expect_true(all(!is.na(dwc_event$countryCode)))
})

testthat::test_that("locationRemarks is always filled in", {
  testthat::expect_true(all(!is.na(dwc_event$locationRemarks)))
})

testthat::test_that("geodeticDatum is always filled in and equal to WGS84", {
  testthat::expect_true(all(!is.na(dwc_event$geodeticDatum)))
  testthat::expect_equal(unique(dwc_event$geodeticDatum), "WGS84")
})

testthat::test_that("verbatimSRS is always filled in and equal to EPSG:31370", {
  testthat::expect_true(all(!is.na(dwc_event$verbatimSRS)))
  testthat::expect_equal(unique(dwc_event$verbatimSRS), "EPSG:31370")
})

testthat::test_that("coordinateUncertaintyInMeters is always filled in and equal to 100", {
  testthat::expect_true(all(!is.na(dwc_event$coordinateUncertaintyInMeters)))
  testthat::expect_equal(unique(dwc_event$coordinateUncertaintyInMeters), 100)
})

