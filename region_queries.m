addpath('./provided_code/');

framesdir = './frames/';
siftdir = './sift/';
fnames = dir([siftdir '/*.mat']);
load('allHist.mat');

for i=1:4
    randomImage = randi([1, 6612]);
    
    % load that random file
    fname = [siftdir '/' fnames(randomImage).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);
    
    figure([i]);
    [oninds] = selectRegion(im, positions);

    % selecting descriptors from the selected region
    selectDes = [];
    selectDes(:,:) = descriptors(oninds(:),:);
    
    distance = dist2(selectDes , kMeans);
    [value, index] = min(distance');
%   index has columns = descriptors size and contains each k value
     
    [new_hist, ~] = histc(index, [1:1500]);
    
    % go through each picutre in the data
    for k=1:6612
            top = 0;
            total_data = 0;
            total_query = 0;
            
        for j=1:1500           
            top = ((new_hist(1, j) * (imageHist(k, j))) +  top);
            total_query = total_query + (new_hist(1, j)^2);
            total_data = total_data + (imageHist(k, j)^2);
        
        end
        bottom = ( sqrt(total_data) * sqrt(total_query));
        sim(k,1) = top / bottom;        % ranking frames by normalized vector
    end
    
    [maxValues, imageNum] = maxk(sim(:), 5);
    
    % show the similar images
    
    subplot(2,3, 1);
    imshow(im);
    title('Query');
    for i=1:5
        fname = [siftdir '/' fnames(imageNum(i)).name];
        load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
        imname = [framesdir '/' imname]; % add the full path
        im = imread(imname);
        subplot(2,3, i+1);
        
        imshow(im);
        title(sprintf('Rank: %d', i))
    end
    
end
