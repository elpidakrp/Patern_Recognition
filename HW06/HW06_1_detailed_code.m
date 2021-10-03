clear;
close all;
clc;

y = [-1 1 1 -1];

X = [0 0 1 1; 0 1 0 1];

% x (2D) -> y (3D)
for i=1:4
    s1 = X(1,i)^2;                     % x1^2
    s2 = sqrt(2)*X(1,i)*X(2,i); % sqrt(2)*x1*x2
    s3 = X(2,i)^2;                     % x2^2

    Mat_Y{i,1} = [1;s1;s2;s3];
end

for i=1:4
    for j=1:4
        K(i,j) = 0;
      for num=1:4
         K(i,j) = Mat_Y{i,1}(num,1)*Mat_Y{j,1}(num,1)+K(i,j); % calc Kernel
      end
    end
end

for i=1:4
    for j=1:4
        H(i,j)= K(i,j)*y(i)*y(j);
    end
end

 f = [-1; -1; -1; -1];

 A=[1 -1 -1 1];
 B=[0];

 % a>=0;
 low_bound_a = zeros(4,1);

% solving quadratic programming problem with A*a ? b
 [x,fval,exitflag,output,lambda] = quadprog(H,f,[],[],A,B,low_bound_a); %min of 1/2*x'*H*x + f'*x = max -(1/2*x'*H*x + f'*x)

% solutions for alphas
 a=x


w=0;
for i=1:4
   w=a(i)*y(i)*Mat_Y{i,1}+w ;
end

calc=0;
w0=0;
for i=1:4
    for j=1:4
        calc=a(j)*y(j)*K(i,j)+calc;
    end
    w0=y(i)-calc+w0;
    calc=0;
end

w
w0

hold on;
scatter3([Mat_Y{1}(2),Mat_Y{4}(2)],[Mat_Y{1}(3),Mat_Y{4}(3)],[Mat_Y{1}(4),Mat_Y{4}(4)],'b*')
scatter3([Mat_Y{2}(2),Mat_Y{3}(2)],[Mat_Y{2}(3),Mat_Y{3}(3)],[Mat_Y{2}(4),Mat_Y{3}(4)],'r*')

syms f(x,y)
f(x,y) = -w(2)/w(4)*x-w(3)/w(4)*y-w0-3.5;
ezsurf(f);
