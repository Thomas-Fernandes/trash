ggplot(proportions_df, aes(x = Annees)) +
  geom_line(aes(y = Prop_ZPN_ZGN, color = "Prop_ZPN_ZGN"), size = 1.5) +
  geom_line(aes(y = Prop_ZGN_ZPN, color = "Prop_ZGN_ZPN"), size = 1.5, linetype = "dashed") +
  labs(x = "Années", y = "Proportions", color = "Légende") +
  ggtitle("Évolution des proportions d'infractions entre ZPN et ZGN") +
  scale_color_manual(values = c("Prop_ZPN_ZGN" = "#0F417A", "Prop_ZGN_ZPN" = "#E89E0B")) +
  theme_minimal()