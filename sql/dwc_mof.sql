/*
Created by Damiano Oldoni (INBO)
*/

/* LOCATIONS: bekken */

SELECT
  f.deelmonster_id                      AS eventID,
  'basin'                               AS measurementType,
  l.bekken                              AS measurementValue,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
  LEFT JOIN locations AS l
  ON f.meetplaats = l.meetplaats
WHERE l.bekken IS NOT NULL

UNION

/* LOCATIONS: owl */

SELECT
  f.deelmonster_id                      AS eventID,
  'waterbody surface code'              AS measurementType,
  l.owl                                 AS measurementValue,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
  LEFT JOIN locations AS l
  ON f.meetplaats = l.meetplaats
WHERE l.owl IS NOT NULL

UNION

/* LOCATIONS: bekken */

SELECT
  f.deelmonster_id                      AS eventID,
  'waterbody category'                  AS measurementType,
  l.waterlichaamcategorietype           AS measurementValue,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
  LEFT JOIN locations AS l
  ON f.meetplaats = l.meetplaats
WHERE l.waterlichaamcategorietype IS NOT NULL

UNION

/* FEATURES: Totale Bedekking (%) */

SELECT
  f.deelmonster_id                      AS eventID,
  'total coverage'                      AS measurementType,
  f."Totale Bedekking (%)"              AS measurementValue,
  '%'                                   AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f."Totale Bedekking (%)" IS NOT NULL

UNION

/* FEATURES: Bedekking Eutrofiëringsindicatoren (%) */

SELECT
  f.deelmonster_id                      AS eventID,
  'eutrophication coverage'             AS measurementType,
  f."Bedekking Eutrofiëringsindicatoren (%)" AS measurementValue,
  '%'                                   AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f."Bedekking Eutrofiëringsindicatoren (%)" IS NOT NULL

UNION

/* FEATURES: Bedekking Helofyten (%) */

SELECT
  f.deelmonster_id                      AS eventID,
  'helophytes coverage'                 AS measurementType,
  f."Bedekking Helofyten (%)"           AS measurementValue,
  '%'                                   AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f."Bedekking Helofyten (%)" IS NOT NULL

UNION

/* FEATURES: Beschaduwing Macrofyten (%) */

SELECT
  f.deelmonster_id                      AS eventID,
  'macrophytes shading'                 AS measurementType,
  f."Beschaduwing Macrofyten (%)"       AS measurementValue,
  '%'                                   AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f."Beschaduwing Macrofyten (%)" IS NOT NULL

UNION

/* FEATURES: sliblaag */

SELECT
  f.deelmonster_id                      AS eventID,
  'sludge level'                        AS measurementType,
  CASE 
    WHEN f.sliblaag = '< 5 cm slib' THEN '0-5'
    WHEN f.sliblaag = '5 à 20 cm slib' THEN '5-20'
    WHEN f.sliblaag = '> 20 cm slib' THEN '>20'
    WHEN f.sliblaag = 'slib afwezig' THEN '0'
    WHEN f.sliblaag = 'slib aanwezig maar meting onmogelijk' THEN '>0'
  END                                   AS measurementValue,
  'cm'                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f.sliblaag IS NOT NULL

UNION

/* FEATURES: Laag Grof Organisch Materiaal (cm) */

SELECT
  f.deelmonster_id                      AS eventID,
  'coarse organic matter layer'         AS measurementType,
  f."Laag Grof Organisch Materiaal (cm)" AS measurementValue,
  'cm'                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f."Laag Grof Organisch Materiaal (cm)" IS NOT NULL

UNION

/* FEATURES: Breedte Waterspiegel Gemiddeld (cm) */

SELECT
  f.deelmonster_id                      AS eventID,
  'average width water level'           AS measurementType,
  f."Breedte Waterspiegel Gemiddeld (cm)" AS measurementValue,
  'cm'                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f."Breedte Waterspiegel Gemiddeld (cm)" IS NOT NULL

UNION

/* FEATURES: Breedte Waterspiegel Minimum (cm) */

SELECT
  f.deelmonster_id                      AS eventID,
  'minimum width water level'           AS measurementType,
  f."Breedte Waterspiegel Minimum (cm)" AS measurementValue,
  'cm'                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f."Breedte Waterspiegel Minimum (cm)" IS NOT NULL

UNION

/* FEATURES: Breedte Waterspiegel Maximum (cm) */

SELECT
  f.deelmonster_id                      AS eventID,
  'maximum width water level'           AS measurementType,
  f."Breedte Waterspiegel Maximum (cm)" AS measurementValue,
  'cm'                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f."Breedte Waterspiegel Maximum (cm)" IS NOT NULL

UNION

/* FEATURES: Diepte Gemiddeld (cm) */

