defaultPATH = ; % default path header

systems = []; % list of folders with the data to plot (should denote the system);
subfolders = []; % list of optional subfolders within the above systems (e.g. "triplet/7x7x1")

styles=["-","--",":","-.","-","-","--",":","-.","-","-"];
colors=[[0.65,0.65,0.65];[45/255 92/255 136/255];[134/255 199/255 186/255];[255/255 0/255 0/255];[98/255 30/255 66/255];[0,0,1];[0,1,0];[0.5,0.5,0.5]];

fig1=figure();
fig2=figure();
axes1=axes('Position',[0.10,0.15,0.8,0.8],'Parent',fig1);
axes2=axes('Position',[0.10 0.15 0.8 0.8],'Parent',fig2);

FWHM_array=[];
FWHMplot = axes('Parent',fig2);
% axes2.YAxisLocation='right';

for s = 1:length(systems)
if s==1 || s == 6 || s == 7 || s == 8
    continue;
end
if s == 2
hold(axes1,'on')
hold(axes2,'on')
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

lowerIndex=find(~(pDOS(:,1,1,1)+5));
upperIndex=find(~(pDOS(:,1,1,1)-3));

% add together Carbon types
first_C=1;
% if s >= 6
    % num_C = 16;
% else
    num_C=14;
% end
C_s = @(spin) sum(pDOS(lowerIndex:upperIndex,2,first_C:num_C+first_C-1,spin),3)./100;
C_p = @(spin) sum(sum(pDOS(lowerIndex:upperIndex,3:5,first_C:num_C+first_C-1,spin),3),2)./100;
C_d = @(spin) sum(sum(pDOS(lowerIndex:upperIndex,6:10,first_C:num_C+first_C-1,spin),3),2)./100;
total = @(spin) sum(sum(pDOS(lowerIndex:upperIndex,2:10,:,1),3),2)./100;

%{
FIND THE MIDPOINT OF THE BANDGAP
%}
bandgap=find(~total(2));
E=pDOS(:,1,1,1);
Emid = E(bandgap(floor(length(bandgap)/2)));

% E=E-(0.616 - 0.19); %used for 9EA and 9VA

 
[totalE, totalJoint,deltaTotalJoint] = make_2particle_DOS(E,total(1)+total(2),Emid);
[carbonE,carbonJoint,deltaCarbonJoint] = make_2particle_DOS(E,C_p(1)+C_p(2),Emid);

area(totalE,totalJoint,'DisplayName',"Total Joint: "+systems(s),'FaceColor',colors(s,:),'FaceAlpha',0.2,'Parent',axes1,'LineWidth',2,'EdgeColor',[colors(s,:)])
plot(carbonE,carbonJoint*50,'DisplayName',"C - p Joint (x50):"+systems(s),'LineWidth',2,'Color',colors(s,:),'LineStyle',styles(s),'Parent',axes1)

area(totalE,totalJoint,'DisplayName',"Total Joint: "+systems(s),'FaceColor',colors(s,:),'FaceAlpha',0.2,'Parent',axes2,'LineWidth',2,'EdgeColor',[colors(s,:)])
plot(carbonE,carbonJoint*50,'DisplayName',"C - p Joint (x50):"+systems(s),'LineWidth',2,'Color',colors(s,:),'LineStyle',styles(s),'Parent',axes2)

outsideFirst=excludedata(carbonE.',carbonJoint*50,'domain',[1.0,2.7]);
Cfit = fit(carbonE',carbonJoint*50,'gauss1','Exclude',outsideFirst);
plot(axes1,Cfit,carbonE,carbonJoint*50)
plot(axes2,Cfit,carbonE,carbonJoint*50)
fprintf("C - p Joint (x50):"+systems(s)+"\nThe Gaussian Fit parameters are mu="+Cfit.b1+" and sigma="+Cfit.c1/sqrt(2)+"\n")



FWHM_array(end+1) = 2*log(2)*Cfit.c1;

if s == length(systems)
    legend()
    hold(axes1, 'off')
    hold(axes2, 'off')
    xlim(axes1,[1,2.7])
    xlim(axes2,[1,2.7])
    ylim(axes1,[0,10])
    ylim(axes2,[0,10])
end

end


labels=["Si:GeMe2A","Si:SiMe2A","Si:Si2Me4A","Si:Si3Me6A","Si:Si4Me8A","Si:Si4Me8A_661","Si:9EA","Si:9VA"];
sigma = [0.074, 0.073129, 0.072391, 0.060735, 0.061135,0.082161, 0.066839, 0.088939];
FWHM = 2*sqrt(2)*log(2).*sigma; % in units of eV
TESA = [10,15,7.5,17.5,20,2.5,55]; % in units of nm

scatter(FWHM,TESA,"filled",'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5)
ylabel("Full-Width Half-Maximum (eV)")
xlabel("Triplet ESA Shift (nm)")
text(FWHM, TESA, labels, 'Vert','bottom', 'Horiz','left', 'FontSize',7)


scatter(1:4,FWHM(2:5))
% slab_linker_distance=[3.69049,3.60453,5.61233,7.56096,9.3694];
% plot(slab_linker_distance,FWHM_array,'Parent',FWHMplot)