
%This function checks the search space boundaries for agents.
function  X=space_bound(X,up,low)

% Agents that go out of the search space, are returned to the boundaries.
[dim,mass_num]=size(X);
for i=1:mass_num 
    Tp=X(:,i)>up;
    Tm=X(:,i)<low;
    X(:,i)=(X(:,i).*(~(Tp+Tm)))+up.*Tp+low.*Tm;
end
