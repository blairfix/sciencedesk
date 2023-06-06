library(bfgg)

dir = getwd()

income = seq( 1, 10, 0.1)
stash = - income ^ 0.5


gplot = ggplot() +
    geom_line(
	      aes(
		  x = income,
		  y = stash
		  ),
	      col = "dodgerblue4",
	      linewidth = 2
	      ) +
    scale_x_continuous(
		       "Class",
		       breaks = c(2, 9),
		       labels = c("workers", "investors")
		       ) +
    scale_y_continuous(
		       "Marginal propensity to stash",
		       breaks = c(-3, -1),
		       labels =  c("low", "high")
		       ) +
    bfgg_theme() +
    annotate(
	     "text",
	     label = "Marginal propensity\nto stash",
	     x = 5.5,
	     y = -1.5,
	     size = 4,
	     family = "Times"
	     )


# export plot
#------------------------------------------

chart_export(
	     plot_var = gplot,
             filename = "stash.png",
             dir = dir,
             width = 3,
             height = 3 
             )



