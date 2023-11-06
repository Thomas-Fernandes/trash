# Supposons que CSP_PN et CSP_GN sont vos dataframes
# On va chercher les valeurs de INSEE_SIEGE_CIRCO dans CSP_PN qui sont aussi dans CU_CIE de CSP_GN

# Utilisation de merge() pour un jointure
resultat <- merge(CSP_PN, CSP_GN, by.x = "INSEE_SIEGE_CIRCO", by.y = "CU_CIE")

# Utilisation de %in% pour filtrer les données
resultat <- CSP_PN[CSP_PN$INSEE_SIEGE_CIRCO %in% CSP_GN$CU_CIE, ]
