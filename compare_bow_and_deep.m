% Kiranpreet Kaur
% Zaryab Farooq
% ECS 174
% PS_3

addpath('./provided_code/');

framesdir = './frames/';
siftdir = './sift/';
fnames = dir([siftdir '/*.mat']);

fname = [siftdir 'friends_0000004503.jpeg.mat'];
load(fname, 'imname', 'deepFC7');
deepFC7_query = deepFC7;
imname = [framesdir '/' imname]; % add the full path
im = imread(imname);

load('allHists.mat');

% using AlexNet   
    sim = zeros([6612, 1]);
    
    % go through each picutre in the data
    for k=1:6612
            top = 0;
            total_data = 0;
            total_query = 0;
            
            % load that random file
            fname = [siftdir '/' fnames(k).name];
            load(fname, 'deepFC7');
            
            deepFC72_data = deepFC7;
            
        for j=1:1500           
            top = ((deepFC7_query(1, j) * (deepFC72_data(1, j))) +  top);
            total_query = total_query + (deepFC7_query(1, j)^2);
            total_data = total_data + (deepFC72_data(1, j)^2);
        
        end
        bottom = (sqrt(total_data) * sqrt(total_query));
        sim(k,1) = top / bottom;        % ranking frames by normalized vector
    end
    
    [maxValues, imageNum] = maxk(sim(:), 10);
    
    % show the similar images
    figure();
    title('AlexNet');
    for i=1:10
        fname = [siftdir '/' fnames(imageNum(i)).name];
        load(fname);
        imname = [framesdir '/' imname]; % add the full path
        im = imread(imname);
        
        subplot(4,3, i);
        imshow(im);
    end
    
    
% ======================using BagOfWords ==========================
    sim = zeros([6612, 1]);
    
    % go through each picutre in the data
    for k=1:6612
            top = 0;
            total_data = 0;
            total_query = 0;
            
        for j=1:1500           
            top = ((imageHist(4503-59, j) * (imageHist(k, j))) +  top);
            total_query = total_query + (imageHist(4503-59, j)^2);
            total_data = total_data + (imageHist(k, j)^2);
        
        end
        bottom = (sqrt(total_data) * sqrt(total_query));
        sim(k,1) = top / bottom;        % ranking frames by normalized vector
    end
    
    [maxValues, imageNum] = maxk(sim(:), 10);
    
    % show the similar images
    figure();
    title('Using Bag Of Words');
    for i=1:10
        fname = [siftdir '/' fnames(imageNum(i)).name];
        load(fname);
        imname = [framesdir '/' imname]; % add the full path
        im = imread(imname);
        
        subplot(4,3, i);
        imshow(im);
    end
    
    
% =====================================================================
% ===================== 2nd picture ===================================   
fname = [siftdir 'friends_0000000394.jpeg.mat'];
load(fname, 'imname', 'deepFC7');
deepFC7_query = deepFC7;
imname = [framesdir '/' imname]; % add the full path
im = imread(imname);

load('allHists.mat');

% using AlexNet   
    sim = zeros([6612, 1]);
    
    % go through each picutre in the data
    for k=1:6612
            top = 0;
            total_data = 0;
            total_query = 0;
            
            % load that random file
            fname = [siftdir '/' fnames(k).name];
            load(fname, 'deepFC7');
            
            deepFC72_data = deepFC7;
            
        for j=1:1500           
            top = ((deepFC7_query(1, j) * (deepFC72_data(1, j))) +  top);
            total_query = total_query + (deepFC7_query(1, j)^2);
            total_data = total_data + (deepFC72_data(1, j)^2);
        
        end
        bottom = (sqrt(total_data) * sqrt(total_query));
        sim(k,1) = top / bottom;        % ranking frames by normalized vector
    end
    
    [maxValues, imageNum] = maxk(sim(:), 10);
    
    % show the similar images
    figure();
    title('AlexNet');
    for i=1:10
        fname = [siftdir '/' fnames(imageNum(i)).name];
        load(fname);
        imname = [framesdir '/' imname]; % add the full path
        im = imread(imname);
        
        subplot(4,3, i);
        imshow(im);
    end
    
% ======================using BagOfWords ==========================
    sim = zeros([6612, 1]);
    
    % go through each picutre in the data
    for k=1:6612
            top = 0;
            total_data = 0;
            total_query = 0;
            
            % load that random file
            fname = [siftdir '/' fnames(k).name];
            load(fname, 'deepFC7');
            
            deepFC72_data = deepFC7;
            
        for j=1:1500           
            top = ((imageHist(394-59, j) * (imageHist(k, j))) +  top);
            total_query = total_query + (imageHist(394-59, j)^2);
            total_data = total_data + (imageHist(k, j)^2);
        
        end
        bottom = (sqrt(total_data) * sqrt(total_query));
        sim(k,1) = top / bottom;        % ranking frames by normalized vector
    end
    
    [maxValues, imageNum] = maxk(sim(:), 10);
    
    % show the similar images
    figure();
    title('Using Bag Of Words');
    for i=1:10
        fname = [siftdir '/' fnames(imageNum(i)).name];
        load(fname);
        imname = [framesdir '/' imname]; % add the full path
        im = imread(imname);
        
        subplot(4,3, i);
        imshow(im);
    end