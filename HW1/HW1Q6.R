#6.
#(a) Load the data, Compute and report the mean, median, standard deviation, 
#Report each estimate to 3 decimal places.
data <-read.csv("hw1q6.csv", header = FALSE)
mean.1 <- round(mean(data[,1]), 3)
mean.2 <- round(mean(data[,2]), 3)
median.1 <- round(median(data[,1]), 3)
median.2 <- round(median(data[,2]), 3) 
stddev.1 <- round(sd(data[,1]), 3)
stddev.2 <- round(sd(data[,2]), 3)

#the maximum likelihood of deviation and the range (i.e. the minimum and maximum)
#??????????????????????????????
range.1 <- range(data[,1])
range.2 <- range(data[,2])

#(b) Compute the quantiles for each variable. The quantiles of data set are
#the 0,25,50,75,and 100 percentiles. Report each to 3 decimal places.
quantile.1 <- quantile(data[,1], probs = c(0, 25, 50, 75, 100) / 100)
quantile.2 <- quantile(data[,2], probs = c(0, 25, 50, 75, 100) / 100)
#=========================
summary(data)

#(c) Create a histogram for each variable using 10 bins. The scale of the
#y-axis should be in terms of density. Also, fitting a density curve to the histogram,
#In this case, we can simply use normal distribution.
hist(data[,1], breaks = 10, freq = FALSE, main = "Histogram of Variable 1", xlim = c(0, 12), ylim = c(0.0, 0.3), xlab = "Variable 1", col = "beige")
curve(dnorm(x, mean(data[,1]), sd = sd(data[,1])), add = TRUE)

hist(data[,2], breaks = 9, freq = FALSE, main = "Histogram of Variable 2", xlim = c(-10, 20), ylim = c(0.00, 0.15), xlab = "Variable 2", col = "beige")
curve(dnorm(x, mean(data[,2]), sd = sd(data[,2])), add = TRUE)

#(d) Create a quantile-quantile plot (commonly called a QQ plot) for each variable. Include in your plot a line indicating perfect agreement,i.e. y = x. 
#What could this QQ plot be used for?
qqnorm(data[,1])
qqline(data[,1], datax = FALSE, distribution = qnorm)

qqnorm(data[,2])
qqline(data[,2], datax = FALSE, distribution = qnorm)

#If the data came from a normal distribution, what will happen when we plot the quantiles of our data against the that of a normal distribution?
norm.distribution <- rnorm(1000, mean = 1, sd = 1)
qqnorm(norm.distribution)
qqline(norm.distribution, ddatax = FALSE, distribution = qnorm)

#(e) Comment briefly on what you have learned about each variable. Include comparisons between x1 and x2 using location measures (mean, median, etc.),
#spread measures (standard deviation), and the shape of the histograms. Qualitatively, does either variable appear to have come from a normal distribution? Why?