clear all
clc

% Arbitrary values for L1 cost
L1 = [1 2 3];
% Arbitrary values for L2 cost
L2 = [1 2 4 8];
% Arbitrary values for associativity cost
a = [1 2 4 8];
% Arbitrary values for cache line size cost
cl = [1 2 4];
% CPI values for L1, L2, associaticity, cache line size from step 2
cpi_L1 = [5.617176 3.513687 3.509131];
cpi_L2 = [5.617176 3.520265 3.518196 3.513844];
cpi_a = [5.617176 3.498384 3.506233 3.506233];
cpi_cl = [5.617176 5.617176 2.623786];
counter = 1;
for i=1:1:3
    for j=1:1:4
        for k=1:1:4
            for t=1:1:3
                cpi(counter) = (cpi_L1(i)+cpi_L2(j)+cpi_a(k)+cpi_cl(t))/4; % CPI for every combination
                cost(counter) = 0.5*L1(i)+0.15*L2(j)+0.3*a(k)+0.05*cl(t);  % Cost for every combination
                position_i(counter) = i;  % Variables showing 
                position_j(counter) = j;  % the position of  
                position_k(counter) = k;  % parameter 
                position_t(counter) = t;  % matrices
                counter = counter+1;
            end
        end
    end
end

% Merged matrices for COST_RESULTS.xlsx
table = [cost ; cpi ; position_i ; position_j ; position_k ; position_t];
