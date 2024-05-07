function X_random = G_randperm(X)
% Generate a completely randomized data set: randperm(N)
N = size(X,1);
M = size(X,2);
X_random = zeros(N,M);
for i=1:M
    X_random(:,i) = X(randperm(N),i);
end
end