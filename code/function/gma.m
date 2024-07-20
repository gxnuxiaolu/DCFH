function [feature_vector] = gma(feature_mat)

feature_mat_mean = mean(mean(feature_mat));
feature_mat = abs(feature_mat - feature_mat_mean);


feature_vector = permute(sum(feature_mat,[1 2]),[1,3,2]);




end

