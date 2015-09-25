clc
clear all
%% a
load('hw2.mat');
[numInst, numFea] = size(X_train)
[numInst, numFea] = size(X_test)

[numInst, numFea] = size(Y_train)
[numInst, numFea] = size(Y_test)

[numClass] = length(unique(Y_train))
[numClass] = length(unique(Y_test))

%% b
mean_X_train = mean(X_train);

new_X_train = X_train - repmat(mean_X_train, length(X_train), 1);
new_X_test = X_test - repmat(mean_X_train, length(X_test), 1);

%% c
cov_X_train = cov(new_X_train);

%% d
%V is the eigen matrix
[V_zhewei, D_zhewei] = eig(cov_X_train);

%D is the eigenvalues
D_zhewei = diag(D_zhewei);
%D
%D_zhewei = sort(abs(D_zhewei), 'descend');

%% e
%d1 is the largest eigenvalue
d1 = D_zhewei(64);

%d2 is the second largest eigenvalue
d2 = D_zhewei(63);

X_train_2D = new_X_train * V_zhewei(:,[64,63]); 

X_test_2D = new_X_test * V_zhewei(:,[64,63]);

%% f
scatter(X_train_2D(:,1), X_train_2D(:,2), 50, Y_train, 'filled')
colorbar
title('train_zhewei')
figure;

scatter(X_test_2D(:,1), X_test_2D(:,2), 50, Y_test, 'filled')
colorbar
title('test_zhewei')