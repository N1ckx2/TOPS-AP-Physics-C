%Nicholas Vadivelu
%SPH4U0
%Lab 5 - Quantum Mechanics
%Started 23 December 2016

%close all;
base_dir = 'C:\Users\nick\OneDrive\Documents\Grade 12\SPH4U0\Lab 5 - QM\Data\Single Slit';
cd(base_dir);

%Parameters related to the image(s)
wid = 3298;
hei = 110;
img_num = 1;

%list all jpgs in the folder
f_list =  dir('*jpg');
img_temp = imread(f_list(img_num).name); %read in the given image
img = zeros(1, length(img_temp(1, :, 1)));
for i = 1:length(img_temp(1, :, 1))
    img(1, i) = mean2(img_temp(:, i, :));
end

x = -1975/5184*0.175:.175/5184:(3298-1975)/5184*0.175;
x = x(1:length(img));
y = (img-min(img));

y2 = sin(pi*2 * 0.013837 * 0.0254/ 8*x/632.8/10^-9/1.211).^2./(pi*2 * 0.013837 *0.0254 / 8*x/632.8/10^-9/1.211).^2;

plot(x, y);
hold all;
plot(x, y2);
