function Accuracy = DimensionAccuracy(d,D_zhewei, V_zhewei, new_X_train, new_X_test)
eigenvalue_index = 64:(64-n+1);
eigenvalue_index = sort(eigenvalue_index, 'descend');
X_train_2D = new_X_train * V_zhewei(:,eigenvalue_index); 
X_test_2D = new_X_test * V_zhewei(:,eigenvalue_index);
Accuracy = (numel(X_train_2D) - sum(X_train_2D == X_test_2D)) / numel(X_train_2D)
end