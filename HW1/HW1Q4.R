#4.
#(a) Generate a 4*4 matrix A with input from Gaussian Distribution with mean 5 and variance 1.
A <- matrix(rnorm(16, mean = 5, sd = 1), nrow = 4, ncol = 4, byrow = TRUE)
#================
A <- rnorm(16, mean = 5, sd = 1)
dim(A) <- c(4, 4)

#(b) Access rows 2 and 4 only.
A[2,]
A[4,]
#================
A[c(2,4),]

#(c) Calculate sum of the 3nd row, the diagonal and the 4rd column in the matrix.
sum(A[3,])
sum(diag(A))
sum(A[,4])

#(d) Sum of all elements in the matrix (use a for/while loop).
sum(A)
#================
matrix.sum <- 0
for (i in 1:length(A)) {
  matrix.sum <- matrix.sum + A[i]
}
matrix.sum
#================
matrix.another.sum <- 0
for (i in 1:nrow(A)) {
  matrix.another.sum <- matrix.another.sum + sum(A[i,])
}
matrix.another.sum

#(e) Generate a diagonal matrix B with from [2, 3, 4, 5] (using this vector as the diagonal entries).
B <- diag(c(2, 3, 4, 5), nrow = 4, ncol = 4)

#(f)  From A and B, using one matrix operation to get a new matrix C such 
#that, the first row of C is equal to the first row of A times 2, the second row of C
#is equal to the second row of A times 3 and so on.
C <- A * diag(B)

#(g) From A and B, using one matrix operation to get a new matrix D such
#that, the first column of D is equal to the first column of A times 2, the second
#column of D is equal to the second column of A times 3 and so on.
D <- t(t(A) * diag(B))
#================
#Matrix multiplication
D <- A %*% B 

#(h) X = [1, 2, 3, 4]T, Y = [9, 6, 4, 1]T. Computing the covariance matrix of
#X and Y in one function, and calculating the result by basic operations (without using that function).
 X <- c(1, 2, 3, 4)
 dim(X) <- c(4, 1)
 Y <- c(9, 6, 4, 1)
 dim(Y) <- c(4, 1)
 matrix(c(cov(X),cov(X,Y),cov(X,Y),cov(Y)),nrow = 2,ncol = 2)
#================
sum((X - mean(X)) * (Y - mean(Y))) / 3
sum((X - mean(X)) * (X - mean(X))) / 3
sum((Y - mean(Y)) * (Y - mean(Y))) / 3

#(i) Verifying the equation in X: x2¯ = (x¯^2+σ^2(x)), where σ(x) is the estimate of the standard deviation.
left <- mean(X ^ 2)
right <- mean(X) ^ 2 + sum((X - mean(X)) ^ 2) / length(X)
left == right