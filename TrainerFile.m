% Trainer File:
% Trains the detector using positive and negative samples with the trainCascadeObjectDetector()
% method to create a ADAboost detector in an xml file to be evaluated later.

clear all;
close all;

% Opens the labeled samples file
load("newStopSign.mat")

% Get filenames for positive samples
imageFilename=gTruth.DataSource.Source

% Get stop sign locations
stopSign = gTruth.LabelData.StopSign

% Create a table for the positive samples to train the classifier
PositiveSample=table(imageFilename, stopSign); 

% Folder name for the negative samples 
negativeFolder = 'nonStopSigns';

% Use ADAboost training with the positive and negative samples to create a 
% 10-stage cascade object detector for stop signs to be saved in xml format.
% Uses a false alarm rate of .33 for each layer
trainCascadeObjectDetector('stopSignDetectorHOG.xml',PositiveSample, ...
   negativeFolder,'FalseAlarmRate',0.33,'NumCascadeStages',10, 'FeatureType', 'HOG' );