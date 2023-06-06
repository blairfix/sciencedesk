library(data.table)

url = "https://sciencedesk.economicsfromthetopdown.com/2023/03/data-table-aggregate/temp/temp.csv"

paleo = fread(url)

paleo = fread("temp.csv")

png(  file = "temp_raw.png", width = 6, height = 3, res = 400, unit = "in" )
plot(paleo$age, paleo$temperature, type = "l", cex = 0.1)
dev.off()


# round age to 5000
paleo$age_round = floor( paleo$age / 5000) * 5000


temp_mean = paleo[,
		  mean( temperature ),
		  by = age_round 
		  ]



temp_mean = paleo[,
		  .(temp = mean( temperature ) ),
		  by = age_round 
		  ]




png(  file = "temp_round.png", width = 6, height = 3, res = 400, unit = "in" )
plot(temp_mean, type = "l")
dev.off()


# standard deviation of temperature by age_round
paleo[,
      sd( temperature ),
      by = age_round 
      ]

# maximum temperature by age_round
paleo[,
      max( temperature ),
      by = age_round 
      ]

# minimum temperature by age_round
paleo[,
      min( temperature ),
      by = age_round 
      ]

# first 10 values by age_round
paleo[,
      head( temperature, 10 ),
      by = age_round 
      ]



