/*
Created by Damiano Oldoni (INBO)
*/

SELECT
  o.'deelmonster_id'                          AS eventID,
  o.deelmonster_id || ':' || REPLACE(o.'Macrofyt Naam', ' ', '_') AS occurrenceID,
  CASE 
    WHEN o.'Macrofyt Naam' = 'Draadwier' THEN 'thread algae'
    WHEN o.'Macrofyt Naam' = 'Draadwier (submers)' THEN 'thread algae'
    WHEN o.'Macrofyt Naam'  = 'Salix spp. (broad leaves)' THEN 'Salix'
    WHEN o.'Macrofyt Naam'  = 'Salix spp. (small leaves)' THEN 'Salix'
    WHEN o.'Macrofyt Naam'  = 'Nymphaea spec. (neofyt)' THEN 'Nymphaea'
    WHEN o.'Macrofyt Naam'  = 'Salix fragilis L. (incl. kruisingen)' 
      THEN 'Salix fragilis L.'
    WHEN o.'Macrofyt Naam'  = 'Salix cinerea L. (incl. kruisingen)' 
      THEN 'Salix cinerea L.'
    WHEN o.'Macrofyt Naam' = 'Taraxacum Wiggers sect. Subvulgaria' AND 
      o.'Macrofyt Auteur' = 'Christians.' 
      THEN 'Taraxacum Wiggers sect. Subvulgaria Christians.'
    WHEN o.'Macrofyt Naam' = 'Lysichiton americanus' AND 
      o.'Macrofyt Auteur' = ' Hultén et St John x L. camtschatcensis (L.) Schott' 
      THEN 'Lysichiton americanus × camtschatcensis'
    WHEN o.'Macrofyt Naam' = 'Trifolium' THEN 'Trifolium Tourn. ex L.'
    -- replace 'groep' with 'group' in Macrofyt Naam
    WHEN o.'Macrofyt Auteur' IS NOT NULL 
      THEN RTRIM(REPLACE(o.'Macrofyt Naam', 'groep', 'group')) || + ' ' || + o.'Macrofyt Auteur'
    WHEN o.'Macrofyt Auteur' IS NULL 
      THEN RTRIM(REPLACE(o.'Macrofyt Naam', 'groep', 'group'))
  END                                         AS scientificName,
  'Plantae'                                   AS kingdom,
  CASE
    WHEN o.'Macrofyt Rang' = 'Species' THEN 'species'
    WHEN o.'Macrofyt Rang' = 'Genus' THEN 'genus'
    WHEN o.'Macrofyt Rang' = 'Form' THEN 'form'
    WHEN o.'Macrofyt Rang' = 'Variety' THEN 'variety'
    WHEN o.'Macrofyt Rang' = 'Species group' THEN 'agg.'
    WHEN o.'Macrofyt Rang' = 'Species hybrid' THEN 'species'
    -- for Taraxacum Wiggers sect. Subvulgaria Christians
    WHEN o.'Macrofyt Rang' = 'Section' AND 
      o.'Macrofyt Naam' = 'Taraxacum Wiggers sect. Subvulgaria' AND 
      o.'Macrofyt Auteur' = 'Christians.' THEN 'genus'
    -- all any other possible taxa with rank section if present
    WHEN o.'Macrofyt Rang' = 'Section' AND 
      o.'Macrofyt Naam' != 'Taraxacum Wiggers sect. Subvulgaria' THEN 'section'
    WHEN o.'Macrofyt Rang' = 'Subgenus' THEN 'subgenus'
    WHEN o.'Macrofyt Rang' = 'Subspecies' THEN 'subspecies'
    -- for Nymphaea spec. (neofyt)
    WHEN o.'Macrofyt Rang' = 'Unknown' AND
      o.'Macrofyt Naam' = 'Nymphaea spec. (neofyt)' THEN 'genus'
    -- other taxa with rank Unknown if present
    WHEN o.'Macrofyt Rang' = 'Unknown' AND
      o.'Macrofyt Naam' != 'Nymphaea spec. (neofyt)' THEN 'unranked'
    -- draadwier or draadwier (submers)
    WHEN o.'Macrofyt Rang' = 'Functional group' AND
      o.'Macrofyt Naam' LIKE 'Draadwier%' THEN 'functional group'
    -- Salix spp. (broad leaves) or Salix spp. (small leaves)
    WHEN o.'Macrofyt Rang' = 'Functional group' AND
      o.'Macrofyt Naam' NOT LIKE 'Draadwier%' AND
      o.'Macrofyt Naam' LIKE 'Salix spp.%' THEN 'genus'
    -- 'Salix fragilis L. (incl. kruisingen)' or 'Salix cinerea L. (incl. kruisingen)'
    WHEN o.'Macrofyt Rang' = 'Functional group' AND
      o.'Macrofyt Naam' NOT LIKE 'Draadwier%' AND 
      o.'Macrofyt Naam' NOT LIKE 'Salix spp.%' THEN 'species'
    WHEN o.'Macrofyt Rang' = 'Species aggregate' THEN 'speciesAggregate'
  END                                         AS taxonRank,
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
