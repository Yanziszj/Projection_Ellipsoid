function [C] = GeneratingOneEllipsoid(n)
%% GENERATINGEXAMPLES is to generate the m sets
%  Input: n is the dimension, m is the number of convex closed sets
%  Output: C is a cell containing all the example
%                        C(1,i) is the positive matrix A, C(2,i) is the
%                        vector b and C(3,i) is the constant.
%  the ellipsoid is the formular:
%           \{x : x'*C{1,1}*x + C{2,1}'*x -C{3,1} \leq 0\}

%% Generate the cell to store the information about the m ellipsoids
C = cell(3,1);
lambda = 1.3;
gamma = 5;
%%   First generate the initial ellipsoid 
% 
mu = 0;
var = 5;
B1 = normrnd(mu,var,n,n);
% B1 is a sparse matrix with sparsity density p=2/n which
%   will be generated by standard normal distributed.
for i=1:n
    % make sure that B1 is a sparse matrix
    for j=1:n
        if B1(i,j)>=2/n
            B1(i,j) = 0;
        end
    end
end
A1 = gamma*eye(n)+B1'*B1;
b1 = rand(n,1);
alpha1 = 1+b1'*A1*b1;

C{1,1} = A1;
C{2,1} = b1;
C{3,1} = alpha1;

% %% To generate the second one
% % first to generate the center of the ellipsoid
% a = 1;
% c =  rand(n,1)*a;
% while (c'*C{1,1}'*c +2*c'*C{2,1} - C{3,1}<=0)
%     % make sure that c does not belong to the first ellipsoid
%     %  generated already
%     a=1.2*a;
% %     c = c + rand(n,1)*a;
%     c = rand(n,1)*a;
% end
% c2=c;
% d = lambda*(Projection(C{1,1},C{2,1},C{3,1},c)-c);
% % we will make sure that the point p will lie in the intersection of all
% %   all the ellipsoid
% p1= Projection(C{1,1},C{2,1},C{3,1},c);
% p = 0.5*(1+lambda)*Projection(C{1,1},C{2,1},C{3,1},c) + 0.5*(1-lambda)*c; 
% % We need to make sure that this point
% %   lies in all the ellipsoid
% u= rand(n-1,1)*norm(d)*0.8;
% u = [norm(d);u];
% A = diag(u);
% Q = rand(n,n);
% for k=1:n
%     Q(k,1) = d(k);
% end
% Q = GramSchmidt(Q);
% A = Q*A*Q';
% A = inv(A'*A);
% C{1,2} = A;
% C{2,2} = -A*c;
% C{3,2} = -c'*A*c+1;
% 
% 
% %% To generate other ellipsoid
% % The left ellipsoid has the formulation 
% %   g_i(x) = (x-c_i)^T A_2 (x-c_i)
% %   A = diag(||d||,u), d = \lambda (P_C1(c2)-c2)
% for i=3:m
%     % first to generate the center of the ellipsoid
%     a = 1;
%     % first generate the center of the i-th ellipsoid
%     c =rand(n,1)*a;
%     for j=1:i-1
%         % check whether c belongs to the j-th ellipsoid 
%         while (c'*C{1,j}'*c +2*c'*C{2,j} - C{3,j}<=0)
%         % If center belongs to the j-th ellipsoid we 
%         %   generate a ellipsoid more far away unitl it is not 
%         %   in the ellipsoid anymore
%             a=1.1*a;
%             c = rand(n,1)*a;
%         end
%     end    
%     
%     d  =  lambda*(p - c);
%     u= rand(n-1,1)*norm(d)*0.8;
%     u = [norm(d);u];
%     A = diag(u);
%     Q = rand(n,n);
%     for k=1:n
%         Q(k,1) = d(k);
%     end
%     Q = GramSchmidt(Q);
%     A = Q*A*Q';
%     A = inv(A'*A);
%     C{1,i} = A;
%     C{2,i} = -A*c;
%     C{3,i} = -c'*A*c+1;
% end
% 
%     % calculate the max lenghth of the semi-axis
% 
% 
% %% To change the order of m-ellipsoids
% cyclic_index = randperm(m);
% 
% C_new = cell(3,m);
% for i=1:m
%     C_new{1,i} = C{1,cyclic_index(i)};
%     C_new{2,i} = C{2,cyclic_index(i)};
%     C_new{3,i} = C{3,cyclic_index(i)};
% end
% 
% Salter_ponit = p;
end


