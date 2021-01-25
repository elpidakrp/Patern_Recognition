clear;
clc;
%------------------------------erwthma-2-----------------------------------

N1 = [20 100 1000];
pdf = zeros(3,6);
for i=1:3
    rand_throws = [];
    rand_throws = ceil(rand(1,N1(i))*6); %ceil so that '0' is excluded
    pdf(i,:) = zeros(1,6);
    for j=1:N1(i)
        pdf(i,rand_throws(j)) = pdf(i,rand_throws(j))+1;
    end
end
figure('Name','Random throws pdf plot','NumberTitle','off');
hold on;
plot([1:6], pdf(1,:)*5, [1:6], pdf(2,:), [1:6], pdf(3,:)*0.1); %normalization to 1000 to see difference
legend({'pdf20','pdf100','pdf1000'},'Location','southwest');
title('Random throws pdf plot')
xlabel('Value of dice');
ylabel('Percentage % of total throws');
hold off;

figure('Name','Mean values - Variation - Skewness - Kurtosis','NumberTitle','off');

N = [10, 20, 50, 100, 500, 1000];

subplot(2,2,1);
hold on;
plot(N,[3.5 3.5 3.5 3.5 3.5 3.5]);
for n=1:5
    for i=1:6
        rand_throws = [];
        rand_throws = ceil(rand(1,N(i))*6);
        mean_val(i) = mean(rand_throws);
        var_val(i) = var(rand_throws);
        skewness_val(i) = skewness(rand_throws);
        kurtosis_val(i) = kurtosis(rand_throws);
    end
    plot(N, mean_val);
end
title('Mean values')
xlabel('Number of throws');
ylabel('Mean value measured');
hold off;

subplot(2,2,2);
hold on;
plot(N,[2.875 2.875 2.875 2.875 2.875 2.875]);
for n=1:5
    for i=1:6
        rand_throws = [];
        rand_throws = ceil(rand(1,N(i))*6);
        mean_val(i) = mean(rand_throws);
        var_val(i) = var(rand_throws);
        skewness_val(i) = skewness(rand_throws);
        kurtosis_val(i) = kurtosis(rand_throws);
    end
    plot(N, var_val);
end
title('Variation')
xlabel('Number of throws');
ylabel('Variation measured');
hold off;

subplot(2,2,3);
hold on;
plot(N,[-0.0043 -0.0043 -0.0043 -0.0043 -0.0043 -0.0043]);
for n=1:5
    for i=1:6
        rand_throws = [];
        rand_throws = ceil(rand(1,N(i))*6);
        mean_val(i) = mean(rand_throws);
        var_val(i) = var(rand_throws);
        skewness_val(i) = skewness(rand_throws);
        kurtosis_val(i) = kurtosis(rand_throws);
    end
    plot(N, skewness_val);
end
title('Skewness')
xlabel('Number of throws');
ylabel('Skewness measured');
hold off;

subplot(2,2,4);
hold on;
plot(N,[1.7806 1.7806 1.7806 1.7806 1.7806 1.7806]);
for n=1:5
    for i=1:6
        rand_throws = [];
        rand_throws = ceil(rand(1,N(i))*6);
        mean_val(i) = mean(rand_throws);
        var_val(i) = var(rand_throws);
        skewness_val(i) = skewness(rand_throws);
        kurtosis_val(i) = kurtosis(rand_throws);
    end
    plot(N, kurtosis_val);
end
title('Kurtosis')
xlabel('Number of throws');
ylabel('Kurtosis measured');
hold off;

%------------------------------erwthma-3-----------------------------------
Z1 = ceil(rand(1,1000)*6);
Z2 = ceil(rand(1,1000)*6);
joint_pdf = zeros(6,6);
for i=1:1000
    joint_pdf(Z1(i),Z2(i)) = joint_pdf(Z1(i),Z2(i))+1;
