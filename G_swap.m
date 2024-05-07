function X_random = G_swap(X,ex)
% Generate a randomized data set: swap(a,b)
N = size(X,1);
M = size(X,2);
X_random = X;
for t = 1:ex
    for i=1:M
        G = 1:N;
        a = randperm(N,1);
        A = X(a,i);
        rn1 = X(:,i)==A;
        G(rn1) = [];
        B = randperm(length(G),1);
        b = G(B);
        X_random(a,i) =  X(b,i);
        X_random(b,i) = A;
    end
    X = X_random;
end
end