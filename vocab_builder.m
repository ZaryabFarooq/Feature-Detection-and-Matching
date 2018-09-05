addpath('./provided_code/');

framesdir = './frames/';
siftdir = './sift/';
fnames = dir([siftdir '/*.mat']);

descriptors_all = [];
positions_all = [];
scales_all = [];
orients_all = [];

for i=1:500
    random = randi([1, 6612]);
    % load that random file
    fname = [siftdir '/' fnames(random).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    
    descriptors_all = cat(1, descriptors_all, descriptors);
    positions_all = cat(1, positions_all, positions);
    scales_all = cat(1, scales_all, scales);
    orients_all = cat(1, orients_all, orients);

end

[idx,kMeans,rms] = kmeansML(1500, descriptors_all.');
save('kMeans.mat');