end
figure('Name','Joint pdf','NumberTitle','off');
surf(joint_pdf/10);
title('Joint pdf')
xlabel('Z1');
ylabel('Z2');
zlabel('Percentage % of total throws');

y = Z1 + Z2;
sum_pdf = zeros(1,12);
for i=1:1000
    sum_pdf(y(i)) = sum_pdf(y(i))+1;
end
sum_possibility = zeros(1,12);
sum_possibility(1) = 0;     %no possible combination
sum_possibility(2) = 1/36;  %P(Z1=1)*P(Z2=1)=(1/6)*(1/6)=1/36
sum_possibility(3) = 1/18;  %P(Z1=1)*P(Z2=2)+P(Z1=2)*P(Z2=1)=2/36=1/18
sum_possibility(4) = 1/12;  %possible pairs:(Z1,Z2)={(1,3),(2,2),(3,1)}
sum_possibility(5) = 1/9;   %possible pairs:(Z1,Z2)={(1,4),(2,3),(3,2),(4,1)}
sum_possibility(6) = 5/36;  %possible pairs:(Z1,Z2)={(1,5),(2,4),(3,3),(4,2),(5,1)}
sum_possibility(7) = 1/6;   %possible pairs:(Z1,Z2)={(1,6),(2,5),(3,4),(4,3),(5,2),(6,1)}
sum_possibility(8) = 5/36;  %possible pairs:(Z1,Z2)={(2,6),(3,5),(4,4),(5,3),(6,2)}
sum_possibility(9) = 1/9;   %possible pairs:(Z1,Z2)={(3,6),(4,5),(5,4),(6,3)}
sum_possibility(10) = 1/12; %possible pairs:(Z1,Z2)={(4,6),(5,5),(6,4)}
sum_possibility(11) = 1/18; %possible pairs:(Z1,Z2)={(5,6),(6,5)}
sum_possibility(12) = 1/36; %possible pair:(Z1,Z2)={(6,6)}
convolution = conv(Z1,Z2);
figure('Name','Sum pdf - Convolution','NumberTitle','off');
subplot(1,2,1);
hold on;
plot(sum_possibility*100);
plot(sum_pdf/10);
hold off;
title('Sum pdf')
xlabel('Z1 + Z2');
ylabel('Percentage % of total throws');

subplot(1,2,2);
plot(convolution);
title('Convolution');

%------------------------------erwthma-4-----------------------------------
f = @(x)(x-5).^4+3*x; %looking for min
diff_f = @(x)4*(x-5).^3+3;
syms x;
local_edges(1:3) = double(solve(4*(x-5).^3+3 == 0,x));
[min_edge, index_of_min_edge] = min(f(local_edges));
x_of_min_edge = local_edges(index_of_min_edge);
disp(['min edge: ',num2str(x_of_min_edge)]);

%--------Gradient Descent
xi_gr = rand()*500;
h = 3.1e-6;
epsilon = 1e-10;
xi_new_gr = xi_gr+10;
gradient_iterations = 0;
while abs(xi_new_gr-xi_gr)>=epsilon
    xi_gr = xi_new_gr;
    xi_new_gr = xi_gr - h*diff_f(xi_gr);
    gradient_iterations = gradient_iterations + 1;
end
disp(['min edge found with gradient:', num2str(xi_gr)]);
disp(['gradient iterations: ', num2str(gradient_iterations)]);

%--------Newton Method
diff_diff_f = @(x)12*(x-5).^2;
xi_n = rand()*50;
h = 0.01;
epsilon = 1e-6;
xi_new_n = xi_n+10;
newtons_iterations = 0;
while abs(xi_new_n-xi_n)>=epsilon
    xi_n = xi_new_n;
    xi_new_n = xi_n - 1/diff_diff_f(xi_n)*diff_f(xi_n);
    newtons_iterations = newtons_iterations + 1;
end
disp(['min edge found with Newtons method :', num2str(xi_gr)]);
disp(['Newtons method iterations: ',num2str(newtons_iterations)]);