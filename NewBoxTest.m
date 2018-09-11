clear;
close all;

load('20180910.mat')
dir = 'G:\My Drive\Dasgupta Research Group\Battery Subgroup\Yuxin Chen\MatLab Code\Yuxin EIS Fitting-test\Data\20180910';
samples{1}=EISFitting('1', 'LTO1', dir , 'LTO-Li_Pt_new (wcr)', '20180910_LTO-Li-Pt_new_gamry_0', '_PEIS.mpt', 0.5,  1);
samples{2}=EISFitting('1', 'LTO2', dir , 'LTO-Li_Pt_new (wcr)', '20180910_LTO-Li-Pt_new2_gamry_0', '_PEIS.mpt', 0.5,  1);
samples{3}=EISFitting('1', 'Li-as recieved', dir , 'Li-Li-Pt (wcr)', '20180910_Li-Li-Pt_gamry_0', '_PEIS.mpt', 0.5,  1);
samples{4}=EISFitting('1', 'Li-compressed', dir , 'Li-Li(ar_crack)-Pt (wrc)', '20180910_Li-Li(ar_crack)-Pt_gamry_0', '_PEIS.mpt', 0.5,  1);
samples{5}=EISFitting('1', '160x alumina', dir , 'Li-Li(ALD)-Pt (wcr)', '20180910_Li-Li(ALD)-Pt_gamry_0', '_PEIS.mpt', 0.5,  1);
samples{6}=EISFitting('1', '160x alumina-compressed', dir , 'Li-Li(ALD_crack)-Pt (wrc)', '20180910_Li-Li(ALD_crack)-Pt_gamry_0_0', '_PEIS.mpt', 0.5,  1);

save('20180910.mat')
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
