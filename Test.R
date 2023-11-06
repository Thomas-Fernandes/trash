# Créer les données
LIEU_COMMISSION <- c(1053, 1053, 1010, 1011)
CODE_SERVICE <- c(3, 3, 4, 4)

# Créer le dataframe
df <- data.frame(LIEU_COMMISSION, CODE_SERVICE)

# Créer les données
INSEE_SIEGE_CIRCO_NOM_COM <- c(1053, 1053, 1053, 1010)
SRV_COD_DESCR_GENERIQUE <- c(3, 3, 3, 4)
INSEE_COMMUNE <- c(1053, 1289, 1344, 435)

# Créer le dataframe
df2 <- data.frame(INSEE_SIEGE_CIRCO_NOM_COM, SRV_COD_DESCR_GENERIQUE, INSEE_COMMUNE)

for (i in 1:nrow(df)) {
  # Initialiser une liste vide pour stocker les résultats
  liste_communes <- c()
  
  # Rechercher le CODE_SERVICE dans la colonne SRV_COD_DESCR_GENERIQUE de df2
  rows <- which(df2$SRV_COD_DESCR_GENERIQUE == df$CODE_SERVICE[i])
  
  # S'il y a une ou plusieurs lignes correspondantes, récupérer les noms de communes associés
  if (length(rows) > 0) {
    liste_communes <- df2$INSEE_COMMUNE[rows]
  }
  
  # Insérer la liste dans la ligne correspondante de df, à la colonne Lieu_enr
  df$Lieu_enr[i] <- paste(liste_communes, collapse = ", ")
}



# Création d'une nouvelle colonne Lieu_enr dans df
df$Lieu_enr <- NA

# Définir une fonction pour la recherche et l'insertion des valeurs
get_matching_communes <- function(code_service) {
    rows <- which(df2$SRV_COD_DESCR_GENERIQUE == code_service)
    if (length(rows) > 0) {
        return(paste(df2$INSEE_COMMUNE[rows], collapse = ", "))
    } else {
        return(NA)
    }
}

# Appliquer la fonction pour chaque valeur de CODE_SERVICE dans df
df$Lieu_enr <- sapply(df$CODE_SERVICE, get_matching_communes)

# Afficher le dataframe mis à jour
print(df)




get_matching_info <- function(code_service) {
    if (code_service != "GN") {
        rows <- which(df2$SRV_COD_DESCR_GENERIQUE == code_service)
        if (length(rows) > 0) {
            communes <- as.list(df2$INSEE_COMMUNE[rows])
            libelle <- unique(df2$LIBELLE_SERVICE_ORUS_CSP[rows])
            return(list(communes, libelle))
        }
    }
    return(list(NA, NA))
}

# Appliquer la fonction pour chaque valeur de CODE_SERVICE dans df
info <- map(df$CODE_SERVICE, get_matching_info)
df$Lieu_enr <- map(info, 1)
df$Libelle_service <- map_chr(info, 2)














get_matching_info <- function(code_service) {
    if (code_service != "GN") {
        rows <- which(df2$SRV_COD_DESCR_GENERIQUE == code_service)
        if (length(rows) > 0) {
            communes <- as.list(df2$INSEE_COMMUNE[rows])
            libelle <- unique(df2$LIBELLE_SERVICE_ORUS_CSP[rows])
            nom_com <- unique(df2$INSEE_SIEGE_CIRCO_NOM_COM[rows])
            return(list(communes, libelle, nom_com))
        }
    }
    return(list(NA, NA, NA))
}

# Appliquer la fonction pour chaque valeur de CODE_SERVICE dans df
info <- map(df$CODE_SERVICE, get_matching_info)
df$Lieu_enr <- map(info, 1)
df$Libelle_service <- map_chr(info, 2)
df$INSEE_SIEGE_CIRCO_NOM_COM <- map_chr(info, 3)










get_matching_info <- function(code_service) {
    if (code_service != "GN") {
        rows <- which(df2$SRV_COD_DESCR_GENERIQUE == code_service)
        if (length(rows) > 0) {
            communes <- as.list(df2$INSEE_COMMUNE[rows])
            libelle <- unique(df2$LIBELLE_SERVICE_ORUS_CSP[rows])
            nom_com <- unique(df2$INSEE_SIEGE_CIRCO_NOM_COM[rows])
            insee_siege_circo <- unique(df2$INSEE_SIEGE_CIRCO[rows])
            return(list(communes, libelle, nom_com, insee_siege_circo))
        }
    }
    return(list(NA, NA, NA, NA))
}










