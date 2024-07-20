%% example code
clear
addpath('function');
cnn_set = {'matlab_vgg16';'matlab_alexnet';'matlab_resnet50'};
cnn = cnn_set{1};
image_set = {'Oxford5k';'Paris6k';'Oxford105k';'Paris106k';'Holidays';...
    'roxford5k';'rparis6k';};
temp_set = image_set{1};

%The gnd file should correspond to the dataset%
%Oxford105k: gnd_oxford5k.mat,Paris106k: gnd_paris6k.mat%
% load(['..\datasets\',temp_set,'\gnd_paris6k.mat']);
% load(['..\datasets\',temp_set,'\gh_holidays.mat']);
load(['..\datasets\',temp_set,'\gnd_oxford5k.mat']);

if strcmp(temp_set,'Oxford105k')
    pool51 = dir(['..\datasets\',cnn,'\Oxford5k\pool5\*.mat']);
    pool52 = dir(['..\datasets\',cnn,'\data100k\pool5\*.mat']);
    pool5 = [pool51;pool52];
    qpool5 = dir(['..\datasets\',cnn,'\Oxford5k\crop_query\*.mat']);
    namelist = arrayfun(@(x) x.name, pool5, 'UniformOutput', false);
    qnamelist = arrayfun(@(x) x.name, qpool5, 'UniformOutput', false);
elseif strcmp(temp_set,'Paris106k')
    pool51 = dir(['..\datasets\',cnn,'\Paris6k\pool5\*.mat']);
    pool52 = dir(['..\datasets\',cnn,'\data100k\pool5\*.mat']);
    pool5 = [pool51;pool52];
    qpool5 = dir(['..\datasets\',cnn,'\Paris6k\crop_query\*.mat']);
    namelist = arrayfun(@(x) x.name, pool5, 'UniformOutput', false);
    qnamelist = arrayfun(@(x) x.name, qpool5, 'UniformOutput', false);
elseif strcmp(temp_set,'roxford5k') || strcmp(temp_set,'rparis6k')
    temp_set2 = temp_set(3:end);
    first = upper(temp_set(2));
    temp_set2 = [first,temp_set2];
    pool5 = dir(['..\datasets\',cnn,'\',temp_set2,'\pool5\*.mat']);
    qpool5 = dir(['..\datasets\',cnn,'\',temp_set,'\crop_query\*.mat']);
    namelist = imlist;
    namelist = cellfun(@(x) [x, '.mat'], namelist, 'UniformOutput', false);
    qnamelist = qimlist;
    qnamelist = cellfun(@(x) [x, '.mat'], qnamelist, 'UniformOutput', false);
else
    pool5 = dir(['..\datasets\',cnn,'\',temp_set,'\pool5\*.mat']);
    qpool5 = dir(['..\datasets\',cnn,'\',temp_set,'\crop_query\*.mat']);
    namelist = arrayfun(@(x) x.name, pool5, 'UniformOutput', false);
    qnamelist = arrayfun(@(x) x.name, qpool5, 'UniformOutput', false);
end
clear pool51 pool52;

%%compute image feature vectors
num = numel(namelist);
pfeature = [];
nfeature = [];
parfor i=1:num
    fe_path = [pool5(i).folder,'\',namelist{i}];
    feature_mat = importdata(fe_path);
    [min_feature,max_feature] = choose_all_map(feature_mat);
    tongji_1(i,:) = permute(sum(min_feature,[1,2]),[1,3,2]);
    tongji_2(i,:) = permute(sum(max_feature,[1,2]),[1,3,2]);
end
[min_index,max_index] = all_max_index(tongji_1,tongji_2);
parfor i=1:num
    fe_path = [pool5(i).folder,'\',namelist{i}];
    feature_mat = importdata(fe_path);
    [min_feature_vector,max_feature_vector] = all_benchmark(feature_mat,min_index,max_index);
    pfeature(i,:) = max_feature_vector;
    nfeature(i,:) = min_feature_vector;
end

%%compute crop_query image feature vectors
if strcmp(temp_set,'Holidays')
    d = cell2mat(query_list(:,2,:));
    query_feature = pfeature(d,:);
else
    num = numel(qnamelist);
    query_feature = [];
    parfor i = 1:num
        fe_path = [qpool5(i).folder,'\',qnamelist{i}];
        feature_mat = importdata(fe_path);
        [~,max_feature_vector] = all_benchmark(feature_mat,min_index,max_index);
        query_feature(i,:) = max_feature_vector;
    end
end

%%compute mAP (Execute PCA_Whitening first )
mAP = zeros(1,3);
dim = [64,128,256,512];
fprintf('------------------------------------\n');

for i = 1:size(dim,2)
    [feature,qfeature] = mpw(pfeature,nfeature,query_feature,dim(i));
    mAP(i) = compute(feature,qfeature,temp_set);
    fprintf('dim = %d  mAP = %.4f\n',dim(i),mAP(i));
end

rmpath('function');

