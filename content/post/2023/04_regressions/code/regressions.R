
# random x y relation
x = rnorm( n = 1000, mean = 0, sd = 1 )
noise = rnorm( n = 1000, mean = 0, sd = 0.2 )
y = x + noise

# correlation
cor(x, y)

# regression
model = lm( y ~ x )
model_coefficients = coef(model)

# r square
summary(model)$r.squared



# plot
png( "xy_scatter.png", width = 5, height = 4.5, res = 300, unit = "in" )
par(mar = c(4, 4, 0, 0) + 0.1)
plot(x, y)
dev.off()




# random x y relation
x = rnorm( n = 1000, mean = 0, sd = 1 )
noise = rnorm( n = 1000, mean = 0, sd = 1 )
y = scale( x + noise )

lm( y ~ x )
