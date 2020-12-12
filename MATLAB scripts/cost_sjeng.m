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
cpi_L1 = [6.810651 10.281112 10.280373];
cpi_L2 = [6.810651 10.280283 10.27544 10.270446];
cpi_a = [6.810651 10.280395 10.280002 10.279446];
cpi_cl = [17.649814 10.28132 6.810651];
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
