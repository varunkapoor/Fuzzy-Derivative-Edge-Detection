function[t1,t2,beta,a,b]=pso1(I,del_sort2)

iterations = 50;
inertia = 1.0;
a1= 2.0;
swarm_size = 20;
[row col] = size(I);
u1= zeros(1,col);
u2= zeros(1,col);
% ---- initial swarm position -----
index = 1;
for i = 1 : 5
    for j = 1 : 5
        for k = 1 : 5
        swarm(index, 1, 1) = 1;
        swarm(index, 1, 2) = 100;
        swarm(index, 1, 3) = 4;
        swarm(index, 1, 4) = 0.5;
        swarm(index, 1, 5) = 1;
        index = index + 1;
    end
    end
end

swarm(:, 6, 1) = 1000;          % best value so far
swarm(:, 2, :) = 0;             % initial velocity

for iter = 1 : iterations
    for i = 1 : swarm_size
        swarm(i, 1, 1) = swarm(i, 1, 1) + swarm(i, 2, 1)/1.3;     
        swarm(i, 1, 2) = swarm(i, 1, 2) + swarm(i, 2, 2)/1.3;     
        swarm(i, 1, 3) = swarm(i, 1, 3) + swarm(i, 2, 3)/1.3;  
        swarm(i, 1, 4) = swarm(i, 1, 4) + swarm(i, 2, 4)/1.3;
        swarm(i, 1, 5) = swarm(i, 1, 5) + swarm(i, 2, 5)/1.3;

        t1 = swarm(i, 1, 1);
        t2= swarm(i, 1, 2);
        beta= swarm(i, 1, 3);
        a= swarm(i, 1, 4);
        b= swarm(i, 1, 5);
        
for j=4:col-3
u1(j)=1/(1+abs((del_sort2(j)-t1)/t2)^2*beta); 
       if(u1(j)<=a)
          u2(j)=0;
      elseif((u1(j)>a)&&(u1(j)<b))
          u2(j)=abs((u1(j)-a)/(a-b));
      elseif(u1(j)>=b)
          u2(j)=1;
       end
  end

E=0;
E1=0;
for k=0:col-1
    
  E1=E1+(-1*(u2(k+1).*(log(u2(k+1)+.00000000001))+(1-u2(k+1)).*(log(1-u2(k+1)+.00000000001))));
end

E=E1/(col*log(2));
J=(0.5-E);
        
        if J < swarm(i, 6, 1)                 
            swarm(i, 3, 1) = swarm(i, 1, 1);    
            swarm(i, 3, 2) = swarm(i, 1, 2);    
            swarm(i, 3, 3) = swarm(i, 1, 3);
            swarm(i, 3, 4) = swarm(i, 1, 4);
            swarm(i, 3, 5) = swarm(i, 1, 5);
            swarm(i, 6, 1) = J;              
        end
    end

    [temp, gbest] = min(swarm(:, 6, 1));        % global best position
    
    %--- updating velocity vectors
    for i = 1 : swarm_size
        swarm(i, 2, 1) = rand*inertia*swarm(i, 2, 1) + a1*rand*(swarm(i, 3, 1) - swarm(i, 1, 1)) + a1*rand*(swarm(gbest, 3, 1) - swarm(i, 1, 1));  
        swarm(i, 2, 2) = rand*inertia*swarm(i, 2, 2) + a1*rand*(swarm(i, 3, 2) - swarm(i, 1, 2)) + a1*rand*(swarm(gbest, 3, 2) - swarm(i, 1, 2));   
        swarm(i, 2, 3) = rand*inertia*swarm(i, 2, 3) + a1*rand*(swarm(i, 3, 3) - swarm(i, 1, 3)) + a1*rand*(swarm(gbest, 3, 3) - swarm(i, 1, 3)); 
        swarm(i, 2, 4) = rand*inertia*swarm(i, 2, 4) + a1*rand*(swarm(i, 3, 4) - swarm(i, 1, 4)) + a1*rand*(swarm(gbest, 3, 4) - swarm(i, 1, 4));  
        swarm(i, 2, 5) = rand*inertia*swarm(i, 2, 5) + a1*rand*(swarm(i, 3, 5) - swarm(i, 1, 5)) + a1*rand*(swarm(gbest, 3, 5) - swarm(i, 1, 5));  
       
    end
end















