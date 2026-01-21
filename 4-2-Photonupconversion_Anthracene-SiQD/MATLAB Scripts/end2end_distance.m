function distance = end2end_distance(savepath,filename,QDSi,endChainSi,scale,cleanup)

savefile_QDSi=convertCharsToStrings(savepath(2:end-1))+"data_for_"+string(QDSi)+".txt";
savefile_endChainSi=convertCharsToStrings(savepath(2:end-1))+"data_for_"+string(endChainSi)+".txt";

if ~isfile(savefile_QDSi) || cleanup
    system(['./parseAtomInfo.bash' ' ' filename  ' ' int2str(QDSi) ' ' savepath]);
end

if ~isfile(savefile_endChainSi) || cleanup
    system(['./parseAtomInfo.bash' ' ' filename  ' ' int2str(endChainSi) ' ' savepath]);
end

% grab the file data in matrix form
data_QDSi = importdata(savefile_QDSi,' ',0);
data_endChainSi = importdata(savefile_endChainSi,' ',0);

for i = 1:length(data_QDSi)
    data_QDSi(i,3:5) = transpose(scale*transpose(data_QDSi(i,3:5)));
    data_endChainSi(i,3:5)=transpose(scale*transpose(data_endChainSi(i,3:5)));
end

% distance from QDSi at (X,Y,Z) to endChainSi (x,y,z) can be given by
% sqrt((x-X)^2 + (y-Y)^2 + (z-Z)^2)
% result is an array of distances between the atoms at each timestep
distance = sqrt(sum((data_QDSi(:,3:5)-data_endChainSi(:,3:5)).^2,2));

end

