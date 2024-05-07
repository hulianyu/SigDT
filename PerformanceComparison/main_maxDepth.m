load('Depths_list.mat')
load('SigDT_Depths.mat')
% For one-sided signrank
alpha = 0.05;
algo_maxDepth = {'SigDT','CUBT_{Max}','CUBT^{Ham}','CUBT^{MI}','IMM','RDM','SHA'};

% #[1]SHA [2]RDM [3]IMM
maxDepth_list = [SigDT_Depths(:,1) CUBT_maxTree_Depth(:,2) CUBT_Ham_Depth(:,2) CUBT_MI_Depth(:,2) MaxDepth(:,3) MaxDepth(:,2) MaxDepth(:,1)];
%% Larger
maxDepth_large = zeros(6,1);
for j = 2:7
    maxDepth_large(j-1,1) = signrank(maxDepth_list(:,j), maxDepth_list(:,1), 'Tail', 'right');
end
larger_algo = {'CUBT_{Max}','CUBT^{Ham}','CUBT^{MI}'};

%% smaller
maxDepth_small = zeros(6,1);
for j = 2:7
    maxDepth_small(j-1,1) = signrank(maxDepth_list(:,j), maxDepth_list(:,1), 'Tail', 'left');
end
smaller_algo = [];