/*
Created by Damiano Oldoni (INBO)
*/

SELECT
  m.'Deelmonster ID MOW'                     AS eventID,
  m.'Deelmonster ID MOW' || ':' || REPLACE(m.par, ' ', '_')   AS measurementID,
  CASE
    WHEN m.par = 'T' THEN 'temperature'
    WHEN m.par = 'pH' THEN 'pH'
    WHEN m.par = 'O2' THEN 'dissolved oxygen'
    WHEN m.par = 'O2 verz' THEN 'oxygen saturation'
    WHEN m.par = 'EC 20' THEN 'electrical conductivity'
    WHEN m.par = 'Secchi' THEN 'Secchi depth'
  END                                   AS measurementType,
  
  CASE
    WHEN m.teken = '=' THEN m.Resultaat
    WHEN m.teken = '>' THEN '>' || m.Resultaat
  END                                   AS measurementValue,
  
  m.eenh                                AS measurementUnit,
  m. monsternamedatum                   AS measurementDeterminedDate,
  
  CASE
    WHEN m.'Secchischijf op Bodem' = 'Ja' THEN 'Secchi disk at the bottom'
    WHEN m.'Secchischijf op Bodem' = 'Nee' THEN 'Secchi disk not at the bottom'
  END                                   AS measurementRemarks
  
FROM
  measurements as m

UNION

/* FEATURES sludge_level*/

SELECT
  f.deelmonster_id                          AS eventID,
  f.deelmonster_id || ':' || 'sludge_level' AS measurementID,
  'sludge level'                              AS measurementType,
  CASE 
    WHEN f.sliblaag = '< 5 cm slib' THEN '0-5'
    WHEN f.sliblaag = '5 à 20 cm slib' THEN '5-20'
    WHEN f.sliblaag = '> 20 cm slib' THEN '>20'
    WHEN f.sliblaag = 'slib afwezig' THEN '0'
    WHEN f.sliblaag = 'slib aanwezig maar meting onmogelijk' THEN '>0'
  END                                   AS measurementValue,
  'cm'                                AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.sliblaag IS NOT NULL

UNION

/* FEATURES coarse_organic_matter_layer */

SELECT
  f.deelmonster_id                          AS eventID,
  f.deelmonster_id || ':' || 'coarse_organic_matter_layer' AS measurementID,
  'coarse organic matter layer'                              AS measurementType,
  f.'Laag Grof Organisch Materiaal (cm)'      AS measurementValue,
  'cm'                                AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.'Laag Grof Organisch Materiaal (cm)' IS NOT NULL

UNION

/* FEATURES average_width_water_level */

SELECT
  f.deelmonster_id                          AS eventID,
  f.deelmonster_id || ':' || 'average_width_water_level'   AS measurementID,
  'average width water level'                              AS measurementType,
  f.'Breedte Waterspiegel Gemiddeld (cm)'      AS measurementValue,
  'cm'                                AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.'Breedte Waterspiegel Gemiddeld (cm)' IS NOT NULL

UNION

/* FEATURES minimum_width_water_level */

SELECT
  f.deelmonster_id                          AS eventID,
  f.deelmonster_id || ':' || 'minimum_width_water_level'   AS measurementID,
  'minimum width water level'                                AS measurementType,
  f.'Breedte Waterspiegel Minimum (cm)'      AS measurementValue,
  'cm'                                AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.'Breedte Waterspiegel Minimum (cm)' IS NOT NULL

UNION

/* FEATURES maximum_width_water_level */

SELECT
  f.deelmonster_id                          AS eventID,
  f.deelmonster_id || ':' || 'maximum_width_water_level'   AS measurementID,
  'maximum width water level'                                AS measurementType,
  f.'Breedte Waterspiegel Maximum (cm)'      AS measurementValue,
  'cm'                                AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.'Breedte Waterspiegel Maximum (cm)' IS NOT NULL

UNION

/* FEATURES average_depth */

SELECT
  f.deelmonster_id                          AS eventID,
  f.deelmonster_id || ':' || 'average_depth'   AS measurementID,
  'average depth'                                AS measurementType,
  f.'Diepte Gemiddeld (cm)'      AS measurementValue,
  'cm'                                AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.'Diepte Gemiddeld (cm)' IS NOT NULL

UNION

/* FEATURES minimum_depth */

SELECT
  f.deelmonster_id                          AS eventID,
  f.deelmonster_id || ':' || 'minimum_depth'   AS measurementID,
  'minimum depth'                                AS measurementType,
  f.'Diepte Minimum (cm)'      AS measurementValue,
  'cm'                                AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.'Diepte Minimum (cm)' IS NOT NULL

UNION

/* FEATURES maximum_depth */

SELECT
  f.deelmonster_id                   AS eventID,
  f.deelmonster_id || ':' || 'maximum_depth'   AS measurementID,
  'maximum depth'                      AS measurementType,
  f.'Diepte Maximum (cm)'              AS measurementValue,
  'cm'                                 AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.'Diepte Maximum (cm)' IS NOT NULL

UNION

/* FEATURES total_coverage */

SELECT
  f.deelmonster_id                     AS eventID,
  f.deelmonster_id || ':' || 'total_coverage'   AS measurementID,
  'total coverage'                     AS measurementType,
  f.'Totale Bedekking (%)'             AS measurementValue,
  '%'                                  AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.'Totale Bedekking (%)' IS NOT NULL

UNION

/* FEATURES eutrophication_coverage */

SELECT
  f.deelmonster_id                   AS eventID,
  f.deelmonster_id || ':' || 'eutrophication_coverage'   AS measurementID,
  'eutrophication coverage'            AS measurementType,
  f.'Bedekking Eutrofiëringsindicatoren (%)'      AS measurementValue,
  '%'                                  AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.'Bedekking Eutrofiëringsindicatoren (%)' IS NOT NULL

