clear;
close all;
clc;

X     = [1 1 1 1 1 1; -2 1 0 -2 2 2; 1 2 0 -1 0 1];
y     = [-1 -1 1 1 1 1];
w_ini = [1 1 1]';
rho   = 1;

% figure('Name','Task A: Perceptron 2d');
hold on;
scatter(X(2,1:2),X(3,1:2),'filled');
scatter(X(2,3:6),X(3,3:6),'filled');
[w,iter,error]=my_perce(X,y,w_ini,rho);
hold off;
