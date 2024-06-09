%% test the projection methods to ellipsoid
clc;
clear;
n=2;  % dimension of the problem
iteration_max = 10; % the max number of the iteration of each method
e = 10^(-6);  % stopping condition

[C]= GeneratingOneEllipsoid(n);
x0 = Generatingx0Ellipsoid(C,n)*10^0.5;

Plot2DEllipsoid(C,1);
hold on;

%%
X_ADMM=[];

Iteration_ADMM=0;


Solutiom_ADMM = zeros(n,iteration_max);
Solutiom_Hyperplane= zeros(n,iteration_max);
Time_ADMM = zeros(iteration_max,1);
Time_Hyplerplane = zeros(iteration_max,1);

for i=1:iteration_max
        [X_ADMM,t,r] = Projection_ADMM(C{1,1},C{2,1}/2,C{3,1},x0,e);
%         Solutiom_ADMM(:,i) = x;
%         Time_ADMM(i) = t;
end

for i=1:iteration_max
        [x,t] = Projection_Hyperplane(C{1,1},C{2,1},C{3,1},x0,e);
%         [x,t] = Projection_CRM(C{1,1},C{2,1},C{3,1},x0,e);
        Solutiom_Hyperplane(:,i) = x;
        Time_Hyplerplane(i) = t;
end
X_ADMM=[x0 X_ADMM];
plot(X_ADMM(1,:),X_ADMM(2,:),'-');
hold on;

