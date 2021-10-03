function [out] = parzen_classifier(X,x,h,P,Y)
%
out = zeros(1,length(Y));
for j = 1:length(Y)
    classes = zeros(1,max(x));
    for c = 1:length(classes)
        class_indexes = find(x==c);
        N = length(class_indexes);
        px= 0;
        for i = class_indexes(1):class_indexes(end)
            px=px+exp(-(Y(j)-X(i))'*(Y(j)-X(i))/(2*h^2));
        end
        classes(c) = px*(1/N)*(1/(((2*pi)^(1/2))*(h^1))); 
    end
    classes = classes.*P';
    [pout,out(j)] = max(classes);
end