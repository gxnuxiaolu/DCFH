function [min_feature,max_feature] = choose_all_map(feature_mat)

tongji = glcm_map(feature_mat);
tongji_min = tongji(:,1)';
tongji_max = tongji(:,2)';

min_avg = sum(tongji_min) / nnz(tongji_min); 
max_avg = sum(tongji_max) / nnz(tongji_max);

min_index = tongji_min > min_avg;
max_index = tongji_max > max_avg;

min_feature_mat = feature_mat(:,:,min_index);
max_feature_mat = feature_mat(:,:,max_index);

min_feature_map = sum(min_feature_mat,3);
max_feature_map = sum(max_feature_mat,3);

min_feature_map_mean = mean(min_feature_map);
max_feature_map_mean = mean(max_feature_map);

min_map = abs(min_feature_map - min_feature_map_mean);
max_map = abs(max_feature_map - max_feature_map_mean);

min_feature = min_map .* feature_mat;
max_feature = max_map .* feature_mat;

end

