% GRAB DA mPFC test mice

clc
clear

cd 'F:\Fiber_Photometry\GRAB-DA-mPFC\2024-132 GRAB DA2m mPFC WT Yassiny 2025\RESULTS_GRAB_DA_PAVLOV_BSL-Indiv_-2500ms_-1000ms_Event_Mouse_Tri_79338'


% A1 = load("CS_27212.mat");
% A2 = load("CS_52505.mat");
% A3 = load("CS_67440.mat");
% A4 = load("CS_79257.mat");
% A5 = load("CS_83657.mat");
% A6 = load("CS_79338.mat");
% A7 = load("CS_83694.mat");
% A8 = load("CS_97084.mat");
% A9 = load("CS_97413.mat");
% A10 = load("CS_97424.mat");

% A1 = load("lick_27212.mat");
% A2 = load("lick_52505.mat");
% A3 = load("lick_67440.mat");
% A4 = load("lick_79257.mat");
% A5 = load("lick_83657.mat");
% A6 = load("lick_79338.mat");
% A7 = load("lick_83694.mat");
% A8 = load("lick_97084.mat");
% A9 = load("lick_97413.mat");
% A10 = load("lick_97424.mat");

% A1 = load("Licks_27212.mat");
% A2 = load("Licks_52505.mat");
% A3 = load("Licks_67440.mat");
% A4 = load("Licks_79257.mat");
% A5 = load("Licks_83657.mat");
% A6 = load("Licks_79338.mat");
% A7 = load("Licks_83694.mat");
% A8 = load("Licks_97084.mat");
% A9 = load("Licks_97413.mat");
% A10 = load("Licks_97424.mat");

% A1 = load("L2_press_27212.mat");
% A2 = load("L2_press_52505.mat");
% A3 = load("L2_press_67440.mat");
% A4 = load("L2_press_79257.mat");
% A5 = load("L2_press_83657.mat");
% A6 = load("L2_press_79338.mat");
% A7 = load("L2_press_83694.mat");
% A8 = load("L2_press_97084.mat");
% A9 = load("L2_press_97413.mat");
% A10 = load("L2_press_97424.mat");

% A1 = load("L2_press_27212_7.mat");
% A2 = load("L2_press_52505_7.mat");
% 
% % nan_rowA2 = nan(1, size(A2.matrix,2));
% % A2.matrix = [A2.matrix(1:48,:); nan_rowA2; A2.matrix(50:end, :)]; %Pour 52505 Sess 8 L1 RL2 remove trial 49 
% % A2_means = mean(A2.matrix, "omitnan");
% 
% %A3 = load("L2_press_67440_7.mat");
% A4 = load("L2_press_79257_7.mat");
% A5 = load("L2_press_83657_7.mat");
% A6 = load("L2_press_79338_7.mat");
% A7 = load("L2_press_83694_7.mat");
% %A8 = load("L2_press_97084_7.mat");
% A9 = load("L2_press_97413_7.mat");
% A10 = load("L2_press_97424_7.mat");

% B = load("CS.mat");
% %B = load("FIN_CS.mat");
B = load("lick.mat"); % PVL
% %B = load("Licks.mat"); % FR
% %B = load("L1_press.mat");
% % B = load("L2_press.mat");
% %B = load("Levers_presentation.mat");
% B = load("US.mat");
% B_means = mean(B.means,1);
% B_std = std(B.means,1);
% B_sem = B_std/sqrt(size(B.means,1));


% C = load("lick_1.mat");
% C_means = mean(C.means,1);
% C_std = std(C.means,1);
% C_sem = C_std/sqrt(size(C.means,1));

% B = load("lick_5.mat");
B_means = mean(B.means,1);
B_std = std(B.means,1);
B_sem = B_std/sqrt(size(B.means,1));


% A1 = load("lick_27212_1.mat");
% A2 = load("lick_52505_1.mat");
% A3 = load("lick_67440_1.mat");
% A4 = load("lick_79257_1.mat");
% A5 = load("lick_83657_1.mat");
% A6 = load("lick_79338_1.mat");
% A7 = load("lick_83694_1.mat");
% A8 = load("lick_97084_1.mat");
% A9 = load("lick_93413_1.mat");
% A10 = load("lick_97424_1.mat");

% A1 = load("CS_27212_1.mat");
% A2 = load("CS_52505_1.mat");
% A3 = load("CS_67440_1.mat");
% A4 = load("CS_79257_1.mat");
% A5 = load("CS_83657_1.mat");
% A6 = load("CS_79338_1.mat");
% A7 = load("CS_83694_1.mat");
% A8 = load("CS_97084_1.mat");
% A9 = load("CS_93413_1.mat");
% A10 = load("CS_97424_1.mat");

