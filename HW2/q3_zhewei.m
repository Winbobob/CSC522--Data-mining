clc
clear all
%% q3
load('hw2.mat');

mean_X_train = mean(X_train);
new_X_train = X_train - repmat(mean_X_train, length(X_train), 1);
new_X_test = X_test - repmat(mean_X_train, length(X_test), 1);

cov_X_train = cov(new_X_train);

%V is the eigen matrix
[V_zhewei, D_zhewei] = eig(cov_X_train);

%D is the eigenvalues
D_zhewei = diag(D_zhewei);

dimensions = [2, 4, 6, 8, 10, 20, 30, 40, 50, 60];
accuracy = [];
for i = dimensions
    accuracy = [accuracy DimensionAccuracy(i, D_zhewei, V_zhewei, new_X_train, new_X_test, Y_train, Y_test)];
end

figure % opens new figure window
plot(dimensions,accuracy)
    