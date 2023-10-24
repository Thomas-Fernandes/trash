p2 <- ggplot(proportions_df, aes(x = Année)) +
  geom_line(aes(y = Prop_ZPN_en_ZGN, color = "Part des infractions enregistrées par la\nGendarmerie mais commises en Zone Police"), size = 1.5) +
  geom_line(aes(y = Prop_ZGN_en_ZPN, color = "Part des infractions enregistrées par la Police \nmais commises en Zone Gendarmerie"), size = 1.5) +
  labs(x = "Années", y = "Proportions (en %)", color = "") +
  ggtitle("Évolution des proportions d'enregistrements d'infractions entre ZPN et ZGN") +
  scale_color_manual(values = c("Part des infractions enregistrées par la\nGendarmerie mais commises en Zone Police" = "#E89E0B",
                                "Part des infractions enregistrées par la Police \nmais commises en Zone Gendarmerie" = "#0F417A")) +
  theme(legend.position = "bottom",
        legend.title = element_text(size = 12)) +
  ylim(5, 10)

p2 <- ggplot(proportions_df, aes(x = Année)) +
  geom_line(aes(y = Prop_ZPN_en_ZGN, color = "Part des violences sexuelles enregistrées par\nla Gendarmerie mais commises en Zone Police"), size = 1.5) +
  geom_line(aes(y = Prop_ZGN_en_ZPN, color = "Part des violences sexuelles enregistrées par\nla Police mais commises en Zone Gendarmerie"), size = 1.5) +
  labs(x = "Années", y = "Proportions", color = "") +
  ggtitle("Évolution des proportions d'enregistrements d'infractions pour violences sexuelles entre ZPN et ZGN") +
  scale_color_manual(values = c("Part des violences sexuelles enregistrées par\nla Gendarmerie mais commises en Zone Police" = "#E89E0B",
                                "Part des violences sexuelles enregistrées par\nla Police mais commises en Zone Gendarmerie" = "#0F417A")) +
  ylim(10, 16) +
  theme(legend.position = "bottom",
        plot.title = element_text(size = 10))

p2 <- ggplot(proportions_df, aes(x = Année)) +
  geom_line(aes(y = Prop_ZPN_en_ZGN, color = "Part des vols avec ou sans violence enregistrés\npar la gendarmerie mais commis en Zone Police"), size = 1.5) +
  geom_line(aes(y = Prop_ZGN_en_ZPN, color = "Part des vols avec ou sans violence enregistrés\npar la Police mais commis en Zone Gendarmerie"), size = 1.5) +
  labs(x = "Années", y = "Proportions", color = "") +
  ggtitle("Évolution des proportions d'enregistrements de vols avec ou sans violence entre ZPN et ZGN") +
  scale_color_manual(values = c("Part des vols avec ou sans violence enregistrés\npar la gendarmerie mais commis en Zone Police" = "#E89E0B",
                                "Part des vols avec ou sans violence enregistrés\npar la Police mais commis en Zone Gendarmerie" = "#0F417A")) +
  theme(legend.position = "bottom",
        plot.title = element_text(size = 10.5)) +
  ylim(5, 10)
