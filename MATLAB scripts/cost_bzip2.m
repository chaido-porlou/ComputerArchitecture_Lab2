clear all
clc

L1 = [1 2 3];
L2 = [1 2 4 8];
a = [1 2 4 8];
cl = [1 2 4];
cpi_L1 = [1.819919 1.81322 1.745362];
cpi_L2 = [1.819919 1.775015 2.538546 1.702656];
cpi_a = [1.819919 1.792806 1.776676 1.768358];
cpi_cl = [2.008644 1.819919 1.81322];
counter = 1;
for i=1:1:3
    for j=1:1:4
        for k=1:1:4
            for t=1:1:3
                cpi(counter) = (cpi_L1(i)+cpi_L2(j)+cpi_a(k)+cpi_cl(t))/4;
                cost(counter) = 0.5*L1(i)+0.15*L2(j)+0.3*a(k)+0.05*cl(t);
                position_i(counter) = i; 
                position_j(counter) = j; 
                position_k(counter) = k; 
                position_t(counter) = t; 
                counter = counter+1;
            end
        end
    end
end


table = [cost ; cpi ; position_i ; position_j ; position_k ; position_t];

% cost
max_cost = max(cost);
min_cost = min(cost);
mean_cost = mean(cost);

% cpi
max_cpi = max(cpi);
min_cpi = min(cpi);
mean_cpi = mean(cpi);
