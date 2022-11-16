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


# test occurrence extension

testthat::test_that("Right columns in right order in occurrence extension", {
  columns_occ <- c(
    "eventID",
    "basisOfRecord",
    "occurrenceID",
    "recordedBy",
    "organismQuantity",
    "organismQuantityType",
    "occurrenceRemarks",
    "identifiedBy",
    "identificationVerificationStatus",
    "scientificName",
    "kingdom",
    "taxonRank",
    "vernacularName"
  )
  testthat::expect_equal(names(dwc_occurrence), columns_occ)
})

testthat::test_that(
  "occurrenceID is always present and is unique in occurrence extension", {
    testthat::expect_true(all(!is.na(dwc_occurrence$occurrenceID)))
    testthat::expect_equal(length(unique(dwc_occurrence$occurrenceID)),
                           nrow(dwc_occurrence)
    )
  })

testthat::test_that("eventID is always present in occurrence extension", {
  testthat::expect_true(all(!is.na(dwc_occurrence$eventID)))
})

testthat::test_that("All eventIDs are in event core ", {
  testthat::expect_true(all(dwc_occurrence$eventID %in% dwc_event$eventID))
})

testthat::test_that(
  "basisOfRecord is always filled in and is 'HumanObservation'", {
  testthat::expect_true(all(!is.na(dwc_occurrence$basisOfRecord)))
  testthat::expect_equal(unique(dwc_occurrence$basisOfRecord),
                         "HumanObservation"
  )
})

testthat::test_that("recordedBy is always filled in", {
    testthat::expect_true(all(!is.na(dwc_occurrence$recordedBy)))
})

testthat::test_that("organismQuantity is always filled in and one in list", {
  testthat::expect_true(all(!is.na(dwc_occurrence$organismQuantity)))
  testthat::expect_equal(
    unique(dwc_occurrence$organismQuantity),
    c("o", "s", "la", "f", "a", "c", "d")
  )
})

testthat::test_that(
  "organismQuantityType is always filled in and is 'Tansley vegetation scale'", 
  {
    testthat::expect_true(all(!is.na(dwc_occurrence$organismQuantityType)))
    testthat::expect_equal(
      unique(dwc_occurrence$organismQuantityType),
      "Tansley vegetation scale"
    )
  }
)

testthat::test_that("occurrenceRemarks starts always with 'growth form'", {
  testthat::expect_equal(
    unique(substring(dwc_occurrence$occurrenceRemarks, 1, 11)),
    "growth form"
  )
})


testthat::test_that("identificationVerificationStatus is always present and is 'verified'", {
  testthat::expect_true(
    all(!is.na(dwc_occurrence$identificationVerificationStatus))
  )
  testthat::expect_equal(
    unique(dwc_occurrence$identificationVerificationStatus),
    "verified"
  )
})

testthat::test_that("kingdom is always filled in and is always Plantae", {
  testthat::expect_true(all(!is.na(dwc_occurrence$kingdom)))
  testthat::expect_equal(unique(dwc_occurrence$kingdom), "Plantae")
})

testthat::test_that("taxonRank is always filled in", {
  testthat::expect_true(all(!is.na(dwc_occurrence$taxonRank)))
})

testthat::test_that("scientificName is always filled in", {
  testthat::expect_true(all(!is.na(dwc_occurrence$scientificName)))
})


# test mof extension

testthat::test_that("Right columns in right order in mof extension", {
  columns_mof <- c(
    "eventID",
    "measurementType",
    "measurementValue",
    "measurementUnit",
    "measurementRemarks"
  )
  testthat::expect_equal(names(dwc_mof), columns_mof)
})

testthat::test_that("eventID is always present in mof extension", {
  testthat::expect_true(all(!is.na(dwc_mof$eventID)))
})

testthat::test_that("All eventIDs are in event core ", {
  testthat::expect_true(all(dwc_mof$eventID %in% dwc_event$eventID))
})

testthat::test_that("measurementType is always filled in", {
  testthat::expect_true(all(!is.na(dwc_mof$measurementType)))
})

testthat::test_that("measurementUnit is one of the list", {
  testthat::expect_equal(unique(dwc_mof$measurementUnit),
                         c("cm", NA, "mg/L", "µS/cm", "%", "°C")
  )
})
