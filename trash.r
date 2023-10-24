library(reshape2)
library(ggplot2)

# Suppose que vous avez trois dataframes nommées proportions_df1, proportions_df2 et proportions_df3

# Rassembler les dataframes
proportions_df1$type <- "Type 1"
proportions_df2$type <- "Type 2"
proportions_df3$type <- "Type 3"

combined_df <- rbind(proportions_df1, proportions_df2, proportions_df3)

# Utiliser la fonction melt pour remodeler le dataframe
melted_df <- melt(combined_df, id.vars = c("Année", "type"))

# Tracer le graphique combiné
ggplot(melted_df, aes(x = Année, y = value, color = variable)) +
  geom_line(size = 1.5) +
  labs(x = "Années", y = "Proportions", color = "Légende") +
  ggtitle("Titre du graphique combiné") +
  scale_color_manual(values = c(
    "Prop_ZPN_en_ZGN" = "#E89E0B",
    "Prop_ZGN_en_ZPN" = "#0F417A"
  )) +
  theme(legend.position = "bottom", plot.title = element_text(size = 10.5)) +
  facet_wrap(~type, ncol = 1, scales = "free_y") +
  ylim(5, 16)
