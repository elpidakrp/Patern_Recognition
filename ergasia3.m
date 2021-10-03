clear;
clc;

% =================================3.2=====================================

%           -------w1-------  -------w2-------  -------w3-------
%            x1    x2    x3    x1    x2    x3    x1    x2    x3
SAMPLES = [-5.01 -8.12 -3.68 -0.91 -0.18 -0.05  5.35  2.26  8.13;
           -5.43 -3.48 -3.54  1.3  -2.06 -3.53  5.12  3.22 -2.66;
            1.08 -5.52  1.66 -7.75 -4.54 -0.95 -1.34 -5.31 -9.87;
            0.86 -3.78 -4.11 -5.47  0.5   3.92  4.48  3.42  5.19;
           -2.67  0.63  7.39  6.14  5.72 -4.85  7.11  2.39  9.21;
            4.94  3.29  2.08  3.6   1.26  4.36  7.17  4.33 -0.98;
           -2.51  2.09 -2.59  5.37 -4.63 -3.65  5.75  3.97  6.65;
           -2.25 -2.13 -6.94  7.18  1.46 -6.66  0.77  0.27  2.41;
            5.56  2.86 -2.26 -7.39  1.17  6.3   0.9  -0.43 -8.71;
            1.03 -3.33  4.33 -7.5  -6.32 -0.31  3.52 -0.36  6.43];

        
P_w_1   = 1/2;
P_w_2   = 1/2;
P_w_3   = 0;

        
% -----------------------------3.2.1---------------------------------------
disp('3.2.1 starting...');

