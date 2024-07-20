function [x] = statistic(glc_map)

[m,n] = size(glc_map);

sum_glc_map = sum(glc_map,[1,2]);
if sum_glc_map > 0
    glc_map = glc_map ./ sum_glc_map;

    CON = 0;
    for j = 1:m
        for k = 1:n
            CON = CON + ((j - k)^2) * glc_map(j,k);
        end
    end
 
    x = CON;
else
    x = 0;
end

