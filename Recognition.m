function [output] = Recognition(TestImage, m, A, Eigenfaces)
% Recognizing step....
%
% Description: This function compares two faces by projecting the images into facespace and 
% measuring the Euclidean distance between them.
%
% Argument:      TestImage              - Path of the input test image
%
%                m                      - (M*Nx1) Mean of the training
%                                         database, which is output of 'EigenfaceCore' function.
%
%                Eigenfaces             - (M*Nx(P-1)) Eigen vectors of the
%                                         covariance matrix of the training
%                                         database, which is output of 'EigenfaceCore' function.
%
%                A                      - (M*NxP) Matrix of centered image
%                                         vectors, which is output of 'EigenfaceCore' function.
% 
% Returns:       OutputName             - Name of the recognized image in the training database.
%
% See also: RESHAPE, STRCAT
                  
%%%%%%%%%%%%%%%%%%%%%%%% Projecting centered image vectors into facespace
% All centered images are projected into facespace by multiplying in
% Eigenface basis's. Projected vector of each face will be its corresponding
% feature vector.

ProjectedImages = [];
Train_Number = size(Eigenfaces,2);
for i = 1 : Train_Number
    temp = Eigenfaces'*A(:,i); % Projection of centered images into facespace
    ProjectedImages = [ProjectedImages temp]; 
end

%%%%%%%%%%%%%%%%%%%%%%%% Extracting the PCA features from test image
InputImage = TestImage;
imshow(TestImage);

InputImage = imresize(InputImage, [60 60]);
InputImage = rgb2gray(InputImage);
%imread('C:\Users\tashi\Documents\MATLAB\Face-Recognition-master\TestDatabase\10.jpg');
temp = InputImage(:,:,1);

[irow, icol] = size(temp);
InImage = reshape(temp',irow*icol,1);
Difference = double(InImage)-m; % Centered test image
ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector

%%%%%%%%%%%%%%%%%%%%%%%% Calculating Euclidean distances 
% Euclidean distances between the projected test image and the projection
% of all centered training images are calculated. Test image is
% supposed to have minimum distance with its corresponding image in the
% training database.

Euc_dist = [];
for i = 1 : Train_Number
    q = ProjectedImages(:,i);
    temp = ( norm( ProjectedTestImage - q ) )^2;
    Euc_dist = [Euc_dist temp];
end

[Euc_dist_min , Recognized_index] = min(Euc_dist);
Euc_dist_min
if Euc_dist_min < 3621287600000
OutputName = strcat(int2str(Recognized_index),'.jpg');

x = 1;
 msgbox('Authorized Person')
% port at which your arduino is connected
clear all port;
port = 'COM3';

% model of your arduino board

board = 'Uno';

% creating arduino object with servo library

arduino_board = arduino(port, board, 'Libraries', 'Servo');

% creating servo motor object

servo_motor = servo(arduino_board, 'D8');

% loop to rotate servo motor from 0 to 180

for angle = 0:0.2:1

   writePosition(servo_motor, angle);

   current_position = readPosition(servo_motor);

   current_position = current_position * 180;   

   % print current position of servo motor

   fprintf('Current position is %d\n', current_position);   

   % small delay is required so that servo can be positioned at the

   % angle told to it.

   pause(10);

end

% bring back motor to 0 angle position

writePosition(servo_motor, 0);




else
    clc
    x = 0;
     msgbox('Unauthorized Person')
    
end
output = x;