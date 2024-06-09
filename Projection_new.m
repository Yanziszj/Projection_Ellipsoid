function [xk,time] = Projection_new(A,b,alpha,x0,e)
%PROJECTION_HYPERPLANE 此处显示有关此函数的摘要
%   此处显示详细说明
t1 = cputime;

max_iteration = 1000;
M = zeros(2,2);
p = zeros(2,1);
q = zeros(2,1);
i=0;


%% generated the second point before going to the loop
    g0 = 2*A*x0+b;
    f0 = x0'*A*x0 +b'*x0-alpha;
%     fk = xk'*A*xk +2b'*xk-alpha;
    
    xk = x0 - max(0,f0)/(norm(g0)^2)*g0;
    fk = xk'*A*xk +b'*xk-alpha;
%%

while fk>e
    gk = 2*A*xk+b;
    xk = x0 - max(0,gk'*xk - fk - gk'*x0)/(norm(gk)^2)*gk;
    
    
    fk = xk'*A*xk +b'*xk-alpha;
    i=i+1;
    
    
    if i==max_iteration
        break;
    end
    
end
t2 = cputime;
time = t2 - t1;


end

