addpath('./provided_code/');

framesdir = './frames/';
siftdir = './sift/';
fnames = dir([siftdir '/*.mat']);

load('allHist.mat');

for i=1:3
    randomImage = randi([1, 6612]);
    % load that random file
    fname = [siftdir '/' fnames(5).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);
    
    sim = zeros([6612, 1]);
    
    % go through each picutre in the data
    for k=1:6612
            top = 0;
            total_data = 0;
            total_query = 0;
            
        for j=1:1500           
            top = ((imageHist(5, j) * (imageHist(k, j))) +  top);
            total_query = total_query + (imageHist(5, j)^2);
            total_data = total_data + (imageHist(k, j)^2);
        
        end
        bottom = ( sqrt(total_data) * sqrt(total_query));
        sim(k,1) = top / bottom;        % ranking frames by normalized vector
    end
    
    [maxValues, imageNum] = maxk(sim(:), 6);
    
    % show the similar images
    figure();
    subplot(2,3, 1);
    imshow(im);
    title('Query');
    
    for i=2:6
        fname = [siftdir '/' fnames(imageNum(i)).name];
        load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
        imname = [framesdir '/' imname]; % add the full path
        im = imread(imname);
        
        subplot(2,3, i);
        imshow(im);
        title(sprintf('Rank: %d', i-1))
    end

end