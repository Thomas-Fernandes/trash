library(cartogram)

mf_theme("brutal")

mf_map(x = geo_data,
       var = "taux_commission",
       breaks = "jenks",
       nbreaks = 4,
       pal = "Blues",
       border = "grey",
       lwd = 0.5,
       leg_pos = "bottomleft",
       leg_title = "Taux de commission"
)

mf_label(x = geo_data,
var = tmp)