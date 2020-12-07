clear all
clc

L1 = [1 2 3];
L2 = [1 2 4 8];
a = [1 2 4 8];
cl = [1 2 4];
cpi_L1 = [1.156702 1.132986 1.153847];
cpi_L2 = [1.156702 1.153442 1.149695 1.149332];
cpi_a = [1.156702 1.15333 1.152864 1.152759];
cpi_cl = [1.177057 1.156702 1.132986];
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


