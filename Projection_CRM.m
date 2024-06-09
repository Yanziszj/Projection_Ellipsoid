function [xk,time] = Projection_CRM(A,b,alpha,x0,e)
%PROJECTION_HYPERPLANE: generate the projection of a point to a ellipsoid
%            by the Hyperpane method
% the ellipsoid is in the following formular:
%           C := \{x: g(x) \leq 0 \} :=  \{x : x'*A*x + b'^x - \alpha \leq 0 \}
% the Hyperpane method can be formulated in the following shceme
%    x^{k+1} = P_{H_k}(x^k)  if k=0;
%    x^{k+1} = P_{ H_k \cap W_k} (x^k)  otherwise
% where       
%     H_k = \{x: \nabla g(x^k)^T (x-x^k) +g(x^k) \leq 0  \}
%     W_k = \{x:  (x-x^k)^T (x^0 - x^k) \leq 0 \}

%% Some prileminaries
%  projection of x^k onto a halfspace H = \{x: a^x \leq b\} is
%        P_H(x^k) = x^k - (max(0,a^x-b))/(\|x\|^2) * a


%% Initialization
t1 = cputime;

max_iteration = 1000;
M = zeros(2,2);
p = zeros(2,1);
lambda = zeros(2,1);
p = zeros(2,1);
i=0;


%% generated the second point before going to the loop
% calculate the projection of x^0 onton H_0
    g0 = 2*A*x0+b;     % the gradient of x^0
    f0 = x0'*A*x0 +b'*x0-alpha;    % the function value of the x^0
    
    xk = x0 - max(0,f0)/(norm(g0)^2)*g0;
    fk = xk'*A*xk +b'*xk-alpha;
    
%% Generate the following point by projecting onto the 
% Projection of x^k onto the intersection of two halfspaces is essential
% constraint problem:
%              min 1/2 \| x- y\|^2
%                     s.t.  y \in H_k \cap W_k
% First we write the Lagerange Function here:
%     L(x, \lambda) = g(x) + \lambda^T H(x)
%                            =1/2 \| x- x^k\|^2 + \alpha +\lambda_1 (g(x^k)^T (x-x^k) +g(x^k))
%                                                  +\lambda_2 ((x-x^k)^T (x^0 - x^k) )
% and \nabla_x L(x,\lambda) :=(x-x^k) +\lambda_1*\nabla g(x^k) +\lamnda_2*(x^0 - x^k)
%        \nabla_{\lambda_1} L(x,\lambda) = g(x^k)^T (x-x^k) +g(x^k)
%        \nabla_{\lambda_2} L(x,\lambda) = (x-x^k)^T (x^0 - x^k) 
%
%  Then the KKT condition for the above problem is
%   \nabla L(x^*,\lambda) = 0  which is 
%                    (x^* - x^k) +\lambda_1*\nabla g(x^k) +\lamnda_2*(x^0 -x^k)
%                    = 0
%                    g(x^k)^T (x^*-x^k) +g(x^k) = 0      
%                    (x^*-x^k)^T (x^0 - x^k) = 0                           
%                    \lamda_1 g(x^k)^T (x^*-x^k) +g(x^k) = 0 
%                    \lamda_2 g(x^k)^T (x^*-x^k)^T (x^0 - x^k) = 0 
%                    \lamda_1 \geq 0
%                    \lamda_2 \geq 0
while fk>e
    gk = 2*A*xk+b;     % the gradient of x^0
    fk = xk'*A*xk +b'*xk-alpha;    % the function value of the x^0
    
    xk_1 = 2*(x0 - (gk'*x0-gk'*xk+fk)/(norm(gk)^2)*gk)-x0;
    xk_2 = 2*xk-x0;
    xk = Para_Circum(xk_1,xk_2,x0);
    
    i=i+1;
    
    
    if i==max_iteration
        break;
    end
    
end
t2 = cputime;
time = t2 - t1;


end


