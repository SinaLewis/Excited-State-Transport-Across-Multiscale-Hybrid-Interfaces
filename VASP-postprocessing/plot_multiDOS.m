defaultPATH = ; % default path header

systems = []; % list of folders to plot the DOS %%input("System to plot: ");
subfolders = []; % list of optional subfolders within the above %input("Subfolder (optional): ");

for s = 1:length(systems)

first_C=1; % location of the first carbon (for intergrating over the carbon p orbitals)
num_C = 14; % number of total carbons, assuming they're sequential

if s == 1
    hold on
end

fullPath = strcat(defaultPATH,systems(s),"/DOS/",subfolders(s));
filename = strcat(fullPath,"/DOSCAR");
filenamePOSCAR = strcat(fullPath,"/POSCAR");

%{
READ IN DOSCAR INFORMATION
%}
[cellVol,NEDOS,Efermi,tDOS,pDOS] = read_DOSCAR(filename);

%{
READ IN POSCAR INFORMATION
%}
[ionLabels,numIons] = read_POSCAR(filenamePOSCAR);

%{
SEPARATE s,p,d CONTRIBUTIONS OF CARBON
%}
C_s = 2*sum(pDOS(:,2,first_C:num_C+first_C-1),3);
C_p = 2*sum(sum(pDOS(:,3:5,first_C:num_C+first_C-1),3),2);
C_d = 2*sum(sum(pDOS(:,6:10,first_C:num_C+first_C-1),3),2);

%{
PLOT SHIFTING ZERO TO FERMI ENERGY
%}
plot(pDOS(:,1,1)- Efermi+0.81,sum(sum(pDOS(:,2:10,:),3),2),'LineWidth',2, 'Color', [0.65 0.65 0.65],'DisplayName',"Total; "+systems(s)+"/"+subfolders(s))
plot(pDOS(:,1,1)-Efermi+0.81,C_s,'LineWidth',2,'Color', [134/255 199/255 186/255],'DisplayName',"C - s; "+systems(s)+"/"+subfolders(s))
plot(pDOS(:,1,1)-Efermi+0.81,C_p,'LineWidth',2,'Color', [134/255 199/255 186/255],'DisplayName',"C - p; "+systems(s)+"/"+subfolders(s))

if s == length(systems)
    legend()
    hold off
end

end
