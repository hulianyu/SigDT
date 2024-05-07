load('avgDepth_list.mat')
% 数据集和算法名称
data = {'Ls', 'Lc', 'So', 'Zo', 'Ps', 'Hr', 'Ly', 'Hd', 'Sf', 'Pt', 'De', 'Hv', 'Bs', 'Ca', 'Bc', 'Mm', 'Tt', 'Ce'};
algo = {'SigDT','CUBT_{Max}','CUBT^{Ham}','CUBT^{MI}','IMM','RDM','SHA'};

% 应用自定义Y轴转换
avgDepth_transformed = avgDepth_list;
avgDepth_transformed(avgDepth_list > 4) = 4 + log(avgDepth_list(avgDepth_list > 4) - 4);

% 创建图形
figure;
b = bar(avgDepth_transformed, 'grouped');
set(gca, 'XTickLabel', data);
legend(algo, 'Location', 'northwest');
xlabel('Data set');
ylabel('avgDepth');

colors = [0.9, 0.9, 0.4;     % SigDT - 亮金色
          0.9, 0.9, 0.9;     % CUBT_{Max} - 非常浅的灰色
          1.0, 0.8, 0.8;     % CUBT^{Ham} - 浅粉红
          0.9, 0.5, 0.5;     % CUBT^{MI} - 淡红色
          0.3, 0.5, 0.9;     % IMM - 更浅的深蓝色
          0.6, 0.8, 1.0;     % RDM - 浅蓝色
          1, 0.5, 0];        % SHA - 深橙色

for i = 1:length(b)
    b(i).FaceColor = colors(i,:);
end

% 添加平均值水平线
line(xlim, [mean(avgDepth_list(:,1)) mean(avgDepth_list(:,1))], 'Color', colors(1,:), 'LineStyle', '--', 'LineWidth', 2);
line(xlim, [mean(avgDepth_list(:,7)) mean(avgDepth_list(:,7))], 'Color', colors(end,:), 'LineStyle', '--', 'LineWidth', 2);

% 定义刻度
yTicks = [1,2,3,4,4+log(6-4),4+log(10-4)];
yTickLabels = {'1','2','3','4','6','10'};

% 应用自定义刻度
set(gca, 'YTick', yTicks, 'YTickLabels', yTickLabels);

% 设置字体大小和字体，确保坐标轴标签不会重叠
set(gca, 'FontSize', 25);
set(gca, 'FontName', 'Arial');
set(gca, 'XTick', 1:length(data), 'XTickLabel', data, 'FontSize', 25); % 设置X轴标签的字体大小