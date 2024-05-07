load('RunningTimes_list.mat')
% For one-sided signrank
% alpha = 0.05;
algo = {'SigDT','DV','CUBT^{Ham}','CUBT^{MI}','k-modes','Entropy','CDE','CDC\_DR','IMM','RDM','SHA'};
i = 8;
vsset = setdiff(1:11,i);
%% Faster
% h_fast = zeros(10,1);
% for j = 1:10
%     h_fast(j,1) = signrank(RunningTimes_list(:,vsset(j)), RunningTimes_list(:,i), 'Tail', 'left');
% end
% Faster_algo = {'NULL'};
%% Slower
h_slow = zeros(10,1);
for j = 1:10
    h_slow(j,1) = signrank(RunningTimes_list(:, i), RunningTimes_list(:, vsset(j) ),'tail', 'left');
end
Slower_algo = {'DV','CUBT^{Ham}','CUBT^{MI}','k-modes','Entropy','CDE','RDM','SHA'};
