function [net,tr]=NN_training_4_clues(X,y,k,code,iter,par_vec)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  net=NN_training(X,y,k,code,iter,par_vec)
% Returns a trained multilayer perceptron as a MATLAB object.
%
% INPUT ARGUMENTS:
%  X:       lxN matrix whose columns are the vectors of the
%           data set.
%  y:       N-dimensional vector containing the class labels for the
%           data vectors.
%  code:    a parameter that specifies the training algorithm to be used
%           ("1" for standard BP, "2" for BP with momentum term and "3" BP
%           with adaptive learning rate).
%  iter:    the maximum number of iterations that will be performed by the
%           algorithm. 
%  par_vec: a five-dimensional vector containing the values of (i) the
%           learning rate used in the standard BP algorithm, (ii) the
%           momentum term used in the BP with momentum term and (iii) the
%           three values involved in the BP with adaptive learning rate.
%
% OUTPUT ARGUMENTS:
%  net:     the neural network as a MATLAB object
%  tr:      training record (epoch and performance)  
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rand('seed',0);   % Initialization of the random number generators
randn('seed',0);

% List of training methods
methods_list={'traingd'; 'traingdm'; 'traingda';'trainlm'; 'traingdx'};

if(length(k)==2)
    functions = {'tansig','purelin'};
else
    functions = {'tansig','tansig','purelin'};
end

% Limits of the region where data lie
limit=[min(X(:,1)) max(X(:,1)); min(X(:,2)) max(X(:,2)); min(X(:,3)) max(X(:,3)); min(X(:,4)) max(X(:,4))];
% Neural network definition
net=newff(limit,k,functions, methods_list{code,1}); %  'traingd -> backpropagation

% Neural network initialization
net=init(net);

% Setting parameters
net.trainParam.epochs=iter;
net.trainParam.lr=par_vec(1);
if(code==2)
    net.trainParam.mc=par_vec(2);
elseif(code==3)
    net.trainParam.lr_inc=par_vec(3);
    net.trainParam.lr_dec=par_vec(4);
    net.trainParam.max_perf_inc=par_vec(5);
end

 % Setup Division of Data for Training, Validation, Testing
net.divideFcn              = 'dividerand';  % Divide data randomly
net.divideMode             = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 75/100; 
net.divideParam.valRatio   = 25/100;  
net.divideParam.testRatio  = 0;
net.trainParam.max_fail    = 9000;

% Neural network training 
[net,tr]=train(net,X,y);
finY = sim(net,X);

%NOTE: During training, the MATLAB shows a plot of the MSE vs the number of
%iterations
