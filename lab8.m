% Load and preprocess the flower dataset
imds = imageDatastore('C:\Users\new\Desktop\8th semester\ICE-4205\Lab\Lab Test\Dataset', ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

% Resize images to 224x224 (ResNet-50 input size)
imds.ReadFcn = @(loc) imresize(imread(loc), [224 224]);

% Split data (optional but recommended)
[imdsTrain, imdsVal] = splitEachLabel(imds, 0.8, 'randomized');

% Load pretrained ResNet-50
net = resnet50;

% Modify the network for transfer learning
numClasses = 5;
lgraph = layerGraph(net);

% Replace final layers
newLayers = [
    fullyConnectedLayer(numClasses, 'Name', 'fc_new', ...
        'WeightLearnRateFactor', 10, 'BiasLearnRateFactor', 10)
    softmaxLayer('Name', 'softmax')
    classificationLayer('Name', 'classoutput')
];

% Remove original FC and classification layers, add new ones
lgraph = removeLayers(lgraph, {'fc1000', 'fc1000_softmax', 'ClassificationLayer_fc1000'});
lgraph = addLayers(lgraph, newLayers);
lgraph = connectLayers(lgraph, 'avg_pool', 'fc_new');

% Training options (Adam optimizer, low learning rate like your 1e-5)
options = trainingOptions('adam', ...
    'InitialLearnRate', 1e-5, ...
    'MaxEpochs', 3, ...
    'MiniBatchSize', 32, ...
    'ValidationData', imdsVal, ...
    'Verbose', true, ...
    'Plots', 'training-progress');

% Train the model
model = trainNetwork(imdsTrain, lgraph, options);