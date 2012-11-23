
%This function initializes the position of agents in the search space, randomly.
function [X]=initialization(dim,N,up,down)

if size(up,1)==1
    X=rand(dim,N).*(up-down)+down;
end
if size(up,1)>1
    for i=1:dim
    high=up(i);
    low=down(i);
     X(i,:)=rand(1,N).*[0.5 0.9 1 100 4];
    end
end