% A1 = load("CS_27212_5.mat");
% A2 = load("CS_52505_5.mat");
% A3 = load("CS_67440_5.mat");
% A4 = load("CS_79257_5.mat");
% A5 = load("CS_83657_5.mat");
% A6 = load("CS_79338_5.mat");
% A7 = load("CS_83694_5.mat");
% A8 = load("CS_97084_5.mat");
% A9 = load("CS_97413_5.mat");
% A10 = load("CS_97424_5.mat");

% A1_ = A1.matrix(1:3, :);
% A1_means = mean(A1_,1,"omitnan");
% 
% A2_ = A2.matrix(1:3, :);
% A2_means = mean(A2_,1,"omitnan");
% 
% A3_ = A3.matrix(1:3, :);
% A3_means = mean(A3_,1,"omitnan");
% 
% A4_ = A4.matrix(1:3, :);
% A4_means = mean(A4_,1,"omitnan");
% 
% A5_ = A5.matrix(1:3, :);
% A5_means = mean(A5_,1,"omitnan");
% 
% A6_ = A6.matrix(1:3, :);
% A6_means = mean(A6_,1,"omitnan");
% 
% A7_ = A7.matrix(1:3, :);
% A7_means = mean(A7_,1,"omitnan");
% 
% A8_ = A8.matrix(1:3, :);
% A8_means = mean(A8_,1,"omitnan");
% 
% A9_ = A9.matrix(1:3, :);
% A9_means = mean(A9_,1,"omitnan");
% 
% A10_ = A10.matrix(1:3, :);
% A10_means = mean(A10_,1,"omitnan");
% 
% A_cat = cat(1, A1_, A2_, A3_, A4_, A5_, A6_, A7_, A8_, A9_, A10_);
% A_cat_means = mean(A_cat,1,"omitnan");
% A_cat_std = std(A_cat);
% A_cat_sem = A_cat_std/sqrt(size(A_cat,1));


% Xval = A2.x_values;
Xval = B.x_values;
Xval = Xval/1000;

hold on

% plot(Xval,A1_means, 'Color', [0 0 1], 'LineWidth', 2, 'DisplayName', '27212');
% plot(Xval,A2_means, 'Color', [0 1 1], 'LineWidth', 2, 'DisplayName', '52505');
% plot(Xval,A3_means, 'Color', [1 0 0], 'LineWidth', 2, 'DisplayName', '67440');
% plot(Xval,A4_means, 'Color', [0.2 0.7 0.2], 'LineWidth', 2, 'DisplayName', '79257');
% plot(Xval,A5_means, 'Color', [1 1 0], 'LineWidth', 2, 'DisplayName', '83657');
% plot(Xval,A6_means, 'Color', [0.2 0 1], 'LineWidth', 2, 'DisplayName', '79338');
% plot(Xval,A7_means, 'Color', [0 0.5 1], 'LineWidth', 2, 'DisplayName', '83694');
% plot(Xval,A8_means, 'Color', [0 0.5 0.5], 'LineWidth', 2, 'DisplayName', '97084');
% plot(Xval,A9_means, 'Color', [0 1 0], 'LineWidth', 2, 'DisplayName', '97413');
% plot(Xval,A10_means, 'Color', [1 0 1], 'LineWidth', 2, 'DisplayName', '97424');

% plot(Xval,A1.means, 'Color', [0 0 1], 'LineWidth', 2, 'DisplayName', '27212');
% plot(Xval,A2.means, 'Color', [0 1 1], 'LineWidth', 2, 'DisplayName', '52505');
% plot(Xval,A3.means, 'Color', [1 0 0], 'LineWidth', 2, 'DisplayName', '67440');
% plot(Xval,A4.means, 'Color', [0.2 0.7 0.2], 'LineWidth', 2, 'DisplayName', '79257');
% plot(Xval,A5.means, 'Color', [1 1 0], 'LineWidth', 2, 'DisplayName', '83657');
% plot(Xval,A6.means, 'Color', [0.5 0 0.7], 'LineWidth', 2, 'DisplayName', '79338');
% plot(Xval,A7.means, 'Color', [0 0.5 1], 'LineWidth', 2, 'DisplayName', '83694');
% plot(Xval,A8.means, 'Color', [0 0.5 0.5], 'LineWidth', 2, 'DisplayName', '97084');
% plot(Xval,A9.means, 'Color', [0 1 0], 'LineWidth', 2, 'DisplayName', '97413');
% plot(Xval,A10.means, 'Color', [1 0 1], 'LineWidth', 2, 'DisplayName', '97424');


