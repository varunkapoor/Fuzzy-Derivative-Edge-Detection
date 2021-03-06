
clc;
close all;
clear all;
[params]=ga;
savefile = 'params.mat';
save(savefile,'params');

 I1=imread('lena.jpg');
 I2=I1;
 I1=rgb2gray(I1);
 I=double(I1);
 I=imresize(I,[512 512]);
[row col] = size(I);
loc_wind_size=10;
mean=0.05;
a=0.5
b=0.9
t1=1
t2=100
beta=4
  del_sort1= zeros(row,col);
  del_sort2= zeros(1,col);
 u2= zeros(1,col);
 u3= zeros(1,col);
 del_nw_xy_f= 0;
 del_n_xy_f=0;
 del_ne_xy_f=0;
 del_e_xy_f=0;
 del_se_xy_f=0;
 del_s_xy_f=0;
 del_sw_xy_f=0;
 del_w_xy_f=0;
            
    for i=4:row-3    
        for j=4:col-3
               
        del_nw_xy=abs((I(i-1,j-1)-I(i,j)));
              del_nw_xm1yp1=abs(I(i-2,j)-I(i-1,j+1));
              del_nw_xp1ym1=abs((I(i,j-2)-I(i+1,j-1)));
        
                  if ((del_nw_xy<=del_nw_xm1yp1)&&(del_nw_xy<=del_nw_xp1ym1))

                    del_nw_xy_f=max(del_nw_xm1yp1,del_nw_xp1ym1);
                  elseif ((del_nw_xm1yp1<=del_nw_xy)&&(del_nw_xm1yp1<=del_nw_xp1ym1))

                    del_nw_xy_f=max(del_nw_xy,del_nw_xp1ym1);
                  elseif (( del_nw_xp1ym1<=del_nw_xy)&&(del_nw_xp1ym1<=del_nw_xm1yp1))   

                    del_nw_xy_f=max(del_nw_xy,del_nw_xm1yp1);
                  end
  
       %for w direction
        
        del_w_xy=abs((I(i,j-1)-I(i,j)));
        del_w_xp1_y=abs((I(i+1,j-1)-I(i+1,j)));
        del_w_xm1_y=abs((I(i-1,j-1)-I(i-1,j)));
        
              if ((del_w_xy<=del_w_xp1_y)&&(del_w_xy<=del_w_xm1_y))

                   del_w_xy_f=max(del_w_xp1_y,del_w_xm1_y);
                elseif ((del_w_xp1_y<=del_w_xy)&&(del_w_xp1_y<= del_w_xm1_y))

                      del_w_xy_f=max(del_w_xy,del_w_xm1_y);
             elseif (( del_w_xm1_y<=del_w_xy)&&(del_w_xm1_y<=del_w_xp1_y))

                    del_w_xy_f=max(del_w_xy,del_w_xp1_y);
             end
  
        %for sw direction   
        
        del_sw_xy=abs((I(i+1,j-1)-I(i,j)));
        del_sw_xm1ym1=abs((I(i,j-2)-I(i-1,j-1)));
        del_sw_xp1yp1=abs((I(i+2,j)-I(i+1,j+1)));
              
          if ((del_sw_xy<=del_sw_xm1ym1)&&(del_sw_xy<=del_sw_xp1yp1))

              del_sw_xy_f=max(del_sw_xm1ym1,del_sw_xp1yp1);
              
        elseif ((del_sw_xm1ym1<=del_sw_xy)&&(del_sw_xm1ym1<=del_sw_xp1yp1))

              del_sw_xy_f=max(del_sw_xy,del_sw_xp1yp1);
        
        elseif (( del_sw_xp1yp1<=del_sw_xy)&&(del_sw_xp1yp1<=del_sw_xm1ym1))

               del_sw_xy_f=max(del_sw_xy,del_sw_xm1ym1);
          end
       
       %for s direction   
        
        del_s_xy=abs((I(i+1,j)-I(i,j)));
        del_s_xym1=abs((I(i+1,j-1)-I(i,j-1)));
        del_s_xyp1=abs((I(i+1,j+1)-I(i,j+1)));
                  
          if ((del_s_xy<=del_s_xym1)&&(del_s_xy<=del_s_xyp1))

               del_s_xy_f=max(del_s_xym1,del_s_xyp1);
          elseif ((del_s_xym1<=del_s_xy)&&(del_s_xym1<=del_s_xyp1))

                del_s_xy_f=max(del_s_xy,del_s_xyp1);
        
         elseif (( del_s_xyp1<=del_s_xy)&&(del_s_xyp1<=del_s_xym1))

                 del_s_xy_f=max(del_s_xy,del_s_xym1);
          end
     
         %for se direction   
        
        del_se_xy=abs((I(i+1,j+1)-I(i,j)));
        del_se_xm1yp1=abs((I(i,j+2)-I(i-1,j+1)));
        del_se_xp1ym1=abs((I(i+2,j)-I(i+1,j-1)));
                  
        if ((del_se_xy<=del_se_xm1yp1)&&(del_se_xy<=del_se_xp1ym1))

              del_se_xy_f=max(del_se_xm1yp1,del_se_xp1ym1);
        elseif ((del_se_xm1yp1<=del_se_xy)&&(del_se_xm1yp1<=del_se_xp1ym1))

                 del_se_xy_f=max(del_se_xy,del_se_xp1ym1);
        elseif (( del_se_xp1ym1<=del_se_xy)&&(del_se_xp1ym1<=del_se_xm1yp1))

                del_se_xy_f=max(del_se_xy,del_se_xm1yp1);
        end
       
       %for e direction
       
        del_e_xy=abs((I(i,j+1)-I(i,j)));
        del_e_xm1_y=abs((I(i-1,j+1)-I(i-1,j)));
        del_e_xp1_y=abs((I(i+1,j+1)-I(i+1,j)));
           
         if ((del_e_xy<=del_e_xp1_y)&&(del_e_xy<=del_e_xm1_y))

            del_e_xy_f=max(del_e_xp1_y,del_e_xm1_y);
         elseif ((del_e_xp1_y<=del_e_xy)&&(del_e_xp1_y<= del_e_xm1_y))

                del_e_xy_f=max(del_e_xy,del_e_xm1_y);
        
         elseif (( del_e_xm1_y<=del_e_xy)&&(del_e_xm1_y<=del_e_xp1_y))

                del_e_xy_f=max(del_e_xy,del_e_xp1_y);
         end
    
       %for ne direction   
        
        del_ne_xy=abs((I(i-1,j+1)-I(i,j)));
        del_ne_xm1ym1=abs((I(i-2,j)-I(i-1,j-1)));
        del_ne_xp1yp1=abs((I(i,j+2)-I(i+1,j+1)));    
          
        if ((del_ne_xy<=del_ne_xm1ym1)&&(del_ne_xy<=del_ne_xp1yp1))

            del_ne_xy_f=max(del_ne_xm1ym1,del_ne_xp1yp1);
        elseif ((del_ne_xm1ym1<=del_ne_xy)&&(del_ne_xm1ym1<=del_ne_xp1yp1))

                      del_ne_xy_f=max(del_ne_xy,del_ne_xp1yp1);
        
        elseif (( del_ne_xp1yp1<=del_ne_xy)&&(del_ne_xp1yp1<=del_ne_xm1ym1))

                del_ne_xy_f=max(del_ne_xy,del_ne_xm1ym1);
        end 
       
       %for n direction   
        
        del_n_xy=abs((I(i-1,j)-I(i,j)));
        del_n_xym1=abs((I(i-1,j-1)-I(i,j-1)));
        del_n_xyp1=abs((I(i-1,j+1)-I(i,j+1)));
        
        if ((del_n_xy<=del_n_xym1)&&(del_n_xy<=del_n_xyp1))

             del_n_xy_f=max(del_n_xym1,del_n_xyp1);
        elseif ((del_n_xym1<=del_n_xy)&&(del_n_xym1<=del_n_xyp1))

                del_n_xy_f=max(del_n_xy,del_n_xyp1);
        elseif (( del_n_xyp1<=del_n_xy)&&(del_n_xyp1<=del_n_xym1))

               del_n_xy_f=max(del_n_xy,del_n_xym1);
        end
        
       del_sort=[del_n_xy_f,del_nw_xy_f,del_e_xy_f,del_se_xy_f,del_s_xy_f,del_sw_xy_f,del_w_xy_f,del_ne_xy_f];  
       del_sort=sort(del_sort);
       del_sort1(i,j)=median(del_sort);
       if(del_sort1(i,j)==0)
            del_sort1(i,j)=1;
       end
       del_sort2(j)=median(del_sort);
        end
    end
          
