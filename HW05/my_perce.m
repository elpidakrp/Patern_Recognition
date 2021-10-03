function [w,iter,error]=my_perce(X,y,w_ini,rho)
%from  function [w,iter,mis_clas]=perce(X,y,w_ini,rho)
[l,N]    = size(X);
max_iter = 20000; % Maximum allowable number of iterations
 
w        = w_ini;        % Initilaization of the parameter vector
iter     = 0;            % Iteration counter
 
mis_clas = N;     % Number of misclassfied vectors


while(mis_clas>0)&&(iter<max_iter)
%     fplot(@(x)-w(2)/w(3)*x-w(1)/w(3),[-8,8],'g');
%     ylim([-3 3]);
    iter        = iter+1;
    mis_clas    = 0;
    
    gradi       = zeros(l,1); % Computation of the "gradient" term
    err         = 0;   		% evaluates the error CC
    error(iter) = 0; 
    for i=1:N
        if((X(:,i)'*w)*y(i)<0)
            mis_clas    = mis_clas+1;
            error(iter) = error(iter)+1;
            gradi       = gradi+rho*(-y(i)*X(:,i));
            err         = err+w'*(y(i)*X(:,i));  			%CC
        end
    end
    if(iter==1)
        fprintf('\n First Iteration: # Misclassified points = %g \n',mis_clas);        
    end	
    w = w-rho*gradi; % Updating the parameter vector
%     fplot(@(x)-w(2)/w(3)*x-w(1)/w(3),[-8,8],'r');
%     ylim([-3 3]);
end
%plots the line CC
error = error./N;