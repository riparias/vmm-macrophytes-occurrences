/*
Created by Damiano Oldoni (INBO)
*/

SELECT
-- RECORD-LEVEL
  'Event'                               AS type,
  'en'                                  AS language,
  'https://creativecommons.org/licenses/by/4.0/' AS license,
  'VMM'                                 AS rightsHolder,
  'http://www.inbo.be/en/norms-for-data-use' AS accessRights,
  'https://doi.org/10.15468/8e9te4'     AS datasetID,
  'VMM'                                 AS institutionCode,
  'VMM - Inland water macrophyte occurrences in Flanders, Belgium' AS datasetName,
-- EVENT
  f.deelmonster_id                      AS eventID,
  date(f.monsternamedatum)              AS eventDate,
  'transect monitoring'                 AS samplingProtocol,
-- LOCATION
  f.meetplaats                          AS locationID,
  l.waterlichaam                        AS waterBody,
  'BE'                                  AS countryCode,
  CASE
    WHEN l.provincie = 'Antwerpen' THEN 'Antwerp'
    WHEN l.provincie = 'Brussel (pro forma)' THEN 'Brussels-Capital Region'
    WHEN l.provincie = 'Henegouwen' THEN 'Hainaut'
    WHEN l.provincie = 'Limburg' THEN 'Limburg'
    WHEN l.provincie = 'Luik' THEN 'Liège'
    WHEN l.provincie = 'Oost-Vlaanderen' THEN 'East Flanders'
    WHEN l.provincie = 'Vlaams-Brabant' THEN 'Flemish Brabant'
    WHEN l.provincie = 'West-Vlaanderen' THEN 'West Flanders'
  END                                   AS stateProvince,
  l.gemeente                            AS municipality,
  CASE
    WHEN f."Diepte Minimum (cm)" IS NULL THEN 0
    ELSE CAST(f."Diepte Maximum (cm)" AS REAL) / 100
  END                                   AS minimumDepthInMeters,
  CAST(f."Diepte Maximum (cm)" AS REAL) / 100 AS maximumDepthInMeters,
  l.omschrijving                        AS locationRemarks,
  printf('%.5f', ROUND(l.decimalLatitude, 5)) AS decimalLatitude,
  printf('%.5f', ROUND(l.decimalLongitude, 5)) AS decimalLongitude,
  'WGS84'                               AS geodeticDatum,
  100                                   AS coordinateUncertaintyInMeters, -- 100m transects
  l.Y                                   AS verbatimLatitude,
  l.X                                   AS verbatimLongitude,
  'EPSG:31370'                          AS verbatimSRS,
  'Belgian Lambert 72'                  AS verbatimCoordinateSystem

FROM features AS f
  LEFT JOIN locations AS l
    ON f.meetplaats = l.meetplaats
