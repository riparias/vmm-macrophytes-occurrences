/*
Created by Damiano Oldoni (INBO)
*/

SELECT
-- RECORD-LEVEL
  'Event'                               AS type,
  'https://creativecommons.org/licenses/by/4.0/' AS license,
  'VMM'                                 AS rightsHolder,
  'http://www.inbo.be/en/norms-for-data-use' AS accessRights,
  NULL                                  AS datasetID,
  'VMM'                                 AS institutionCode,
  'Inland water macrophyte occurrences in Flanders, Belgium' AS datasetName,
  'HumanObservation'                    AS basisOfRecord,
-- EVENT
  f.deelmonster_id                      AS eventID,
  date(f.monsternamedatum)              AS eventDate,
-- LOCATION
  f.meetplaats                          AS locationID,
  'Europe'                              AS continent,
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
  0                                     AS minimumDepthInMeters,
  CAST(f.'Diepte Maximum (cm)' AS REAL) / 100 AS maximumDepthInMeters,
  l.omschrijving                        AS locationRemarks,
  printf('%.5f', ROUND(l.decimalLatitude, 5)) AS decimalLatitude,
  printf('%.5f', ROUND(l.decimalLongitude, 5)) AS decimalLongitude,
  'WGS84'                               AS geodeticDatum,
  30                                    AS coordinateUncertaintyInMeters,
  l.Y                                   AS verbatimLatitude,
  l.X                                   AS verbatimLongitude,
  'EPSG:31370'                          AS verbatimSRS,
  'Belgian Lambert 72'                  AS verbatimCoordinateSystem

FROM features AS f
  LEFT JOIN locations AS l
    ON f.meetplaats = l.meetplaats
