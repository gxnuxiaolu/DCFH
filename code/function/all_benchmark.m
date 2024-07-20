function [min_feature,max_feature] = all_benchmark(feature_mat,min_index,max_index)


temp_map(:,:,1) = sum(feature_mat(:,:,min_index),3) / numel(min_index);
temp_map(:,:,2) = sum(feature_mat(:,:,max_index),3) / numel(max_index);


min_feature_mat = feature_mat .* temp_map(:,:,1);
max_feature_mat = feature_mat .* temp_map(:,:,2);



min_feature = gma(min_feature_mat);
max_feature = gma(max_feature_mat);
end

