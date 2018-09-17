clear;
close all;

load('20180915_GroupMeeting.mat')
cellfun(@(x) GetSampleType(x),samples)

Plot{1} = samples{1};
Plot{2} = samples{2};
Plot{3} = samples{4};
Plot{4} = samples{5};
Plot{5} = samples{6};

figure
hold on
cellfun(@(x) SemicircleImpedanceOhmcm2(x),Plot)
% xlim([xmin xmax])
hold off


figure
hold on
cellfun(@(x) ChangeSemicircleImpedanceOhmcm2(x),Plot)
% xlim([xmin xmax])
hold off
