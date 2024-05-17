library(readr)
library(dplyr)
fr_esr_atlas_regional_effectifs_d_etudiants_inscrits <- read_csv("C:/Users/Administrateur/Desktop/fr-esr-atlas_regional-effectifs-d-etudiants-inscrits.csv")

# calcul par années "annee_universitaire" le nombre d'étudiant "effectif" lorsque "regourpement == TOTAL" et que "niveau_geographique == Commune"
t <- fr_esr_atlas_regional_effectifs_d_etudiants_inscrits %>%
  filter(regroupement == "TOTAL" & niveau_geographique == "Commune") %>%
  group_by(annee_universitaire) %>%
  summarise(effectif = sum(effectif))
