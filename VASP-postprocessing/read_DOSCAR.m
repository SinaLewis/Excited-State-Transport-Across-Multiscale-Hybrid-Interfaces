function [cellVol,NEDOS,Efermi,tDOS,pDOS] = read_DOSCAR(filepath)

fullFile = readlines(filepath);
firstRow = split(fullFile(1));
cellInfo = split(fullFile(2));
DOScalc = split(fullFile(6));

numIons = int32(str2double(firstRow(2)));
cellVol = str2double(cellInfo(2));
NEDOS = int32(str2double(DOScalc(4)));
Efermi = str2double(DOScalc(5));

spinPolarized = false;
if length(str2num(fullFile(7))) > 3
    spinPolarized = true;
end

% get the rows with
% "energy DOS integratedDOS"
tDOS = zeros(NEDOS,3+(2*spinPolarized));
for line = 1:NEDOS
    tDOS(line,:) = str2num(fullFile(6+line));
end

% get the rows with
% "energy s  p_y p_z p_x d_{xy} d_{yz} d_{z2-r2} d_{xz} d_{x2-y2}"
% each grouping is per ion
pDOS = zeros(NEDOS,10+(9*spinPolarized));
for ion = 1:numIons
    for line = 1:NEDOS
    pDOS(line,:,ion) = str2num(fullFile(6+ion*(NEDOS+1)+line));
    end
end

if spinPolarized
pDOSup = [pDOS(:,1,:),pDOS(:,2:2:19,:)];
pDOSdown = [pDOS(:,1,:),pDOS(:,3:2:19,:)];
pDOS = zeros(NEDOS,10,numIons,2);
pDOS(:,:,:,1) = pDOSup;
pDOS(:,:,:,2) = pDOSdown;
end

% info = [cellVol,NEDOS,Efermi,tDOS,pDOS];

end