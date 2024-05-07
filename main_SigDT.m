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
results = zeros(18,7);
Results = zeros(18,2);
eTime = zeros(18,1);
numPi = zeros(18,2);
Depths = zeros(18,2);
Clusterability = 0;
ODS_pval = zeros(18,1);
for I=1:18
%     disp(I);
    X_data = load([strtrim(filename(I,:)), '.txt']); %Load a Dataset
    X = X_data(:,2:end); %Data set
    GT = X_data(:,1); %Ground Truth 
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
    tic
    [Node, final_b, pi_Node] = Sig_divide(X,Q,k,pi_Node); 
    eTime(I,1) = toc;
    %% Clustering quality
    pi = pi_Node(1:end-1);
    results(I,:) = ClusteringMeasure(GT, pi);
    Results(I,1) = results(I,3); % Purity
    Results(I,2) = results(I,7); % F-score
    %% Depths
    numPi(I,1) = length(unique(GT));
    numPi(I,2) = length(unique(pi));
    Depths(I,1) = treeDepth(Node);
    Depths(I,2) = averageLeafDepth(Node);
    drawTree(Node, rowNames, I); % Call the function to draw the tree
    ODS_pval(I,1) = Node.pval;
    Clusterability = Clusterability + double(Node.pval>(0.01/Q));
end
disp(mean(Results,1));    
disp(mean(Depths,1));
% disp(mean(results,1));
Show = [mean(Results,1) mean(numPi(:,2),1) mean(Depths,1)];