[m_1_1 , Sigma_1_1] = Gaussian_ML_estimate(SAMPLES(:,1)');
syms g_1(x);
g_1_1(x)  = g(1, m_1_1, Sigma_1_1, P_w_1);

[m_1_2 , Sigma_1_2] = Gaussian_ML_estimate(SAMPLES(:,4)');
syms g_2(x);
g_1_2(x)  = g(1, m_1_2, Sigma_1_2, P_w_2);

g_1_3     = 0; %Since p=0;

d_1(x)    = g_1_1(x) - g_1_2(x);
w1_0      = double(solve(d_1(x)==0));

disp(['Separation points of w1, w2 using only x1: ',num2str(w1_0(1)),' ,  ',num2str(w1_0(2))]);

% -------------------------------3.2.2-------------------------------------
correct1_1 = 0;
correct1_2 = 0;

for(i=1:10)
    x1 = SAMPLES(i,1);
%     x2 = SAMPLES(i,2);
    if(subs(d_1)>=0)
        correct1_1 = correct1_1 + 1;
    end
    x1 = SAMPLES(i,4);
%     x2 = SAMPLES(i,5);
    if(subs(d_1)<=0)
        correct1_2 = correct1_2 + 1;
    end
end

error1_1   = (10-correct1_1)/10;
error1_2   = (10-correct1_2)/10;

disp(['Error of w1: ',num2str(error1_1)]);
disp(['Error of w2: ',num2str(error1_2)]);

% -------------------------------3.2.3-------------------------------------
disp("3.2.3 starting...");

[m_3_1 , Sigma_3_1] = Gaussian_ML_estimate(SAMPLES(:,1:2)');
syms g_3_1(x);
g_3_1(x)  = g(2, m_3_1, Sigma_3_1, P_w_1);

[m_3_2 , Sigma_3_2] = Gaussian_ML_estimate(SAMPLES(:,4:5)');
syms g_3_2(x);
g_3_2(x)  = g(2, m_3_2, Sigma_3_2, P_w_2);

d_3(x)    = g_3_1(x) - g_3_2(x);

w3_0      = vpa(solve(d_3(x)==0));

disp(['Separation functions of w1, w2 using x1 and x2:']);
fprintf('%s\n', w3_0(1));
fprintf('%s\n', w3_0(2));

correct3_1 = 0;
correct3_2 = 0;

for(i=1:10)
    x1 = SAMPLES(i,1);
    x2 = SAMPLES(i,2);
    if(subs(d_3)>=0)
        correct3_1 = correct3_1 + 1;
    end
    x1 = SAMPLES(i,4);
    x2 = SAMPLES(i,5);
    if(subs(d_3)<=0)
        correct3_2 = correct3_2 + 1;
    end
end

error3_1   = (10-correct3_1)/10;
error3_2   = (10-correct3_2)/10;

disp(['Error of w1: ',num2str(error3_1)]);
disp(['Error of w2: ',num2str(error3_2)]);

% -------------------------------3.2.4-------------------------------------
disp("3.2.4 starting...");

[m_4_1 , Sigma_4_1] = Gaussian_ML_estimate(SAMPLES(:,1:3)');
syms g_4_1(x);
g_4_1(x)  = g(3, m_4_1, Sigma_4_1, P_w_1);

[m_4_2 , Sigma_4_2] = Gaussian_ML_estimate(SAMPLES(:,4:6)');
syms g_4_2(x) x;
g_4_2(x)  = g(3, m_4_2, Sigma_4_2, P_w_2);

g_4_3     = 0; %Since p=0;

d_4(x)    = g_4_1(x) - g_4_2(x);

w4_0      = vpa(solve(d_4(x)==0));

disp(['Separation functions of w1, w2 using x1, x2 and x3:']);
fprintf('%s\n', w4_0(1));
fprintf('%s\n', w4_0(2));

correct4_1 = 0;
correct4_2 = 0;

for(i=1:10)
    x1 = SAMPLES(i,1);
    x2 = SAMPLES(i,2);
    x3 = SAMPLES(i,3);
    if(subs(d_4)>=0)
        correct4_1 = correct4_1 + 1;
    end
    x1 = SAMPLES(i,4);
    x2 = SAMPLES(i,5);
    x3 = SAMPLES(i,6);
    if(subs(d_4)<=0)
        correct4_2 = correct4_2 + 1;
    end
end


error4_1   = (10-correct4_1)/10;
error4_2   = (10-correct4_2)/10;

disp(['Error of w1: ',num2str(error4_1)]);
disp(['Error of w2: ',num2str(error4_2)]);


% -------------------------------3.2.6-------------------------------------
disp("3.2.6 starting...");

P_w_1   = 0.8;
P_w_2   = 0.1;
P_w_3   = 0.1;

[m_6_1 , Sigma_6_1] = Gaussian_ML_estimate(SAMPLES(:,1:3)');
syms g_6_1(x);
g_6_1(x)  = g(3, m_6_1, Sigma_6_1, P_w_1);

[m_6_2 , Sigma_6_2] = Gaussian_ML_estimate(SAMPLES(:,4:6)');
syms g_6_2(x);
g_6_2(x)  = g(3, m_6_2, Sigma_6_2, P_w_2);

[m_6_3 , Sigma_6_3] = Gaussian_ML_estimate(SAMPLES(:,7:9)');
syms g_6_3(x);
g_6_3(x)  = g(3, m_6_3, Sigma_6_3, P_w_3);

d_6__1_2(x)    = g_6_1(x) - g_6_2(x);
d_6__1_3(x)    = g_6_1(x) - g_6_3(x);
d_6__2_3(x)    = g_6_2(x) - g_6_3(x);

w6_0__1_2      = vpa(solve(d_6__1_2(x)==0));  % Separation Functions for w1, w2
w6_0__1_3      = vpa(solve(d_6__1_3(x)==0));  % Separation Functions for w1, w3
w6_0__2_3      = vpa(solve(d_6__2_3(x)==0));  % Separation Functions for w2, w3

disp(['Separation functions of w1, w2 using x1, x2 and x3:']);
fprintf('%s\n', w6_0__1_2(1));
fprintf('%s\n', w6_0__1_2(2));

disp(['Separation functions of w1, w3 using x1, x2 and x3:']);
fprintf('%s\n', w6_0__1_3(1));
fprintf('%s\n', w6_0__1_3(2));

disp(['Separation functions of w2, w3 using x1, x2 and x3:']);
fprintf('%s\n', w6_0__2_3(1));
% fprintf('%s\n', w6_0__2_3(2));


% =================================3.3=====================================
% -----------------------------3.3.1---------------------------------------
disp("3.3 starting...");

a        = sym('a','real');
integral = integral(@(u) sin(pi*u),0,1);
A        = double(solve(a*integral==1));

disp(['A = ',num2str(A)]);

% -----------------------------3.3.2---------------------------------------
x = [1 1 0 1 0 1 1 1 0 1];

syms p0(u) p1(u) p5(u) p10(u);
p0(u)  = p(0, A, x);
p1(u)  = p(1, A, x);
p5(u)  = p(5, A, x);
p10(u) = p(10, A, x);


disp('P(Theta|D0):');
disp(p0);
figure;
fplot(p0,[0 1]);
disp('P(Theta|D1):');
disp(p1);
figure;
fplot(p1,[0 1]);
disp('P(Theta|D5):');
disp(p5);
figure;
fplot(p5,[0 1]);
disp('P(Theta|D10):');
disp(p10);
figure;
fplot(p10,[0 1]);


% =================================3.4=====================================
% -----------------------------3.4.A---------------------------------------
disp("3.4 starting...");

P           = [1/3 1/3 1/3];
m           = [[0; 0; 0] [1; 2; 2] [3; 3; 4]];

Sigma(:,:,1) = [0.8 0.2 0.1; 0.2 0.8 0.2; 0.1 0.2 0.8];
Sigma(:,:,2) = [0.8 0.2 0.1; 0.2 0.8 0.2; 0.1 0.2 0.8];
Sigma(:,:,3) = [0.8 0.2 0.1; 0.2 0.8 0.2; 0.1 0.2 0.8];

X           = [mvnrnd(m(:,1), Sigma(:,:,1), 3333); mvnrnd(m(:,2), Sigma(:,:,2), 3333); mvnrnd(m(:,3), Sigma(:,:,3), 3334)]';
X1          = [mvnrnd(m(:,1), Sigma(:,:,1), 333); mvnrnd(m(:,2), Sigma(:,:,2), 333); mvnrnd(m(:,3), Sigma(:,:,3), 334)]';
X1_correct  = [ones(1,333) 2*ones(1,333) 3*ones(1,334)];

% -----------------------------3.4.B---------------------------------------
euclidean   = euclidean_classifier(m, X1);
mahalanobis = mahalanobis_classifier(m,  Sigma, X1);
bayes       = bayes_classifier(m, Sigma, P, X1);

eucl_corr   = 0;
mah_corr    = 0;
bayes_corr  = 0;
for i=1:1000
    if(euclidean(i)==X1_correct(i))
        eucl_corr = eucl_corr + 1;
    end
    if(mahalanobis(i)==X1_correct(i))
        mah_corr = mah_corr + 1;
    end
    if(bayes(i)==X1_correct(i))
        bayes_corr = bayes_corr + 1;
    end
end

euclidean_error = (1000-eucl_corr)/1000;
mahalanobis_error = (1000-mah_corr)/1000;
bayes_error = (1000-bayes_corr)/1000;

disp('Euclidean error:');
disp(euclidean_error);
disp('Mahalanobis error:');
disp(mahalanobis_error);
disp('Bayes error:');
disp(bayes_error);

% -----------------------------3.4.C---------------------------------------
disp("3.4.C starting...");

[m_hat(:,1), Sigma_hat(:,:,1)] = Gaussian_ML_estimate(X(:,1:3333));
[m_hat(:,2), Sigma_hat(:,:,2)] = Gaussian_ML_estimate(X(:,3334:6666));
[m_hat(:,3), Sigma_hat(:,:,3)] = Gaussian_ML_estimate(X(:,6667:10000));

euclidean   = euclidean_classifier(m_hat, X1);
mahalanobis = mahalanobis_classifier(m_hat,  Sigma_hat, X1);
bayes       = bayes_classifier(m_hat, Sigma_hat, P, X1);

eucl_corr   = 0;
mah_corr    = 0;
bayes_corr  = 0;

for i=1:1000
    if(euclidean(i)==X1_correct(i))
        eucl_corr = eucl_corr + 1;
    end
    if(mahalanobis(i)==X1_correct(i))
        mah_corr = mah_corr + 1;
    end
    if(bayes(i)==X1_correct(i))
        bayes_corr = bayes_corr + 1;
    end
end

euclidean_error = (1000-eucl_corr)/1000;
mahalanobis_error = (1000-mah_corr)/1000;
bayes_error = (1000-bayes_corr)/1000;

disp('Euclidean error:');
disp(euclidean_error);
disp('Mahalanobis error:');
disp(mahalanobis_error);
disp('Bayes error:');
disp(bayes_error);

% -----------------------------3.4.D---------------------------------------
disp("3.4.D starting...");

P           = [1/6 1/6 2/3];
m           = [[0; 0; 0] [1; 2; 2] [3; 3; 4]];

Sigma(:,:,1) = [0.8 0.2 0.1; 0.2 0.8 0.2; 0.1 0.2 0.8];
Sigma(:,:,2) = [0.6 0.2 0.01; 0.2 0.8 0.01; 0.01 0.01 0.6];
Sigma(:,:,3) = [0.6 0.1 0.1; 0.1 0.6 0.1; 0.1 0.1 0.6];

X           = [mvnrnd(m(:,1), Sigma(:,:,1), 3333); mvnrnd(m(:,2), Sigma(:,:,2), 3333); mvnrnd(m(:,3), Sigma(:,:,3), 3334)]';
X1          = [mvnrnd(m(:,1), Sigma(:,:,1), 333); mvnrnd(m(:,2), Sigma(:,:,2), 333); mvnrnd(m(:,3), Sigma(:,:,3), 334)]';
X1_correct  = [ones(1,333) 2*ones(1,333) 3*ones(1,334)];

euclidean   = euclidean_classifier(m, X1);
mahalanobis = mahalanobis_classifier(m,  Sigma, X1);
bayes       = bayes_classifier(m, Sigma, P, X1);

eucl_corr   = 0;
mah_corr    = 0;
bayes_corr  = 0;
for i=1:1000
    if(euclidean(i)==X1_correct(i))
        eucl_corr = eucl_corr + 1;
    end
    if(mahalanobis(i)==X1_correct(i))
        mah_corr = mah_corr + 1;
    end
    if(bayes(i)==X1_correct(i))
        bayes_corr = bayes_corr + 1;
    end
end

euclidean_error = (1000-eucl_corr)/1000;
mahalanobis_error = (1000-mah_corr)/1000;
bayes_error = (1000-bayes_corr)/1000;

disp('Euclidean error:');
disp(euclidean_error);
disp('Mahalanobis error:');
disp(mahalanobis_error);
disp('Bayes error:');
disp(bayes_error);

% =================================3.1=====================================

% -----------------------------3.1.a---------------------------------------

function [output] = g(d, m_i, Sigma_i, P_w_i)
    x      = sym('x',[size(m_i) 1],'real');
    output = -1/2*(x-m_i)'*inv(Sigma_i)*(x-m_i)-d/2*log(2*pi)-1/2*log(det(Sigma_i))+log(P_w_i);
end

% -----------------------------3.1.b---------------------------------------

function [output] = euclidean_dist(x1, x2)
    output = norm(x1-x2);
end

% -----------------------------3.1.c---------------------------------------

function [output] = mahalanobis_dist(x, m, Sigma)
    output = sqrt((x-m)'*inv(Sigma)*(x-m));
end

% -----------------------------3.3.2---------------------------------------
function [output] = p(n, A, x)
    syms u;
    if(n == 0)
        output = A*sin(pi*u);
    else
        output = u^n*(1-u)^(10-n)*p(0, A, x)/(int(u^n*(1-u)^(10-n)*p(0, A, x)));
    end
end

