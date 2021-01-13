# Stop_Sign_Detector

This project is a MATLAB script for training a cascade detector for detecting stop signs.
To do this, three sets of data were first collected. Two sets of images were of stop
signs and non stop signs. The images that featured stop signs were used in the MATLAB 
image labeler app to define regions of interest around each stop sign and then exported
to the 'newStopSign.mat' object and loaded to the MATLAB script workspace. Both of these
positive and negative sample sets were passed to an ADAboost trainer for a cascade object
detector that generates an .xml file of said detector. This 

