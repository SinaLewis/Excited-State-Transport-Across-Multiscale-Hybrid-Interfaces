function data = extract_atom_data(filename)

% grab the full file
fullfile = readlines(filename);

% % dump file format; look for line "ITEM: ATOMS id type xz ys zs
% numberOfAtoms=int32(str2double(fullfile(4)));
% numberOfTimesteps=length(fullfile)/(numberOfAtoms+9);
% data=zeros(numberOfAtoms,5,numberOfTimesteps);
% 
% extract only atom data (i.e. remove header lines)
% for j = 1:numberOfTimesteps
%     data(:,:,j)=str2double(split(fullfile(9+1+(j-1)*(numberOfAtoms+9):j*(numberOfAtoms+9))));
% end
numTS = length(fullfile);
data=zeros(5,numTS);

for ts=1:numTS
    data(:,ts) = str2double(split(fullfile(ts)));
end
    


end

