% Tester File:
% Loads the test images to the object detector from the xml file from before.

clear all;
close all;

% Create a cascade object detector using the xml file trained earlier
detector = vision.CascadeObjectDetector('stopSignDetectorHOG.xml');

% Get the testing file names with extenion .jpg in the test images folder
Files=dir('test_image\*.jpg');


for k=1:length(Files)   
    
   % Get the kth file name from the list of file names and read the
   % associated image in
   imgName = Files(k).name;
   imgName = strcat('test_image\',imgName);
   img = imread(imgName);
   
   % Get the list of bounding boxes for the associated image from the
   % detector in the format [col idx, row idx, bbox width, bbox height]
   bbox = step(detector,img);
   
   new_bbox=[];    %the new list for the bounding boxes after the post processing
    % Add code for the post processing: Filter out the false postives
    % Color information :  use the color information to determine whether the detected bounding box is the real stop sign or not.
    %   i)Crop the image using the bounding box information, [column index, row index, width, height]. 
    % 	ii) Then, convert the RGB color system into the YCbCr color system, which is less sensitive to illumination changes. 
    %   iii)	Calculate the mean value in the Cr channel.
    %   iv)	If the mean value in the Cr channel < threshold, then remove that bounding box. 
    %    	Or If the mean value in the Cr channel > threshold, then keep that bounding box (it means the mean value in the Cr channel in the bounding box is strong in the red channel, Cr). 
    
   for bboxCtr = 1:size(bbox, 1) % Evaluates all bounding boxes
       
        
       % Crops the bounding box out from the original complete image
       newImg = img(bbox(bboxCtr, 2):(bbox(bboxCtr, 2) + bbox(bboxCtr, 4)), (bbox(bboxCtr,1):(bbox(bboxCtr, 1) + bbox(bboxCtr, 3))), :);
       
       % Convert the image to YCbCr color model
       ycbcrImg = rgb2ycbcr(newImg);
       
       % Calculates the average value of Cr (red) of the cropped converted image 
       avgImg = mean(mean(ycbcrImg(:, :, 3)));
        
       if (~(avgImg < 155)) % If the bounding box is not strongly red
           if (~(bbox(bboxCtr, 4)*bbox(bboxCtr, 3) < 1000)) % If the bounding box small
               new_bbox = [new_bbox; bbox(bboxCtr, :)]; % Adds a specific bounding box to the new list of correct bounding boxes
           end
       end
   end
    
   largest_bbox = 1;
   [numRows,numCols] = size(new_bbox);
   if (numRows > 1) % If there are multiple bboxes, remove the smaller ones
       
       for (i = 2:numRows)
           sizeOfLargest = new_bbox(largest_bbox,3)*new_bbox(largest_bbox,4);
           sizeOfNew = new_bbox(i,3)*new_bbox(i,4);
           if (sizeOfLargest < sizeOfNew) % If the size of the newly inspected bbox is larger than the previously largest, replace it
               largest_bbox = i;
           end
       end    
   end
   
   if (numRows == 0) % there are no bounding boxes in the new_bbox variable
       bbox_final = bbox(1,:);
   else
       bbox_final = new_bbox(largest_bbox,:);
   end
   

  
  % Create the bounding box for the detection and display it 
  if( ~ isempty(bbox_final) ) % if there is any detection 
     detectedImg = insertObjectAnnotation(img,'rectangle', bbox_final,'stop sign', 'Color', 'yellow','LineWidth', 4  );
     figure(k); imshow(detectedImg);
  end
  
end