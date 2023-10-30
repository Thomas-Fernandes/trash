library(readr)
library(dplyr)
library(ggplot2)
library(plotly)
library(writexl)

#----------------------#
# Chargement des bases #
#----------------------#

bases_infractions <- c("2016.RDATA", "2017.RDATA", "2018.RDATA", "2019.RDATA", "2020.RDATA")

for(i in 1:length(bases_infractions)){
  load(bases_infractions[i])
  print(paste("Chargement des fichiers : ", (i/length(bases_infractions)*100), "%"))
}

#----------------------#
# Création de la matrice carré #
#----------------------#

# Le nom des colonnes et des lignes est le même, il s'agit de la taille de l'unité urbaine
#0-Rural
#1-Unités urbaines de 2 000 à 4 999 habitants
#2-Unités urbaines de 5 000 à 9 999 habitants
#3-Unités urbaines de 10 000 à 19 999 habitants
#4-Unités urbaines de 20 000 à 49 999 habitants
#5-Unités urbaines de 50 000 à 99 999 habitants
#6-Unités urbaines de 100 000 à 199 999 habitants
#7-Unités urbaines de 200 000 à 1 999 999 habitants
#8-Agglomération de Paris



create_matrix <- function(base) {
  matrice <- data.frame(
    "TUU_COMM_0" = c(0,0,0,0,0,0,0,0,0),
    "TUU_COMM_1" = c(0,0,0,0,0,0,0,0,0),
    "TUU_COMM_2" = c(0,0,0,0,0,0,0,0,0),
    "TUU_COMM_3" = c(0,0,0,0,0,0,0,0,0),
    "TUU_COMM_4" = c(0,0,0,0,0,0,0,0,0),
    "TUU_COMM_5" = c(0,0,0,0,0,0,0,0,0),
    "TUU_COMM_6" = c(0,0,0,0,0,0,0,0,0),
    "TUU_COMM_7" = c(0,0,0,0,0,0,0,0,0),
    "TUU_COMM_8" = c(0,0,0,0,0,0,0,0,0),
    row.names = c(
      "TUU_ENR_0",
      "TUU_ENR_1", 
      "TUU_ENR_2", 
      "TUU_ENR_3", 
      "TUU_ENR_4", 
      "TUU_ENR_5", 
      "TUU_ENR_6", 
      "TUU_ENR_7", 
      "TUU_ENR_8"
    )
  )
  counts <- table(base$TUU_COMMISSION, base$SAME)

  #Peuplement de la matrice
  for(i in 1:nrow(matrice)){
    for(j in 1:ncol(matrice)){
      matrice[i,j] <- counts[i,j]
    }
  }  
  return(matrice)
}

> dep.voi
$`01`
[1] "01" "38" "39" "69" "71" "73" "74"
