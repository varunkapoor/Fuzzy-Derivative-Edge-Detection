function optimise(a,b,t1,t2,beta,col,del_sort2)
u1=zeros(1,col);
u2=zeros(1,col);
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
    
%         E1=E1+(-1*(u1(k+1).*(log(u1(k+1)+.00000000001))+(1-u1(k+1)).*(log(1-u1(k+1)+.00000000001))))+(-1*(u2(k+1).*(log(u2(k+1)+.00000000001))+(1-u2(k+1)).*(log(1-u2(k+1)+.00000000001))));
               E1=E1+(-1*(u2(k+1).*(log(u2(k+1)+.00000000001))+(1-u2(k+1)).*(log(1-u2(k+1)+.00000000001))));
end

E=E1/(col*log(2));
J=(0.5-E)