UNION

/* FEATURES helophytes_coverage */

SELECT
  f.deelmonster_id                   AS eventID,
  f.deelmonster_id || ':' || 'helophytes_coverage'   AS measurementID,
  'helophytes coverage'                AS measurementType,
  f.'Bedekking Helofyten (%)'          AS measurementValue,
  '%'                                  AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.'Bedekking Helofyten (%)' IS NOT NULL

UNION

/* FEATURES macrophytes_shading */

SELECT
  f.deelmonster_id                     AS eventID,
  f.deelmonster_id || ':' || 'macrophytes_shading'   AS measurementID,
  'macrophytes shading'                AS measurementType,
  f.'Beschaduwing Macrofyten (%)'      AS measurementValue,
  '%'                                  AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.'Beschaduwing Macrofyten (%)' IS NOT NULL

UNION

/* FEATURES current */

SELECT
  f.deelmonster_id                     AS eventID,
  f.deelmonster_id || ':' || 'current' AS measurementID,
  'current'                            AS measurementType,
  CASE
    WHEN f.stroming = 'Stilstaand / traag' THEN 'stationary-slow'
    WHEN f.stroming = 'Matig' THEN 'moderate'
    WHEN f.stroming = 'Snel' THEN 'fast'
    WHEN f.stroming is NULL THEN NULL
  END                                  AS measurementValue,
  NULL                                 AS measurementUnit,
  f.monsternamedatum                   AS measurementDeterminedDate,
  NULL                                 AS measurementRemarks
FROM features as f WHERE f.stroming IS NOT NULL

UNION

/* ECOLOGIC COEFFICIENT ecologic_quality_coefficient_with_gep */

SELECT
  e.'Deelmonster ID'                         AS eventID,
  e.'Deelmonster ID' || ':' || 'ecologic_quality_coefficient_with_gep'   AS measurementID,
  'ecologic quality coefficient with GEP'     AS measurementType,
  e.'index GEP'      AS measurementValue,
  NULL                                        AS measurementUnit,
  e.monsternamedatum                          AS measurementDeterminedDate,
  NULL                                        AS measurementRemarks
FROM ecologic_coeffs as e WHERE e.'index GEP' IS NOT NULL

UNION

/* ECOLOGIC COEFFICIENT ecologic_quality_coefficient_without_gep */

SELECT
  e.'Deelmonster ID'                          AS eventID,
  e.'Deelmonster ID' || ':' || 'ecologic_quality_coefficient_without_gep'   AS measurementID,
  'ecologic quality coefficient without GEP'  AS measurementType,
  e.'index ZONDER gep'                        AS measurementValue,
  NULL                                        AS measurementUnit,
  e.monsternamedatum                          AS measurementDeterminedDate,
  NULL                                        AS measurementRemarks
FROM ecologic_coeffs as e WHERE e.'index ZONDER gep' IS NOT NULL

UNION

/* ECOLOGIC COEFFICIENT ecologic_quality_coefficient_class */

SELECT
  e.'Deelmonster ID'                          AS eventID,
  e.'Deelmonster ID' || ':' || 'ecologic_quality_coefficient_class' AS measurementID,
  'ecologic quality coefficient class'        AS measurementType,
  CASE 
    WHEN e.'klasse' = 'SLECHT' THEN 'poor'
    WHEN e.'klasse' = 'ONTOEREIKEND' THEN 'insufficient'
    WHEN e.'klasse' = 'MATIG' THEN 'fair'
    WHEN e.'klasse' = 'GOED' THEN 'good'
    WHEN e.'klasse' = 'GOED EN HOGER' THEN 'very good'
  END                                         AS measurementValue,
  NULL                                        AS measurementUnit,
  e.monsternamedatum                          AS measurementDeterminedDate,
  NULL                                        AS measurementRemarks
FROM ecologic_coeffs as e WHERE e.'index ZONDER gep' IS NOT NULL

UNION

/* VEGETATION DEVELOPMENT  submerged_code */

SELECT
  v.deelmonster_id || ':' || v.interval       AS eventID,
  v.deelmonster_id || ':' || 'submerged_code' AS measurementID,
  'submerged code'                            AS measurementType,
  v.'Submers Code'                            AS measurementValue,
  NULL                                        AS measurementUnit,
  v.monsternamedatum                          AS measurementDeterminedDate,
  NULL                                        AS measurementRemarks
FROM vegetations as v WHERE v.'Submers Code' IS NOT NULL

UNION

/* VEGETATION DEVELOPMENT  submerged_category */

SELECT
  v.deelmonster_id || ':' || v.interval       AS eventID,
  v.deelmonster_id || ':' || 'submerged_category' AS measurementID,
  'submerged category'                            AS measurementType,
  CASE 
    WHEN v.submers = 'geen ondergedoken vegetatie' 
      THEN 'no submerged vegetation'
    WHEN v.submers = 'Planten schaars' THEN 'plants scarce'
    WHEN v.submers = 'Planten frequent tot talrijk maar niet de gehele waterkolom opvullend' 
      THEN 'plants frequent to numerous but not filling the entire water column'
    WHEN v.submers = 'Waterkolom grotendeels tot geheel opgevuld' 
      THEN 'Water column largely to completely filled up'
  END                                         AS measurementValue,
  NULL                                        AS measurementUnit,
  v.monsternamedatum                          AS measurementDeterminedDate,
  NULL                                        AS measurementRemarks
FROM vegetations as v WHERE v.'submers' IS NOT NULL

