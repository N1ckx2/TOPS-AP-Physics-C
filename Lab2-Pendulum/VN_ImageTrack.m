%Nicholas Vadivelu
%SPH4U0
%Lab 2 - Pendulum 
%Complete 30 October 16

clear all;
close all;
base_dir = 'C:\Users\nick\OneDrive\Documents\Grade 12\SPH4U0\Lab 2 - Pendulum\Run Videos\28 Oct\L7 2';
cd(base_dir);

%Parameters related to the image sequence
wid = 1100;
hei = 550;
thre = -20;
numBlank = 65;

%list all jpgs in the folder
f_list =  dir('*jpg');


% make average of blank frames
N = numBlank; %number of blank frames
img = zeros(hei,wid,N);
for i = 1:N    
    img_tmp = imread(f_list(i).name); %read in the given image
    img(:,:,i) = img_tmp(:,:,1); 
end
bck_img = (mean(img,3)); %take the average across the image stack..and bingo! there's your background template!
clear img; % free up memory.

%initialize gaussian filter to smooth image
hsize = 4;
sigma = 10;
gaus_filt = fspecial('gaussian',hsize , sigma);

%marker that shows up on the graph to track the object
SE = strel('diamond', 7);


%find the object
CM_idx = zeros(length(f_list),2); %this variable stores the position

for i = 1:length(f_list)
    img_tmp = double(imread(f_list(i).name));
    img = img_tmp(:,:,1); %reduce to just the first dimension (no rbg)
    
    %subtract background from the image
    sub_img = (img - bck_img);
    
    %gaussian blurr the image
    gaus_img = filter2(gaus_filt,sub_img,'same');     
    
    thres_img = (gaus_img < thre);
    
    %Tracking object
    %averages the x and y positions of object to get centre of mass
    %(uniform density). If nothing is found, enter point 1 1
    [x,y] = find (thres_img);    
    if ~isempty(x)
        CM_idx(i,:) = ceil([mean(x) mean(y)]+1); % i used ceiling to avoid zero indices, but it makes the system SLIGHTLY biased, meh, no biggie, not the point here :).
    else
        CM_idx(i,:) = ceil([1 1]);
    end
   
    bug_img = zeros(size(thres_img)); 
    bug_img(CM_idx(i,1),CM_idx(i,2)) = 1;

    bug_img = imdilate(bug_img, SE);
    
    if i < 500 %stops showing the footage after 500 frames to save memory
        plot(224);imagesc(thres_img + bug_img);
        title(strcat('thresholde ', num2str(i), ' of ', num2str(length(f_list))));
        axesHandles = get(gcf,'children');
        set(axesHandles, 'XTickLabel', [], 'XTick', []);
        set(axesHandles, 'YTickLabel', [], 'YTick', [])  ;    
        pause(.01)
    end
    
    if (mod(i, 50) == 0) %shows which frame the program is currently processing.
        disp(i);
    end
end

plot(CM_idx(i,1),CM_idx(i,2));