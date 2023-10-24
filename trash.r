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
# Tracer le graphique combiné avec des améliorations visuelles
ggplot(melted_df, aes(x = Année, y = value, color = variable, linetype = type)) +
  geom_line(size = 1.5) +
  labs(x = "Années", y = "Proportions", color = "Légende", linetype = "Type") +
  ggtitle("Titre du graphique combiné") +
  scale_color_manual(values = c(
    "Prop_ZPN_en_ZGN" = "#E89E0B",
    "Prop_ZGN_en_ZPN" = "#0F417A"
  )) +
  scale_linetype_manual(values = c("solid", "dashed", "dotted")) +
  theme_minimal() +
  theme(legend.position = "bottom",
        plot.title = element_text(size = 14, hjust = 0.5, face = "bold"),
        axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 10, face = "bold"),
        legend.text = element_text(size = 9)) +
  facet_wrap(~type, ncol = 1, scales = "free_y") +
  ylim(5, 16) +
  annotate("text", x = 2010, y = 15, label = "Annotations personnalisées", size = 4, color = "black") +
  annotate("rect", xmin = 2010, xmax = 2012, ymin = 5, ymax = 16, fill = "grey", alpha = 0.2) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

