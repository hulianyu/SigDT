addpath([cd '/']);
addpath([cd '/Datasets']);
addpath([cd '/Evaluation']);
%% Load Data sets
filename = char('lenses','lung-cancer','soybean-small','zoo','dna-promoter',...
    'hayes-roth','lymphography','heart-disease','solar-flare','primary-tumor',...
    'dermatology','house-votes','balance-scale','credit-approval','breast-cancer-wisconsin',...
    'mammographic-mass','tic-tac-toe','car');
rowNames = {'Ls', 'Lc', 'So', 'Zo', 'Ps', 'Hr', 'Ly', 'Hd', 'Sf',...
    'Pt', 'De', 'Hv', 'Bs', 'Ca', 'Bc', 'Mm', 'Tt', 'Ce'};
pval = zeros(18,4);
% CompletelyRandomizedData = cell(18,1);
load('CompletelyRandomizedData.mat')
for I=1:18
    disp(I);
%     X_data = load([strtrim(filename(I,:)), '.txt']); %Load a Dataset
%     X = X_data(:,2:end); %Data set
%     X = G_randperm(X);
    X = CompletelyRandomizedData{I,1};
    try
        cluster_all = ccdv(X);
    catch
        pval(I,4) = 1;
    end
    [N,M] = size(X);
    for m=1:M
        % keep the order in discat
        [~, ~, X(:,m)] = unique(X(:,m), 'stable');
    end
    for m =2:M
        X(:,m) = X(:,m) + max(X(:,m-1));
    end
    Q = max(X(:,M));
    objsID = 1:N;
    X = [objsID' X];
    k = 0;
    pi_Node = zeros(N+1,1);
    [Node, final_b, pi_Node] = Sig_divide(X,Q,k,pi_Node); 
    pi = pi_Node(1:end-1);
    % drawTree(Node, rowNames, I); % Call the function to draw the tree
    pval(I,1) = 0.01/Q;
    pval(I,2) = Node.pval;
    pval(I,3) = double(Node.pval>pval(I,1));
end