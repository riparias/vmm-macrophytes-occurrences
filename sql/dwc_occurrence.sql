/*
Created by Damiano Oldoni (INBO)
*/

SELECT
  o.'deelmonster_id'                          AS eventID,
  o.deelmonster_id || ':' || REPLACE(o.'Macrofyt Naam', ' ', '_') AS occurrenceID,
  CASE 
    WHEN o.'Macrofyt Auteur' IS NOT NULL THEN RTRIM(REPLACE(o.'Macrofyt Naam', 'groep', '')) || + ' ' || + o.'Macrofyt Auteur'
    WHEN o.'Macrofyt Auteur' IS NULL THEN RTRIM(REPLACE(o.'Macrofyt Naam', 'groep', ''))
  END                                         AS scientificName,
  'Plantae'                                   AS kingdom,
  CASE
    WHEN o.'Macrofyt Rang' = 'Species' THEN 'species'
    WHEN o.'Macrofyt Rang' = 'Genus' THEN 'genus'
    WHEN o.'Macrofyt Rang' = 'Form' THEN 'form'
    WHEN o.'Macrofyt Rang' = 'Variety' THEN 'variety'
    WHEN o.'Macrofyt Rang' = 'Species group' THEN 'species'
    WHEN o.'Macrofyt Rang' = 'Species hybrid' THEN 'species'
    WHEN o.'Macrofyt Rang' = 'Section' THEN NULL
    WHEN o.'Macrofyt Rang' = 'Subgenus' THEN NULL
    WHEN o.'Macrofyt Rang' = 'Subspecies' THEN 'subspecies'
    WHEN o.'Macrofyt Rang' = 'Unknown' THEN NULL
    ELSE NULL
  END                                         AS taxonRank,
  o.'Macrofyt Rang'                           AS verbatimTaxonRank,
  o.'Macrofyt Voorkeursnaam'                  AS vernacularName,
  CASE 
    WHEN o.'Tansley Code' = 'z' THEN 's'
    WHEN o.'Tansley Code' = 'cd' THEN 'c'
    ELSE o.'Tansley Code'
  END                                         AS organismQuantity,
  'Tansley vegetation scale'                  AS organismQuantityType,
  o.groeivorm                                 AS occurrenceRemarks,
  p.team                                      AS identifiedBy,
  o.gevalideerd                               AS identificationVerificationStatus
FROM observations as o 
 LEFT JOIN positions AS p
    ON p.meetplaats = o.meetplaats
WHERE o.'Macrofyt Rang' != 'Functional group' AND o.'Macrofyt Rang' != 'Species aggregate'
