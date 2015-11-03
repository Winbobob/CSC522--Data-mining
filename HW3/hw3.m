clear
load('hw3data.mat')
%% Convert Y-target into one line matrix, where each element should be the class number, either 1 or 2, cause we have two classes.
Y_target = Y_target(2,:) + 1;

%% Split the data into train, which is 60 percent of original data and test,the other 40 percent, ignoring valid.
rand = randperm(2000);
X_train = X(:,rand(1:1200))';
Y_train = Y_target(:,rand(1:1200))';

X_test = X(:,rand(1201:2000))';
Y_test = Y_target(:,rand(1201:2000))';

%% However, you have to change the kernel type for each experiment. There are 5 kernel types including linear, polynomial, radial basic function (gaussian kernel), sigmoid, quadratic.
model1 = svmtrain(Y_train, X_train, '-t 0 -c 10 -q');%linear
model2 = svmtrain(Y_train, X_train, '-t 1 -c 1000 -q');%polynomial
model3 = svmtrain(Y_train, X_train, '-t 2 -c 1000 -q');%rbf
model4 = svmtrain(Y_train, X_train, '-t 3 -c 10 -g 0.035 -q');%sigmoid
model5 = svmtrain(Y_train, X_train, '-t 1 -d 2 -c 1000 -q');%quadratic

p1 = svmpredict(Y_test, X_test, model1);
p2 = svmpredict(Y_test, X_test, model2);
p3 = svmpredict(Y_test, X_test, model3);
p4 = svmpredict(Y_test, X_test, model4);
p5 = svmpredict(Y_test, X_test, model5);

%% Make a table, record the precision, recall and F-measure for each experiment.
[precision1, recall1, f_measure1] = calculator(p1, Y_test, 1)
[precision2, recall2, f_measure2] = calculator(p2, Y_test, 1)
[precision3, recall3, f_measure3] = calculator(p3, Y_test, 1)
[precision4, recall4, f_measure4] = calculator(p4, Y_test, 1)
[precision5, recall5, f_measure5] = calculator(p5, Y_test, 1)

[p1, r1, f1] = calculator(p1, Y_test, 2)
[p2, r2, f2] = calculator(p2, Y_test, 2)
[p3, r3, f3] = calculator(p3, Y_test, 2)
[p4, r4, f4] = calculator(p4, Y_test, 2)
[p5, r5, f5] = calculator(p5, Y_test, 2)