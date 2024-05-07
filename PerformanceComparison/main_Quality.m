load('Quality_metrics.mat')
% For one-sided signrank
% alpha = 0.05;
algo = {'[1]SigDT','[2]CUBT^{Ham}','[3]CUBT^{MI}','[4]k-modes','[5]Entropy','[6]CDE','[7]CDC\_DR','[8]IMM','[9]RDM','[10]SHA'};
Quality_Purity(:,2) = [];
Quality_Fscore(:,2) = [];
i = 1;
vsset = setdiff(1:10,i);
%% Purity
% Smaller
Purity_smaller = zeros(9,1);
for j = 1:9
    Purity_smaller(j,1) = signrank(Quality_Purity(:,i), Quality_Purity(:,vsset(j)), 'Tail', 'right');
end
Yes_set = Purity_smaller<=0.05;
Smaller_Purity = vsset(Yes_set);

%% Fscore
Fscore_smaller = zeros(9,1);
for j = 1:9
    Fscore_smaller(j,1) = signrank(Quality_Fscore(:,i), Quality_Fscore(:,vsset(j)), 'Tail', 'right');
end
Yes_set = Fscore_smaller<=0.05;
Smaller_Fscore = vsset(Yes_set);