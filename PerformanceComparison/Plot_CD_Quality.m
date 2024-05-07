load('Quality_metrics.mat')
% For Bonferroni-Dunn (BD) test
alpha = 0.05;

%% All algorithms (except for DV)
algo = {'SigDT','CUBT^{Ham}','CUBT^{MI}','k-modes','Entropy','CDE','CDCDR','IMM','RDM','SHA'};
Purity_list = Quality_Purity;
Purity_list(:,2) = [];
Fscore_list = Quality_Fscore;
Fscore_list(:,2) = [];
% [cd1,f1] = criticaldifference('Purity_CD',Purity_list,algo,alpha);
[cd2,f2] = criticaldifference('Fscore_CD',Fscore_list,algo,alpha);

%% Interpretable clustering algorithms
algo = {'SigDT','CUBT^{Ham}','CUBT^{MI}','IMM','RDM','SHA'};
list = [1 3 4 9 10 11];
Purity_list_Tree = Quality_Purity(:,list);
Fscore_list_Tree = Quality_Fscore(:,list);
%[cd3,f3] = criticaldifference('PurityTree_CD',Purity_list_Tree,algo,alpha);
[cd4,f4] = criticaldifference('FscoreTree_CD',Fscore_list_Tree,algo,alpha);