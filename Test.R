for (i in 1:nrow(data)) {
  dept_commission <- as.character(data$DEPT_COMMISSION[i])
  dept_service <- as.character(data$DEPT_SERV[i])
  print(dept_commission)
  print(dept_service)
  if(!is.na(dept_commission) && dept_commission != "" && !is.na(dept_service) && dept_service != "") {
    if (dept_commission == dept_service) {
      matrice_dep[dept_commission, dept_commission] <- as.numeric(matrice_dep[dept_commission, dept_commission] + 1)
      print(matrice_dep[dept_commission, dept_commission])
    } else {
      if(dept_commission %in% sorted_dep && dept_service %in% sorted_dep) {
        matrice_dep[dept_service, dept_commission] <- as.numeric(matrice_dep[dept_service, dept_commission] + 1)
      }
    }
  }
}


#La boucle est trop longue, on va l'optimiser en utilisant table
# Initialisation de la matrice_dep
matrice_dep <- matrix(0, nrow = length(sorted_dep), ncol = length(sorted_dep), dimnames = list(sorted_dep, sorted_dep))

# Conversion en caractères des colonnes concernées
data$DEPT_COMMISSION <- as.character(data$DEPT_COMMISSION)
data$DEPT_SERV <- as.character(data$DEPT_SERV)

# Filtrer les lignes non vides pour DEPT_COMMISSION et DEPT_SERV
data <- data[!is.na(data$DEPT_COMMISSION) & data$DEPT_COMMISSION != "" & !is.na(data$DEPT_SERV) & data$DEPT_SERV != "", ]

# Identifier les correspondances
matching_indices <- data$DEPT_COMMISSION == data$DEPT_SERV
matching_depts <- data$DEPT_COMMISSION[matching_indices]

# Incrémenter les correspondances
matrice_dep[matching_depts, matching_depts] <- as.numeric(matrice_dep[matching_depts, matching_depts] + 1)

# Filtrer les correspondances restantes
remaining_indices <- data$DEPT_COMMISSION %in% sorted_dep & data$DEPT_SERV %in% sorted_dep & !matching_indices

# Incrémenter les correspondances restantes
matrice_dep[as.matrix(data[remaining_indices, c("DEPT_SERV", "DEPT_COMMISSION")])] <- 
  matrice_dep[as.matrix(data[remaining_indices, c("DEPT_SERV", "DEPT_COMMISSION")])] + 1
