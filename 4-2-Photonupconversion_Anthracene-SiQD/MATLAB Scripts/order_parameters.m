path = '"/Users/sina/OneDrive - UCB-O365/Projects/MoleculesAttachedToSi/Si-QD';
cleanup=true;

% numbers 0-4 indicating what runs to use as defined by their seed
seed_list=[1,2,3,4]-1;

% % SiA
d1={};Rg1={};ts1={};
Lx=5.0379015000000003e+01-(5.3790149999999999e+00);
Ly=5.0156255999999999e+01-(5.1562560000000000e+00);
Lz=5.5097434999999997e+01-(1.0097435000000001e+01);
scale=[Lx,0,0;0,Ly,0;0,0,Lz];

sisi_bond = 2.36;
csi_bond = 1.89;
cc_bond = 1.54;

for i=seed_list
savePath = append(path,sprintf('/Si1-Anth/300/run%d/"',i));
dumpPath = append(path,sprintf('/Si1-Anth/300/run%d/dump.AnthSi.lammpstrj"',i));
si_chain_atoms = [249,1154,1132,1129]; % attached to C with index 1132 (1129 is C 9', across from the attachment point)
masses=[28.085,28.085,12.011,12.011];

d1{end+1}=end2end_distance(savePath,dumpPath,si_chain_atoms(1),si_chain_atoms(end),scale,cleanup);
Rg1{end+1}=radius_of_gyration(savePath,dumpPath,si_chain_atoms,masses,scale,cleanup,);
ts1{end+1}=importdata(convertCharsToStrings(savePath(2:end-1))+"timesteps_for_"+string(si_chain_atoms(1))+".txt",' ',0);
end


% % Si2A
d2={};Rg2={};ts2={};
Lx=4.5469544999999997e+01-(-9.5304549999999999e+00);
Ly=4.6351885000000003e+01-(-8.6481150000000007e+00);
Lz=5.1071804999999998e+01-(-3.9281950000000001e+00);
scale=[Lx,0,0;0,Ly,0;0,0,Lz];
for i = seed_list
savePath = append(path,sprintf('/Si2-Anth/300/run%d/"',i));
dumpPath = append(path,sprintf('/Si2-Anth/300/run%d/dump.AnthSi.lammpstrj"',i));
si_chain_atoms = [249,908,1124,1125,1141]; % attached to C with index 1125 (1141 = C 9')
masses=[28.085,28.0855,28.085,12.011,12.011];

d2{end+1}=end2end_distance(savePath,dumpPath,si_chain_atoms(1),si_chain_atoms(end),scale,cleanup);
Rg2{end+1}=radius_of_gyration(savePath,dumpPath,si_chain_atoms,masses,scale,cleanup);
ts2{end+1}=importdata(convertCharsToStrings(savePath(2:end-1))+"timesteps_for_"+string(si_chain_atoms(1))+".txt",' ',0);
end


% % Si3A
d3={};Rg3={};ts3={};
Lx=6.0379015000000003e+01-(-4.6209850000000001e+00);
Ly=6.0156255999999999e+01-(-4.8437440000000000e+00);
Lz=6.8124509000000003e+01-(3.1245090000000002e+00);
scale=[Lx,0,0;0,Ly,0;0,0,Lz];
for i = seed_list
savePath = append(path,sprintf('/Si3-Anth/300/run%d/"',i));
dumpPath = append(path,sprintf('/Si3-Anth/300/run%d/dump.AnthSi.lammpstrj"',i));
si_chain_atoms = [249,1170,1171,1172,1132,1129]; % attached to C with index 1132 (1129 = C 9')
masses=[28.085,28.085,28.085,28.085,12.011,12.011];

d3{end+1}=end2end_distance(savePath,dumpPath,si_chain_atoms(1),si_chain_atoms(end),scale,cleanup);
Rg3{end+1}=radius_of_gyration(savePath,dumpPath,si_chain_atoms,masses,scale,cleanup);
ts3{end+1}=importdata(convertCharsToStrings(savePath(2:end-1))+"timesteps_for_"+string(si_chain_atoms(1))+".txt",' ',0);
end


% % Si4A
d4={};Rg4={};ts4={}; 
Lx=6.5379014999999995e+01-(-9.6209849999999992e+00);
Ly=6.5156255999999999e+01-(-9.8437439999999992e+00);
Lz=7.4357984000000002e+01-(-6.4201600000000003e-01);
scale=[Lx,0,0;0,Ly,0;0,0,Lz];
for i = seed_list
savePath = append(path,sprintf('/Si4-Anth/300/run%d/"',i));
dumpPath = append(path,sprintf('/Si4-Anth/300/run%d/dump.AnthSi.lammpstrj"',i));
si_chain_atoms = [249,1170,1171,1172,1132,1129]; % attached to C with index 1132 (1129 = C 9')
masses=[28.085,28.085,28.085,28.085,28.085,12.011,12.011];

d4{end+1}=end2end_distance(savePath,dumpPath,si_chain_atoms(1),si_chain_atoms(end),scale,cleanup);
Rg4{end+1}=radius_of_gyration(savePath,dumpPath,si_chain_atoms,masses,scale,cleanup,11.74827,);
ts4{end+1}=importdata(convertCharsToStrings(savePath(2:end-1))+"timesteps_for_"+string(si_chain_atoms(1))+".txt",' ',0);
end

figure(); hold on
for i = seed_list
plot(ts1{i+1},d1{i+1},'DisplayName',sprintf("Si1A_%d",i),'Color',[45,92,136,255*(1-i*0.2)]/255)
plot(ts2{i+1},d2{i+1},'DisplayName',sprintf("Si2A_%d",i),'Color',[134,199,186,255*(1-i*0.2)]/255)
plot(ts3{i+1},d3{i+1},'DisplayName',sprintf("Si3A_%d",i),'Color',[160,48,35,255*(1-i*0.2)]/255)
plot(ts4{i+1},d4{i+1},'DisplayName',sprintf("Si4A_%d",i),'Color',[98,30,66,255*(1-i*0.2)]/255)
end
legend()
hold off

figure(); hold on
for i = seed_list
plot(ts1{i+1},Rg1{i+1},'DisplayName',sprintf("Si1A_%d",i),'Color',[45,92,136,255*(1-i*0.2)]/255)
plot(ts2{i+1},Rg2{i+1},'DisplayName',sprintf("Si2A_%d",i),'Color',[134,199,186,255*(1-i*0.2)]/255)
plot(ts3{i+1},Rg3{i+1},'DisplayName',sprintf("Si3A_%d",i),'Color',[160,48,35,255*(1-i*0.2)]/255)
plot(ts4{i+1},Rg4{i+1},'DisplayName',sprintf("Si4A_%d",i),'Color',[98,30,66,255*(1-i*0.2)]/255)
end
legend()
hold off

% Create a tiled layout with no spacing
t = tiledlayout(2, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

% Shared labels for the entire figure
xlabel(t, 'Time');
ylabel(t, 'Radius of Gyration');
colors=[[45,92,136]/255;
    [134,199,186]/255;
    [160,48,35]/255;
    [98,30,66]/255
    ];
% Overall title for the figure
% title(t, 'Figure with Four Panels, Each with Multiple Lines');

% Panel 1 (top-left) with two lines
nexttile;
plot(ts1{1}, Rg1{1},'Color',colors(1,:));
hold on;
for i = 1:(length(seed_list)-1)
plot(ts1{i+1}, Rg1{i+1},'Color',colors(i+1,:));
end
xlim([0,10^6]);
m=mean(Rg1{1});
ylim([m-1,m+1]);
hold off;
title('Si1Me2');

% Panel 2 (top-right) with two lines
nexttile;
plot(ts2{1}, Rg2{1},'Color',colors(1,:));
hold on;
for i = 1:(length(seed_list)-1)
plot(ts2{i+1}, Rg2{i+1},'Color',colors(i+1,:));
end
xlim([0,10^6]);
m=mean(Rg2{1});
ylim([m-1,m+1]);
hold off;
title('Si2Me4');

% Panel 3 (bottom-left) with two lines
nexttile;
plot(ts3{1}, Rg3{1},'Color',colors(1,:));
hold on;
for i = 1:(length(seed_list)-1)
plot(ts3{i+1}, Rg3{i+1},'Color',colors(i+1,:));
end
xlim([0,10^6]);
m=mean(Rg3{1});
ylim([m-1,m+1]);
hold off;
title('Si3Me6');

% Panel 4 (bottom-right) with two lines
nexttile;
plot(ts4{1}, Rg4{1},'Color',colors(1,:));
hold on;
for i = 1:(length(seed_list)-1)
plot(ts4{i+1}, Rg4{i+1},'Color',colors(i+1,:));
end
xlim([0,10^6]);
m=mean(Rg4{1});
ylim([m-1,m+1]);
hold off;
title('Si4Me8');
