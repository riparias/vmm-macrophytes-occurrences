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
  '{{"watercourse":"' || p.waterloop ||
    '", "basin":"' || p.bekken || 
    '", "waterbodySurfaceCode":"' || p.owl || 
    '", "waterbodyCategory":"' || p.waterlichaamcategorietype ||
    '"}}'                               AS dynamicProperties,
-- EVENT
  f.deelmonster_id                      AS eventID,
  date(f.monsternamedatum)              AS eventDate,
-- LOCATION
  f.meetplaats                          AS locationID,
  'Europe'                              AS continent,
  p.waterlichaam                        AS waterBody,
  'BE'                                  AS countryCode,
  CASE
    WHEN p.provincie = 'Antwerpen' THEN 'Antwerp'
    WHEN p.provincie = 'Brussel (pro forma)' THEN 'Brussels-Capital Region'
    WHEN p.provincie = 'Henegouwen' THEN 'Hainaut'
    WHEN p.provincie = 'Limburg' THEN 'Limburg'
    WHEN p.provincie = 'Luik' THEN 'Liège'
    WHEN p.provincie = 'Oost-Vlaanderen' THEN 'East Flanders'
    WHEN p.provincie = 'Vlaams-Brabant' THEN 'Flemish Brabant'
    WHEN p.provincie = 'West-Vlaanderen' THEN 'West Flanders'
  END                                   AS stateProvince,
  p.gemeente                            AS municipality,
  0                                     AS minimumDepthInMeters,
  CAST(f.'Diepte Maximum (cm)' AS REAL) / 100 AS maximumDepthInMeters,
  p.omschrijving                        AS locationRemarks,
  printf('%.5f', ROUND(p.decimalLatitude, 5)) AS decimalLatitude,
  printf('%.5f', ROUND(p.decimalLongitude, 5)) AS decimalLongitude,
  'WGS84'                               AS geodeticDatum,
  30                                    AS coordinateUncertaintyInMeters,
  p.Y                                   AS verbatimLatitude,
  p.X                                   AS verbatimLongitude,
  'EPSG:31370'                          AS verbatimSRS,
  'Belgian Lambert 72'                  AS verbatimCoordinateSystem

FROM features AS f
  LEFT JOIN positions AS p
    ON f.meetplaats = p.meetplaats
