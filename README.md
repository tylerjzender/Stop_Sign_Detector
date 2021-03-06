# Stop Sign Detector

This project is a MATLAB script for training a cascade detector for detecting stop signs.
To do this, three sets of data were first collected. Two sets of images were of stop
signs and non stop signs. The images that featured stop signs were used in the MATLAB 
image labeler app to define regions of interest around each stop sign and then exported
to the 'newStopSign.mat' object and loaded to the MATLAB script workspace. Both of these
positive and negative sample sets were passed to an ADAboost trainer for a cascade object
detector that generates an .xml file of said detector. This detector is created with 10
stages and uses the HOG of an image to detect stop signs. 

Once trained, this detector is used with the third and final set of images used to evaluate
detecting capability. The detector generates a set of bounding boxes for each test image.
Bounding boxes are then evaluated accoring to their sizes and color intensity to determine
which bounding box is the correct bounding box of the stop sign to correct for detector error.
To do this, the image is converted to the YCbCr color model. The Cr channel of the area 
inside the bounding box is used to determine if that area of the image is 'strongly red', 
indicating a stop sign. The largest bounding box of the image is then kept while the rest are
removed.

![StopSignDetector_Output](https://user-images.githubusercontent.com/77171947/104414719-b81a5980-553e-11eb-97d1-7a865d898db7.JPG)
Figure 1: Output of the .mlx MATLAB file with determined correct bounding boxes for each test image

This project was initially completed while completing my computer engineering degree
for an elective course in computer vision. Files were initially written and ran in .mlx
but were moved to .m format for ease of viewing in github.