get_matching_info <- function(code_service) {
    if (code_service != "GN") {
        rows <- which(df2$SRV_COD_DESCR_GENERIQUE == code_service)
        if (length(rows) > 0) {
            communes <- as.list(df2$INSEE_COMMUNE[rows])
            libelle <- unique(df2$LIBELLE_SERVICE_ORUS_CSP[rows])
            nom_com <- unique(df2$INSEE_SIEGE_CIRCO_NOM_COM[rows])
            insee_siege_circo <- unique(df2$INSEE_SIEGE_CIRCO[rows])
            return(list(communes, libelle, nom_com, insee_siege_circo, NA))
        }
    } else {
        rows <- which(df2$CODE_DIR_RATTACH == df$CODE_SERVICE)
        if (length(rows) > 0) {
            communes <- as.list(df2$CODE_INSEE[rows])
            libelle <- unique(df2$BTA_BP[rows])
            nom_com <- unique(df2$ID_COMMUNE_IMPLANTATION_CIE[rows])
            insee_siege_circo <- NA
            code_dir_rattach <- unique(df2$CODE_DIR_RATTACH[rows])
            return(list(communes, libelle, nom_com, insee_siege_circo, code_dir_rattach))
        }
    }
    return(list(NA, NA, NA, NA, NA))
}



info <- map(df$CODE_SERVICE, get_matching_info)
df$Lieu_enr <- map(info, 1)
df$Libelle_service <- map_chr(info, 2)
df$INSEE_SIEGE_CIRCO_NOM_COM <- map_chr(info, 3)
df$INSEE_SIEGE_CIRCO <- map_dbl(info, 4)
df$CODE_DIR_RATTACH <- map_chr(info, 5)



info <- mapply(get_matching_info, df$CODE_SERVICE, ifelse(df$CODE_SERVICE == "GN", df$CODE_SERVICE, NA), SIMPLIFY = FALSE)












# Définir une fonction pour la recherche et l'insertion des valeurs lorsque CODE_SERVICE n'est pas "GN"
get_non_gn_matching_info <- function(code_service) {
    rows <- which(df2$SRV_COD_DESCR_GENERIQUE == code_service)
    if (length(rows) > 0) {
        communes <- as.list(df2$INSEE_COMMUNE[rows])
        libelle <- unique(df2$LIBELLE_SERVICE_ORUS_CSP[rows])
        nom_com <- unique(df2$INSEE_SIEGE_CIRCO_NOM_COM[rows])
        insee_siege_circo <- unique(df2$INSEE_SIEGE_CIRCO[rows])
        return(list(communes, libelle, nom_com, insee_siege_circo))
    }
    return(list(NA, NA, NA, NA))
}

# Définir une fonction pour la recherche et l'insertion des valeurs lorsque CODE_SERVICE est "GN"
get_gn_matching_info <- function(code_dir_rattach) {
    rows <- which(df2$CODE_DIR_RATTACH == code_dir_rattach)
    if (length(rows) > 0) {
        communes <- as.list(df2$CODE_INSEE[rows])
        libelle <- unique(df2$CU_BTA_BP[rows])
        nom_com <- unique(df2$ID_COMMUNE_IMPLANTATION_CIE[rows])
        insee_siege_circo <- unique(df2$CODE_DIR_RATTACH[rows])
        return(list(communes, libelle, nom_com, insee_siege_circo))
    }
    return(list(NA, NA, NA, NA))
}

# Appliquer les fonctions correspondantes pour chaque valeur de CODE_SERVICE dans df
non_gn_info <- map(df$CODE_SERVICE[df$CODE_SERVICE != "GN"], get_non_gn_matching_info)
gn_info <- map(df$CODE_SERVICE[df$CODE_SERVICE == "GN"], get_gn_matching_info)

df$Lieu_enr[df$CODE_SERVICE != "GN"] <- map(non_gn_info, 1)
df$Libelle_service[df$CODE_SERVICE != "GN"] <- map_chr(non_gn_info, 2)
df$INSEE_SIEGE_CIRCO_NOM_COM[df$CODE_SERVICE != "GN"] <- map_chr(non_gn_info, 3)
df$INSEE_SIEGE_CIRCO[df$CODE_SERVICE != "GN"] <- map_dbl(non_gn_info, 4)

