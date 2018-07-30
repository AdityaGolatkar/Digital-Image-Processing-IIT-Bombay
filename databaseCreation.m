function [personMatrix,personDecMean,redEigvectors,eigcoeff,personMean] = databasecreation(k)
%function [] = databaseCreation(k)

%Make sure that you are in the directory which contains the folders for each person.
%Make sure that the databaseCreation.m is in the directory which
%contains the folders s1 s2 ...and so on.
%Make sure that the folder for each person is named s1,s2...... and each person has images named 1.pgm ... and so on.
%We will take 6 images of each of first 32 people.

m = 1;                                          % This will indicate the number of persons in total at the end of the loop given below
for personNo = 1: 32                            % For each of the 32 person.
	personNostr = int2str(personNo);            % Convert the integer to string.
	cd(strcat('s',personNostr));                % Change the directory to the one which contains the corresponding persons images.

%Now we have entered the directory which contains the a persons images.

	for imageNo = 1 : 6                                 % For each of the 6 images.
		imageNostr = int2str(imageNo);                  % Convert the integer to string.
		tempimg = imread(strcat(imageNostr,'.pgm'));	% Stores the image of a person temporarily.
		personMatrix(:,m) = tempimg(:);                 % personMatrix stores the images of all the people in column form with dimension 32*6 x 92*110.
    	m = m + 1;
	end
	cd ..;
end
    
    m = m - 1;
    %size(personMatrix)
	personMean = mean(personMatrix,2);                          % This stores the mean vector for all person.
	%size(personMean)
    personMatrix = double(personMatrix);                        % Convert the matrix to double to ensure that it is of same datatype as personMean.
    personDecMean = bsxfun(@minus,personMatrix,personMean);     % This is a ((92*112) cross m) dimensional matrix which stores the person deducted mean for all people.(Captial X matrix in slides)
	%size(personDecMean)
    L_matrix = (personDecMean')*personDecMean;                  % This is the L matrix on pg 39 of slides.It is m x m.
	%size(L_matrix)
    [eigv eigvector] = eig(L_matrix);                           % We get the eigen vectors of the L matrix.
	personEigvectors = personDecMean*eigvector;                 % This is the V matrix in the slides.
	%size(personEigvectors)
    personEigvectors = normc(personEigvectors);                 % Normalize the columns of the eigen vectors. This matrix will at max have m eigenvalues.

% Eigen values of personEigvectors matrix and L_matrix are the same.So we just need to find the k max out of them.
    
    eigv = sum(eigv,1);                                         % eigv is a diagonal matrix so by doing sum along the columns we get the eigen values in a row matrix.Dimension will be 1 x m.
	sorted = sort(eigv,'descend');
		
	for i = 1:k
		pos = find(eigv == sorted(i));                          % Find the position of the eigen value in the eigv matrix and then include the corresponding eigenvector in reduced eigen space
		%size(pos)
        redEigvectors(:,i) = personEigvectors(:,pos);           % It is a 92*112 x k matrix.
	end
	%size(redEigvectors)
    %redEigvectors
% We now have the reduced eigen space.We shall now evaluate the eigen coefficients

	eigcoeff = (redEigvectors')*personDecMean;              % Each column has the eigen coefficients for each person so it is k x m matrix.
    %size(eigcoeff)
				