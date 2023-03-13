%Read in image
%CHANGE THIS LINE IF USING MAC
I = imread(uigetfile("C:"));

%adaptive contrast enhancement
I2 = adapthisteq(I, "NBins", 65536);

%guassian filter, noise reduction
I2 = imgaussfilt(I2, 2);

% ScI = I - min(I, [], 'all');
% ScI = I.*(65536/max(I,[],'all'));

%morphological structure
disk = strel("disk", 10);

%morphological operations for highlighting cells
Ie = imerode(I2, disk);
Ier = imreconstruct(Ie, I2);
Ierd = imdilate(Ier, disk);
Ierdr = imreconstruct(imcomplement(Ierd),imcomplement(Ier));
Ierdr = imcomplement(Ierdr);

%finding regional maximums for watershed markers
A = imregionalmax(Ierdr);

%B = arrayfun(@(x) f(x, threshold), A);

%reverse distance transform
B = bwdist(logical(A));

%watershed transform
C = watershed(B);

imagesc(C);