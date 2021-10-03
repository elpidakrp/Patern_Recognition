clear;
clc;

Sigma=[4 1; 1 9];
m1=[1; 2];
m2=[-2; -1];
p1=0.25;
p2=0.75;

Sigma_inv = inv(Sigma);
W_1   = Sigma_inv*m1;
W_10  = -1/2*(m1')*Sigma_inv*(m1)+log(p1);

W_2   = Sigma_inv*m2;
W_20  = -1/2*(m2')*Sigma_inv*(m2)+log(p2);

disp("W_1: ");
disp(W_1);
disp("W_10: ");
disp(W_10);

disp("W_2: ");
disp(W_2);
disp("W_20: ");
disp(W_20);

W  = [0.6857; 0.2571];
W0 = -0.8843;

disp("W'*m1");
disp(W'*m1);
disp("W'*m2");
disp(W'*m2);
disp("W'*S*W");
disp(W'*Sigma*W);

% ---------------------------erwthma-4-------------------------------------

disp("Cost expected: 1.4")

p1=1/3;
m1=2;
sigma_1=sqrt(0.5);
x1=2.*randn(10000,1)+sigma_1;      % x1 vector --->  N(2, 0.5)
count_1=0;

p2=2/3;
m2=1.5;
sigma_2=sqrt(0.2);
x2=1.5.*randn(10000,1)+sigma_2;    % x2 vector --->  N(1.5, 0.2)
count_2=0;

lamda_11=1;
lamda_12=2;
lamda_21=3;
lamda_22=1;

for(i=1:10000)
    if (x1(i,1)<=0.403)||(x1(i,1)>1.93)
        count_1 = count_1 + 1; % if x1(i,1) is in w1 area count +1 element
    end
    if (x1(i,1)>0.403)&&(x1(i,1)<=1.93)
        count_2 = count_2 + 1; % if x2(i,1) is in w2 area count +1 element
    end
end

P1     = count_1/10000;        % find P1 for w1 posterior
P1_not = (10000-count_1)/10000; % find not P1 (wrong output cases) for w1 posterior
P2     = count_2/10000;        % find P2 for w2 posterior
P2_not = (10000-count_2)/10000; % find not P2 (wrong output cases) for w2 posterior

cost_1 = (P1*lamda_11+P1_not*lamda_21)*p1;
cost_2 = (P2*lamda_22+P2_not*lamda_12)*p2;
cost = cost_1 + cost_2;       % sum of the 2 costs
disp(['Cost: ', num2str(cost)]);

error = (cost-1.4)/1.4;
disp(['Error: ', num2str(error), '%']);


