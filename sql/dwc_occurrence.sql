/*
Created by Damiano Oldoni (INBO)
*/

SELECT
  o.'deelmonster_id'                    AS eventID,
-- OCCURRENCE
  o.deelmonster_id || ':' || o.species_name_hash AS occurrenceID,
  CASE 
    WHEN o.'Tansley Code' = 'z' THEN 's'
    WHEN o.'Tansley Code' = 'cd' THEN 'c'
    ELSE o.'Tansley Code'
  END                                         AS organismQuantity,
  'Tansley vegetation scale'                  AS organismQuantityType,
  o.groeivorm                                 AS occurrenceRemarks,
-- IDENTIFICATION
  l.team                                      AS identifiedBy,
  o.gevalideerd                               AS identificationVerificationStatus,
-- TAXON
  CASE 
    WHEN o.'Macrofyt Naam' = 'Draadwier' THEN 'thread algae'
    WHEN o.'Macrofyt Naam' = 'Draadwier (submers)' THEN 'thread algae'
    WHEN o.'Macrofyt Naam' = 'Salix spp. (broad leaves)' THEN 'Salix'
    WHEN o.'Macrofyt Naam' = 'Salix spp. (small leaves)' THEN 'Salix'
    WHEN o.'Macrofyt Naam' = 'Nymphaea spec. (neofyt)' THEN 'Nymphaea'
    WHEN o.'Macrofyt Naam' = 'Salix fragilis L. (incl. kruisingen)' THEN 'Salix fragilis L.'
    WHEN o.'Macrofyt Naam' = 'Salix cinerea L. (incl. kruisingen)' THEN 'Salix cinerea L.'
    WHEN o.'Macrofyt Naam' = 'Taraxacum Wiggers sect. Subvulgaria' AND o.'Macrofyt Auteur' = 'Christians.'
      THEN 'Taraxacum Wiggers sect. Subvulgaria Christians.'
    WHEN o.'Macrofyt Naam' = 'Lysichiton americanus' AND o.'Macrofyt Auteur' = ' Hultén et St John x L. camtschatcensis (L.) Schott'
      THEN 'Lysichiton americanus × camtschatcensis'
    WHEN o.'Macrofyt Naam' = 'Trifolium' THEN 'Trifolium Tourn. ex L.'
    WHEN o.'Macrofyt Auteur' IS NOT NULL -- Replace 'groep' with 'group' in Macrofyt Naam
      THEN RTRIM(REPLACE(o.'Macrofyt Naam', 'groep', 'group')) || + ' ' || + o.'Macrofyt Auteur'
    WHEN o.'Macrofyt Auteur' IS NULL
      THEN RTRIM(REPLACE(o.'Macrofyt Naam', 'groep', 'group'))
  END                                   AS scientificName,
  'Plantae'                             AS kingdom,
  CASE
    WHEN o.'Macrofyt Rang' = 'Species' THEN 'species'
    WHEN o.'Macrofyt Rang' = 'Genus' THEN 'genus'
    WHEN o.'Macrofyt Rang' = 'Form' THEN 'form'
    WHEN o.'Macrofyt Rang' = 'Variety' THEN 'variety'
    WHEN o.'Macrofyt Rang' = 'Species group' THEN 'agg.'
    WHEN o.'Macrofyt Rang' = 'Species hybrid' THEN 'species'
    WHEN o.'Macrofyt Rang' = 'Section' THEN 'section'
    WHEN o.'Macrofyt Rang' = 'Subgenus' THEN 'subgenus'
    WHEN o.'Macrofyt Rang' = 'Subspecies' THEN 'subspecies'
    WHEN o.'Macrofyt Rang' = 'Unknown' AND o.'Macrofyt Naam' = 'Nymphaea spec. (neofyt)' THEN 'genus'
    WHEN o.'Macrofyt Rang' = 'Unknown' THEN 'unranked'
    WHEN o.'Macrofyt Rang' = 'Functional group' AND o.'Macrofyt Naam' LIKE 'Salix spp.%' THEN 'genus'
    WHEN o.'Macrofyt Rang' = 'Functional group' AND o.'Macrofyt Naam' = 'Salix fragilis L. (incl. kruisingen)' THEN 'species'
    WHEN o.'Macrofyt Rang' = 'Functional group' AND o.'Macrofyt Naam' = 'Salix cinerea L. (incl. kruisingen)' THEN 'species'
    WHEN o.'Macrofyt Rang' = 'Functional group' THEN 'functional group'
    WHEN o.'Macrofyt Rang' = 'Species aggregate' THEN 'speciesAggregate'
  END                                         AS taxonRank,
  o.'Macrofyt Voorkeursnaam'                  AS vernacularName

FROM observations as o
  LEFT JOIN locations AS l
    ON o.meetplaats = l.meetplaats
