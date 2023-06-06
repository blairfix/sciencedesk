# access data elements

# read in data
url = "https://sciencedesk.economicsfromthetopdown.com/2022/11/r-access-elements/data/fdata.csv"
fdata = read.csv(url)

# look at the data
head(fdata)

# how much data do I have?
nrow(fdata)

# get apple profit data
apple = subset( fdata, ticker == "AAPL" )
apple_profit = apple$profit



