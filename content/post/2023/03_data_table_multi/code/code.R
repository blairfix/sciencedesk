library(data.table)


url = "https://sciencedesk.economicsfromthetopdown.com/2023/03/data-table-aggregate/temp/temp.csv"

paleo = fread(url)

# get summary of the temperature data
summary(paleo$temperature)



# round age data to 10K year intervals
accuracy = 2e4
paleo$age_round = floor( paleo$age / accuracy) *  accuracy


# average temperature by age_round
paleo[,
      mean(temperature),
      by = age_round
      ]


# summarize periods
paleo[,
      summary(temperature),
      by = age_round
      ]


# summarize periods
paleo[,
      as.list( summary(temperature) ),
      by = age_round
      ]


# get range
paleo[,
      as.list( range(temperature) ),
      by = age_round
      ]

paleo[,
      as.list(
	      quantile(temperature, probs = c(0.05, 0.95 ) )
	      ),
      by = age_round
      ]




# plot
library(ggplot2)

gplot = ggplot( data = paleo_summary ) +
    geom_ribbon(
		aes(
		    x = age_round,
		    ymin = `1st Qu.`,
		    ymax = `3rd Qu.`
		    ),
		fill = "dodgerblue4",
		alpha = 0.2
		) +
    geom_line(
	      aes(
		  x = age_round,
		  y = Median
		  ),
	      col = "dodgerblue4",
	      )