df$Lieu_enr[df$CODE_SERVICE == "GN"] <- map(gn_info, 1)
df$Libelle_service[df$CODE_SERVICE == "GN"] <- map_chr(gn_info, 2)
df$INSEE_SIEGE_CIRCO_NOM_COM[df$CODE_SERVICE == "GN"] <- map_chr(gn_info, 3)
df$INSEE_SIEGE_CIRCO[df$CODE_SERVICE == "GN"] <- map_dbl(gn_info, 4)



# Fonction pour trouver la circonscription
find_circonscription <- function(insee_commission, code_service, csp_gn, csp_pn) {
  if (code_service == "GN") {
    circonscription <- csp_gn$CU_CIE[match(insee_commission, csp_gn$CODE_INSEE)]
  } else {
    circonscription <- csp_pn$INSEE_SIEGE_CIRCO[match(insee_commission, csp_pn$INSEE_COMMUNE)]
  }
  return(circonscription)
}

# Appliquer la fonction sur chaque ligne du dataframe base_infractions_2016
base_infractions_2016$circonscription <- mapply(find_circonscription, 
                                                 base_infractions_2016$INSEE_COMMISSION_2016, 
                                                 base_infractions_2016$CODE_SERVICE, 
                                                 MoreArgs = list(csp_gn = CSP_GN, csp_pn = CSP_PN))







# Création de nouvelles colonnes Lieu_enr, Libelle_service, INSEE_SIEGE_CIRCO_NOM_COM et INSEE_SIEGE_CIRCO dans df
df$Lieu_enr <- NA
df$Libelle_service <- NA
df$INSEE_SIEGE_CIRCO_NOM_COM <- NA
df$INSEE_SIEGE_CIRCO <- NA

# Définir une fonction pour la recherche et l'insertion des valeurs
get_matching_info <- function(code_service, code_dir_rattach) {
    if (code_service != "GN") {
        rows <- which(df2$SRV_COD_DESCR_GENERIQUE == code_service)
        if (length(rows) > 0) {
            communes <- as.list(df2$INSEE_COMMUNE[rows])
            libelle <- unique(df2$LIBELLE_SERVICE_ORUS_CSP[rows])
            nom_com <- unique(df2$INSEE_SIEGE_CIRCO_NOM_COM[rows])
            insee_siege_circo <- unique(df2$INSEE_SIEGE_CIRCO[rows])
            return(list(communes, libelle, nom_com, insee_siege_circo))
        }
    } else {
        rows <- which(df2$CODE_DIR_RATTACH == code_dir_rattach)
        if (length(rows) > 0) {
            insee_siege_circo <- unique(df2$CU_BTA_BP[rows])
            return(list(NA, NA, NA, insee_siege_circo))
        }
    }
    return(list(NA, NA, NA, NA))
}

# Appliquer la fonction pour chaque valeur de CODE_SERVICE dans df
info <- mapply(get_matching_info, df$CODE_SERVICE, df$CODE_DIR_RATTACH)
df$Lieu_enr <- map(info, 1)
df$Libelle_service <- map_chr(info, 2)
df$INSEE_SIEGE_CIRCO_NOM_COM <- map_chr(info, 3)
df$INSEE_SIEGE_CIRCO <- map_dbl(info, 4)














# Fonction ajustée pour renvoyer directement les valeurs de la circonscription et du libellé
find_circonscription <- function(insee_commission, code_service, csp_gn, csp_pn) {
  if (code_service == "GN") {
    circonscription <- csp_gn$CU_CIE[match(insee_commission, csp_gn$CODE_INSEE)]
    libelle <- csp_gn$CIE[match(insee_commission, csp_gn$CODE_INSEE)]
  } else {
    circonscription <- csp_pn$INSEE_SIEGE_CIRCO[match(insee_commission, csp_pn$INSEE_COMMUNE)]
    libelle <- csp_pn$INSEE_SIEGE_CIRCO_NOM_COM[match(insee_commission, csp_pn$INSEE_COMMUNE)]
  }
  return(list(circonscription = circonscription, libelle = libelle))
}

# Appliquer la fonction avec mapply et créer directement deux nouvelles colonnes
results <- mapply(find_circonscription, 
                  base_infractions_2016$INSEE_COMMISSION_2016, 
                  base_infractions_2016$CODE_SERVICE, 
                  MoreArgs = list(csp_gn = CSP_GN, csp_pn = CSP_PN),
                  SIMPLIFY = FALSE)  # Conserver le résultat sous forme de liste

# Création des colonnes circonscription et libellé_circonscription
base_infractions_2016$circonscription <- sapply(results, `[[`, "circonscription")
base_infractions_2016$libelle_circonscription <- sapply(results, `[[`, "libelle")
