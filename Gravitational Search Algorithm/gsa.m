
% Gravitational Search Algorithm.
function [t1,t2,beta,a,b]=gsa(img,del_sort2)
%  inputs:
% N:  Number of agents.
% max_it: Maximum number of iterations (T).

%V:   Velocity.
%a:   Acceleration.
%M:   Mass.  Ma=Mp=Mi=M;
%dim: Dimension of test function.
%N:   Number of agents.
%X:   Position of agents. dim-by-N matrix.
%R:   Distance between agents in search space.
%[low-up]: Allowable range for search space.
%Rnorm:  Norm in eq.8.
%Rpower: Power of R in eq.7.

 N=40; 
 max_it=20; 
 ElitistCheck=1; 
 Rnorm=2; 
 Rpower=1; 
 min_flag=1; 
 dim=1;
low=-10;
up=10;
%random initialization for agents.
X=initialization(dim,N,up,low); 


V=zeros(dim,N);

for iteration=1:max_it    
    %Checking allowable range. 
    X=space_bound(X,up,low); 

    %Evaluation of fitness of agents based on objective function
    [t1,t2,beta,a,b,fitness]=evaluateF(img,del_sort2,X); 
    
    [best best_X]=min(fitness); 
    
    if iteration==1
       Fbest=best;
       Lbest=X(:,best_X);
    end
    if best<Fbest  
       Fbest=best;
       Lbest=X(:,best_X);
    end

%Calculation of M. eq.14-20
[M]=massCalculation(fitness,min_flag); 

%Calculation of Gravitational constant. eq.13.
G=Gconstant(iteration,max_it); 

%Calculation of accelaration in gravitational field. eq.7-10,21.
ac=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,max_it);

%Agent movement. eq.11-12
[X,V]=move(X,ac,V);
end 


