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
  NULL                                AS collectionCode,
  'The inland water macrophyte occurrences in Flanders, Belgium' AS datasetName,
  NULL                                  AS ownerInstitutionCode,
  'human observation'                   AS basisOfRecord,
-- EVENT
  e.eventID                             AS eventID,
  e.parentEventID                       AS parentEventID,
  date(e.monsternamedatum)              AS eventDate,
  e.Jaar                                AS year,
  e.eventRemarks                        AS eventRemarks,
-- LOCATION
  p.meetplaats                          AS locationID,
  'Europe'                              AS continent,
  p.waterlichaam                        AS waterBody,
  'Belgium'                             AS country,
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
  CAST(e.'Diepte Maximum (cm)' AS REAL) / 100 AS maximumDepthInMeters,
  NULL                                  AS verbatimDepth,
  p.omschrijving                        AS locationRemarks,
  p.decimalLatitude                     AS decimalLatitude,
  p.decimalLongitude                    AS decimalLongitude,
  'EPSG:4326'                           AS geodeticDatum,
  p.Y                                   AS verbatimLatitude,
  p.X                                   AS verbatimLongitude,
  'EPSG:31370'                          AS verbatimSRS,
  'Belgian Lambert 72'                  AS verbatimCoordinateSystemProperty,
  '{{"watercourse":"' || p.waterloop ||
    '", "basin":"' || p.bekken || 
    '", "waterbodySurfaceCode":"' || p.owl || 
    '", "waterbodyCategory":"' || p.waterlichaamcategorietype ||
    '"}}'                               AS dynamicProperties

FROM (
  
/* FEATURES */
  
SELECT
  f.deelmonster_id                      AS eventID,
  NULL                                  AS parentEventID,
  NULL                                  AS eventRemarks,
  f.meetplaats,
  f.'Diepte Maximum (cm)',
  f.monsternamedatum,
  f.Jaar
FROM
  features AS f

UNION

/* VEGETATIONS */
/*
Create separate child events for VEGETATIONS info at different 'interval' values
The few deelmonster IDs not present in features are excluded to avoid poining to
not existing parentEventID.
*/

SELECT
  v.deelmonster_id || ':' || v.interval AS eventID,
  v.deelmonster_id                      AS parentEventID,
  NULL                                  AS eventRemarks,
  f.meetplaats,
  f.'Diepte Maximum (cm)',
  f.monsternamedatum,
  f.Jaar
FROM vegetations as v
  INNER JOIN features as f
  ON f.deelmonster_id = v.deelmonster_id

) AS e

LEFT JOIN positions AS p
  ON p.meetplaats = e.meetplaats
