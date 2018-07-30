%function [] = facedetection(zp,k)   		% Here zp is the column vector for the image.
%	[personMatrix,personDecMean,redEigvectors,eigcoeff,personMean] = databasecreation(k);	% Create the database
%	zp_bar = zp - personMean;							% Compute the zp_bar for the test image in accordance with the slides pg.29
%	alpha_p = (redEigvectors')*zp_bar;						% Compute the alpha for the test image
%	diff = bsxfun(@minus,eigcoeff,alpha_p);						% Diff is now a k x m.
%	sq_diff = diff.*diff;								% Square diff
%	ssd = sum(sq_diff,1);								% Gives a row vector of the sum of square squared differences.
%	[m i] = min(ssd);
%	matchedface = personMatrix(:,i);
%	for q = 1:size(matchedface,1)/112
%		t = 112*(q-1);
%		matchedperson(:,q) = matchedface(t+1:t+112);
%	end
%	imshow(matchedperson);
		
	

%function [personMatrix,personDecMean,redEigvectors,eigcoeff,personMean] = databasecreation(k)
function [] = facedetection(k)
%Make sure that you are in the directory which contains the folders for each person.
%Make sure that the folder for each person is named s1,s2...... and each person has images named 1.pgm ... and so on.
%First we shall take multiple images of each person and compute the eigenspace for each person.
%We will take images of first 32 people.
personNo = 1;					% This will go until 32.
m = 1;						% This will indicate the number of persons in total at the end of the loop given below
for personNo <= 32				% For each of the 32 person.
	personNostr = int2str(personNo);	% Convert the integer to string.
	cd(strcat('s',personNostr));		% Change the directory to the one which contains the corresponding persons images.

%So now we have entered the directory which contains the a persons images.

	imageNo = 1;
	for imageNo <= 6					% For each of the 6 images.
		imageNostr = int2str(imageNo);
		tempimg = imread(strcat(imageNostr,'.pgm'));	% Stores the image of a person temporarily.
		personMatrix(m,:) = tempimg(:);			% personMatrix stores the images of all the people in column form with dimension 32*6 x 92*110.
		imageNo = imageNo + 1;
		m = m + 1;
	end
	cd ..;
personNo = personNo + 1;
end
	
	personMean = mean(personMatrix,2);			% This stores the mean vector for all person.
	personDecMean = bsxfun(@minus,personMatrix,personMean);	% This is a ((92*110) cross m) dimensional matrix which stores the person deducted mean for all people.(Captial X matrix in slides)
	L_matrix = (personDecMean')*personDecMean;		% This is the L matrix on pg 39 of slides.It is m x m.
	[eigv eigvector] = eig(L_matrix);			% We get the eigen vectors of the L matrix.
	personEigvectors = personDecMean*eigvector; 		% This is the V matrix in the slides.
	personEigvectors = normc(personEigvectors);		% Normalize the columns of the eigen vectors. This matrix will at max have m eigenvalues.

% Eigen values of personEigvectors matrix and L_matrix are the same.So we just need to find the k max out of them.
        eigv = sum(eigv,1);					% eigv is a diagonal matrix so by doing sum along the columns we get the eigen values in a row matrix.Dimension will be 1 x m.
	sorted = sort(eigv,'descend');
		
	for i = 1:k
		pos = find(eigv == sorted(i));			% Find the position of the eigen value in the eigv matrix and then include the corresponding eigenvector in reduced eigen space
		redEigvectors(:,i) = personEigvectors(:,pos);	% It is a 92*110 x k matrix.
	end
	
% We now have the reduced eigen space.We shall now evaluate the eigen coefficients

	eigcoeff = (redEigvectors')*personDecMean;              % Each column has the eigen coefficients for each person so it is k x m matrix.

				
