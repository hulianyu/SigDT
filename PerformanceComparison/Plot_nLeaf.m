load('nLeaf.mat')
nLeaf(10,:) = [];
load('DV_k.mat')
DV_k(10,:) = [];
algo = {'Ground-Truth','SigDT','CUBT_{Max}','CUBT^{Ham}','CUBT^{MI}'};
data = {'Ls', 'Lc', 'So', 'Zo', 'Ps', 'Hr', 'Ly', 'Hd', 'Sf',...
    'De', 'Hv', 'Bs', 'Ca', 'Bc', 'Mm', 'Tt', 'Ce'};
% 创建图形
figure;
hold on;

% 定义颜色
colors = [1, 0.8, 0.8;    % 淡红色
          1, 0.843, 0;    % 金色
          0.3, 0.3, 0.3;  % 深灰色
          0.7, 0.9, 1;    % 淡蓝色
          0.6, 0.8, 1];   % 浅蓝色

% 基准线及其±1区域，使用原始数据
baseLine = nLeaf(:,1);
x = 1:length(baseLine);
plot(x, baseLine + 1, '--', 'Color', colors(1,:));
plot(x, baseLine - 1, '--', 'Color', colors(1,:));
fill([x, fliplr(x)], [baseLine'+1, fliplr(baseLine'-1)], colors(1,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
plot(baseLine, 'LineWidth', 2, 'Color', colors(1,:));  % 绘制基准线以覆盖填充区域边缘

% 画蓝色方块表示 DV_k 中非零的值
indices = DV_k > 8;
DV_k(indices) = 8 + log(DV_k(indices) - 8);
% 找到 DV_k 中不为0的索引
nonZeroIndices = DV_k ~= 0;
% 使用 scatter 函数画出蓝色方块，'s' 表示正方形标记
scatter(find(nonZeroIndices), DV_k(nonZeroIndices), 150, 's', 'MarkerEdgeColor', [0 0.4470 0.7410], 'MarkerFaceColor', [0 0.4470 0.7410]);

% 数据转换：超过8的取对数，否则保持原值
transformedNLeaf = nLeaf;
indices = nLeaf > 8;
transformedNLeaf(indices) = 8 + log(nLeaf(indices) - 8);


% 画线
h = zeros(1, 5);  % 初始化图例句柄数组
for i = 1:5
    h(i) = plot(transformedNLeaf(:,i), 'LineWidth', 2, 'Color', colors(i,:));  % 绘制线
end

% 画点
for j = 2:5  % 从第二列开始
    % 只在当前列的点落在第一列±1区域内时添加黑点
    pointsInTolerance = abs(nLeaf(:,j) - nLeaf(:,1)) <= 1;
    scatter(x(pointsInTolerance), transformedNLeaf(pointsInTolerance, j), 50, 'k', 'filled');
end

% 图例和标签
legend(h, algo, 'Location', 'northwest');
xlabel('Data set');
ylabel('Number of Clusters');
% title('Comparison of Different Methods');

% 美化图形
set(gca, 'FontSize', 14);
box on;
grid on;
ylim([0 max(transformedNLeaf(:))+1]);  % 调整y轴范围以适应数据
%ylim([0 max([transformedNLeaf(:); DV_k]) + 1]);  % 调整y轴范围以适应所有数据，包括 DV_k

% 定义刻度
%yTicks = [2, 4, 6, 8, 10, 14, 42, 64];
yTicks = [2, 4, 6, 8, 8+log(10-8), 8+log(13-8), 8+log(32-8), 8+log(64-8)];
yTickLabels = {'2', '4', '6', '8', '10', '13', '32', '64'};

% 应用自定义刻度
set(gca, 'YTick', yTicks, 'YTickLabels', yTickLabels);

set(gca, 'XTick', 1:length(data), 'XTickLabel', data, 'FontSize', 15); % 增加y轴标签的字体大小

% 设置字体
set(gca, 'FontName', 'Arial');

hold off;
