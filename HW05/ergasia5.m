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

%% ------------------------------ task A ----------------------------------
% ------------------------------ perceptron -------------------------------
% X     = [ones(150,1) x3 x4]';
% y     = [ones(1,50) ones(1,100).*(-1)];
% w_ini = [1 1 1]';
% rho   = 1;

X     = [ones(150,1) x1 x2 x3 x4]';
y     = [ones(1,50) ones(1,100).*(-1)];
w_ini = [1 1 1 1 1]';
rho   = 1;

% figure('Name','Task A: Perceptron 2d');
% hold on;
% plot(x3(1:50),x4(1:50),'o');
% plot(x3(51:150),x4(51:150),'o');
[w,iter,error]=my_perce(X,y,w_ini,rho);
% hold off;

figure('Name','Task A: Perceptron error');
plot([1:iter],error);
xlabel('Iterations');
ylabel('Error');

% --------------------- batch relaxation with margin ----------------------
% X     = [ones(150,1) x3 x4]';
% y     = [ones(1,50) ones(1,100).*(-1)];
% w_ini = [1 1 1]';
% rho   = 1;

X     = [ones(150,1) x1 x2 x3 x4]';
y     = [ones(1,50) ones(1,100).*(-1)];
w_ini = [1 1 1 1 1]';
rho   = 1;

size_of_X      = size(X);
train_patterns = X(2:size_of_X(1),:);
train_targets  = [ones(1,50) zeros(1,100)];
test_patterns  = X(2:size_of_X(1),:);
Max_iter       = 200;
b              = 1;    % Margin
eta            = 0.02;  % Convergence rate

% figure('Name','Task A: Batch relaxation with margin 2d');
% hold on;
% plot(x3(1:50),x4(1:50),'o');
% plot(x3(51:150),x4(51:150),'o');
[test_targets,w,error_b] = Relaxation_BM(train_patterns,train_targets, test_patterns, Max_iter,b,eta);
% hold off;

figure('Name','Task A: Batch relaxation with margin error');
plot(error_b);
xlabel('Iterations');
ylabel('Error');

%% ------------------------------ task B ----------------------------------
X     = [x1 x2 x3 x4]';
y     = [ones(1,50) ones(1,100).*(-1)];
X     = [X;ones(1,150)];

