% load('PerformanceQuality.mat')
% Quality_Purity = zeros(18,11);
% Quality_Fscore = zeros(18,11);
% algo_names = {'SigDT', 'DV', 'CUBT^{Ham}', 'CUBT^{MI}', 'k-modes', 'Entropy', 'CDE', 'CDCDR', 'IMM', 'RDM', 'SHA'};
% for I = 1:18
%     Quality_Purity(I,:) = [Results(I,1) Metric_DV(I,3) CUBT_Ham_metrics(I,1) CUBT_MI_metrics(I,1) Metric_kmodes(I,3) Metric_Entropy(I,3) Metric_CDE(I,3) Metric_CDC_DR(I,3) IMM_metrics(I,1) RDM_metrics(I,1) SHA_metrics(I,1)];
%     Quality_Fscore(I,:) = [Results(I,2) Metric_DV(I,7) CUBT_Ham_metrics(I,2) CUBT_MI_metrics(I,2) Metric_kmodes(I,7) Metric_Entropy(I,7) Metric_CDE(I,7) Metric_CDC_DR(I,7) IMM_metrics(I,2) RDM_metrics(I,2) SHA_metrics(I,2)];
% end
load('Quality_metrics.mat')
dataNames = {'Ls', 'Lc', 'So', 'Zo', 'Ps', 'Hr', 'Ly', 'Hd', 'Sf',...
    'Pt', 'De', 'Hv', 'Bs', 'Ca', 'Bc', 'Mm', 'Tt', 'Ce'};
% 定义每个点的具体名称
algo_names = {'SigDT', 'DV', 'CUBT^{Ham}', 'CUBT^{MI}', 'k-modes', 'Entropy', 'CDE', 'CDCDR', 'IMM', 'RDM', 'SHA'};
% 准备数据
% Purity = [0.833 0.497 0.790 0.650 0.715 0.792 0.841 0.816 0.841 0.673 0.887];
% Fscore = [0.857 0.443 0.790 0.526 0.606 0.677 0.751 0.730 0.733 0.569 0.819];
% Purity = [0.802 0.950 0.733 0.832 0.831 0.876 0.872 0.871 0.888 0.810 0.917];
% Fscore = [0.685 0.964 0.793 0.916 0.705 0.705 0.765 0.790 0.772 0.630 0.796];
% 准备绘图
for I = 1:18  % Assuming you want to run this for a specific dataset index
    Purity = Quality_Purity(I,:);
    Fscore = Quality_Fscore(I,:);
    figure;
    hold on;
    set(gcf, 'Color', 'w');  % Set background to white
    set(gca, 'FontSize', 16);  % Increase font size for axis

    % Define different solid marker styles and colors
    markers = {'o', 's', 'd', 'd', 'p', 'p', 'h', 'h', '^', 'v', '>'};
    %  (1) bright yellow (2) shade of blue (3) red  (4) orange
    colors = [1 1 0; 0 0.4470 0.7410; 0.8500 0.3250 0.0980; 1 0.6 0];  % Added bright yellow to emphasize the first point

    % Color assignments, using newly added bright yellow for the first point
    color_assignments = [1, 2, 2, 3, 2, 3, 2, 3, 2, 3, 4];

    % Define the baseline point (purity1 and fscore1) if needed
    purity1 = Purity(1);
    fscore1 = Fscore(1);

    % Plot the scatter points, skipping those with Purity and F-score both zero
    for i = 1:length(Purity)
        if Purity(i) ~= 0 || Fscore(i) ~= 0  % Only plot if either value is non-zero
            scatter(Purity(i), Fscore(i), 750, 'Marker', markers{i}, 'MarkerFaceColor', colors(color_assignments(i), :), 'MarkerEdgeColor', 'k', 'LineWidth', 1.5);
        end
    end

    % Find the right upper corner points and draw dashed lines
    right_upper_purities = Purity(Purity > purity1);
    right_upper_fscores = Fscore(Fscore > fscore1 & Purity > purity1);

    if ~isempty(right_upper_purities) && ~isempty(right_upper_fscores)
        max_purity = max(right_upper_purities);
        max_fscore = max(right_upper_fscores);
        % Draw dashed lines to mark the specific area
        plot([purity1, max_purity], [fscore1, fscore1], 'k--', 'LineWidth', 5);
        plot([purity1, purity1], [fscore1, max_fscore], 'k--', 'LineWidth', 5);
        plot([purity1, max_purity], [max_fscore, max_fscore], 'k--', 'LineWidth', 5);
        plot([max_purity, max_purity], [fscore1, max_fscore], 'k--', 'LineWidth', 5);
    end

    % Count points superior to the baseline
    count_points = sum(Fscore > fscore1 & Purity > purity1);

    % Update the title based on count_points
    if count_points > 0
        titleText = ['Data set: ' dataNames{I} ' | Superiority Count: ' num2str(count_points)];
    else
        titleText = ['Data set: ' dataNames{I}];
    end
    title(titleText, 'FontSize', 22);  % Set the title with dynamic content

    % Legend, labels, and plot settings
%     lg = legend(algo_names, 'Location', 'best');
%     set(lg, 'FontSize', 25);  % Increase legend font size
    xlabel('Purity', 'FontSize', 16);
    ylabel('F-score', 'FontSize', 16);
    grid on;
    axis tight;  % Reduce whitespace
    box on;  % Add box around plot
    hold off;
end