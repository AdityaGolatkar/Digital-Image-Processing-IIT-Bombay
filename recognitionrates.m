function [] = recognitionrates(k)
% Ensure that this file is in the directory which contains the folders of the images
% The folders having images must be named s1 s2 ... and so on
% The images in the folder must be named 1.pgm 2.pgm ..... and so on 

% First of all we shall create the database
    [personMatrix,personDecMean,redEigvectors,eigcoeff,personMean] = databaseCreation(k);	% Create the database
    
m = 1;                                          % This will indicate the number of persons in total at the end of the loop given below
for personNo = 1: 32                            % For each of the 32 person.
	personNostr = int2str(personNo);            % Convert the integer to string.
	cd(strcat('s',personNostr));                % Change the directory to the one which contains the corresponding persons images.

%Now we have entered the directory which contains the a persons images.

	for imageNo = 7 : 10                                 % For each of the last 4 images.
		imageNostr = int2str(imageNo);                   % Convert the integer to string.
		tempimg = imread(strcat(imageNostr,'.pgm'));	 % Stores the image of a person temporarily.
		testmatrix(:,m) = tempimg(:);                    % testmatrix stores the images of all the people in column form with dimension 32*6 x 92*110.
    	m = m + 1;
	end
	cd ..;
end
m = m-1;
    
    testmatrix = double(testmatrix);
  
% We have now obtained the test image and shall now find it in the database.
for w = 1:m
    zp = testmatrix(:,w);
	zp_bar = zp - personMean;							% Compute the zp_bar for the test image in accordance with the slides pg.29
	alpha_p = (redEigvectors')*zp_bar;                  % Compute the alpha for the test image
	zp_bar_redspace = redEigvectors*alpha_p;            % Project the image on the reduced space 
    %size(zp_bar_redspace)
    mod_zpbrs(1,w) = sum(zp_bar_redspace.*zp_bar_redspace); % Square the individual elements and compute their sum.
    diff = bsxfun(@minus,eigcoeff,alpha_p);				% Diff is now a k x m.
	sq_diff = diff.*diff;								% Square diff
	ssd = sum(sq_diff,1);								% Gives a row vector of the sum of square squared differences.
	[mini i] = min(ssd);                                % Find the minimum of the ssd.
    matchedface = personMatrix(:,i);                    % Contains the matrix in vector form
    rates(1,w) = mini;
end
w=1:m;
%max(rates./mod_zpbrs)
plot(w,rates),title(strcat('Rates for k = ',int2str(k)));