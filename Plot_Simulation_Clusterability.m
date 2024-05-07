figure;
hold on; % 保持当前图形，用于在同一图上绘制多条线

% 绘制原始数据
plot(unclusterable_found, 'LineWidth', 2, 'Color', [0 0.4470 0.7410]); % 深蓝色
xlabel('Number of Exchange Events', 'FontSize', 15, 'FontWeight', 'bold');
ylabel('Identification Rate (%)', 'FontSize', 15, 'FontWeight', 'bold');
% title('Unclusterable data found', 'FontSize', 14, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
set(gcf, 'Color', 'w');

% 获取数据的最小值和长度
min_value = min(unclusterable_found);
data_length = length(unclusterable_found);

% 设置坐标轴范围
xlim([1 data_length]);
ylim([min_value max(unclusterable_found)]);

% 计算线性拟合
p = polyfit(1:data_length, unclusterable_found, 1); % 拟合一阶多项式，即直线
y_fit = polyval(p, 1:data_length); % 计算拟合直线的y值

% 绘制拟合直线
plot(y_fit, 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980]); % 橙色

hold off; % 结束保持状态