optimise(a,b,t1,t2,beta,col,del_sort2)

load params.mat
a=params(1)
b=params(2)
t1=params(3)
t2=params(4)
beta=params(5)
    
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
   
i2=zeros(row,col);
for i=4:row-3  
    for j=4:col-3
        for k=4:col-3
        if  (del_sort1(i,j)==del_sort2(k))
            i2(i,j)=u2(k);
        end        
    end
    end
end
i3=i2*255;
i4=adaptivethreshold(i3,loc_wind_size,mean,0);
i5=i4;
i6=1-i5;
[row1 col1]= size(i5);
for i=5:row1-5
for j=5:col1-5
a=i6(i+1,j);
b=i6(i-1,j);
c=i6(i,j+1);
d=i6(i,j-1);
sum=a+b+c+d;
if(sum<1)
i6(i,j)=0;
end
end
end
i9=1-i6;
i10=1-i9;
[row1 col1]= size(i9);
for i=5:row1-5
for j=5:col1-5
a=i10(i+1,j);
b=i10(i-1,j);
c=i10(i,j+1);
d=i10(i,j-1);
sum=a+b+c+d;
if(sum<1)
i10(i,j)=0;
end
end
end
i13=1-i10;
i14=1-i13;
[row1 col1]= size(i13);
for i=5:row1-5
for j=5:col1-5
a=i14(i+1,j);
b=i14(i-1,j);
c=i14(i,j+1);
d=i14(i,j-1);
sum=a+b+c+d;
if(sum<1)
i14(i,j)=0;
end
end
end
i15=1-i14;
figure;imshow(i15);



