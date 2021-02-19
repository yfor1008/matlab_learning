close all; clear; clc;

% 对比测试 getframe 与 saveas 的区别
% saveas 优点:
% - 保存图像简单方便
% saveas 缺点:
% - 但不能设置图像背景颜色
% - 保存图像有较宽的边界
% getframe 优点:
% - 可以设置图像背景颜色
% - 可以设置保存图像的边界宽度
% getframe 缺点:
% - 操作相对复杂
%

% saveas
back_color = [240,240,240]/255;
fig = figure('NumberTitle', 'off', 'Name', '标题', 'color', back_color);
plot(peaks)
set(gca, 'color', back_color);
saveas(fig, 'plot_saveas.jpg'); % 不能设置背景色, 需通过figure指定

% getframe, 整个图片区域=边缘填充区域+坐标轴区域+绘图区域, 等价于 saveas
back_color = [240,240,240]/255;
fig = figure('NumberTitle', 'off', 'Name', '标题', 'color', back_color);
plot(peaks)
set(gca, 'color', back_color);
ax = gca;
ax.Units = 'pixels';
pos = ax.OuterPosition; % 整个figure的坐标位置
rect = [0, 0, pos(3), pos(4)];
fig_rgb = getframe(fig, rect);
fig_rgb = fig_rgb.cdata;
imwrite(fig_rgb, 'plot_getframe_fig.jpg');

% getframe, 坐标轴区域+绘图区域
back_color = [240,240,240]/255;
fig = figure('NumberTitle', 'off', 'Name', '标题', 'color', back_color);
plot(peaks)
set(gca, 'color', back_color);
ax = gca;
ax.Units = 'pixels';
pos = ax.OuterPosition; % 整个axis的坐标位置
ti = ax.TightInset; % axis距离figure边界的距离
rect = [pos(1) + ti(1), pos(2) + ti(2), pos(3) - ti(1) - ti(3), pos(4) - ti(2) - ti(4)];
fig_rgb = getframe(fig, rect);
fig_rgb = fig_rgb.cdata;
imwrite(fig_rgb, 'plot_getframe_axis.jpg');

% getframe, 绘图区域
back_color = [240,240,240]/255;
fig = figure('NumberTitle', 'off', 'Name', '标题', 'color', back_color);
plot(peaks)
axis off
set(gca, 'color', back_color);
ax = gca;
ax.Units = 'pixels';
pos = ax.Position;
rect = [0, 0, pos(3), pos(4)];
fig_rgb = getframe(ax, rect);
fig_rgb = fig_rgb.cdata;
imwrite(fig_rgb, 'plot_getframe_image.jpg');

