library(data.table)
library(magrittr)

d = fread("/home/blair/Dropbox/cloud_work/blog/posts/2023/2023_02_04_interest/analysis/data/paleoclimate/clean/temp.txt")

d_out = data.table(
		   age = d$Age,
		   temperature = d$Temperature
		   ) %>% na.omit()


d_out = d_out[ order( age ) ]


fwrite(d_out, "temp.csv")
