
% Segmentation of Bluedyed thin section





he = imread('nano.jpg');

figure(1), imshow(he);

cform = makecform('srgb2lab');
lab_he = applycform(he,cform);

ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = input('nColors(Enter number of colors)=');
% repeat the clustering 3 times to avoid local minima
[cluster_idx cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',10);
                                  
pixel_labels = reshape(cluster_idx,nrows,ncols);
%figure(2),imshow(pixel_labels,[]), title('image labeled by cluster index');    
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = he;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

figure(2),imshow(segmented_images{1}), title('objects in class 1');
figure(3),imshow(segmented_images{2}), title('objects in class 2');
figure(4),imshow(segmented_images{3}), title('objects in class 3');

%% Porosity Detection

if nColors==3

% Porosity Detection ---- Class 1

S1=rgb2gray(segmented_images{1});
%figure(5),imshow(S1);
level1 = graythresh(S1);
bw1 = im2bw(S1,level1);


graindata1 = regionprops(bw1, 'all');

[C1 B]=size(graindata1);
[V1 Y1]=size(bw1);


Area1=zeros(1,0);

for c=1:C1
    
YY1=graindata1(c,1).Area;
Area1        =   [Area1 YY1];

end

[V1 Y1]=size(bw1);
totalporosity1=100*sum(Area1)/(V1*Y1)

 %Porosity Detection ---- Class 2
 
S2=rgb2gray(segmented_images{2});
%figure(6),imshow(S2);
level2 = graythresh(S2);
bw2 = im2bw(S2,level2);


graindata2 = regionprops(bw2, 'all');

[C2 B2]=size(graindata2);
[V2 Y2]=size(bw2);


Area2=zeros(1,0);

for c=1:C2
    
YY2=graindata2(c,1).Area;
Area2        =   [Area2 YY2];

end

[V2 Y2]=size(bw2);
totalporosity2=100*sum(Area2)/(V2*Y2)

%Porosity Detection ---- Class 3

S3=rgb2gray(segmented_images{3});
%figure(6),imshow(S3);
level3 = graythresh(S3);
bw3 = im2bw(S3,level3);


graindata3 = regionprops(bw3, 'all');

[C3 B3]=size(graindata3);
[V3 Y3]=size(bw3);


Area3=zeros(1,0);

for c=1:C3
    
YY3=graindata3(c,1).Area;
Area3        =   [Area3 YY3];

end

[V3 Y3]=size(bw3);
totalporosity3=100*sum(Area3)/(V3*Y3)

elseif nColors==2
    
% Porosity Detection ---- Class 1

S1=rgb2gray(segmented_images{1});
%figure(5),imshow(S1);
level1 = graythresh(S1);
bw1 = im2bw(S1,level1);


graindata1 = regionprops(bw1, 'all');

[C1 B]=size(graindata1);
[V1 Y1]=size(bw1);


Area1=zeros(1,0);

for c=1:C1
    
YY1=graindata1(c,1).Area;
Area1        =   [Area1 YY1];

end

[V1 Y1]=size(bw1);
totalporosity1=100*sum(Area1)/(V1*Y1)

 %Porosity Detection ---- Class 2
 
S2=rgb2gray(segmented_images{2});
%figure(6),imshow(S2);
level2 = graythresh(S2);
bw2 = im2bw(S2,level2);


graindata2 = regionprops(bw2, 'all');

[C2 B2]=size(graindata2);
[V2 Y2]=size(bw2);


Area2=zeros(1,0);

for c=1:C2
    
YY2=graindata2(c,1).Area;
Area2        =   [Area2 YY2];

end

[V2 Y2]=size(bw2);
totalporosity2=100*sum(Area2)/(V2*Y2)


end