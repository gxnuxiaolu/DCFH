function [x] = glcm_map(feature_mat)

% [0 1;-1 1;-1 0;-1 -1]
%                    0         [0 D]   
%                    45        [-D D]
%                    90        [-D 0]
%                    135       [-D -D] 
[~,~,k] = size(feature_mat);
feature_vector = permute(sum(feature_mat,[1,2]),[1,3,2]);
feature_avg = sum(feature_vector) / k;
index_vector = feature_vector > feature_avg; 

num = size(index_vector,2);
x1 = zeros(k,1);
x2 = zeros(k,1);

[mind,maxd] = grayf(feature_mat,index_vector);

for i = 1:num
    if index_vector(i)
        glcm = graycomatrix(feature_mat(:,:,i),'NumLevels',8,'Offset',[mind;maxd],'GrayLimits',[]);
        x1(i) = statistic(glcm(:,:,1));
        x2(i) = statistic(glcm(:,:,2));
    else
        x1(i) = 0;
        x2(i) = 0;
    end
    x = [x1,x2];
end
end

