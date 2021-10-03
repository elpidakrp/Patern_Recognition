clear;
clc;
close all;

data = readtable('iris.txt');
data.Properties.VariableNames{1} = 'sepal_length';
data.Properties.VariableNames{2} = 'sepal_width';
data.Properties.VariableNames{3} = 'petal_length';
data.Properties.VariableNames{4} = 'petal_width';
data.Properties.VariableNames{5} = 'species';

x1 = table2array(data(:,1));
x2 = table2array(data(:,2));
x3 = table2array(data(:,3));
x4 = table2array(data(:,4));

rand_ind = randperm(50);
% Training Set
Xtrain = [ones(90,1)...
         [x1(rand_ind(1:30));x1(50+ rand_ind(1:30));x1(100+ rand_ind(1:30))]...
         [x2(rand_ind(1:30));x2(50+ rand_ind(1:30));x2(100+ rand_ind(1:30))]...
         [x3(rand_ind(1:30));x3(50+ rand_ind(1:30));x3(100+ rand_ind(1:30))]...
         [x4(rand_ind(1:30));x4(50+ rand_ind(1:30));x4(100+ rand_ind(1:30))]]';

% Validation Set
Xval=    [ones(30,1)...
         [x1(rand_ind(1:10));x1(50+ rand_ind(1:10));x1(100+ rand_ind(1:10))]...
         [x2(rand_ind(1:10));x2(50+ rand_ind(1:10));x2(100+ rand_ind(1:10))]...
         [x3(rand_ind(1:10));x3(50+ rand_ind(1:10));x3(100+ rand_ind(1:10))]...
         [x4(rand_ind(1:10));x4(50+ rand_ind(1:10));x4(100+ rand_ind(1:10))]]';

     
% Test Set
Xtest =  [ones(30,1)...
         [x1(rand_ind(1:10));x1(50+ rand_ind(1:10));x1(100+ rand_ind(1:10))]...
         [x2(rand_ind(1:10));x2(50+ rand_ind(1:10));x2(100+ rand_ind(1:10))]...
         [x3(rand_ind(1:10));x3(50+ rand_ind(1:10));x3(100+ rand_ind(1:10))]...
         [x4(rand_ind(1:10));x4(50+ rand_ind(1:10));x4(100+ rand_ind(1:10))]]';

ytrain_a = [ones(1,30) ones(1,60).*(-1)];
yval_a   = [ones(1,10) ones(1,20).*(-1)];
ytest_a  = [ones(1,10) ones(1,20).*(-1)];

ytrain_b = [ones(1,30).*(-1) ones(1,30) ones(1,30).*(-1)];
yval_b   = [ones(1,10).*(-1) ones(1,10) ones(1,10).*(-1)];
ytest_b  = [ones(1,10).*(-1) ones(1,10) ones(1,10).*(-1)];

ytrain_c = [ones(1,60).*(-1) ones(1,30)];
yval_c   = [ones(1,20).*(-1) ones(1,10)];
ytest_c  = [ones(1,20).*(-1) ones(1,10)];

rho = 1;

randn('seed',0);
for i=1:3
    w_ini{i}=rand(5,1);
end

[w_a,iter_a,error_val_a,error_test_a]=my_perce_with_val_test(Xtrain,ytrain_a,w_ini{1},rho,Xval,yval_a,Xtest,ytest_a);
[w_b,iter_b,error_val_b,error_test_b]=my_perce_with_val_test(Xtrain,ytrain_b,w_ini{2},rho,Xval,yval_b,Xtest,ytest_b);
[w_c,iter_c,error_val_c,error_test_c]=my_perce_with_val_test(Xtrain,ytrain_c,w_ini{3},rho,Xval,yval_c,Xtest,ytest_c);

figure('Name','Iris Setosa Error');
plot([1:iter_a],error_val_a);
xlabel('Iterations');
ylabel('Error');

figure('Name','Iris Versicolor Error');
plot([1:iter_b],error_val_b);
xlabel('Iterations');
ylabel('Error');

figure('Name','Iris Virginica Error');
plot([1:iter_c],error_val_c);
xlabel('Iterations');
ylabel('Error');




