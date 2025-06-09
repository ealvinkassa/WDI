
# setup -------------------------------------------------------------------
# installer le package WDI (World Development Indicators)
install.packages("WDI")

# library -----------------------------------------------------------------
# charger de package WDI
library(WDI)

# wrangling ---------------------------------------------------------------

# Indicateurs WDI sur le site WDI 
# https://databank.worldbank.org/source/world-development-indicators
# Cliquer sur series puis entrer le code de l'indicateur
# dans "enter keywords for" pour en savoir le sens au besoin

# choix indicateurs WDI

indicateurs_utiles <- c(
  "NY.GDP.MKTP.CD",     # PIB (USD courant)
  "NY.GDP.MKTP.KD",     # PIB (USD constant)
  "NY.GDP.MKTP.KD.ZG",  # Croissance PIB (% annuel)
  "NY.GDP.PCAP.CD",     # PIB par habitant
  "SL.UEM.TOTL.ZS",     # Taux de ch?mage (%)
  "SP.POP.TOTL",        # Population totale
  "SP.POP.GROW",        # Croissance d?mographique (%)
  "SP.URB.TOTL.IN.ZS",  # Taux d'urbanisation
  "SH.XPD.CHEX.GD.ZS",  # D?penses de sant? (% du PIB)
  "SE.XPD.TOTL.GD.ZS",  # D?penses d'?ducation (% du PIB)
  "SE.PRM.ENRR",        # Taux de scolarisation (primaire)
  "SE.SEC.ENRR",        # Taux de scolarisation (secondaire)
  "SP.DYN.IMRT.IN",     # Mortalit? infantile
  "SH.STA.BASS.ZS",     # Acc?s ? des services d'eau de base
  "EG.ELC.ACCS.ZS",     # Acc?s ? l'?lectricit? (% pop)
  "NE.GDI.TOTL.ZS",     # Formation brute de capital (% du PIB)
  "BX.KLT.DINV.CD.WD",  # Investissements directs ?trangers
  "GC.XPN.TOTL.GD.ZS",  # D?penses publiques (% du PIB)
  "GC.REV.XGRT.GD.ZS",  # Revenus publics (% du PIB)
  "FR.INR.RINR",        # Taux d'int?r?t r?el
  "FP.CPI.TOTL.ZG",     # Inflation (% annuel)
  "TM.VAL.MRCH.CD.WT",  # Valeur des importations
  "TX.VAL.MRCH.CD.WT",  # Valeur des exportations
  "NE.EXP.GNFS.CD",     # Exportations de biens et services
  "NE.IMP.GNFS.CD",     # Importations de biens et services
  "NE.TRD.GNFS.ZS",     # Commerce (% du PIB)
  "NV.AGR.TOTL.ZS",     # Valeur ajout?e agriculture (% PIB)
  "NV.IND.TOTL.ZS",     # Valeur ajout?e industrie (% PIB)
  "NV.SRV.TOTL.ZS",     # Valeur ajout?e services (% PIB)
  "EG.USE.PCAP.KG.OE",  # Consommation d'?nergie par habitant
  "AG.LND.ARBL.ZS",     # Terres arables (% des terres)
  "AG.PRD.FOOD.XD",     # Production alimentaire
  "BX.TRF.PWKR.DT.GD.ZS", # Transferts des travailleurs (% PIB)
  "SH.MED.BEDS.ZS",     # Lits d'h?pital pour 1.000 habitants
  "SP.DYN.LE00.IN",     # Esp?rance de vie
  "IT.NET.USER.ZS",     # Utilisateurs d'Internet (%)
  "IT.CEL.SETS.P2",     # Abonnements mobiles
  "GC.DOD.TOTL.GD.ZS",  # Dette publique (% du PIB)
  "DT.TDS.DECT.EX.ZS",  # Paiement de la dette ext?rieure (% exportations)
  "SL.TLF.TOTL.IN",     # Population active
  "SL.AGR.EMPL.ZS",     # Emploi dans l'agriculture (%)
  "SL.IND.EMPL.ZS",     # Emploi dans l'industrie (%)
  "SL.SRV.EMPL.ZS",     # Emploi dans les services (%)
  "SL.TLF.CACT.FE.ZS",  # Participation f?minine au travail
  "SH.XPD.OOPC.CH.ZS",  # D?penses de sant? ? charge (%)
  "SP.DYN.TFRT.IN",     # Taux de f?condit?
  "EG.FEC.RNEW.ZS",     # Part d'?nergie renouvelable (%)
  "SP.POP.0014.TO.ZS",  # Part des jeunes (0-14 ans)
  "SP.POP.1564.TO.ZS",  # Part de la population active (15-64 ans)
  "SP.POP.65UP.TO.ZS",  # Part des personnes ?g?es (+65 ans)
  "SP.POP.TOTL.FE.ZS",  # Part des femmes dans la population
  "SP.POP.TOTL.MA.ZS",  # Part des hommes dans la population
  "SP.RUR.TOTL.ZS",     # Population rurale (%)
  "SP.REG.BRTH.ZS",     # Enfants enregistr?s ? la naissance
  "SE.ADT.LITR.ZS",     # Taux d'alphab?tisation adulte
  "SE.PRM.CMPT.ZS",     # Taux d'ach?vement primaire
  "SE.SEC.CMPT.LO.ZS",  # Taux d'ach?vement secondaire
  "SE.TER.CUAT.BA.ZS",  # Population dipl?m?e d'un niveau sup?rieur
  "EN.URB.LCTY.UR.ZS",  # Population urbaine dans les grandes villes
  "SP.UWT.TFRT",        # Taux de f?condit? chez les adolescentes
  "SP.DYN.CONU.ZS",     # Utilisation de contraceptifs (%)
  "SH.MMR.RISK.ZS",     # Risque de mortalit? maternelle
  "SP.DYN.CBRT.IN",     # Taux de natalit? brut
  "SH.IMM.IDPT",        # Couverture vaccinale dipht?rie-t?tanos-coqueluche
  "SH.IMM.MEAS",        # Couverture vaccinale rougeole
  "SH.XPD.GHED.CH.ZS",  # D?penses de sant? par habitant
  "SL.TLF.CACT.ZS",     # Taux de participation ? la force de travail
  "NY.GNS.ICTR.ZS",     # Taux d'?pargne nationale
  "SP.RUR.TOTL",        # Population rurale
  "SP.URB.TOTL",        # Population urbaine
  "SP.DYN.TO65.FE.ZS",  # Esp?rance de vie femmes ? 65 ans
  "SP.DYN.TO65.MA.ZS"   # Esp?rance de vie hommes ? 65 ans
)

