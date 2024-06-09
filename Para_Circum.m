function c = Para_Circum(x,y,z)
%PARA_ 此处显示有关此函数的摘要
%   此处显示详细说明
[n,m] = size(x);

A=zeros(n+3,n+3);
b=zeros(n+3,1);
for i=1:n
    A(1,i) = 2*(y(i)-x(i));
    A(2,i) = 2*(z(i)-y(i));
%    A(3,i) = 2*(x(i)-z(i));
    b(1) = b(1)+(y(i)^2-x(i)^2);
    b(2) = b(2)+(z(i)^2-y(i)^2);
%    b(3) = b(3)+(x(i)^2-z(i)^2);
end

A(1,n+1:n+3)=0;
A(2,n+1:n+3)=0;
%A(3,n+1:n+3)=0;

for i=3:n+2
    for j=1:n
        if i-2==j
            A(i,j)=-1;
        else
            A(i,j)=0;
        end
    end
    A(i,n+1) = x(i-2);
    A(i,n+2) = y(i-2);
    A(i,n+3) = z(i-2);
    b(i) = 0;
end

A(n+3,n+1) = 1;
A(n+3,n+2) = 1;
A(n+3,n+3) = 1;
b(n+3) = 1;

% check the rank of A
if rank(A) < n+3
    c =(1/3)*(x+y+z);
else
    C=A\b;
    c=C(1:n);
end

end

