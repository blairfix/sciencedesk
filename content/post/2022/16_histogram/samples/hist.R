
# sample of 10 random numbers from a normal distribution
x = rnorm( n = 10, mean = 0, sd = 1)

print(x)

# histogram of x
png("hist1.png", width = 6, height = 5, unit = "in", res = 300)
hist(x)
dev.off()


# sample of 10 random numbers from a normal distribution
x = rnorm( n = 1000, mean = 0, sd = 1)


# histogram of x
png("hist2.png", width = 6, height = 5, unit = "in", res = 300)
hist(x)
dev.off()


# 100 bins
png("hist3.png", width = 6, height = 5, unit = "in", res = 300)
hist(x, breaks = 100)
dev.off()


#  40 bins
png("hist4.png", width = 6, height = 5, unit = "in", res = 300)
hist(x, breaks = 40)
dev.off()


# manual bins
bins = seq( from = -4, to = 4, by = 0.25)

png("hist5.png", width = 6, height = 5, unit = "in", res = 300)
hist(x, breaks = bins)
dev.off()


# big data
x = rnorm( n = 1e6, mean = 0, sd = 1)

png("hist6.png", width = 6, height = 5, unit = "in", res = 300)
hist(x, breaks = 1000)
dev.off()


# data only
hist_data$counts
