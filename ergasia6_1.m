close('all');
clear;
clc;

l=2;   % Dimensionality
N=4; % Number of vectors

X1 = [0 1 0 1; 0 0 1 1];
y1 = [1 -1 -1 1];

X2 = [0 1 0 1; 0 0 0 sqrt(2); 0 0 1 1]; % X1 in 3D space
y2 = [1 -1 -1 1];

kernel='poly';
kpar1=0;
kpar2=2; % K(x,y)=(x.y)^2 -> kpar1 = 0 ,  kpar2 = 2
max_iter=30000;
[a,iter,count_misclas]=kernel_perce(X1,y1,kernel,kpar1,kpar2,max_iter);

% Compute the training error
for i=1:N
    K{i}=CalcKernel(X1',X1(:,i)',kernel,kpar1,kpar2)';
    out_train(i)=sum((a.*y1).*K{i})+sum(a.*y1);
end
err_train=sum(out_train.*y1<0)/length(y1)
% where N is the number of training vectors.

% Count the number of training vectors 
sum_pos_a=sum(a>0)

% 2. Plot the training set (see book Figures 2.7 and 2.8)
figure(1), hold on
figure(1), plot(X1(1,y1==1),X1(2,y1==1),'ro',...
    X1(1,y1==-1),X1(2,y1==-1),'b+')
figure(1), axis equal
% Note that the vectors of the training set from class 1 (?1) are marked by
% "o” (“+”). 

% Plot the decision boundary in the same figure
bou_x=[-5 5];
bou_y=[-5 5];
resolu=.05;
fig_num=1;
plot_kernel_perce_reg(X1,y1,a,kernel,kpar1,kpar2,bou_x,bou_y, resolu,fig_num)

w = y2(a>0).*a(a>0)*X2(:,a>0)';
w0 = sum(a.*y1);

