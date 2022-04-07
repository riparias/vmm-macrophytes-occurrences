/*
Created by Damiano Oldoni (INBO)
*/

/* RECORD-LEVEL */

SELECT
  'Event'                               AS type,
  'https://creativecommons.org/licenses/by/4.0/' AS license,
  'VMM'                                 AS rightsHolder,
  'http://www.inbo.be/en/norms-for-data-use' AS accessRights,
  NULL                                  AS datasetID,
  'VMM'                                 AS institutionCode,
  NULL                                AS collectionCode,
  'The inland water macrophyte occurrences in Flanders, Belgium' AS datasetName,
  NULL                                  AS ownerInstitutionCode,
  *
FROM (

SELECT
-- EVENT
  f.deelmonster_id                      AS eventID,
  NULL                                  AS parentEventID,
  date(f.monsternamedatum)              AS eventDate,
  f.Jaar                                AS year,    
  NULL                                  AS eventRemarks,
-- LOCATION
  p.meetplaats                          AS locationID,
  'Europe'                              AS continent,
  p.waterlichaam                        AS waterBody,
  'Belgium'                             AS country,
  'BE'                                  AS countryCode,
  p.provincie                           AS stateProvince,
  p.gemeente                            AS municipality,
  0                                     AS minimumDepthInMeters,
  CAST(f.'Diepte Maximum (cm)' AS REAL) / 100         AS maximumDepthInMeters,
  NULL                                  AS verbatimDepth,
  p.omschrijving                        AS locationRemarks,
  p.decimalLatitude                     AS decimalLatitude,
  p.decimalLongitude                    AS decimalLongitude,
  'EPSG:4326'                           AS geodeticDatum,
  p.Y                                   AS verbatimLatitude,
  p.X                                   AS verbatimLongitude,
  'EPSG:31370'                          AS verbatimCoordinateSystemProperty,
  '{{"watercourse":"' || p.waterloop ||
    '", "basin":"' || p.bekken || 
    '", "waterbodySurface":"' || p.owl || 
    '", "waterbodyCategory":"' || p.waterlichaamcategorietype || 
    '", "map":"' || p.kaart ||
    '"}}' AS dynamicProperties
FROM
  features AS f
  LEFT JOIN positions AS p
    ON p.meetplaats = f.meetplaats
)

UNION

/* 
to attach VEGETATIONS info at different 'interval' values as separate 
child events.
The few deelmonster IDs not present in features are excluded to avoid 
pointing to not existing parentEventID.
*/

SELECT
  'Event'                               AS type,
  'https://creativecommons.org/licenses/by/4.0/' AS license,
  'VMM'                                 AS rightsHolder,
  'http://www.inbo.be/en/norms-for-data-use' AS accessRights,
  NULL                                  AS datasetID,
  'VMM'                                 AS institutionCode,
  NULL                                  AS collectionCode,
  'Inland water macrophytes occurrences in Flanders' AS datasetName,
  'VMM'                                 AS ownerInstitutionCode,
  *
FROM (

SELECT
-- EVENT
  v.deelmonster_id || ':' || v.interval             AS eventID,
  v.deelmonster_id                                  AS parentEventID,
  NULL                                              AS eventDate,
  NULL                                              AS year,
  v.opmerking                                       AS eventRemarks,
-- LOCATION
  NULL                                              AS locationID,
  NULL                                              AS continent,
  NULL                                              AS waterBody,
  NULL                                              AS country,
  NULL                                              AS countryCode,
  NULL                                              AS stateProvince,
  NULL                                              AS municipality,
  CASE 
    WHEN v.interval REGEXP '^0-' = 1 THEN 0
    WHEN v.interval REGEXP '^10-' = 1 THEN 10
    WHEN v.interval REGEXP '^20-' = 1 THEN 20
    WHEN v.interval REGEXP '^30-' = 1 THEN 30
    WHEN v.interval REGEXP '^40-' = 1 THEN 40
    WHEN v.interval REGEXP '^50-' = 1 THEN 50
    WHEN v.interval REGEXP '^60-' = 1 THEN 60
    WHEN v.interval REGEXP '^70-' = 1 THEN 70
    WHEN v.interval REGEXP '^80-' = 1 THEN 80
    WHEN v.interval REGEXP '^90-' = 1 THEN 90
  END                                               AS minimumDepthInMeters,
  CASE 
    WHEN v.interval REGEXP '-10m' = 1 THEN 10
    WHEN v.interval REGEXP '-20m' = 1 THEN 20
    WHEN v.interval REGEXP '-30m' = 1 THEN 30
    WHEN v.interval REGEXP '-40m' = 1 THEN 40
    WHEN v.interval REGEXP '-50m' = 1 THEN 50
    WHEN v.interval REGEXP '-60m' = 1 THEN 60
    WHEN v.interval REGEXP '-70m' = 1 THEN 70
    WHEN v.interval REGEXP '-80m' = 1 THEN 80
    WHEN v.interval REGEXP '-90m' = 1 THEN 90
    WHEN v.interval REGEXP '-100m' = 1 THEN 100
  END                                               AS maximumDepthInMeters,
  v.interval                                        AS verbatimDepth,
  NULL                                              AS locationRemarks,
  NULL                                              AS decimalLatitude,
  NULL                                              AS decimalLongitude,
  NULL                                              AS geodeticDatum,
  NULL                                              AS verbatimLatitude,
  NULL                                              AS verbatimLongitude,
  NULL                                              AS verbatimCoordinateSystemProperty,
  NULL                                              AS dynamicProperties 
  FROM vegetations as v
  INNER JOIN features as f
  ON f.deelmonster_id = v.deelmonster_id
)
