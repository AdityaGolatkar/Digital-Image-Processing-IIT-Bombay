function [] = facerecognition(k)                       
% Ensure that this file is in the directory which contains the folders of the images
% The folders having images must be named s1 s2 ... and so on
% The images in the folder must be named 1.pgm 2.pgm ..... and so on 

% First of all we shall create the database
    [personMatrix,personDecMean,redEigvectors,eigcoeff,personMean] = databaseCreation(k);	% Create the database
    
% Now as the database is created we shall take a test image and then identify it.     
    cd s2;                                              % Change the directory to the one having images of the second person.
    temp = imread('8.pgm');                             % Take the corresponding image of the person
    %imshow(temp);
    zp = temp(:);                                       % Convert the image into vector format i.e. 112*92 x 1.
    zp = double(zp);                                    % Convert this to double to make it compatible with subtraction with personMean.
    cd ..;
   
% We have now obtained the test image and shall now find it in the database.

	zp_bar = zp - personMean;							% Compute the zp_bar for the test image in accordance with the slides pg.29
	alpha_p = (redEigvectors')*zp_bar;					% Compute the alpha for the test image
	diff = bsxfun(@minus,eigcoeff,alpha_p);				% Diff is now a k x m.
	sq_diff = diff.*diff;								% Square diff
	ssd = sum(sq_diff,1);								% Gives a row vector of the sum of square squared differences.
	[mini i] = min(ssd);
	matchedface = personMatrix(:,i);                    % Contains the matrix in vector form
    %size(matchedface)
	for q = 1:size(matchedface,1)/112                   % Since the number of rows is 112 we divide by 112 to get the number of columns
		t = 112*(q-1);      
		matchedperson(:,q) = matchedface(t+1:t+112);    % Convert the vector back to an array.
    end
    %matchedperson
    %imshow(temp);
	%imshow(uint8(matchedperson));
    subplot(1,2,1), imshow(temp),title('LookingForSuspectedTerrorist');
    subplot(1,2,2), imshow(uint8(matchedperson)),title('MatchFoundxxx');