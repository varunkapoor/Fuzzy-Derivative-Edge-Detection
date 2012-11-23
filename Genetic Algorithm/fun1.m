
function [del_sort2,col]= fun1()
I1=imread('lena.jpg');
 I2=I1;
 I1=rgb2gray(I1);
 I=double(I1);
[row col] = size(I);
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
%                     del_nw_xy_f=(del_nw_xm1yp1+del_nw_xp1ym1)/2;
                    del_nw_xy_f=max(del_nw_xm1yp1,del_nw_xp1ym1);
                  elseif ((del_nw_xm1yp1<=del_nw_xy)&&(del_nw_xm1yp1<=del_nw_xp1ym1))
%                     del_nw_xy_f=(del_nw_xy+del_nw_xp1ym1)/2;
                    del_nw_xy_f=max(del_nw_xy,del_nw_xp1ym1);
                  elseif (( del_nw_xp1ym1<=del_nw_xy)&&(del_nw_xp1ym1<=del_nw_xm1yp1))   
%                     del_nw_xy_f=(del_nw_xy+del_nw_xm1yp1)/2;
                    del_nw_xy_f=max(del_nw_xy,del_nw_xm1yp1);
                  end
  
       %for w direction
        
        del_w_xy=abs((I(i,j-1)-I(i,j)));
        del_w_xp1_y=abs((I(i+1,j-1)-I(i+1,j)));
        del_w_xm1_y=abs((I(i-1,j-1)-I(i-1,j)));
        
              if ((del_w_xy<=del_w_xp1_y)&&(del_w_xy<=del_w_xm1_y))
%                    del_w_xy_f=(del_w_xp1_y+del_w_xm1_y)/2;
                   del_w_xy_f=max(del_w_xp1_y,del_w_xm1_y);
                elseif ((del_w_xp1_y<=del_w_xy)&&(del_w_xp1_y<= del_w_xm1_y))
%                    del_w_xy_f=(del_w_xy+del_w_xm1_y)/2;
                      del_w_xy_f=max(del_w_xy,del_w_xm1_y);
             elseif (( del_w_xm1_y<=del_w_xy)&&(del_w_xm1_y<=del_w_xp1_y))
%                    del_w_xy_f=(del_w_xy+del_w_xp1_y)/2;
                    del_w_xy_f=max(del_w_xy,del_w_xp1_y);
             end
  
        %for sw direction   
        
        del_sw_xy=abs((I(i+1,j-1)-I(i,j)));
        del_sw_xm1ym1=abs((I(i,j-2)-I(i-1,j-1)));
        del_sw_xp1yp1=abs((I(i+2,j)-I(i+1,j+1)));
              
          if ((del_sw_xy<=del_sw_xm1ym1)&&(del_sw_xy<=del_sw_xp1yp1))
%               del_sw_xy_f=(del_sw_xm1ym1+del_sw_xp1yp1)/2;
              del_sw_xy_f=max(del_sw_xm1ym1,del_sw_xp1yp1);
              
        elseif ((del_sw_xm1ym1<=del_sw_xy)&&(del_sw_xm1ym1<=del_sw_xp1yp1))
%                del_sw_xy_f=(del_sw_xy+del_sw_xp1yp1)/2;
              del_sw_xy_f=max(del_sw_xy,del_sw_xp1yp1);
        
        elseif (( del_sw_xp1yp1<=del_sw_xy)&&(del_sw_xp1yp1<=del_sw_xm1ym1))
%                del_sw_xy_f=(del_sw_xy+del_sw_xm1ym1)/2;
               del_sw_xy_f=max(del_sw_xy,del_sw_xm1ym1);
          end
       
       %for s direction   
        
        del_s_xy=abs((I(i+1,j)-I(i,j)));
        del_s_xym1=abs((I(i+1,j-1)-I(i,j-1)));
        del_s_xyp1=abs((I(i+1,j+1)-I(i,j+1)));
                  
          if ((del_s_xy<=del_s_xym1)&&(del_s_xy<=del_s_xyp1))
%               del_s_xy_f=( del_s_xym1+del_s_xyp1)/2;
               del_s_xy_f=max(del_s_xym1,del_s_xyp1);
          elseif ((del_s_xym1<=del_s_xy)&&(del_s_xym1<=del_s_xyp1))
%                 del_s_xy_f=(del_s_xy+del_s_xyp1)/2;
                del_s_xy_f=max(del_s_xy,del_s_xyp1);
        
         elseif (( del_s_xyp1<=del_s_xy)&&(del_s_xyp1<=del_s_xym1))
