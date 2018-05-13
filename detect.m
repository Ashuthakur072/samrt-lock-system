
for im = 1:10
C = webcamlist;
cam=webcam(C{1});
preview(cam);
NotYet = false;
faceDetector = vision.CascadeObjectDetector;
while ~NotYet
pause(2);
I = snapshot(cam);
disp('took a snapshot. checking to find a face ....')
bboxes = step(faceDetector, I);
if ~isempty(bboxes)
NotYet = true;
disp('face found!');
break;
end
disp('no face detected :(, repeating...');
end
closePreview(cam);
clear('cam');
IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
% figure, imshow(IFaces), title('Detected faces');
g = imcrop(I, bboxes);
img = strcat(int2str(im),'.jpg');

% f = strcat(path,img);
imwrite(g,img)
end