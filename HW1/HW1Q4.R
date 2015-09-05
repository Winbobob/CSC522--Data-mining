#4.
#(a) Generate a 4*4 matrix A with input from Gaussian Distribution with mean 5 and variance 1.
A <- matrix(rnorm(16, mean = 5, sd = 1), nrow = 4, ncol = 4, byrow = TRUE)

A#(b) Access rows 2 and 4 only.
A[2,]
A[4,]

#(c) Calculate sum of the 3nd row, the diagonal and the 4rd column in the matrix.
sum(A[3,])
# sum(diag(A))
sum(A[,4])

#(d) Sum of all elements in the matrix (use a for/while loop).
sum(A)
matrix.sum <- 0
for (i in 1:length(A)) {
  matrix.sum <- matrix.sum + A[i]
}
matrix.sum

#(e) Generate a diagonal matrix B with from [2, 3, 4, 5] (using this vector as the diagonal entries).
B <- diag(c(2, 3, 4, 5), nrow = 4, ncol = 4)

#(f)  From A and B, using one matrix operation to get a new matrix C such 
#that, the first row of C is equal to the first row of A times 2, the second row of C
#is equal to the second row of A times 3 and so on.
C <- A * c(2, 3, 4, 5)

#(g) From A and B, using one matrix operation to get a new matrix D such
#that, the first column of D is equal to the first column of A times 2, the second
#column of D is equal to the second column of A times 3 and so on.
D <- t(t(A) * c(2, 3, 4, 5))

#(h) X = [1, 2, 3, 4]T, Y = [9, 6, 4, 1]T. Computing the covariance matrix of
#X and Y in one function, and calculating the result by basic operations (without using that function).
cor(t(c(1, 2, 3, 4)), t(c(9, 6, 4, 1)))