%                  del_s_xy_f=(del_s_xy+del_s_xym1)/2;
                 del_s_xy_f=max(del_s_xy,del_s_xym1);
          end
     
         %for se direction   
        
        del_se_xy=abs((I(i+1,j+1)-I(i,j)));
        del_se_xm1yp1=abs((I(i,j+2)-I(i-1,j+1)));
        del_se_xp1ym1=abs((I(i+2,j)-I(i+1,j-1)));
                  
        if ((del_se_xy<=del_se_xm1yp1)&&(del_se_xy<=del_se_xp1ym1))
%             del_se_xy_f=(del_se_xm1yp1+del_se_xp1ym1)/2;
              del_se_xy_f=max(del_se_xm1yp1,del_se_xp1ym1);
        elseif ((del_se_xm1yp1<=del_se_xy)&&(del_se_xm1yp1<=del_se_xp1ym1))
%                 del_se_xy_f=(del_se_xy+del_se_xp1ym1)/2;
                 del_se_xy_f=max(del_se_xy,del_se_xp1ym1);
        elseif (( del_se_xp1ym1<=del_se_xy)&&(del_se_xp1ym1<=del_se_xm1yp1))
%                del_se_xy_f=(del_se_xy+del_se_xm1yp1)/2;
                del_se_xy_f=max(del_se_xy,del_se_xm1yp1);
        end
       
       %for e direction
       
        del_e_xy=abs((I(i,j+1)-I(i,j)));
        del_e_xm1_y=abs((I(i-1,j+1)-I(i-1,j)));
        del_e_xp1_y=abs((I(i+1,j+1)-I(i+1,j)));
           
         if ((del_e_xy<=del_e_xp1_y)&&(del_e_xy<=del_e_xm1_y))
%             del_e_xy_f=(del_e_xp1_y+del_e_xm1_y)/2;
            del_e_xy_f=max(del_e_xp1_y,del_e_xm1_y);
         elseif ((del_e_xp1_y<=del_e_xy)&&(del_e_xp1_y<= del_e_xm1_y))
%                 del_e_xy_f=(del_e_xy+del_e_xm1_y)/2;
                del_e_xy_f=max(del_e_xy,del_e_xm1_y);
        
         elseif (( del_e_xm1_y<=del_e_xy)&&(del_e_xm1_y<=del_e_xp1_y))
%                 del_e_xy_f=(del_e_xy+del_e_xp1_y)/2;
                del_e_xy_f=max(del_e_xy,del_e_xp1_y);
         end
    
       %for ne direction   
        
        del_ne_xy=abs((I(i-1,j+1)-I(i,j)));
        del_ne_xm1ym1=abs((I(i-2,j)-I(i-1,j-1)));
        del_ne_xp1yp1=abs((I(i,j+2)-I(i+1,j+1)));    
          
        if ((del_ne_xy<=del_ne_xm1ym1)&&(del_ne_xy<=del_ne_xp1yp1))
%             del_ne_xy_f=(del_ne_xm1ym1+del_ne_xp1yp1)/2;
            del_ne_xy_f=max(del_ne_xm1ym1,del_ne_xp1yp1);
        elseif ((del_ne_xm1ym1<=del_ne_xy)&&(del_ne_xm1ym1<=del_ne_xp1yp1))
%                       del_ne_xy_f=(del_ne_xy+del_ne_xp1yp1)/2;
                      del_ne_xy_f=max(del_ne_xy,del_ne_xp1yp1);
        
        elseif (( del_ne_xp1yp1<=del_ne_xy)&&(del_ne_xp1yp1<=del_ne_xm1ym1))
%                 del_ne_xy_f=(del_ne_xy+del_ne_xm1ym1)/2;
                del_ne_xy_f=max(del_ne_xy,del_ne_xm1ym1);
        end 
       
       %for n direction   
        
        del_n_xy=abs((I(i-1,j)-I(i,j)));
        del_n_xym1=abs((I(i-1,j-1)-I(i,j-1)));
        del_n_xyp1=abs((I(i-1,j+1)-I(i,j+1)));
        
        if ((del_n_xy<=del_n_xym1)&&(del_n_xy<=del_n_xyp1))
%             del_n_xy_f=( del_n_xym1+del_n_xyp1)/2;
             del_n_xy_f=max(del_n_xym1,del_n_xyp1);
        elseif ((del_n_xym1<=del_n_xy)&&(del_n_xym1<=del_n_xyp1))
%                 del_n_xy_f=(del_n_xy+del_n_xyp1)/2;
                del_n_xy_f=max(del_n_xy,del_n_xyp1);
        elseif (( del_n_xyp1<=del_n_xy)&&(del_n_xyp1<=del_n_xym1))
%                del_n_xy_f=(del_n_xy+del_n_xym1)/2;
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