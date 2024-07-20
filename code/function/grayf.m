function [min_direction,max_direction] = grayf(feature_mat,index_vector)

[~,~,k] = size(feature_mat);
min_count = zeros(1,4);
max_count = zeros(1,4);

for i = 1:k
    if index_vector(i)
        [minf,maxf] = choosef(feature_mat(:,:,i));
        switch maxf
            case 1
                max_count(1) = max_count(1) + 1;
            case 2
                max_count(2) = max_count(2) + 1;
            case 3
                max_count(3) = max_count(3) + 1;
            case 4
                max_count(4) = max_count(4) + 1;
        end
        switch minf
            case 1
                min_count(1) = min_count(1) + 1;
            case 2
                min_count(2) = min_count(2) + 1;
            case 3
                min_count(3) = min_count(3) + 1;
            case 4
                min_count(4) = min_count(4) + 1;
        end
    end
end
[~, max_direction_index] = max(max_count);
[~, min_direction_index] = min(max_count);

switch max_direction_index
    case 1
        max_direction = [0 1];
    case 2
        max_direction = [-1 1];
    case 3
        max_direction = [-1 0];
    case 4
        max_direction = [-1 -1];
end
switch min_direction_index
    case 1
        min_direction = [0 1];
    case 2
        min_direction = [-1 1];
    case 3
        min_direction = [-1 0];
    case 4
        min_direction = [-1 -1];
end
end

