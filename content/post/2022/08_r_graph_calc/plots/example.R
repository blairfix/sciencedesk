
# plot 1

x = 1:10
y = x^2


png("plot1.png", width = 5, height = 4, unit = "in", res = 300)

par( mar=c(4,4,1,1) )
plot(x, y)

dev.off()



# plot 1

x = -10:10
y = x^2


png("plot2.png", width = 5, height = 4, unit = "in", res = 300)

par( mar=c(4,4,1,1) )
plot(x, y)

dev.off()



png("plot3.png", width = 5, height = 4, unit = "in", res = 300)

par( mar=c(4,4,1,1) )
plot(x, y, type = "l")

dev.off()
