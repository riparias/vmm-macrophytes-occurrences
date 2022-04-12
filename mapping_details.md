# Mapping details

This document contains the detailed mapping of each field from the raw data export.

sheet | field | DwC file | DwC field | comments
--- | --- | --- | --- | ---
opnames_lijst | `deelmonster_id` | `occurrences.csv` | `eventID`; part of the `occurrenceID` | multiple unique plants per `deelmonster_id`. Example for `eventID`: `21341683`. Examples for `occurrenceID`: `21341683:Rorippa_amphibia`, `21341683:Sparganium_emersum`.
opnames_lijst | `meetplaats` | none | none | position recorded at event level
opnames_lijst | `Jaar` | none | none |  date recorded at event level
opnames_lijst | `monsternamedatum` | none | none | date recorded at event level
opnames_lijst | `Macrofyt Naam` | `occurrences.csv` | part of `scientificName` and `occurrenceID` | used with `Macrofyt Auteur` to form `scientificName`, e.g. `Rorippa amphibia (L.) Besser`, `Sparganium emersum Rehm.`. Use with `deelmonster_id` to form `occurrenceID` (see examples above).
opnames_lijst | `Macrofyt Rang` | `occurrences.csv` | `taxonRank` | Final mapping depending on #6
opnames_lijst | `Macrofyt Auteur` | `occurrences.csv` | part of `scientificName` | used with `Macrofyt Naam` to form `scientificName` (see examples above).
opnames_lijst | `Macrofyt Voorkeursnaam` | `occurrences.csv` | `vernacularName` | 
opnames_lijst | `groeivorm` | `occurrences.csv` | `occurrenceRemarks` | See DwC term [definition](https://dwc.tdwg.org/terms/#dwc:occurrenceRemarks). Examples: `Oever/moeras`, `Vallisneriden`. To be translated to English, see #21.
opnames_lijst | `Tansley Code` | `occurrences.csv` | `organismQuantityValue` | See #11.
opnames_lijst | `"Tansley Code"` (field name) | `occurrences.csv` | `organismQuantityType` | string `"Tansley vegetation scale"`. See #11.
opnames_lijst | `Tansley Weging` | none | none | See #12.
opnames_lijst | `waterlichaamcategorie` | none | none |  
opnames_lijst | `gevalideerd` | `occurrences.csv` | `identificationVerificationStatus` | Example: `1`. All data are validated. 
opnames_lijst | `waterlichaamcategorietype` | none | none | Same info present in sheet meetplaatsen.
vegetatie-ontwikkeling | `deelmonster_id` | `events.csv` | part of `eventID`; `parentEventID` | Multiple `interval` values (see below) for each `eventID`: children events are made combining `deelmonster_id` with `interval` . Examples `eventID`: `21327837:0-10m`, `21327837:10-20m`. Example `parentEventID`: `21327837`.
vegetatie-ontwikkeling | `meetplaats` | none | none |  Same place as parent event. 
vegetatie-ontwikkeling | `monsternamedatum` | none | none | Same date as parent event.
vegetatie-ontwikkeling | `interval` | `events.csv` | part of `eventID` and part of `dynamicProperties` | For `eventID`, see examples above. Example `dynamicProperties`: `{"watercourse":"WOLUWE", "basin":"Dijle- en Zennebekken", "waterbodySurface":"VL11_91", "waterbodyCategory":"Bg", "map":"31/3-4", "interval":"40-50m"}`. 
vegetatie-ontwikkeling | `Submers Code` | `mof.csv`  | `measurementValue` | Examples: `1`, `2`. To review: see #13.
vegetatie-ontwikkeling | `"Submers Code"` (field name) | `mof.csv`  | `measurementType` and `measurementID` | Translated as `submerged code`. To review: see #13.
vegetatie-ontwikkeling | `submers` | `mof.csv`  | `measurementValue` | Example: `"no submerged vegetation"`. To review: see #13 and #7.
vegetatie-ontwikkeling | `"submers"` (field name) | `mof.csv`  | `measurementType` and `measurementID` | Translated as `submerged category`. To review: see #13.
vegetatie-ontwikkeling | `Submers Weging` | none | none | It can be added. See #14.
vegetatie-ontwikkeling | `gevalideerd` | none | none | not possible to add validation for measurements. See #13.
vegetatie-ontwikkeling | `opmerking` | `events.csv` | `eventRemarks` | 
vegetatie-ontwikkeling | `waterlichaamcategorietype` | none | none | Same as parent event.
meetplaatsen | `meetplaats` | `events.csv` | `locationID` | Examples: `TR100400.1`, `C05.143`. 
meetplaatsen | `omschrijving` | `events.csv` | `locationRemarks` | Examples: `"Hamont, Kluizerdijk, voor Achelse Kluis, 20m opw brug"`, `"centroïde MAAS II"`.
meetplaatsen | `X` | `events.csv` | `verbatimLongitude` | Example: `228043`.
meetplaatsen | `Y` | `events.csv` | `verbatimLatitude` | Example: `221224`.
meetplaatsen | `gemeente` | `events.csv`| `municipality`| 
meetplaatsen | `provincie` | `events.csv` | `stateProvince` | 
meetplaatsen | `waterloop` | `events.csv` | part of `dynamicProperties` | See #15. Example: `waterloop` = `waterBody`. Example: `{"watercourse":"WOLUWE", "basin":"Dijle- en Zennebekken", "waterbodySurfaceCode":"VL11_91", "waterbodyCategory":"Bg", "map":"31/3-4"}`.
meetplaatsen | `bekken` | `events.csv` | part of `dynamicProperties` | Translated as `basin`. See above and #15.
meetplaatsen | `owl` | `events.csv`| part of `dynamicProperties` | See above and #15.
meetplaatsen | `waterlichaam` | `events.csv` | `waterBody` | Example: `WARMBEEK`, `MAAS I+II+III`.
meetplaatsen | `waterlichaamcategorietype` | `events.csv` | part of `dynamicProperties` |  See above and #15.
meetplaatsen | `kaart` | `events.csv` | Not mapped: internal use only. | See above and #15.
meetplaatsen | `team` | `occurrences.csv` | `identifiedBy` | See #16.
kenmerken | `deelmonster_id` | `events.csv` | `eventID` | Used as unique identifier. Also used as `parentEventID` for child events from `vegetatie-ontwikkeling` (see above). Part of all `measurementID` values, examples: `21327837:Secchi_depth`, `21327837:current`, `21327837:dissolved_oxygen`.
kenmerken | `meetplaats` | none | none | `meetplaats` field used in the JOIN with `meetplaatsen` sheet. 
kenmerken | `Jaar` | `events.csv` | `year` | 
kenmerken | `monsternamedatum` | `events.csv` | `eventDate` | 
kenmerken | `Totale Bedekking (%)` | `mof.csv` | `measurementValue` | 
kenmerken | `"Totale Bedekking (%)"` (field name) | `mof.csv` | `measurementType` |  Translated as `total coverage`. Assigned `measurementUnit`: `%`. Used in `measurementID`, example: `21586186:total_coverage`.
kenmerken | `Bedekking Eutrofiëringsindicatoren (%)` | `mof.csv` | `measurementValue` | 
kenmerken | `"Bedekking Eutrofiëringsindicatoren (%)"` (field name) | `mof.csv` | `measurementType` | Translated as `eutrophication coverage`. Assigned `measurementUnit`: `%`. Used in `measurementID`, example: `21586186:eutrophication_coverage`.
kenmerken | `Bedekking Helofyten (%)` | `mof.csv` | `measurementValue` | 
kenmerken | `"Bedekking Helofyten (%)"` (field name) | `mof.csv` | `measurementType` | Translated as `helophytes coverage`. Assigned `measurementUnit`: `%`. Used in `measurementID`, example: `21586186:helophytes_coverage`.  
kenmerken | `Beschaduwing Macrofyten (%)` | `mof.csv` | `measurementValue` | 
kenmerken | `"Beschaduwing Macrofyten (%)"` (field name) | `mof.csv` | `measurementType` | Translated as `macrophytes shading`. Assigned `measurementUnit`: `%`. Used in `measurementID`, example: `21327838:macrophytes_shading`.
kenmerken | `sliblaag` | `mof.csv` | `measurementValue` | See proposed mapping in #17.
kenmerken | `"sliblaag"` (field name) | `mof.csv` | `measurementType` | Translated as `sludge level`. Assigned `measurementUnit`: `cm`. Used in `measurementID`, example: `21327837:sludge_level`. See #17.
kenmerken | `Laag Grof Organisch Materiaal (cm)` | | | 
kenmerken | `"Laag Grof Organisch Materiaal (cm)"` | `mof.csv` | `measurementType` | Translated as `coarse organic matter layer`. Assigned `measurementUnit`: `cm`. Used in `measurementID`, example: `21583203:coarse_organic_matter_layer`. See #2.
kenmerken | `Breedte Waterspiegel Gemiddeld (cm)` | `mof.csv` | `measurementValue` | 
kenmerken | `"Breedte Waterspiegel Gemiddeld (cm)"` (field name) | `mof.csv` | `measurementType` | Translated as `average width water level`. Assigned `measurementUnit`: `cm`. Used in `measurementID`, example: `21336080:average_width_water_level`. See #18.
kenmerken | `Breedte Waterspiegel Minimum (cm)` | `mof.csv` | `measurementValue` | 
kenmerken | `"Breedte Waterspiegel Minimum (cm)` (field name) | `mof.csv` | `measurementType` | Translated as `minimum width water level`. Assigned `measurementUnit`: `cm`. Used in `measurementID`, example: `21336080:minimum_width_water_level`. See #18.
kenmerken | `Breedte Waterspiegel Maximum (cm)` | `mof.csv` | `measurementValue` | 
kenmerken | `"Breedte Waterspiegel Maximum (cm)"` (field name) | `mof.csv` | `measurementType` | Translated as `maximum width water level`. Assigned `measurementUnit`: `cm`. Used in `measurementID`, example: `21336080:maximum_width_water_level`. See #18.
kenmerken | `Diepte Gemiddeld (cm)` | `mof.csv` | `measurementValue` | 
kenmerken | `"Diepte Gemiddeld (cm)"` (field name) | `mof.csv` | `measurementType` | Translated as `average depth`. Assigned `measurementUnit`: `cm`. Used in `measurementID`, example: `21336627:average_depth`.
kenmerken | `Diepte Minimum (cm)` | `mof.csv` | `measurementValue` | No values present. Mapped value is empty.
kenmerken | `"Diepte Minimum (cm)"` (field name) | `mof.csv` | `measurementType` | Translated as `minimum depth`. Assigned `measurementUnit`: `cm`. Same `measurementID` convention as for `average depth` will apply.
kenmerken | `Diepte Maximum (cm)` | `mof.csv` | `measurementValue` | 
kenmerken | `"Diepte Maximum (cm)"` (field name) | `mof.csv` | `measurementType` | Translated as `maximum depth`. Assigned `measurementUnit`: `cm`. Used in `measurementID`, example: `21341689:maximum_depth`.
kenmerken | `stroming` | `mof.csv` | `mof.csv` | `measurementValue` | See proposed mapping in #9.
kenmerken | `"stroming"` (field name) | `mof.csv` | `mof.csv` | `measurementType` | Translated as `current`. No `measurementUnit`. Used in `measurementID`, example: `21327837:current`.
veldmetingen (FC) | `Monster ID MOW` | none | none | Not used. See #19.
veldmetingen (FC) | `Deelmonster ID MOW` | none | none | used to JOIN with `deelmonster_id` from sheet kenmerken. 
veldmetingen (FC) | `meetplaats` | `mof.csv`| none | none | 
veldmetingen (FC) | `monsternamedatum` | `mof.csv`| `measurementDeterminedDate` |  
veldmetingen (FC) | `par` | `mof.csv`| `measurementType` |  Mapping of the values in #. Used in `measurementID`. Examples: `21327837:Secchi_depth`, `21327837:current`, `21327837:dissolved_oxygen`.
veldmetingen (FC) | `teken` | `mof.csv`| part of `measurementValue` if not `=` | Example: `>40`.
veldmetingen (FC) | `Resultaat` | `mof.csv`| (part of) `measurementValue` | Examples: `1215`, `70` `>40`.
veldmetingen (FC) | `eenh` | `mof.csv`| `measurementUnit` | Examples: `°C`, `cm`, `mg/L`.
veldmetingen (FC) | `Secchischijf op Bodem` | `mof.csv`| `measurementRemarks` when `measurementType` = '"Secchi depth"'  | Values: `"Secchi disk at the bottom"`, '"Secchi disk not at the bottom"'.
EKC MAF | `meetplaats` | none | none | Geographic info already saved at event level. 
EKC MAF | `Deelmonster ID` | `mof.csv` | `eventID` and part of `measurementID`| Link to `events.csv` via `eventID`. Example `measurementID`: 21327837:ecologic_quality_coefficient_with_gep.
EKC MAF | `Jaar` | none | none | Temporal info already saved at event level. See above.
EKC MAF | `monsternamedatum` | none | none | Temporal info already saved at event level. See above.
EKC MAF | `index ZONDER gep` | `mof.csv` | `measurementValue` | Examples: `0.5`, `0.3`.
EKC MAF | `"index ZONDER gep"` (field name) | `mof.csv` | `measurementType` | Translate as `"ecologic quality coefficient without GEP"`. See #4.
EKC MAF | `index GEP` | `mof.csv` | `measurementValue` | Examples: `0.4`, `0.5`.
EKC MAF | `"index GEP"` (field name) | `mof.csv` | `measurementTye` | Translated as `"ecologic quality coefficient with GEP"`. See #4.
EKC MAF | `type` | none | none | Save at event level using info from sheet meetplaatsen, field `waterlichaamcategorietype`.
EKC MAF | `klasse` | `mof.csv` | `measurementValue`| See #4.
EKC MAF | `"klasse"` (field name) | `mof.csv` | `measurementType`| Translated as `"'ecologic quality coefficient class"`. See #4.
EKC MAF | `status` | `mof.csv` | `measurementValue` | Examples: `default`, `artificial`. See #4.
EKC MAF | `"status"` (field name) | `mof.csv` | `measurementType` | Unchanged while translating to EN: `status`. See #4.
EKC MAF | `sterk veranderd` | none | none | Not sure how to map it. See #4.
EKC MAF | `owl` | none | none | Information at event level.
EKC MAF | `waterlichaam` | none | none | Information at event level.
EKC MAF | `Bevestigingscode MF` | none | none | See #4.
EKC MAF | `Deelmonster Geen Organisme` | none | none | See #4.
