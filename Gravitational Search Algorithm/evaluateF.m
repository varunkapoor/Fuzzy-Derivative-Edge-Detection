
%This function Evaluates the agents. 
function [t1,t2,beta,a,b,fitness]=evaluateF(img,del_sort2,X)

[dim,N]=size(X);
I=img;
 I=double(I);

a=0.5;
b=0.9;
t1=1;
t2=100;
beta=4;


for i=1:N 
    L1=X(:,i)';
 
     fitness(i)=test_function(I,t1,t2,beta,a,b,del_sort2,L1); 
     [t1,t2,beta,a,b]=optimal(t1,t2,beta,a,b,L1);
end
