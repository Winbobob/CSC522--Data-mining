#5. For this exercise, use the provided ”locations.csv” file, which contains a list
#of 1718 data instances. The file contains the migration information for a turkey vulture
#named ’Tesla’ for Fall 2013. (Source: movebank.org) There are 25 columns representing
#several properties, including the latitude and longitude positions of Tesla,GPS tag number, date, time, behavior etc. For the purpose of this exercise, we are concerned with
#the ’lat’ and ’long’ columns. Complete the following tasks:
install.packages("plotrix")
require("plotrix")
#(a) Load the file and read ’lat’ and ’long’ columns.
locations <- read.csv("locations.csv", header = TRUE)
locations$lat
locations$long

#(b) Make a 2D plot and label the axes (latitude should be x-axis and longitude should be y-axis)
plot(locations$lat, 
     locations$long, 
     main = "Location distribution", 
     xlab = "Latitude", 
     ylab = "Longitude", 
     col = "blue")

#(c) Find the correlation between the dimensions
cor(locations$lat, locations$long)

#(d) Compute the mean of latitude and longitude values. Consider this point as P.
P <- matrix(c(mean(locations$lat), mean(locations$long)), nrow = 1, ncol = 2)
#Build locations matrix
locations.matrix <- matrix(c(locations$lat, locations$long), nrow = 1718, ncol = 2)
diff.dist <- matrix(data = NA, nrow = 1718, ncol = 2)
diff.dist[,1] <- locations.matrix[,1] - P[,1]
diff.dist[,2] <- locations.matrix[,2] - P[,2]

#(d.a) Compute the distance between P and the 1718 data points using the following distance measures: 
#Euclidean distance
euc.dist <- c()
for (i in 1:nrow(diff.dist)) {
  euc.dist[i] <- sqrt(sum(diff.dist[i,1] ^ 2, diff.dist[i,2] ^ 2))
}
#euc.dist <- sort(euc.dist, decreasing = FALSE)

#Mahalanobis distance
mahala.dist <- mahalanobis(locations.matrix, P, cov(locations.matrix, locations.matrix))
mahala.dist <- sort(mahala.dist, decreasing = FALSE)

#City block metric (Manhattan distance)
city.block.dist <- c()
for (i in 1:nrow(diff.dist)) {
  city.block.dist[i] <- sum(abs(diff.dist[i,1]), abs(diff.dist[i,2]))
}
#city.block.dist <- sort(city.block.dist, decreasing = FALSE)

#Minkowski metric (for p=3)
Minkowski.dist <- c()
for (i in 1:nrow(diff.dist)) {
  Minkowski.dist[i] <- sum(abs(diff.dist[i,1]) ^ 3, abs(diff.dist[i,2]) ^ 3) ^ (1 / 3)
}
#Minkowski.dist <- sort(Minkowski.dist, decreasing = FALSE)

#Chebyshev distance
Cheby.dist <- c()
for (i in 1:nrow(diff.dist)) {
  Cheby.dist[i] <- max(abs(diff.dist[i,1]), abs(diff.dist[i,2]))
}
#Cheby.dist <- sort(Cheby.dist, decreasing = FALSE)

#Cosine distance
cos.dist <- c()
for (i in 1:nrow(diff.dist)) {
  numerator <- sum(locations.matrix[i,] * P)
  denominator <- sqrt(sum(locations.matrix[i,] * locations.matrix[i,])) * sqrt(sum(P * P))
  cos.dist[i] <- 1 - numerator / denominator
}
#cos.dist <- sort(cos.dist, decreasing = FALSE)

#(d.b) For each distance measure, identify the 10 points from the dataset that are the closest to the point P
#(d.b.a) Create plots, one for each distance measure. Place an ’X’ for P and mark the 10 closest points. 
#To mark them, you could place a circle or draw the line between these closest neighbors and the points ’X’. 
#Make sure the points can be uniquely identified.

#Euclidean distance
ten.nearest.point.euc <- order(euc.dist, decreasing = FALSE)[1:10]
plot(locations$lat, locations$long, xlab = "Latitude", ylab = "Longitude", col = "black")
points(P[1], P[2], col = "red", pch = "X")
points(locations.matrix[ten.nearest.point.euc,1], locations.matrix[ten.nearest.point.euc,2], col = "blue")
radius <- sqrt((P[1] - locations.matrix[ten.nearest.point.euc[10],1]) ^ 2 
               + (P[2] - locations.matrix[ten.nearest.point.euc[10],2]) ^ 2)
