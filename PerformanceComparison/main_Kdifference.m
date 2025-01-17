load('nLeaf.mat')
% Average_Difference (K)

KAD = zeros(4,1);
algo = {'K','SigDT','CUBT_{Max}','CUBT^{Ham}','CUBT^{MI}'};
for j=1:4
    KAD(j,1) = sum(abs(Depths_nLeaf(:,j+1)-Depths_nLeaf(:,1)))/18;
end

load('PerformanceQuality.mat')
List = find(DV_k~=0);
KAD_DV = sum(abs(DV_k(List,1)-Depths_nLeaf(List,1)))/18;