% plot(Xval,A_cat_means, 'Color', [0.5 0 1], 'LineWidth', 2, 'DisplayName', 'GRAB DA mPFC');
% plot(Xval,A_cat_means-A_cat_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,A_cat_means+A_cat_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[A_cat_means+A_cat_sem, fliplr(A_cat_means-A_cat_sem)];
% patch(xC1L_,yC1L_,[0.5 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');



% plot(Xval,C_means, 'Color', [0.5 0 1], 'LineWidth', 2, 'LineStyle', '-', 'DisplayName', 'S1');
% plot(Xval,C_means-C_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,C_means+C_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[C_means+C_sem, fliplr(C_means-C_sem)];
% patch(xC1L_,yC1L_,[0.5 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');



plot(Xval,B_means, 'Color', [0.25 0 0.5], 'LineWidth', 2, 'LineStyle', '-');
%plot(Xval,B_means, 'Color', [0.5 0 1], 'LineWidth', 2, 'LineStyle', '-', 'DisplayName', 'S1-S5');
plot(Xval,B_means-B_sem,'LineWidth', 1 , 'Color', [0.25 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
plot(Xval,B_means+B_sem,'LineWidth', 1 , 'Color', [0.25 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');

xC1L_=[Xval fliplr(Xval)];
yC1L_=[B_means+B_sem, fliplr(B_means-B_sem)];
patch(xC1L_,yC1L_,[0.25 0 0.5], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');


% xline([0 3 10],":r",{'CS', 'US','CS Off'},'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
% xline(0,":r",'Lick','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=17);
xline(0,":r",'CS','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=17);
% xline(0,":r",'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'Lever Out','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'LP','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
% xline(0,":r",'LP-UL','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'LP-RL','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);


yline(0,'-', HandleVisibility='off'); 
ylabel(['Z-Score of ∆F/F'],'FontSize',15, 'FontWeight','bold');
xlabel(["Time from CS onset (s)"],"FontSize",15, "FontWeight","bold"); 
% xlabel(["Time from Lever Press onset (s)"],"FontSize",15, "FontWeight","bold"); 
%xlabel(["Time from Lever presentation onset (s)"],"FontSize",15, "FontWeight","bold"); 
% xlabel(["Time from Licking onset(s)"],"FontSize",15, "FontWeight","bold"); 
%xlabel(["Time from US onset (s)"],"FontSize",15, "FontWeight","bold"); 
xt = get(gca, 'XTick');  
xtl = get(gca, 'LineWidth');
xtl = 1;
yt = get(gca, 'YTick');
ytl = get(gca, 'LineWidth');
ytl = 1;
ax = gca;
ax.FontSize =16;
ax.FontWeight ="bold";
ax.LineWidth = 1;
%xlim([-3000 13000]);
%xlim([-2000 5000]);
xlim([-2.5 2.5]);
ylim([-1.5 2.03]);
set(gca, 'xtick', -2:1:2);
xL = xlim;
yL = ylim;
lgd = legend;
% set(lgd, 'FontSize', 12, 'Location', 'northwest');
set(lgd, 'FontSize', 17, 'FontWeight', 'normal','Location', 'northwest');

xL = xlim;
yL = ylim;
%text(0.92*xL(1), 0.99*yL(2),'S7','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[0 0 0],'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);


x0 = 15;
y0 = 8;
%w = 12;
%h = 16.5; 
% w = 13;
% % h = 18; 
% h = 13; 
h = 13; 
w = 10.5;
set(gcf, 'units', 'centimeters', 'position', [x0, y0, w, h]);

hold off


% %% AUC -0.9 0
% BBB = trapz(Xval(17 : 26), B.means(1 : end, 17 : 26), 2);


% %% AUC 0.1 1
% BBB = trapz(Xval(27 : 36), B.means(1 : end, 27 : 36), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% % DDD = trapz(Xval(27 : 36), C.means(1 : end, 27 : 36), 2);

% %% AUC 0.1 2
% BBB = trapz(Xval(27 : 46), B.means(1 : end, 27 : 46), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% % DDD = trapz(Xval(27 : 36), C.means(1 : end, 27 : 36), 2);


% % Z-score 0.1 1
% 
% BBB=B.means(:,27 : 36);
% % DDD=C.means(:,27 : 36);
% 
% RL = mean(BBB,2);
% % UL = mean(DDD,2);

%% Peak -0.9 0

BBB=B.means(:,17:26);
% DDD=C.means(:,17:26);

Early = max(BBB,[],2);
% Late = max(DDD,[],2);

% % Peak 0.1 1
% 
% BBB=B.means(:,27 : 36);
% % DDD=C.means(:,27 : 36);
% 
% Early = max(BBB,[],2);
% % Late = max(DDD,[],2);
