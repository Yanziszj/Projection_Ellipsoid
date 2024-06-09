function [X,time,i] = Projection_ADMM(A,b,alpha,x0,e)
%% This .m is to calculate the projection of a point onto a ellipsoid by ADMM
%   A is the n*n matrix 
%   b is the vector
%   c is the constant
%   xk is the current point
% X=[];
t1 = cputime;
X=[];
B=chol(A);
[n,m] = size(A);
%% Intitialzation
% y = x0; 
y=rand(n,1);
lambda = rand(n,1)*0.1;
upsilon =norm(inv(B))/norm(B) ;

y = 1/(sqrt(upsilon))*x0;

% e =10^(-6);    %  precision of the projection
I =eye(n);
i=0;

% b_Bar = - inv(B)'*b;
b_Bar = - inv(B)'*b;
A_Bar = inv(I +upsilon*B'*B);
r=sqrt(alpha+norm(b_Bar)^2);

    u = x0 + B'*lambda +upsilon*B'*(y+b_Bar);
    x = A_Bar*u;
    w = B*x - (1/upsilon)*lambda-b_Bar;
    if norm(w)<=r
        y=w;
    else
        y = r/(norm(w))*w;
    end
% y = r/(norm(w))*w;
    lambda = lambda - upsilon*(B*x - y - b_Bar);

while Residual(x,y,lambda,B,b_Bar,x0,alpha)>e
    
    u = x0 + B'*lambda +upsilon*B'*(y+b_Bar);
    x = A_Bar*u;
    w = B*x - (1/upsilon)*lambda-b_Bar;
    if norm(w)<=r
        y=w;
    else
        y = r/(norm(w))*w;
    end
%     y = r/(norm(w))*w;
    lambda = lambda - upsilon*(B*x - y - b_Bar);
     X=[X x];
     i=i+1;
end

t2 = cputime;

time = t2-t1;
end