draw.circle(P[1], P[2], radius, nv=100, border="black", col=NA,lty=1,lwd=1)

#Mahalanobis distance
ten.nearest.point.mahala <- order(euc.dist, decreasing = FALSE)[1:10]
plot(locations$lat, locations$long, xlab = "Latitude", ylab = "Longitude", col = "black")
points(P[1], P[2], col = "red", pch = "X")
points(locations.matrix[ten.nearest.point.mahala,1], locations.matrix[ten.nearest.point.mahala,2], col = "blue")
radius <- sqrt((P[1] - locations.matrix[ten.nearest.point.mahala[10],1]) ^ 2 
               + (P[2] - locations.matrix[ten.nearest.point.mahala[10],2]) ^ 2)
draw.circle(P[1], P[2], radius, nv=100, border="black", col=NA,lty=1,lwd=1)


#City block metric (Manhattan distance)
ten.nearest.point.city <- order(euc.dist, decreasing = FALSE)[1:10]
plot(locations$lat, locations$long, xlab = "Latitude", ylab = "Longitude", col = "black")
points(P[1], P[2], col = "red", pch = "X")
points(locations.matrix[ten.nearest.point.city,1], locations.matrix[ten.nearest.point.city,2], col = "blue")
radius <- sqrt((P[1] - locations.matrix[ten.nearest.point.city[10],1]) ^ 2 
               + (P[2] - locations.matrix[ten.nearest.point.city[10],2]) ^ 2)
draw.circle(P[1], P[2], radius, nv=100, border="black", col=NA,lty=1,lwd=1)

#Minkowski metric (for p=3)
ten.nearest.point.minkowski <- order(euc.dist, decreasing = FALSE)[1:10]
plot(locations$lat, locations$long, xlab = "Latitude", ylab = "Longitude", col = "black")
points(P[1], P[2], col = "red", pch = "X")
points(locations.matrix[ten.nearest.point.minkowski,1], locations.matrix[ten.nearest.point.minkowski,2], col = "blue")
radius <- sqrt((P[1] - locations.matrix[ten.nearest.point.minkowski[10],1]) ^ 2 
               + (P[2] - locations.matrix[ten.nearest.point.minkowski[10],2]) ^ 2)
draw.circle(P[1], P[2], radius, nv=100, border="black", col=NA,lty=1,lwd=1)

#Chebyshev distance
ten.nearest.point.Cheby <- order(Cheby.dist, decreasing = FALSE)[1:10]
plot(locations$lat, locations$long, xlab = "Latitude", ylab = "Longitude", col = "black")
points(P[1], P[2], col = "red", pch = "X")
points(locations.matrix[ten.nearest.point.Cheby,1], locations.matrix[ten.nearest.point.Cheby,2], col = "blue")
radius <- sqrt((P[1] - locations.matrix[ten.nearest.point.Cheby[10],1]) ^ 2
               + (P[2] - locations.matrix[ten.nearest.point.Cheby[10],2]) ^ 2)
draw.circle(P[1], P[2], radius, nv=100, border="black", col=NA,lty=1,lwd=1)

#Cosine distance
ten.nearest.point.cos <- order(Cheby.dist, decreasing = FALSE)[1:10]
plot(locations$lat, locations$long, xlab = "Latitude", ylab = "Longitude", col = "black")
points(P[1], P[2], col = "red", pch = "X")
points(locations.matrix[ten.nearest.point.cos,1], locations.matrix[ten.nearest.point.cos,2], col = "blue")
radius <- sqrt((P[1] - locations.matrix[ten.nearest.point.cos[10],1]) ^ 2
               + (P[2] - locations.matrix[ten.nearest.point.cos[10],2]) ^ 2)
draw.circle(P[1], P[2], radius, nv=100, border="black", col=NA,lty=1,lwd=1)

#(d.b.b) Verify if the set of points is the same across all the distance
#measures.
#Yes.
sort(ten.nearest.point.cos) == 
  sort(ten.nearest.point.Cheby) ==
  sort(ten.nearest.point.minkowski) == 
  sort(ten.nearest.point.city) == 
  sort(ten.nearest.point.mahala) == 
  sort(ten.nearest.point.euc)

