function [min_index,max_index] = all_max_index(tongji_1,tongji_2)

[~,k] = size(tongji_1);
c = round(k / 3);
[v(1,:),index(1,:)] = sort(var(tongji_1),"descend");
[v(2,:),index(2,:)] = sort(var(tongji_2),"descend");

part_index = index(:,1:c);
part_var = v(:,1:c);
sum_var = sum(part_var,2);
avg_var = sum_var ./ c;
quarter_index(1,:) = part_var(1,:) > avg_var(1);
quarter_index(2,:) = part_var(2,:) > avg_var(2);

min_index = part_index(1,quarter_index(1,:));
max_index = part_index(2,quarter_index(2,:));
end

