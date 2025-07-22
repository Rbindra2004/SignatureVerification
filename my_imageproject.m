
%% loading dataset
folders = {'dataset1', 'dataset2', 'dataset3', 'dataset4'};
imds = imageDatastore(folders, "IncludeSubfolders", true, "LabelSource", "foldernames");
label_set = countEachLabel(imds);
img = readimage(imds,1);
disp(size(img));  % Just to check original size

%% shuffling data
imdsrand = shuffle(imds);

%% train-test split
[imdsTrain, imdsValidation] = splitEachLabel(imdsrand, 0.8, 'randomized');
rng(42)

%% data augmentation for training
augmenter = imageDataAugmenter( ...
    'RandRotation', [-10,10], ...
    'RandXTranslation', [-10 10], ...
    'RandYTranslation', [-10 10], ...
    'RandXScale', [0.9 1.1], ...
    'RandYScale', [0.9 1.1]);

augTrainDs = augmentedImageDatastore([83 226 3], imdsTrain, ...
    'DataAugmentation', augmenter, ...
    'ColorPreprocessing', 'gray2rgb');

augValDs = augmentedImageDatastore([83 226 3], imdsValidation, ...
    'ColorPreprocessing', 'gray2rgb');

%% network structure (with 4 conv layers + flattening)
layers = [
    imageInputLayer([83 226 3])

    convolution2dLayer(3, 16, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)

    convolution2dLayer(3, 32, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)

    convolution2dLayer(3, 64, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)

    convolution2dLayer(3, 128, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)

    flattenLayer

    fullyConnectedLayer(2)  % Binary classification
    softmaxLayer
    classificationLayer('Classes', 'auto')
];

%% training options
options = trainingOptions('adam', ...
    'MaxEpochs', 15, ...
    'MiniBatchSize', 16, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', augValDs, ...
    'ValidationFrequency', 20, ...
    'Verbose', true, ...
    'Plots', 'training-progress');

%% training
net = trainNetwork(augTrainDs, layers, options);

%% evaluation
predictedLabels = classify(net, augValDs);
actualLabels = imdsValidation.Labels;
accuracy = sum(predictedLabels == actualLabels) / numel(actualLabels);
fprintf('Validation Accuracy: %.2f%%\n', accuracy * 100);
%% Saving the model
save('mymodel.mat','net');