SELECT
  f.deelmonster_id                      AS eventID,
  'average depth'                       AS measurementType,
  f."Diepte Gemiddeld (cm)"             AS measurementValue,
  'cm'                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f."Diepte Gemiddeld (cm)" IS NOT NULL

UNION

/* FEATURES: Diepte Minimum (cm) */

SELECT
  f.deelmonster_id                      AS eventID,
  'minimum depth'                       AS measurementType,
  f."Diepte Minimum (cm)"               AS measurementValue,
  'cm'                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f."Diepte Minimum (cm)" IS NOT NULL

UNION

/* FEATURES: Diepte Maximum (cm) */

SELECT
  f.deelmonster_id                      AS eventID,
  'maximum depth'                       AS measurementType,
  f."Diepte Maximum (cm)"               AS measurementValue,
  'cm'                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f."Diepte Maximum (cm)" IS NOT NULL

UNION

/* FEATURES: stroming */

SELECT
  f.deelmonster_id                      AS eventID,
  'velocity'                            AS measurementType,
  CASE
    WHEN f.stroming = 'Stilstaand / traag' THEN 'stationary / slow'
    WHEN f.stroming = 'Matig' THEN 'moderate'
    WHEN f.stroming = 'Snel' THEN 'fast'
    WHEN f.stroming is NULL THEN NULL
  END                                   AS measurementValue,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM features AS f
WHERE f.stroming IS NOT NULL

UNION

/* MEASUREMENTS */

SELECT
  m."Deelmonster ID MOW"                AS eventID,
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
  CASE 
    WHEN m.eenh = '-' THEN NULL
    ELSE m.eenh
  END                                   AS measurementUnit,
  CASE
    WHEN m.par = 'Secchi' AND m."Secchischijf op Bodem" = 'Ja' THEN 'Secchi disk at the bottom'
    WHEN m.par = 'Secchi' AND m."Secchischijf op Bodem" = 'Nee' THEN 'Secchi disk not at the bottom'
  END                                   AS measurementRemarks
FROM
  measurements as m

UNION

/* ECOLOGIC COEFFICIENT: index GEP */

SELECT
  e."Deelmonster ID"                    AS eventID,
  'ecologic quality coefficient with GEP' AS measurementType,
  e."index GEP"                         AS measurementValue,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM ecologic_coeffs as e
WHERE e."index GEP" IS NOT NULL

UNION

/* ECOLOGIC COEFFICIENT: index ZONDER gep */

SELECT
  e."Deelmonster ID"                    AS eventID,
  'ecologic quality coefficient without GEP' AS measurementType,
  e."index ZONDER gep"                  AS measurementValue,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM ecologic_coeffs as e
WHERE e."index ZONDER gep" IS NOT NULL

UNION

/* ECOLOGIC COEFFICIENT: klasse */

SELECT
  e."Deelmonster ID"                    AS eventID,
  'ecologic quality coefficient class'  AS measurementType,
  CASE 
    WHEN e.klasse = 'SLECHT' THEN 'poor'
    WHEN e.klasse = 'ONTOEREIKEND' THEN 'insufficient'
    WHEN e.klasse = 'MATIG' THEN 'fair'
    WHEN e.klasse = 'GOED' THEN 'good'
    WHEN e.klasse = 'GOED EN HOGER' THEN 'very good'
  END                                   AS measurementValue,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM ecologic_coeffs as e
WHERE e."index ZONDER gep" IS NOT NULL

UNION

/* ECOLOGIC COEFFICIENT: status */

SELECT
  e."Deelmonster ID"                    AS eventID,
  'status'                              AS measurementType,
  CASE 
    WHEN e.status = 'DEFAU' THEN 'default'
    WHEN e.status = 'KUNST' THEN 'artificial'
    WHEN e.status = 'NAT' THEN 'natural'
  END                                   AS measurementValue,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementRemarks
FROM ecologic_coeffs as e
WHERE e.status IS NOT NULL

UNION

/* VEGETATION DEVELOPMENT */

SELECT
  f.deelmonster_id                      AS eventID,
  'submerged plants ' || interval || ' upstream' AS measurementType,
  CASE
    WHEN v."Submers Code" = 0 THEN 'none' -- Geen ondergedoken vegetatie
    WHEN v."Submers Code" = 1 THEN 'rare' -- Planten schaars
    WHEN v."Submers Code" = 2 THEN 'frequent to abundant' -- Planten frequent tot talrijk maar niet de gehele waterkolom opvullend
    WHEN v."Submers Code" = 3 THEN 'filling entire water column' -- Waterkolom grotendeels tot geheel opgevuld
    ELSE NULL    
  END                                   AS measurementValue,
  NULL                                  AS measurementUnit,
  v.opmerking                           AS measurementRemarks
FROM features AS f
  LEFT JOIN vegetations AS v
    ON f.deelmonster_id = v.deelmonster_id
WHERE v."Submers Code" IS NOT NULL
