clear;
close all;

load('20180921.mat');
dir = 'G:\My Drive\Dasgupta Research Group\Battery Subgroup\Data Characterization\ALD mechanics Yuxin\20180921_EIS';
samples{1} = EISFitting('1', 'Li-as recieved 1', dir , 'Li-Li-Pt_1', '20180921_Li-Li-Pt_1_gamry_01_PEIS', 0.5,  'WE');
samples{2} = EISFitting('1', 'Li-as recieved 1', dir , 'Li-Li-Pt_1', '20180921_Li-Li-Pt_1_gamry_05_PEIS', 0.5,  'WE');
samples{3} = EISFitting('1', 'Li-as recieved 1', dir , 'Li-Li-Pt_1', '20180921_Li-Li-Pt_1_gamry_01_PEIS', 0.5,  'CE');
samples{4} = EISFitting('1', 'Li-as recieved 1', dir , 'Li-Li-Pt_1', '20180921_Li-Li-Pt_1_gamry_05_PEIS', 0.5,  'CE');
samples{5} = EISFitting('1', 'Li-as recieved 2', dir , 'Li-Li-Pt_2', '20180921_Li-Li-Pt_2_gamry_01_PEIS', 0.5,  'WE');
samples{6} = EISFitting('1', 'Li-as recieved 2', dir , 'Li-Li-Pt_2', '20180921_Li-Li-Pt_2_gamry_05_PEIS', 0.5,  'WE');
samples{7} = EISFitting('1', 'Li-as recieved 2', dir , 'Li-Li-Pt_2', '20180921_Li-Li-Pt_2_gamry_01_PEIS', 0.5,  'CE');
samples{8} = EISFitting('1', 'Li-as recieved 2', dir , 'Li-Li-Pt_2', '20180921_Li-Li-Pt_2_gamry_05_PEIS', 0.5,  'CE');

save('20180921.mat')
% 
% % xmin=0;
% % xmax=2500;
% 
% 
% cellfun(@(x) NyquistPlotOhmcm2(x),samples)
%xlim([xmin xmax])
% 
figure
hold on
cellfun(@(x) TotalImpedanceOhmcm2(x),samples)
% xlim([xmin xmax])
hold off

figure
hold on
cellfun(@(x) SemicircleImpedanceOhmcm2(x),samples)
% xlim([xmin xmax])
hold off

figure
hold on
cellfun(@(x) OhmicImpedanceOhmcm2(x),samples)
% xlim([xmin xmax])
hold off

figure
hold on
cellfun(@(x) ChangeSemicircleImpedanceOhmcm2(x),samples)
% xlim([xmin xmax])
hold off
