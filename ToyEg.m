rowNames = {'Toy data'};
load('demoData.mat')
X = X_r;
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
[Node, final_k] = Sig_divide(X,Q,k);
drawTree(Node, rowNames, 1);