function Rg = radius_of_gyration(savepath,filename,si_chain,masses,scale,cleanup,maxRg,minRg)
M =sum(masses);

for index = si_chain
    savefile=convertCharsToStrings(savepath(2:end-1))+"data_for_"+string(index)+".txt";
    if ~isfile(savefile) || cleanup
        system(['./parseAtomInfo.bash' ' ' filename  ' ' int2str(index) ' ' savepath]);
    end
    data{index}=importdata(savefile,' ',0);

    for i = 1:length(data{index}(:,3:5))
        data{index}(i,3:5)=scale*transpose(data{index}(i,3:5));
    end
end

Rcom = zeros(3,length(data{si_chain(1)}));
% calculate COM at each time step
for i = 1:length(si_chain)
    Rcom = Rcom+transpose(masses(i).*data{si_chain(i)}(:,3:5));
end

Rcom = Rcom / M;

% The radius of gyration can be given by
% sqrt(sum(mi*(Rcom - Ri)^2)/sum(mi))
Rg = zeros(1,length(data{si_chain(1)}));
for i = 1:length(si_chain)
Rg = Rg + masses(i).*sum((Rcom - transpose(data{si_chain(i)}(:,3:5))).^2,1);
end

Rg = sqrt(Rg / M);
Rg = (Rg - minRg)./(maxRg - minRg); % Rescale the data to be between minRg and maxRg

end

