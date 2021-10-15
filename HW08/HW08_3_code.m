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
[l,N]=size(X);
theta_ini=rand(l,m);
X_max=max(X'); X_min=min(X');
for j=1:l
    theta_ini(j,:)=theta_ini(j,:)*(X_max(j)-X_min(j))+X_min(j);
end

[theta,bel,J]=k_means(X,theta_ini);
SSE_pikrakis=J
theta
%Matlab . Attention data are given in columns 
K=3;
[IDX, C, SUMD] = kmeans(X', K );

% More options
opts = statset('Display','final');
[IDX, C, SUMD] = kmeans(X', K, 'Replicates',5,... 
'Replicates',5, 'Options',opts);

SSE_matlab=sum(SUMD)
C=C'

%ISODATA
ON=28; % threshold number of elements for the elimination of a cluster.
OC=0; % threshold distance for the union of clusters.
OS=0.1;  % deviation typical threshold for the division of a cluster.
k=4;   % number (maximum) cluster.
L=5;   % maximum number of clusters that can be mixed in a single iteration.
I=100;  % maximum number of iterations allowed.
NO=1;  % extra parameter to automatically answer no to the request of cambial any parameter.
min_dist=3; % Minimum distance a point must be in each center. If you want to delete any point

[C_ISO, Xcluster, A, clustering]=isodata_ND(X', k, L, I, ON, OC, OS, NO, min_dist);
C_ISO=C_ISO'; IDX_ISO=clustering';
[l,m]=size(C_ISO);
dist_all=[];
for j=1:m
 dist=sum(((ones(N,1)*C_ISO(:,j)'-X').^2)');
 dist_all=[dist_all; dist];
end
SSE_ISODATA=sum(min(dist_all))
fprintf('Number of Clusters: %d\n',A);
C_ISO

for i=1:150
    a(i)=(IDX_ISO(i)==1);
    b(i)=(IDX_ISO(i)==2);
    c(i)=(IDX_ISO(i)==3);
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