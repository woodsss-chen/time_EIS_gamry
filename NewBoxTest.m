clear;
close all;

load('20180922_CT.mat');
dir = 'G:\My Drive\Dasgupta Research Group\Battery Subgroup\Data Characterization\ALD mechanics Yuxin\20180921_EIS';
samples{1} = EISFitting('1', 'Li-as recieved 8', dir , 'Li-Li-Pt_8', '20180921_Li-Li-Pt_8_gamry_01_PEIS', 0.5,  'WE', 1);
samples{2} = EISFitting('1', 'Li-as recieved 8', dir , 'Li-Li-Pt_8', '20180921_Li-Li-Pt_8_gamry_05_PEIS', 0.5,  'WE', 2);
samples{3} = EISFitting('1', 'Li-as recieved 8', dir , 'Li-Li-Pt_8', '20180921_Li-Li-Pt_8_gamry_01_PEIS', 0.5,  'CE', 1);
samples{4} = EISFitting('1', 'Li-as recieved 8', dir , 'Li-Li-Pt_8', '20180921_Li-Li-Pt_8_gamry_05_PEIS', 0.5,  'CE', 2);
samples{5} = EISFitting('1', 'ALD 1', dir , 'ALD-ALD-Pt_1', '20180921_ALD-ALD-Pt_gamry_01_PEIS', 0.5,  'WE', 1);
samples{6} = EISFitting('1', 'ALD 1', dir , 'ALD-ALD-Pt_1', '20180921_ALD-ALD-Pt_gamry_05_PEIS', 0.5,  'WE', 2);
samples{7} = EISFitting('1', 'ALD 1', dir , 'ALD-ALD-Pt_1', '20180921_ALD-ALD-Pt_gamry_01_PEIS', 0.5,  'CE', 1);
samples{8} = EISFitting('1', 'ALD 1', dir , 'ALD-ALD-Pt_1', '20180921_ALD-ALD-Pt_gamry_05_PEIS', 0.5,  'CE', 2);
samples{9} = EISFitting('1', 'ALD 2', dir , 'ALD-ALD-Pt_2', '20180921_ALD-ALD-Pt_2_gamry_01_PEIS', 0.5,  'WE', 1);
samples{10} = EISFitting('1', 'ALD 2', dir , 'ALD-ALD-Pt_2', '20180921_ALD-ALD-Pt_2_gamry_05_PEIS', 0.5,  'WE', 2);
samples{11} = EISFitting('1', 'ALD 2', dir , 'ALD-ALD-Pt_2', '20180921_ALD-ALD-Pt_2_gamry_01_PEIS', 0.5,  'CE', 1);
samples{12} = EISFitting('1', 'ALD 2', dir , 'ALD-ALD-Pt_2', '20180921_ALD-ALD-Pt_2_gamry_05_PEIS', 0.5,  'CE', 2);
samples{13} = EISFitting('1', 'ALD 3', dir , 'ALD-ALD-Pt_3', '20180921_ALD-ALD-Pt_3_gamry_01_PEIS', 0.5,  'WE', 1);
samples{14} = EISFitting('1', 'ALD 3', dir , 'ALD-ALD-Pt_3', '20180921_ALD-ALD-Pt_3_gamry_05_PEIS', 0.5,  'WE', 2);
samples{15} = EISFitting('1', 'ALD 3', dir , 'ALD-ALD-Pt_3', '20180921_ALD-ALD-Pt_3_gamry_01_PEIS', 0.5,  'CE', 1);
samples{16} = EISFitting('1', 'ALD 3', dir , 'ALD-ALD-Pt_3', '20180921_ALD-ALD-Pt_3_gamry_05_PEIS', 0.5,  'CE', 2);
samples{17} = EISFitting('1', 'Li-as recieved 9', dir , 'Li-Li-Pt_9', '20180921_Li-Li-Pt_9_gamry_01_PEIS', 0.5,  'WE', 1);
samples{18} = EISFitting('1', 'Li-as recieved 9', dir , 'Li-Li-Pt_9', '20180921_Li-Li-Pt_9_gamry_05_PEIS', 0.5,  'WE', 2);
samples{19} = EISFitting('1', 'Li-as recieved 9', dir , 'Li-Li-Pt_9', '20180921_Li-Li-Pt_9_gamry_01_PEIS', 0.5,  'CE', 1);
samples{20} = EISFitting('1', 'Li-as recieved 9', dir , 'Li-Li-Pt_9', '20180921_Li-Li-Pt_9_gamry_05_PEIS', 0.5,  'CE', 2);
samples{21} = EISFitting('1', 'ALD-3 strokes', dir , '3s-3s-Pt_1', '20180921_3s-3s-Pt_1_gamry_01_PEIS', 0.5,  'WE', 1);
samples{22} = EISFitting('1', 'ALD-3 strokes', dir , '3s-3s-Pt_1', '20180921_3s-3s-Pt_1_gamry_05_PEIS', 0.5,  'WE', 2);
samples{23} = EISFitting('1', 'ALD-3 strokes', dir , '3s-3s-Pt_1', '20180921_3s-3s-Pt_1_gamry_01_PEIS', 0.5,  'CE', 1);
samples{24} = EISFitting('1', 'ALD-3 strokes', dir , '3s-3s-Pt_1', '20180921_3s-3s-Pt_1_gamry_05_PEIS', 0.5,  'CE', 2);
samples{25} = EISFitting('1', 'as recieved-3 strokes', dir , '3sar-3sar-Pt_1', '20180921_3sar-3sar-Pt_1_gamry_01_PEIS', 0.5,  'WE', 1);
samples{26} = EISFitting('1', 'as recieved-3 strokes', dir , '3sar-3sar-Pt_1', '20180921_3sar-3sar-Pt_1_gamry_05_PEIS', 0.5,  'WE', 2);
samples{27} = EISFitting('1', 'as recieved-3 strokes', dir , '3sar-3sar-Pt_1', '20180921_3sar-3sar-Pt_1_gamry_01_PEIS', 0.5,  'CE', 1);
samples{28} = EISFitting('1', 'as recieved-3 strokes', dir , '3sar-3sar-Pt_1', '20180921_3sar-3sar-Pt_1_gamry_05_PEIS', 0.5,  'CE', 2);
samples{29} = EISFitting('1', 'ALD-5 strokes', dir , '5s-5s-Pt_1', '20180921_5s-5s-Pt_1_gamry_01_PEIS', 0.5,  'WE', 1);
samples{30} = EISFitting('1', 'ALD-5 strokes', dir , '5s-5s-Pt_1', '20180921_5s-5s-Pt_1_gamry_05_PEIS', 0.5,  'WE', 2);
samples{31} = EISFitting('1', 'ALD-5 strokes', dir , '5s-5s-Pt_1', '20180921_5s-5s-Pt_1_gamry_01_PEIS', 0.5,  'CE', 1);
samples{32} = EISFitting('1', 'ALD-5 strokes', dir , '5s-5s-Pt_1', '20180921_5s-5s-Pt_1_gamry_05_PEIS', 0.5,  'CE', 2);

save('20180922_CT.mat')
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
