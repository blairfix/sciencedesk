library(data.table)
library(here)

dir = getwd()

setwd("/home/blair/Research/data/compustat_complete")
comp = fread("compustat_complete_2021-09-27.csv")

comp = comp[ fyear == 2010 ] 
comp = comp[ fic == "USA" ] 


# metadata
year = comp$fyear
country = comp$fic
ticker = comp$tic

# market cap
n_shares = comp$csho
price = comp$prcc_c

# markup
sales = comp$sale
profit = comp$ni

# merge
result = data.table(
		    year, 
                    ticker,
                    profit,
		    sales
		    )

# export
setwd(dir)
fwrite(result, "fdata.csv")
