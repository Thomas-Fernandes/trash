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