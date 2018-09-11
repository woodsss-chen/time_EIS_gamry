clear;
close all;

save('20180910.mat')
dir = 'G:\My Drive\Dasgupta Research Group\Battery Subgroup\Yuxin Chen\MatLab Code\Yuxin EIS Fitting-test\Data\20180910';
% samples{1}=EISFitting('1', 'Li-ALD-crack', dir , 'Li(ALD crack)-LTO-LTO (wrc)', '20180906_Li(ALD crack)-LTO-LTO_gamry_0', '_PEIS.mpt', 0.5,  1);
% samples{2}=EISFitting('1', 'Li-ALD', dir , 'Li(ALD)-LTO-LTO (wrc)', '20180906_Li(ALD)-LTO-LTO_gamry_0', '_PEIS.mpt', 0.5,  1);
% samples{3}=EISFitting('1', 'Li-AR-crack', dir , 'Li(ar crack)-LTO-LTO (wrc)', '20180906_Li(ar crack)-LTO-LTO_gamry_0', '_PEIS.mpt', 0.5,  1);
% samples{4}=EISFitting('1', 'Li-AR-scrap', dir , 'Li(ar scrap)-LTO-LTO (wrc)', '20180906_Li(ar scrap)-LTO-LTO_gamry_0', '_PEIS.mpt', 0.5,  1);
% samples{5}=EISFitting('1', 'Li-AR', dir , 'Li(ar)-LTO-LTO (wrc)', '20180906_Li(ar)-LTO-LTO_gamry_0', '_PEIS.mpt', 0.5,  1);
% samples{6}=EISFitting('1', 'LTO', dir , 'LTO-LTO-LTO (wrc)', '20180906_LTO-LTO-LTO_gamry_0', '_PEIS.mpt', 0.5,  1);
samples{1}=EISFitting('1', 'Li-ALD', dir , 'Li-Li-Pt (wcr)', '20180910_Li-Li-Pt_gamry_0', '_PEIS.mpt', 0.5,  1);
save('20180910.mat')

% xmin=0;
% xmax=2500;


cellfun(@(x) NyquistPlotOhmcm2(x),samples)
% xlim([xmin xmax])

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
