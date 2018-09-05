% Kiranpreet Kaur
% Zaryab Farooq
% ECS 174
% PS_3

% Load the data file
addpath('./provided_code/');

framesdir = './frames/';
siftdir = './sift/';
fnames = dir([siftdir '/*.mat']);

load('kMeans.mat')

descriptors_all = [];
for i=1:500    
    random = randi([1, 6612]);
    % load that random file
    fname = [siftdir '/' fnames(random).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    
    descriptors_all = cat(1, descriptors_all, descriptors);

end

% get first and the last descriptor from descriptor_all
random = randi([1, size(membership, 1)]);
first_desc = kMeans(membership(random), :);
random = randi([1, size(membership, 1)]);
second_desc = kMeans(membership(random), :);

% for first descriptor
% read in twenty-five images.
for i=1:25
    random = randi([1, 6612]);
    fname = [siftdir '/' fnames(random).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);
    
    % get minimum descriptor
    distance = dist2(first_desc , descriptors);
    [value, index] = min(distance');

    [patch] = getPatchFromSIFTParameters(positions(index, :), scales(index), orients(index), rgb2gray(im));
    
    figure(1);
    subplot(5,5,i);
    imshow(patch);
end

% for second descriptor
% read in twenty-five images.
for i=1:25
    random = randi([1, 6612]);
    fname = [siftdir '/' fnames(random).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);
    
    % get minimum descriptor
    distance = dist2(first_desc , descriptors);
    [value, index] = min(distance);

    [patch] = getPatchFromSIFTParameters(positions(index, :), scales(index), orients(index), rgb2gray(im));
    
    figure(2);
    subplot(5,5,i);
    imshow(patch);
end

