library(data.table)

sales = fread("sales.csv")
profit = fread("profit.csv")

all = merge(sales, profit, by = c("year", "company"))

all$markup = all$profit / all$sales * 100
