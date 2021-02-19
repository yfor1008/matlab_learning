close all; clear; clc;

% 设置 figure 边界的宽度

%% 单幅图像显示
clear; clc;
back_color = [240,240,240]/255;
fig = figure('color', back_color);
plot(peaks)
set(gca, 'color', back_color);
ax = gca;
ax.Units = 'pixels';
pos = ax.OuterPosition; % 整个figure的坐标位置
rect = [0, 0, pos(3), pos(4)];
fig_rgb = getframe(fig, rect);
fig_rgb = fig_rgb.cdata;
imwrite(fig_rgb, 'single_plot_original.jpg');

% 改善, 边界尽量窄
clear; clc;
back_color = [240,240,240]/255;
fig = figure('color', back_color);
plot(peaks)
set(gca, 'color', back_color);
ax = gca;
ax.Units = 'pixels';
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];
% save
pos = ax.Position; % 整个figure的坐标位置
rect = [0, 0, round(pos(3)+pos(1)), round(pos(4)+pos(2))];
fig_rgb = getframe(fig, rect);
fig_rgb = fig_rgb.cdata;
imwrite(fig_rgb, 'single_plot_modify.jpg');

% 改善, 去除坐标轴以外的图像
clear; clc;
% fig = figure;
plot(peaks)
axis off
set(gca, 'color', [255, 255, 255]/255);
ax = gca;
ax.Units = 'pixels';
pos = ax.Position;
rect = [0, 0, pos(3), pos(4)];
fig_rgb = getframe(ax, rect);
fig_rgb = fig_rgb.cdata;
imwrite(fig_rgb, 'axisoff_plot_modify.jpg');

%% 多个子图显示
clear; clc;
fig = figure;
subplot(211), plot(peaks);
set(gca, 'color', [255, 255, 255]/255);
subplot(212), plot(peaks);
set(gca, 'color', [255, 255, 255]/255);
saveas(fig, 'multi_plot_original.jpg');

% 改善, 边界尽量窄
fig = figure('NumberTitle', 'off', 'Name', '标题');
T = tiledlayout(2,1);
T.TileSpacing = 'compact';
T.Padding = 'compact';
nexttile(1);
plot(peaks);
set(gca, 'color', [255, 255, 255]/255);
nexttile(2);
plot(peaks);
set(gca, 'color', [255, 255, 255]/255);
saveas(fig, 'multi_plot_modify.jpg');
