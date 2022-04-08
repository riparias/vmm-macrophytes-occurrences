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
  CASE
    WHEN p.provincie = 'Limburg' THEN 'Limburg'
    WHEN p.provincie = 'West-Vlaanderen' THEN 'West Flanders'
    WHEN p.provincie = 'Oost-Vlaanderen' THEN 'East Flanders'
    WHEN p.provincie = 'Antwerpen' THEN 'Antwerp'
    WHEN p.provincie = 'Antwerpen' THEN 'Antwerp'
    WHEN p.provincie = 'Vlaams-Brabant' THEN 'Flemish Brabant'
    WHEN p.provincie = 'Brussel (pro forma)' THEN 'Brussels-Capital Region'
    WHEN p.provincie = 'Luik' THEN 'Liège'
    WHEN p.provincie = 'Henegouwen' THEN 'Hainaut'
  END                                   AS stateProvince,
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
  'The inland water macrophyte occurrences in Flanders, Belgium' AS datasetName,
  'VMM'                                 AS ownerInstitutionCode,
  *
FROM (

SELECT
-- EVENT
  v.deelmonster_id || ':' || v.interval             AS eventID,
  v.deelmonster_id                                  AS parentEventID,
  date(f.monsternamedatum)                          AS eventDate,
  f.Jaar                                            AS year,
  v.opmerking                                       AS eventRemarks,
-- LOCATION
    p.meetplaats                          AS locationID,
  'Europe'                              AS continent,
  p.waterlichaam                        AS waterBody,
  'Belgium'                             AS country,
  'BE'                                  AS countryCode,
  CASE
    WHEN p.provincie = 'Limburg' THEN 'Limburg'
    WHEN p.provincie = 'West-Vlaanderen' THEN 'West Flanders'
    WHEN p.provincie = 'Oost-Vlaanderen' THEN 'East Flanders'
    WHEN p.provincie = 'Antwerpen' THEN 'Antwerp'
    WHEN p.provincie = 'Antwerpen' THEN 'Antwerp'
    WHEN p.provincie = 'Vlaams-Brabant' THEN 'Flemish Brabant'
    WHEN p.provincie = 'Brussel (pro forma)' THEN 'Brussels-Capital Region'
    WHEN p.provincie = 'Luik' THEN 'Liège'
    WHEN p.provincie = 'Henegouwen' THEN 'Hainaut'
  END                                   AS stateProvince,
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
    '", "interval":"' || v.interval ||
    '"}}' AS dynamicProperties
  FROM vegetations as v
  INNER JOIN features as f
  ON f.deelmonster_id = v.deelmonster_id
  INNER JOIN positions as p
  ON p.meetplaats = f.meetplaats
)
