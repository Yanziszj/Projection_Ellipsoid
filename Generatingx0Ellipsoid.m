function x0 = Generatingx0Ellipsoid(C,n)
%GENERATINGX0 is to generate an random initial point outside the ellipsoid
% C is a cell for restoring the ellipsoid
% n is the dimension of the problem
%

m=1;
k=1;
mu = 10;
gamma = 0.2;
while(1)

index = 1;
x0 = rand(n,1)*mu^k;
for i=1:m
    if x0'*C{1,i}*x0+2*C{2,i}'*x0 -C{3,i}<=0
        break;
    end
    index = index + 1;
end

if index==m+1
    break;
end

k = k+gamma;
end

