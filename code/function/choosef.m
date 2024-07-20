function [min_direction_index,max_direction_index] = choosef(gray_image)
num0 = gray_image == 0;

% Calculate the gradient magnitude and direction of the image
[Gx, Gy] = imgradientxy(gray_image, 'sobel'); 
[~, direction] = imgradient(Gx, Gy); 

index = direction < 0;
direction(index) = 180 + direction(index);
direction(num0) = 181;
 
% Count the number of occurrences of the gradient direction
num_bins = 4; 
histogram_counts = zeros(num_bins, 1);

[height, width] = size(gray_image);
for i = 1:height
    for j = 1:width
        n = direction(i,j);
        if n >= 0 && n < 22.5
            histogram_counts(1) = histogram_counts(1) + 1;
        elseif n >= 22.5 && n < 67.5
            histogram_counts(2) = histogram_counts(2) + 1;
        elseif n >= 67.5 && n < 112.5
            histogram_counts(3) = histogram_counts(3) + 1;
        elseif n >= 112.5 && n < 157.5
            histogram_counts(4) = histogram_counts(4) + 1;
        elseif n >= 157.5 && n <= 180
            histogram_counts(1) = histogram_counts(1) + 1;
        end
    end
end
[max_count, max_direction_index] = max(histogram_counts);
[min_count, min_direction_index] = min(histogram_counts);
end

