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

% % clues 1,2,3,4
% % Training Set
% X1 = [ones(90,1) [x1(1:30);x1(51:80);x1(101:130)]...
%     [x2(1:30);x2(51:80);x2(101:130)]...
%     [x3(1:30);x3(51:80);x3(101:130)]...
%     [x4(1:30);x4(51:80);x4(101:130)]];
% 
% % Validation Set
% X2 = [ones(30,1) [x1(31:40);x1(81:90);x1(131:140)]...
%     [x2(31:40);x2(81:90);x2(131:140)]...
%     [x3(31:40);x3(81:90);x3(131:140)]...
%     [x4(31:40);x4(81:90);x4(131:140)]];
% 
% % Test Set
% X3 = [ones(30,1) [x1(41:50);x1(91:100);x1(141:150)]...
%     [x2(41:50);x2(91:100);x2(141:150)]...
%     [x3(41:50);x3(91:100);x3(141:150)]...
%     [x4(41:50);x4(91:100);x4(141:150)]];

% clues 1,2,4
% Training Set
X1 = [[x1(1:30);x1(51:80);x1(101:130)]...
    [x2(1:30);x2(51:80);x2(101:130)]...
    [x4(1:30);x4(51:80);x4(101:130)]];

% Validation Set
X2 = [[x1(31:40);x1(81:90);x1(131:140)]...
    [x2(31:40);x2(81:90);x2(131:140)]...
    [x4(31:40);x4(81:90);x4(131:140)]];

% Test Set
X3 = [[x1(41:50);x1(91:100);x1(141:150)]...
    [x2(41:50);x2(91:100);x2(141:150)]...
    [x4(41:50);x4(91:100);x4(141:150)]];

% 2 classes (merge w1 with w3)
y1 = [ones(1,30) ones(1,30).*2 ones(1,30).*3];
y2 = [ones(1,10) ones(1,10).*2 ones(1,10).*3];
y3 = [ones(1,10) ones(1,10).*2 ones(1,10).*3];

t = templateLinear();
SVMModel = fitcecoc(X1,y1,'Learners',t);
% SVMModel = fitcecoc(X1,y1,'OptimizeHyperparameters',{'BoxConstraint','KernelScale','KernelFunction','PolynomialOrder'});

classOrder = SVMModel.ClassNames;

% sv = SVMModel.SupportVectors;
% figure
% scatter3(X1([1:30 61:90],1),X1([1:30 61:90],2),X1([1:30 61:90],3),'filled')
% hold on
% scatter3(X1(31:60,1),X1(31:60,2),X1(31:60,3),'filled')
% plot3(sv(:,1),sv(:,2),sv(:,3),'ko','MarkerSize',10)
% legend('class: 1-3','class: 2','Support Vector')

Train_Labels      = predict(SVMModel,X1);
Validation_Labels = predict(SVMModel,X2);
Test_Labels       = predict(SVMModel,X3);

Train_Error       = length(find(Train_Labels'-y1))/length(y1)
Validation_Error  = length(find(Validation_Labels'-y2))/length(y2)
Test_Error        = length(find(Test_Labels'-y3))/length(y3)

% svm_3d_plot(SVMModel,X1,y1);
% hold off;
