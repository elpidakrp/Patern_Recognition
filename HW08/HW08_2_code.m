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

X     = [x1 x2 x3 x4]';
y     = [ones(1,50) ones(1,50).*2 ones(1,50).*3];

n_points=50*ones(1,3); %Number of points per group

 
m=3;
q=2;
[l,N]=size(X);
rand('seed',0)
theta_ini=rand(l,m);
[theta,U,obj_fun] = fuzzy_c_means(X,m,q);
[qw,bel]=max(U');

for i=1:150
    a(i)=(bel(i)==1)
    b(i)=(bel(i)==2)
    c(i)=(bel(i)==3)
end

hist(1)=sum(a(1:50))/50;
hist(2)=sum(b(1:50))/50;
hist(3)=sum(c(1:50))/50;
hist(4)=sum(a(51:100))/50;
hist(5)=sum(b(51:100))/50;
hist(6)=sum(c(51:100))/50;
hist(7)=sum(a(101:150))/50;
hist(8)=sum(b(101:150))/50;
hist(9)=sum(c(101:150))/50;
bar([11,12,13,21,22,23,31,32,33],hist);