# telecharger pour tous les pays de 1962 ? 2023
data_wdi <- WDI(country = "all", 
                indicator = indicateurs_utiles, 
                start = 1962, end = 2023)

# vous recevez un message avis (normal)

View(data_wdi)

# renommage des indicateurs
noms_indicateurs <- c(
  "NY.GDP.MKTP.CD"       = "PIB_USD_courant",
  "NY.GDP.MKTP.KD"       = "PIB_USD_constant",
  "NY.GDP.MKTP.KD.ZG"    = "Croissance_PIB",
  "NY.GDP.PCAP.CD"       = "PIB_par_habitant",
  "SL.UEM.TOTL.ZS"       = "Taux_chomage",
  "SP.POP.TOTL"          = "Population_totale",
  "SP.POP.GROW"          = "Croissance_population",
  "SP.URB.TOTL.IN.ZS"    = "Urbanisation",
  "SH.XPD.CHEX.GD.ZS"    = "Depenses_sante_PIB",
  "SE.XPD.TOTL.GD.ZS"    = "Depenses_education_PIB",
  "SE.PRM.ENRR"          = "Scolarisation_primaire",
  "SE.SEC.ENRR"          = "Scolarisation_secondaire",
  "SP.DYN.IMRT.IN"       = "Mortalite_infantile",
  "SH.STA.BASS.ZS"       = "Acces_eau_de_base",
  "EG.ELC.ACCS.ZS"       = "Acces_electricite",
  "NE.GDI.TOTL.ZS"       = "Formation_capital_PIB",
  "BX.KLT.DINV.CD.WD"    = "IDE_entrant_USD",
  "GC.XPN.TOTL.GD.ZS"    = "Depenses_publiques_PIB",
  "GC.REV.XGRT.GD.ZS"    = "Revenus_publics_PIB",
  "FR.INR.RINR"          = "Taux_interet_reel",
  "FP.CPI.TOTL.ZG"       = "Inflation_annuelle",
  "TM.VAL.MRCH.CD.WT"    = "Importations_USD",
  "TX.VAL.MRCH.CD.WT"    = "Exportations_USD",
  "NE.EXP.GNFS.CD"       = "Exportations_biens_services",
  "NE.IMP.GNFS.CD"       = "Importations_biens_services",
  "NE.TRD.GNFS.ZS"       = "Commerce_PIB",
  "NV.AGR.TOTL.ZS"       = "Valeur_agriculture_PIB",
  "NV.IND.TOTL.ZS"       = "Valeur_industrie_PIB",
  "NV.SRV.TOTL.ZS"       = "Valeur_services_PIB",
  "EG.USE.PCAP.KG.OE"    = "Conso_energie_par_hab",
  "AG.LND.ARBL.ZS"       = "Terres_arables",
  "AG.PRD.FOOD.XD"       = "Production_alimentaire",
  "BX.TRF.PWKR.DT.GD.ZS" = "Transferts_travailleurs_PIB",
  "SH.MED.BEDS.ZS"       = "Lits_hospitaliers",
  "SP.DYN.LE00.IN"       = "Esperance_vie_naissance",
  "IT.NET.USER.ZS"       = "Utilisateurs_internet",
  "IT.CEL.SETS.P2"       = "Abonnements_mobiles",
  "GC.DOD.TOTL.GD.ZS"    = "Dette_publique_PIB",
  "DT.TDS.DECT.EX.ZS"    = "Paiement_dette_export",
  "SL.TLF.TOTL.IN"       = "Population_active",
  "SL.AGR.EMPL.ZS"       = "Emplois_agriculture",
  "SL.IND.EMPL.ZS"       = "Emplois_industrie",
  "SL.SRV.EMPL.ZS"       = "Emplois_services",
  "SL.TLF.CACT.FE.ZS"    = "Participation_femmes_travail",
  "SH.XPD.OOPC.CH.ZS"    = "Depenses_sante_directes",
  "SP.DYN.TFRT.IN"       = "Taux_fertilite",
  "EG.FEC.RNEW.ZS"       = "Energie_renouvelable_PIB",
  "SP.POP.0014.TO.ZS"    = "Population_jeunes",
  "SP.POP.1564.TO.ZS"    = "Population_active_age",
  "SP.POP.65UP.TO.ZS"    = "Population_agee",
  "SP.POP.TOTL.FE.ZS"    = "Part_femmes_population",
  "SP.POP.TOTL.MA.ZS"    = "Part_hommes_population",
  "SP.RUR.TOTL.ZS"       = "Population_rurale_pct",
  "SP.REG.BRTH.ZS"       = "Enregistrement_naissances",
  "SE.ADT.LITR.ZS"       = "Alphabetisation_adultes",
  "SE.PRM.CMPT.ZS"       = "Ach?vement_primaire",
  "SE.SEC.CMPT.LO.ZS"    = "Ach?vement_secondaire",
  "SE.TER.CUAT.BA.ZS"    = "Diplomes_enseignement_sup",
  "EN.URB.LCTY.UR.ZS"    = "Population_grandes_villes",
  "SP.UWT.TFRT"          = "Fertilite_adolescentes",
  "SP.DYN.CONU.ZS"       = "Utilisation_contraceptifs",
  "SH.MMR.RISK.ZS"       = "Risque_mortalite_maternelle",
  "SP.DYN.CBRT.IN"       = "Taux_natalite",
  "SH.IMM.IDPT"          = "Vaccination_DTC",
  "SH.IMM.MEAS"          = "Vaccination_rougeole",
  "SH.XPD.GHED.CH.ZS"    = "Depenses_sante_habitant",
  "SL.TLF.CACT.ZS"       = "Participation_travail_total",
  "NY.GNS.ICTR.ZS"       = "Taux_epargne",
  "SP.RUR.TOTL"          = "Population_rurale",
  "SP.URB.TOTL"          = "Population_urbaine",
  "SP.DYN.TO65.FE.ZS"    = "Esperance_vie_femme_65",
  "SP.DYN.TO65.MA.ZS"    = "Esperance_vie_homme_65"
)

#integration des nouveaux noms
names(data_wdi) <- 
  ifelse(names(data_wdi) %in%
           names(noms_indicateurs),
         noms_indicateurs[names(data_wdi)],
         names(data_wdi))

View(data_wdi)

# bon courage
