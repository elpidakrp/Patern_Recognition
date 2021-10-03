function [w,iter,error_val,error_test]=my_perce_with_val_test(X,y,w_ini,rho,X_validation,y_validation,X_test,y_test)
%from  function [w,iter,mis_clas]=perce(X,y,w_ini,rho)
[l,N]    = size(X);
[l,M]    = size(X_validation);
[l,K]    = size(X_test);

max_iter = 20000; % Maximum allowable number of iterations
 
w        = w_ini;        % Initilaization of the parameter vector
iter     = 0;            % Iteration counter
 
mis_clas = N;     % Number of misclassfied vectors


while(mis_clas>0)&&(iter<max_iter)
%     fplot(@(x)-w(2)/w(3)*x-w(1)/w(3),[-8,8],'g');
%     ylim([-3 3]);
    iter            = iter+1;
    mis_clas        = 0;
    
    gradi           = zeros(l,1); % Computation of the "gradient" term
    err             = 0;   		% evaluates the error CC
    error_val(iter) = 0; 
    
    for i=1:N
        if((X(:,i)'*w)*y(i)<0)
            gradi = gradi+rho*(-y(i)*X(:,i));
            err   = err+w'*(y(i)*X(:,i));  			%CC
        end
    end
    
    for i=1:M
        if((X_validation(:,i)'*w)*y_validation(i)<0)
            mis_clas = mis_clas+1;
        end
    end
    error_val(iter) = mis_clas/M;
    
    if(iter==1)
        fprintf('\n First Iteration: # Misclassified points = %g \n',mis_clas);        
    end	
    w = w-rho*gradi; % Updating the parameter vector
%     fplot(@(x)-w(2)/w(3)*x-w(1)/w(3),[-8,8],'r');
%     ylim([-3 3]);
end
%plots the line CC
mis_clas = 0;
for i=1:M
    if((X_test(:,i)'*w)*y_test(i)<0)
        mis_clas = mis_clas+1;
    end
end
error_test = mis_clas/K;