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

% clues 1,2,3,4
% Training nad Validation Set (they are separated in the NN_training_4_clues function)
rand_ind = randperm(50);
Xtrain_val = [[x1(rand_ind(1:40));x1(50+ rand_ind(1:40));x1(100+ rand_ind(1:40))]...
              [x2(rand_ind(1:40));x2(50+ rand_ind(1:40));x2(100+ rand_ind(1:40))]...
              [x3(rand_ind(1:40));x3(50+ rand_ind(1:40));x3(100+ rand_ind(1:40))]...
              [x4(rand_ind(1:40));x4(50+ rand_ind(1:40));x4(100+ rand_ind(1:40))]]';

% Test Set
Xtest = [[x1(rand_ind(1:10));x1(50+ rand_ind(1:10));x1(100+ rand_ind(1:10))]...
         [x2(rand_ind(1:10));x2(50+ rand_ind(1:10));x2(100+ rand_ind(1:10))]...
         [x3(rand_ind(1:10));x3(50+ rand_ind(1:10));x3(100+ rand_ind(1:10))]...
         [x4(rand_ind(1:10));x4(50+ rand_ind(1:10));x4(100+ rand_ind(1:10))]]';

ytrain_val = [[ones(1,40) zeros(1,80)]; [zeros(1,40) ones(1,40).*2 zeros(1,40)]; [zeros(1,80) ones(1,40).*3]];
ytest      = [[ones(1,10) zeros(1,20)]; [zeros(1,10) ones(1,10).*2 zeros(1,10)]; [zeros(1,20) ones(1,10).*3]];

% 2. Train a two-layer FNN with four nodes in the hidden layer using the
% standard BP algorithm, with learning rate 0.01 and maximum number of
% iterations equal to 9000

for j=1:20
    for z=1:20
        error(j,z)=0;
        for t=1:5
rand('seed',100) 
randn('seed',100)
iter=10000; %Number of iterations
code=1; %Code for the chosen training algorithm
k=[j z 3]; %number of hidden layer nodes
lr=.01; %learning rate
par_vec=[lr 0 0 0 0];
[net,tr]=NN_training_4_clues(Xtrain_val,ytrain_val,k,code,iter,par_vec);

%simulation
a=sim(net,Xtest);

%rounding results of sim function
a1=round(a);

%comparing results with expected output
for i=1:length(ytest)
    if (a1(:,i)==ytest(:,i)) 
        results(i)= 0;
    else
        results(i)=1;
    end 
end

%number of errors
error(j,z)=error(j,z)+(nnz(results)/length(ytest))/5;
        end
    end
end
surf(error)
[min_row,min_index_of_rows] = min(error);
[total_min,min_index_of_cols] = min(min_row);