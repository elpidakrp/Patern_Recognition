clear;
clc;
close all;

%% ______________________________task_4.1__________________________________
m = 0;
S = 1;
P = 1/2;
N = [32 256 5000];

for i=1:3
    X{i} = rand(1,N(i))*2;
end

x    = -1:0.1:3;
pdfx = (1/2)*(x>0 & x<2);

%% ------------------------------task-4.1.a--------------------------------
h = [0.05 0.2];

figure('name','4.1 a)');
j = 1;
for i = 1:3
    subplot(3,2,j);
    plot(x,pdfx);
    hold on;
    pdfx_approx = Parzen_gauss_kernel(X{i},h(1),-3,3);
    plot(-3:h(1):3,pdfx_approx);
    title(['N = ',num2str(N(i)),' , h = ',num2str(h(1))]);
    hold off;
    
    subplot(3,2,j+1);
    plot(x,pdfx);
    hold on;
    pdfx_approx = Parzen_gauss_kernel(X{i},h(2),-3,3);
    plot(-3:h(2):3,pdfx_approx);
    title(['N = ',num2str(N(i)),' , h = ',num2str(h(2))]);
    hold off;
    j = j+2;
end

%% ------------------------------task-4.1.b--------------------------------
k = [32 64 256];

figure('name','4.1 b)');
for i = 1:3
    subplot(3,1,i);
    plot(x,pdfx);
    hold on;
    pdfx_approx_b = knn_density_estimate(X{3},k(i),-3,3,0.1);
    plot(-3:0.1:3,pdfx_approx_b);
    title(['N = ',num2str(N(3)),' , k = ',num2str(k(i))]);
    hold off;
end

%% ______________________________task_4.2__________________________________
m            = [2 1 3];
Sigma(:,:,1) = 0.5;
Sigma(:,:,2) = 1;
Sigma(:,:,3) = 1.2;
P            = [0.5 0.3 0.2]';

%% ------------------------------task-4.2.A--------------------------------
randn('seed',0);
[X,x] = generate_gauss_classes(m,Sigma,P,100);
[Y,y] = generate_gauss_classes(m,Sigma,P,1000);

%% ------------------------------task-4.2.B--------------------------------
for k=1:3
    Y_sorted_knn{k} = k_nn_classifier_1d(X,x,k,Y);
    pr_err_knn(k) = sum(Y_sorted_knn{k}~=y)/length(y);
    disp(['For k = ',num2str(k),' Error = ',num2str(pr_err_knn(k))]);
end

Y_sorted_bayesian = bayes_classifier(m,Sigma,P,Y);
pr_err_bayesian = sum(Y_sorted_bayesian~=y)/length(y);
disp(['With Bayesian classifier = ',num2str(pr_err_bayesian)]);

for k=1:100
    Y_sorted_knn{k} = k_nn_classifier_1d(X,x,k,Y);
    pr_err_knn(k) = sum(Y_sorted_knn{k}~=y)/length(y);
end
[min_error, min_error_k] = min(pr_err_knn);
figure('name','4.2 B)');
plot(pr_err_knn);
title('Error with several k');
xlabel('k');
ylabel('error');
disp(['minimum error: ',num2str(min_error),' with k = ',num2str(min_error_k)]);

%% ------------------------------task-4.2.C--------------------------------
h = [0.01:0.05:0.9];
for i = 1:length(h)
    Y_estimate_class{i} = parzen_classifier(X,x,h(i),P,Y);
    pr_err(i) = sum(Y_estimate_class{i}~=y)/length(y);
end

figure('name','4.2 C)');
plot(h,pr_err);
title('Error with several h');
xlabel('h');
ylabel('error');

[min_error, index] = min(pr_err);
disp(['Min error = ',num2str(min_error),', for h = ',num2str(h(index))]);

%% ------------------------------task-4.2.D--------------------------------
h = [0.1 0.2 0.3 0.4 0.5 1];
net = parzenPNNlearn(X,x);
for i=1:length(h)
    [class{i}, score{i}, scores{i}] = parzenPNNclassify(net,Y,h(i));
    pr_err_Parzen_PNN(i) = sum(class{i}~=y)/length(y);
end
figure('name','4.2 D)');
plot(h,pr_err_Parzen_PNN);
title('Error with several h');
xlabel('h');
ylabel('error');


%% _____________________________functions__________________________________
% function [y_classified] = classify_given_px_w(px_w1,px_w2,px_w3,xx,Y)
%     for i=1:length(Y)
%         [x1,x2] = find_2_nearest_points(Y(i),xx);
%         line1 = @(x)(px_w1(x2)-px_w1(x1))/(x2-x1)*(x-x1)+px_w1(x1);
%         line2 = @(x)(px_w2(x2)-px_w2(x1))/(x2-x1)*(x-x1)+px_w2(x1);
%         line3 = @(x)(px_w3(x2)-px_w3(x1))/(x2-x1)*(x-x1)+px_w3(x1);
%         if((line1(Y(i))>=line2(Y(i)))&&(line1(Y(i))>=line3(Y(i))))
%             y_classified(i)=1;
%         elseif((line2(Y(i))>=line1(Y(i)))&&(line2(Y(i))>=line3(Y(i))))
%             y_classified(i)=2;
%         elseif((line3(Y(i))>=line1(Y(i)))&&(line3(Y(i))>=line2(Y(i))))
%             y_classified(i)=3;
%         end
%     end
% end
% 
% function [a,b] = find_2_nearest_points(x,A)
%     d = sort(abs(x-A));   
%     a = find(abs(x-A)==d(1));
%     b = find(abs(x-A)==d(2));
% end

