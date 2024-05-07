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
Total_ex = 300;
Clusterability = zeros(Total_ex,18);
for I=1:18
    X_data = load([strtrim(filename(I,:)), '.txt']); %Load a Dataset
    X = X_data(:,2:end); %Data set
    [N,M] = size(X);
    Q = max(X(:,M));
    for m=1:M
        % keep the order in discat
        [~, ~, X(:,m)] = unique(X(:,m), 'stable');
    end
    for m =2:M
        X(:,m) = X(:,m) + max(X(:,m-1));
    end
    for ex = 1:Total_ex
        disp(I);
        disp(ex/Total_ex);
        X_r = G_swap(X,ex);
        objsID = 1:N;
        X_r = [objsID' X_r];
        k = 0;
        pi_Node = zeros(N+1,1);
        [Node, final_b, pi_Node] = Sig_divide(X_r,Q,k,pi_Node);
        pi = pi_Node(1:end-1);
        % drawTree(Node, rowNames, I); % Call the function to draw the tree
        Clusterability(ex,I) = double(Node.pval>(0.01/Q));
    end
end
unclusterable_found = 100*(sum(Clusterability,2)/18);