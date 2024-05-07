load('RunningTimes_list.mat')

% 算法名称
algo = {'SigDT','DV','CUBT^{Ham}','CUBT^{MI}','k-modes','Entropy','CDE','CDCDR','IMM','RDM','SHA'};

% 数据集名称
data = {'Ls', 'Lc', 'So', 'Zo', 'Ps', 'Hr', 'Ly', 'Hd', 'Sf',...
    'Pt', 'De', 'Hv', 'Bs', 'Ca', 'Bc', 'Mm', 'Tt', 'Ce'};

% 定义色阶边界
edges = [6.8E-4, 1E-3, 1E-2, 1E-1, 1, 708.2];

% 将运行时间映射到这些时间间隔
timeCategories = discretize(RunningTimes_list, edges);

% 创建热力图
figure;
imagesc(timeCategories);
colormap(blueMap); % 使用之前定义的蓝红色调色板
colorbar; % 显示色标

% 设定色标的刻度位置和标签，以匹配edges数组
clim([1 length(edges)]); % 设置色标范围
hColorbar = colorbar('Ticks', 1:length(edges), 'TickLabels', edges);
set(hColorbar, 'FontSize', 15); % 增加色标的字体大小

% 添加算法和数据集的名称到坐标轴
set(gca, 'XTick', 1:length(algo), 'XTickLabel', algo, 'XTickLabelRotation', 45, 'FontSize', 10); % 增加x轴标签的字体大小
set(gca, 'YTick', 1:length(data), 'YTickLabel', data, 'FontSize', 15); % 增加y轴标签的字体大小

% 添加标题和轴标签
%title('Running Times', 'FontSize', 20); % 增加标题的字体大小
xlabel('Algorithm', 'FontSize', 20); % 增加x轴标题的字体大小
ylabel('Data set', 'FontSize', 20); % 增加y轴标题的字体大小

% 设置字体
set(gca, 'FontName', 'Arial');