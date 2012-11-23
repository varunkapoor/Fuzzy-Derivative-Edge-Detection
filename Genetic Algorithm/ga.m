function[params]=ga()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Genetic Algorithm (GA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program simulates the optimzation of a simple function with
% a base-10 genetic algorithm.  

clc
close all
clear           % Initialize momery
rand('state',0) 

  NUM_TRAITS=2;          % Number of traits in each individual
  HIGHTRAIT=[30 30];  	 % Upper limit of a trait
  LOWTRAIT=[0 0]; 	     % Lower limit of a trait
  SIG_FIGS=[6 6]';       % Number of genes in each trait
  DECIMAL=[2 2];         % Order of magnitude the trait
  MUTAT_PROB=0.02;       % Probability of mutation (typically <.1)
  CROSS_PROB=0.6;        % Probability of crossover (typically near 1)
  SELF_ENTERED=0;        
  POP_SIZE=25;           % Number of individuals in the population
  ELITISM=0;             
  DELTA=100;             
  EPSILON = 0.01;  	     
  MAX_GENERATION=1000;   
popcount=1;         	

if SELF_ENTERED == 0            
for pop_member = 1:POP_SIZE
      for current_trait = 1:NUM_TRAITS,
      trait(current_trait,pop_member,popcount)=((rand-(1/2))*(HIGHTRAIT(current_trait)-LOWTRAIT(current_trait)))+((1/2)*(HIGHTRAIT(current_trait)+LOWTRAIT(current_trait)));
			    
	  end
end 

else
								
for pop_member = 1:POP_SIZE
        for current_trait = 1:NUM_TRAITS,
            trait(current_trait,pop_member,popcount)=0;  
						
		end
end 
	
end

   CHROM_LENGTH=sum(SIG_FIGS)+NUM_TRAITS; 
   TRAIT_START(1)=1;					  

   for current_trait=1:NUM_TRAITS, 
TRAIT_START(current_trait+1)=TRAIT_START(current_trait)+SIG_FIGS(current_trait)+1;
  
   end

while popcount <= MAX_GENERATION 
 
for pop_member = 1:POP_SIZE

for current_trait = 1:NUM_TRAITS,

if trait(current_trait,pop_member,popcount)>HIGHTRAIT(current_trait)
               
trait(current_trait,pop_member,popcount)=HIGHTRAIT(current_trait);

elseif trait(current_trait,pop_member,popcount)<LOWTRAIT(current_trait)           

trait(current_trait,pop_member,popcount)=LOWTRAIT(current_trait);
                  
end
               if trait(current_trait,pop_member,popcount) < 0
                  pop(TRAIT_START(current_trait),pop_member)=0;
               else
                  pop(TRAIT_START(current_trait),pop_member)=9;
               end

temp_trait(current_trait,pop_member)=...
           abs(trait(current_trait,pop_member,popcount));  

temp_trait(current_trait,pop_member)=...
temp_trait(current_trait,pop_member)/10^(DECIMAL(current_trait)-1);


for make_gene = TRAIT_START(current_trait)+1:TRAIT_START(current_trait+1)-1,
               
pop(make_gene,pop_member)=temp_trait(current_trait,pop_member)-...
   rem(temp_trait(current_trait,pop_member),1);

temp_trait(current_trait,pop_member)=...
  (temp_trait(current_trait,pop_member)-pop(make_gene,pop_member))*10;
               
end
         end        
	 end     

sumfitness = 0; 		

   for chrom_number = 1:POP_SIZE,       % Test fitness of the objective function

fitness_bar(chrom_number)=trait(1,chrom_number,popcount)+trait(2,chrom_number,popcount);

   end
  
   for chrom_number = 1:POP_SIZE,      

 fitness(chrom_number)= fitness_bar(chrom_number)/120;
 
sumfitness = sumfitness + fitness(chrom_number);  
   end

[bestfitness(popcount),bestmember]=max(fitness);
[worstfitness(popcount),worstmember]=min(fitness);

bestindividual(:,popcount)=trait(:,bestmember,popcount);

avefitness(popcount) = sumfitness / POP_SIZE;        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create the next generation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   for pop_member = 1:POP_SIZE,
	if ELITISM ==1 & pop_member==bestmember  
		parent_chrom(:,pop_member)=pop(:,pop_member); 
	else
      pointer=rand*sumfitness;  
      member_count=1;        
      total=fitness(1);

      while total < pointer,                
       									    
         member_count=member_count+1;
         total=total+fitness(member_count);
      end

    parent_chrom(:,pop_member)=pop(:,member_count);
	end
   end


for parent_number1 = 1:POP_SIZE,   
									
	if ELITISM ==1 & parent_number1==bestmember 
											 
		child(:,parent_number1)=parent_chrom(:,parent_number1);
	else
	   parent_number2=parent_number1;  
	   while parent_number2 == parent_number1   
		                                        
         parent_number2 = rand*POP_SIZE; 
		 								
         parent_number2 = parent_number2-rem(parent_number2,1)+1;     
	   end
    if CROSS_PROB > rand          

         site = rand*CHROM_LENGTH;   
         site = site-rem(site,1)+1;  
         							

child(1:site,parent_number1)=parent_chrom(1:site,parent_number1);

child(site+1:CHROM_LENGTH,parent_number1)=...
     parent_chrom(site+1:CHROM_LENGTH,parent_number2);

      else                           

child(:,parent_number1)=parent_chrom(:,parent_number1);

	 end
   end  
end  

   for pop_member= 1:POP_SIZE,

	if ELITISM ==1 & pop_member==bestmember  
											
		child(:,pop_member)=child(:,pop_member); 
											
	else
	  for site = 1:CHROM_LENGTH,

         if MUTAT_PROB > rand        
            rand_gene=rand*10; 		 
            
            while child(site,pop_member) == rand_gene-rem(rand_gene,1),
               rand_gene=rand*10;
            end;
            
            child(site,pop_member)=rand_gene-rem(rand_gene,1);  
            
            if rand_gene == 10
                 site=site-1;
            end
         end   
	   end  
	 end  
   end  

   pop=child;               
   popcount=popcount+1;		
   
for pop_member = 1:POP_SIZE

	for current_trait = 1:NUM_TRAITS,
			 
trait(current_trait,pop_member,popcount)=0; 
place_pointer=1;

for gene=TRAIT_START(current_trait)+1:TRAIT_START(current_trait+1)-1,
 place=DECIMAL(current_trait)-place_pointer;
 trait(current_trait,pop_member,popcount)=...
 trait(current_trait,pop_member,popcount)+...
    (pop(gene,pop_member))*10^place;
 place_pointer=place_pointer+1;
end

if pop(TRAIT_START(current_trait),pop_member) < 5
   trait(current_trait,pop_member,popcount)=...
      -trait(current_trait,pop_member,popcount);
end

	end 
         
end    
  			
   if popcount > DELTA+1 & ...
       max(abs(bestfitness(popcount-DELTA:popcount-1)-...
          bestfitness(popcount-DELTA-1:popcount-2)))<=EPSILON
       break;
   end

end  

J=avefitness(popcount-1)
trait(current_trait,1,popcount)=0.5-(0.1*sin(trait(current_trait,1,popcount))^2);
trait(current_trait,2,popcount)=0.9+0.1*sin(trait(current_trait,2,popcount));
trait(current_trait,3,popcount)=1+0.1*(sin(trait(current_trait,3,popcount)));
trait(current_trait,4,popcount)=100+(1.5*sin(trait(current_trait,4,popcount)))^2;
trait(current_trait,5,popcount)=4+0.5*(sin(trait(current_trait,5,popcount)));
params=trait(current_trait,:,popcount);