%----LS
w1      = SSErr(X,y,0);
SSE_out = 2*(w1'*X>0)-1;
err_SSE = sum(SSE_out.*y<0)/150;
disp(['LS Error =  ',num2str(err_SSE)]);

%----cals the Widrow LSE
y=zeros(1,150);
y(1:50)=1;
[test_targets, w2, updates]=LMS_cc(X(2:5,:),y',X(2:5,:),100,0.1,0.01);
err_SSE=sum(test_targets~=y)/155;
disp(['LS Error =  ',num2str(err_SSE)]);

%% ------------------------------ task C ----------------------------------
X     = [x3(51:150) x4(51:150) ones(100,1)]';
y     = [ones(1,50) ones(1,50).*(-1)];

X     = [x1(51:150) x2(51:150) x3(51:150) x4(51:150) ones(100,1)]';
y     = [ones(1,50) ones(1,50).*(-1)];

% figure(1), plot(X(1,y==1),X(2,y==1),'bo',X(1,y==-1),X(2,y==-1),'r.')
% figure(1), axis equal; hold on; 

type=0; Max_iter=1000; b_min=0.001 ; eta= 0.5;
[w,b,err_KH] = Ho_Kashyap_cc(X, y,type, Max_iter, b_min, eta);

figure('Name','Task C: Ho-Kashyap error');
plot(err_KH);
ylim([0 0.1]);
xlabel('Iterations');
ylabel('Error');

%% ------------------------------ task D ----------------------------------

X  = [x1 x2 x3 x4]';
X  = [X;ones(1,150)]; 
y = [zeros(1,50) ones(1,50) ones(1,50).*2];

y1 = [ones(1,50) ones(1,100).*(-1)];
y2 = [ones(1,50).*(-1) ones(1,50) ones(1,50).*(-1)];
y3 = [ones(1,100).*(-1) ones(1,50)];
[w1]=SSErr(X,y1,0);
[w2]=SSErr(X,y2,0);
[w3]=SSErr(X,y3,0);
[max,index]=max([w1'*X;w2'*X;w3'*X]);
SSE_out=index-1;
err_SSE=sum(SSE_out~=y)/150;

%% ------------------------------ task E ----------------------------------
% ------------------------------- 1 - 2 - 3 -------------------------------
c = 3; % number of classes

% 1. Generate X1
X1 = [x1 x2 x3]';
y1 = [ones(1,50) ones(1,50).*(2) ones(1,50).*(3)];

[l,N1]=size(X1);
X1=[X1; ones(1,N1)];

% Plot X1 using different colors for points of different classes,
figure(1), plot3(X1(1,y1==1),X1(2,y1==1),X1(3,y1==1),'r.',...
    X1(1,y1==2),X1(2,y1==2),X1(3,y1==2),'g.',...
    X1(1,y1==3),X1(2,y1==3),X1(3,y1==3),'b.')
axis equal; hold on; axis(axis); XA=axis;

% Next, we define matrix z1, each column of which
% corresponds to a training point.
z1=zeros(c,N1);
for i=1:N1
    z1(y1(i),i)=1;
end

% Estimate the parameter vectors of the three discriminant functions
w_all=[];
for i=1:c
    w=SSErr(X1,z1(i,:),0);
    w_all=[w_all w];
end
% Note: in w_all, the i-th column corresponds to the parameter vector of the i-th discriminant function.

% plots segmended plane and gi(x)
% Generate XP as a set of points covering all the plane (NPxNP grid)
NP=100;
DX=(XA(2)-XA(1))/(NP-1); DY=(XA(4)-XA(3))/(NP-1); DZ=(XA(6)-XA(5))/(NP-1);
XP1=[XA(1):DX:XA(2)];XP2=[XA(3):DY:XA(4)];XP3=[XA(5):DZ:XA(6)];
XP=[];
for i=1:NP
    for j=1:NP
        XTMP=[ones(1,NP)*XP1(i);ones(1,NP)*XP2(j);XP3];
        XP=[XP;XTMP'];
    end
end

[vali,class_est]=max(w_all'*X1);
err=sum(class_est~=y1)/N1

XP=XP';
XP=[XP;ones(1,NP*NP*NP)];       %adds the extra dimension
[vali,class_est]=max(w_all'*XP);

figure(2), plot3(XP(1,class_est==1),XP(2,class_est==1),XP(3,class_est==1),'y.',...
    XP(1,class_est==2),XP(2,class_est==2),XP(3,class_est==2),'m.',...
    XP(1,class_est==3),XP(2,class_est==3),XP(3,class_est==3),'c.'); axis(XA);hold on;

% ------------------------------- 2 - 3 - 4 -------------------------------
c = 3; % number of classes

% 1. Generate X1
X1 = [x2 x3 x4]';
y1 = [ones(1,50) ones(1,50).*(2) ones(1,50).*(3)];

[l,N1]=size(X1);
X1=[X1; ones(1,N1)];

% Plot X1 using different colors for points of different classes,
figure(3), plot3(X1(1,y1==1),X1(2,y1==1),X1(3,y1==1),'r.',...
    X1(1,y1==2),X1(2,y1==2),X1(3,y1==2),'g.',...
    X1(1,y1==3),X1(2,y1==3),X1(3,y1==3),'b.')
axis equal; hold on; axis(axis); XA=axis;

% Next, we define matrix z1, each column of which
% corresponds to a training point.
z1=zeros(c,N1);
for i=1:N1
    z1(y1(i),i)=1;
end

% Estimate the parameter vectors of the three discriminant functions
w_all=[];
for i=1:c
    w=SSErr(X1,z1(i,:),0);
    w_all=[w_all w];
end
% Note: in w_all, the i-th column corresponds to the parameter vector of the i-th discriminant function.

% plots segmended plane and gi(x)
% Generate XP as a set of points covering all the plane (NPxNP grid)
NP=100;
DX=(XA(2)-XA(1))/(NP-1); DY=(XA(4)-XA(3))/(NP-1); DZ=(XA(6)-XA(5))/(NP-1);
XP1=[XA(1):DX:XA(2)];XP2=[XA(3):DY:XA(4)];XP3=[XA(5):DZ:XA(6)];
XP=[];
for i=1:NP
    for j=1:NP
        XTMP=[ones(1,NP)*XP1(i);ones(1,NP)*XP2(j);XP3];
        XP=[XP;XTMP'];
    end
end

[vali,class_est]=max(w_all'*X1);
err=sum(class_est~=y1)/N1

XP=XP';
XP=[XP;ones(1,NP*NP*NP)];       %adds the extra dimension
[vali,class_est]=max(w_all'*XP);

figure(4), plot3(XP(1,class_est==1),XP(2,class_est==1),XP(3,class_est==1),'y.',...
    XP(1,class_est==2),XP(2,class_est==2),XP(3,class_est==2),'m.',...
    XP(1,class_est==3),XP(2,class_est==3),XP(3,class_est==3),'c.'); axis(XA);hold on;


%% ------------------------------ task F ----------------------------------
X  = [x1 x2 x3 x4]';
y1 = [ones(1,50) ones(1,50).*(2) ones(1,50).*(3)];
c=2;

[l,N1]=size(X);
X1=[X; ones(1,N1)];
%--------- Multi class perceptron with Kesler structure -----------
data_kesler.X=X; data_kesler.y=y1; %puts data in format for STPRtool
options.tmax=100000; % max number of iterations
modelKESLER = mperceptron( data_kesler, options );
% calculates the error on the trainning set
for i=1:l
w_allKESLER(i,:)=modelKESLER.W(i,:);
end
w_allKESLER(l+1,:)=modelKESLER.b';
[vali,class_est]=max(w_allKESLER'*X1);
errKESLER=sum(class_est~=y1)/N1





