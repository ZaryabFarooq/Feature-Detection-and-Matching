% Kiranpreet Kaur
% Zaryab Farooq
% ECS 174
% PS_3

% Load the data file
addpath('./provided_code/');
load('twoFrameData.mat');

% display the first image
imshow(im1);    

% get the selected region
[oninds] = selectRegion(im1, positions1);

% selecting descriptors from the selected region
selectDes = [];
selectDes(:,:) = descriptors1(oninds(:),:);

% show the 2nd image
imshow(im2);

% now we find the distances between the features
minIndexes = [];
minValues = [];
for k=1:size(selectDes)
    distance = dist2(selectDes(k,:), descriptors2);
    [I,J] = min(distance);
    minValues(k) = I;
    minIndexes(k) = J;
end

% select a top 30% of minimum distances to display
keepIndexes = minIndexes(minValues(:) < 0.3);

% display the matched descriptors on the second image
displaySIFTPatches(positions2(keepIndexes,:), scales2(keepIndexes), orients2(keepIndexes), im2);