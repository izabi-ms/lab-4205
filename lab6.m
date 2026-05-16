clc; clear; close all;
% Data
d = imageDatastore('C:\Users\new\Desktop\8th semester\ICE-4205\Lab\Lab Test\Dataset', ...
    'IncludeSubfolders',1,'LabelSource','foldernames');
d.ReadFcn = @(x)imresize(imread(x),[64 64]);
% CNN
net = trainNetwork(d, [
    imageInputLayer([64 64 3])
    convolution2dLayer(3,8)
    reluLayer
    fullyConnectedLayer(3)
    softmaxLayer
    classificationLayer], ...
    trainingOptions('adam','MaxEpochs',20));
% Test + Result
I = imresize(imread('C:\Users\new\Desktop\8th semester\ICE-4205\Lab\Lab Test\img2.jpg'),[64 64]);
imshow(I); title(char(classify(net,I)));