% GRAB DA mPFC test mice

clc
clear

cd 'F:\Fiber_Photometry\GRAB-DA-mPFC\2024-132 GRAB DA2m mPFC WT Yassiny 2025\RESULTS_GRAB_DA_RL1_BSL-Indiv_-2500ms_-1000ms_Event_Sess_Mouse_tri_79338'

% 
% % A1 = load("CS_27212.mat");
% % A2 = load("CS_52505.mat");
% % A3 = load("CS_67440.mat");
% % A4 = load("CS_79257.mat");
% % A5 = load("CS_83657.mat");
% % A6 = load("CS_79338.mat");
% % A7 = load("CS_83694.mat");
% % A8 = load("CS_97084.mat");
% % A9 = load("CS_97413.mat");
% % A10 = load("CS_97424.mat");
% 
% % A1 = load("lick_27212.mat");
% % A2 = load("lick_52505.mat");
% % A3 = load("lick_67440.mat");
% % A4 = load("lick_79257.mat");
% % A5 = load("lick_83657.mat");
% % A6 = load("lick_79338.mat");
% % A7 = load("lick_83694.mat");
% % A8 = load("lick_97084.mat");
% % A9 = load("lick_97413.mat");
% % A10 = load("lick_97424.mat");

%B = load("CS.mat");
%B = load("FIN_CS.mat");
%B = load("lick.mat"); % PVL
%B = load("Licks.mat"); % FR
%B = load("L2_press.mat");
%B = load("Levers_presentation.mat");
%B = load("US.mat");

B1 = load("L1_press_1.mat");
B2 = load("L1_press_2.mat");

B = cat(3, B1.means, B2.means);
B_cat_means = mean(B, 3, "omitnan");
B_means = mean(B_cat_means, 1);
B_std = std(B_cat_means,1);
B_sem = B_std/sqrt(size(B_cat_means,1));


C1 = load("L2_press_1.mat");
C2 = load("L2_press_2.mat");

% C1 = load("Licks_1.mat");
% C2 = load("Licks_2.mat");

% C1 = load("Levers_presentation_1.mat");
% C2 = load("Levers_presentation_2.mat");

C = cat(3, C1.means, C2.means);
C_cat_means = mean(C, 3, "omitnan");
C_means = mean(C_cat_means, 1);
C_std = std(C_cat_means,1);
C_sem = C_std/sqrt(size(C_cat_means,1));

BB1 = load("L1_press_7.mat");
BB2 = load("L1_press_8.mat");


nan_rowBB1 = nan(1, size(BB1.means,2));
BB1.means = [BB1.means(1:7,:); nan_rowBB1; BB1.means(8:end, :)]; % L1press missing animal 8 for session 7 RL
BB2.means = [BB2.means(1:4,:); nan_rowBB1; BB2.means(5:end, :)]; % L1press missing animal 5 for session 8 RL

BB = cat(3, BB1.means, BB2.means);
BB_cat_means = mean(BB, 3, "omitnan");
BB_means = mean(BB_cat_means, 1);
BB_std = std(BB_cat_means,1);
BB_sem = BB_std/sqrt(size(BB_cat_means,1));

CC1 = load("L2_press_7.mat");
CC2 = load("L2_press_8.mat");

% CC1 = load("Licks_7.mat");
% CC2 = load("Licks_8.mat");

% CC1 = load("Levers_presentation_7.mat");
% CC2 = load("Levers_presentation_8.mat");

CC = cat(3, CC1.means, CC2.means);
CC_cat_means = mean(CC, 3, "omitnan");
CC_means = mean(CC_cat_means, 1);
CC_std = std(CC_cat_means,1);
CC_sem = CC_std/sqrt(size(CC_cat_means,1));



% % C = load("lick_1.mat");
% % C_means = mean(C.means,1);
% % C_std = std(C.means,1);
% % C_sem = C_std/sqrt(size(C.means,1));
% 
% % B = load("lick_5.mat");
% % B_means = mean(B.means,1);
% % B_std = std(B.means,1);
% % B_sem = B_std/sqrt(size(B.means,1));
% 
% 
% % A1 = load("lick_27212_1.mat");
% % A2 = load("lick_52505_1.mat");
% % A3 = load("lick_67440_1.mat");
% % A4 = load("lick_79257_1.mat");
% % A5 = load("lick_83657_1.mat");
% % A6 = load("lick_79338_1.mat");
% % A7 = load("lick_83694_1.mat");
% % A8 = load("lick_97084_1.mat");
% % A9 = load("lick_93413_1.mat");
% % A10 = load("lick_97424_1.mat");
% 
% % A1 = load("CS_27212_1.mat");
% % A2 = load("CS_52505_1.mat");
% % A3 = load("CS_67440_1.mat");
% % A4 = load("CS_79257_1.mat");
% % A5 = load("CS_83657_1.mat");
% % A6 = load("CS_79338_1.mat");
% % A7 = load("CS_83694_1.mat");
% % A8 = load("CS_97084_1.mat");
% % A9 = load("CS_93413_1.mat");
% % A10 = load("CS_97424_1.mat");
% 
% % A1 = load("CS_27212_5.mat");
% % A2 = load("CS_52505_5.mat");
% % A3 = load("CS_67440_5.mat");
% % A4 = load("CS_79257_5.mat");
% % A5 = load("CS_83657_5.mat");
% % A6 = load("CS_79338_5.mat");
% % A7 = load("CS_83694_5.mat");
% % A8 = load("CS_97084_5.mat");
% % A9 = load("CS_97413_5.mat");
% % A10 = load("CS_97424_5.mat");
% 
% % A1_ = A1.matrix(1:3, :);
% % A1_means = mean(A1_,1,"omitnan");
% % 
% % A2_ = A2.matrix(1:3, :);
% % A2_means = mean(A2_,1,"omitnan");
% % 
% % A3_ = A3.matrix(1:3, :);
% % A3_means = mean(A3_,1,"omitnan");
% % 
% % A4_ = A4.matrix(1:3, :);
% % A4_means = mean(A4_,1,"omitnan");
% % 
% % A5_ = A5.matrix(1:3, :);
% % A5_means = mean(A5_,1,"omitnan");
% % 
% % A6_ = A6.matrix(1:3, :);
% % A6_means = mean(A6_,1,"omitnan");
% % 
% % A7_ = A7.matrix(1:3, :);
% % A7_means = mean(A7_,1,"omitnan");
% % 
% % A8_ = A8.matrix(1:3, :);
% % A8_means = mean(A8_,1,"omitnan");
% % 
% % A9_ = A9.matrix(1:3, :);
% % A9_means = mean(A9_,1,"omitnan");
% % 
% % A10_ = A10.matrix(1:3, :);
% % A10_means = mean(A10_,1,"omitnan");
% % 
% % A_cat = cat(1, A1_, A2_, A3_, A4_, A5_, A6_, A7_, A8_, A9_, A10_);
% % A_cat_means = mean(A_cat,1,"omitnan");
% % A_cat_std = std(A_cat);
% % A_cat_sem = A_cat_std/sqrt(size(A_cat,1));


Xval = B1.x_values;
% Xval = B.x_values;
Xval = Xval/1000;

hold on

% % plot(Xval,A1_means, 'Color', [0 0 1], 'LineWidth', 2, 'DisplayName', '27212');
% % plot(Xval,A2_means, 'Color', [0 1 1], 'LineWidth', 2, 'DisplayName', '52505');
% % plot(Xval,A3_means, 'Color', [1 0 0], 'LineWidth', 2, 'DisplayName', '67440');
% % plot(Xval,A4_means, 'Color', [0.2 0.7 0.2], 'LineWidth', 2, 'DisplayName', '79257');
% % plot(Xval,A5_means, 'Color', [1 1 0], 'LineWidth', 2, 'DisplayName', '83657');
% % plot(Xval,A6_means, 'Color', [0.2 0 1], 'LineWidth', 2, 'DisplayName', '79338');
% % plot(Xval,A7_means, 'Color', [0 0.5 1], 'LineWidth', 2, 'DisplayName', '83694');
% % plot(Xval,A8_means, 'Color', [0 0.5 0.5], 'LineWidth', 2, 'DisplayName', '97084');
% % plot(Xval,A9_means, 'Color', [0 1 0], 'LineWidth', 2, 'DisplayName', '97413');
% % plot(Xval,A10_means, 'Color', [1 0 1], 'LineWidth', 2, 'DisplayName', '97424');
% 
% % plot(Xval,A1.means, 'Color', [0 0 1], 'LineWidth', 2, 'DisplayName', '27212');
% % plot(Xval,A2.means, 'Color', [0 1 1], 'LineWidth', 2, 'DisplayName', '52505');
% % plot(Xval,A3.means, 'Color', [1 0 0], 'LineWidth', 2, 'DisplayName', '67440');
% % plot(Xval,A4.means, 'Color', [0.2 0.7 0.2], 'LineWidth', 2, 'DisplayName', '79257');
% % plot(Xval,A5.means, 'Color', [1 1 0], 'LineWidth', 2, 'DisplayName', '83657');
% % plot(Xval,A6.means, 'Color', [0.2 0 1], 'LineWidth', 2, 'DisplayName', '79338');
% % plot(Xval,A7.means, 'Color', [0 0.5 1], 'LineWidth', 2, 'DisplayName', '83694');
% % plot(Xval,A8.means, 'Color', [0 0.5 0.5], 'LineWidth', 2, 'DisplayName', '97084');
% % plot(Xval,A9.means, 'Color', [0 1 0], 'LineWidth', 2, 'DisplayName', '97413');
% % plot(Xval,A10.means, 'Color', [1 0 1], 'LineWidth', 2, 'DisplayName', '97424');
% 
% 
% % plot(Xval,A_cat_means, 'Color', [0.5 0 1], 'LineWidth', 2, 'DisplayName', 'GRAB DA mPFC');
% % plot(Xval,A_cat_means-A_cat_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % plot(Xval,A_cat_means+A_cat_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % 
% % xC1L_=[Xval fliplr(Xval)];
% % yC1L_=[A_cat_means+A_cat_sem, fliplr(A_cat_means-A_cat_sem)];
% % patch(xC1L_,yC1L_,[0.5 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% 
% % plot(Xval,B_means, 'Color', [0.5 0 1], 'LineWidth', 2, 'LineStyle', '-', 'DisplayName', 'S1-S3');
% % plot(Xval,B_means-B_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % plot(Xval,B_means+B_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % 
% % xC1L_=[Xval fliplr(Xval)];
% % yC1L_=[B_means+B_sem, fliplr(B_means-B_sem)];
% % patch(xC1L_,yC1L_,[0.5 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');

% % Plot each animal in a different color
% colorsA = lines(size(CC_cat_means, 1));  % Generate distinguishable colors (same number as animals)
% for i = 1:size(CC_cat_means, 1)
%     if all(isnan(CC_cat_means(i, :)))
%         continue  % skip NaN-only rows
%     end
%     plot(Xval, CC_cat_means(i, :), 'Color', colorsA(i, :), 'LineWidth', 2, 'DisplayName', ['Animal ' num2str(i)]);
% end
% legend('show');

% plot(Xval,C_means, 'Color', [0.25 0 0.5], 'LineWidth', 2, 'LineStyle', '-', 'DisplayName', 'RL'); %EARLY
% % plot(Xval,C_means, 'Color', [0.25 0 0.5], 'LineWidth', 2, 'LineStyle', '-', 'DisplayName', 'Early');
% plot(Xval,C_means-C_sem,'LineWidth', 1 , 'Color', [0.25 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,C_means+C_sem,'LineWidth', 1 , 'Color', [0.25 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[C_means+C_sem, fliplr(C_means-C_sem)];
% patch(xC1L_,yC1L_,[0.25 0 0.5], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% 
% 
% plot(Xval,B_means, 'Color', [0.8 0 0.5], 'LineWidth', 2, 'LineStyle', '-', 'DisplayName', 'UL'); %EARLY
% % plot(Xval,B_means, 'Color', [0.8 0 0.5], 'LineWidth', 2, 'LineStyle', '-', 'DisplayName', 'Early'); %EARLY
% plot(Xval,B_means-B_sem,'LineWidth', 1 , 'Color', [0.8 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,B_means+B_sem,'LineWidth', 1 , 'Color', [0.8 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[B_means+B_sem, fliplr(B_means-B_sem)];
% patch(xC1L_,yC1L_,[0.8 0 0.5], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');




% % Plot each animal in a different color
% colorsA = lines(size(BB_cat_means, 1));  % Generate distinguishable colors (same number as animals)
% for i = 1:size(BB_cat_means, 1)
%     if all(isnan(BB_cat_means(i, :)))
%         continue  % skip NaN-only rows
%     end
%     plot(Xval, BB_cat_means(i, :), 'Color', colorsA(i, :), 'LineWidth', 2, 'DisplayName', [num2str(i)]); 
% end
% legend('show');


% plot(Xval,CC_means, 'Color', [0.25 0 0.5], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'RL'); %Late
% % plot(Xval,CC_means, 'Color', [0.25 0 0.5], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Late');
% plot(Xval,CC_means-CC_sem,'LineWidth', 1 , 'Color', [0.25 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,CC_means+CC_sem,'LineWidth', 1 , 'Color', [0.25 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[CC_means+CC_sem, fliplr(CC_means-CC_sem)];
% patch(xC1L_,yC1L_,[0.25 0 0.5], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% 
% 
% plot(Xval,BB_means, 'Color', [0.8 0 0.5], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'UL'); %Late
% % plot(Xval,BB_means, 'Color', [0.8 0 0.5], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Late'); %Late
% plot(Xval,BB_means-BB_sem,'LineWidth', 1 , 'Color', [0.8 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,BB_means+BB_sem,'LineWidth', 1 , 'Color', [0.8 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[BB_means+BB_sem, fliplr(BB_means-BB_sem)];
% patch(xC1L_,yC1L_,[0.8 0 0.5], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');



%xline(0,":r",'CS','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'Lick','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'Lever Out','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
xline(0,":r",'LP','LabelOrientation','horizontal','LabelHorizontalAlignment','left',HandleVisibility='off',LineWidth=2.5, FontSize=17);
%xline(0,":r",'LP-UL','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);


yline(0,'-', LineWidth=1.5, HandleVisibility='off');  
ylabel(['Z-Score of ∆F/F'],'FontSize',16, 'FontWeight','bold');
%xlabel(["Time from CS onset (s)"],"FontSize",15, "FontWeight","bold"); 
xlabel(["Time from Lever Press (s)"],"FontSize",16, "FontWeight","bold"); 
% xlabel(["Time from Lever presentation onset (s)"],"FontSize",15, "FontWeight","bold"); 
%xlabel(["Time from Licking onset (s)"],"FontSize",15, "FontWeight","bold"); 
%xlabel(["Time from US onset (s)"],"FontSize",15, "FontWeight","bold"); 
xt = get(gca, 'XTick');  
xtl = get(gca, 'LineWidth');
xtl = 1;
yt = get(gca, 'YTick');
ytl = get(gca, 'LineWidth');
ytl = 1;
ax = gca;
ax.FontSize =17;
ax.FontWeight ="bold";
ax.LineWidth = 1.5;
%xlim([-3000 13000]);
%xlim([-2000 5000]);
xlim([-2.5 3]);
% ylim([-1.5 2.03]);
ylim([-3 3]);
xL = xlim;
yL = ylim;
lgd = legend;
set(gca, 'xtick', -2:1:3);
% set(lgd, 'FontSize', 12, 'Location', 'northwest');
% set(lgd, 'FontSize', 17, 'FontWeight', 'normal','Location', 'northwest');
set(lgd, 'FontSize', 11, 'FontWeight', 'bold','Location', 'northwest');
% text(0.92*xL(1), -0.56*yL(2),'LATE','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[0 0 0], 'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);
% text(0.92*xL(1), -0.56*yL(2),'EARLY','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[0 0 0], 'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);
% text(0.92*xL(1), 0.99*yL(2),'RL','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[0 0 0], 'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);
%text(0.92*xL(1), 0.99*yL(2),'UL','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[0 0 0], 'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);



x0 = 20;
y0 = 8;
%w = 12;
%h = 16.5; 
w = 13;
% h = 18; 
h = 13; 
% w = 10.5;
set(gcf, 'units', 'centimeters', 'position', [x0, y0, w, h]);

hold off

% %% AUC -0.9 0
% UL_EARLY  = trapz(Xval(17 : 26), B_cat_means(1 : end, 17 : 26), 2);
% RL_EARLY  = trapz(Xval(17 : 26), C_cat_means(1 : end, 17 : 26), 2);
% UL_LATE  = trapz(Xval(17 : 26), BB_cat_means(1 : end, 17 : 26), 2);
% RL_LATE  = trapz(Xval(17 : 26), CC_cat_means(1 : end, 17 : 26), 2);


% %% AUC 0.1 1
% UL_EARLY  = trapz(Xval(27 : 36), B_cat_means(1 : end, 27 : 36), 2);
% RL_EARLY  = trapz(Xval(27 : 36), C_cat_means(1 : end, 27 : 36), 2);
% UL_LATE  = trapz(Xval(27 : 36), BB_cat_means(1 : end, 27 : 36), 2);
% RL_LATE  = trapz(Xval(27 : 36), CC_cat_means(1 : end, 27 : 36), 2);

%% AUC 0.1 2
UL_EARLY  = trapz(Xval(27 : 46), B_cat_means(1 : end, 27 : 46), 2);
RL_EARLY  = trapz(Xval(27 : 46), C_cat_means(1 : end, 27 : 46), 2);
UL_LATE  = trapz(Xval(27 : 46), BB_cat_means(1 : end, 27 : 46), 2);
RL_LATE  = trapz(Xval(27 : 46), CC_cat_means(1 : end, 27 : 46), 2);

% % %% Peak -0.9 0
% 
% BBB=B_cat_means(:,17:26);
% DDD=C_cat_means(:,17:26);
% EEE=BB_cat_means(:,17:26);
% FFF=CC_cat_means(:,17:26);
% 
% UL_EARLY  = max(BBB,[],2);
% RL_EARLY = max(DDD,[],2);
% UL_LATE  = max(EEE,[],2);
% RL_LATE = max(FFF,[],2);

% %% Peak -0.9 0 MINIMUM
% 
% BBB=B_cat_means(:,17:26);
% DDD=C_cat_means(:,17:26);
% EEE=BB_cat_means(:,17:26);
% FFF=CC_cat_means(:,17:26);
% 
% UL_EARLY  = min(BBB,[],2);
% RL_EARLY = min(DDD,[],2);
% UL_LATE  = min(EEE,[],2);
% RL_LATE = min(FFF,[],2);

% % Peak 0.1 1
% 
% BBB=B_cat_means(:,27 : 36);
% DDD=C_cat_means(:,27 : 36);
% EEE=BB_cat_means(:,27 : 36);
% FFF=CC_cat_means(:,27 : 36);
% 
% UL_EARLY  = max(BBB,[],2);
% RL_EARLY = max(DDD,[],2);
% UL_LATE  = max(EEE,[],2);
% RL_LATE = max(FFF,[],2);


% %% AUC 0.1 1.5
% UL_EARLY  = trapz(Xval(27 : 41), B_cat_means(1 : end, 27 : 41), 2);
% RL_EARLY  = trapz(Xval(27 : 41), C_cat_means(1 : end, 27 : 41), 2);
% UL_LATE  = trapz(Xval(27 : 41), BB_cat_means(1 : end, 27 : 41), 2);
% RL_LATE  = trapz(Xval(27 : 41), CC_cat_means(1 : end, 27 : 41), 2);

% %% AUC 1.1 3
% UL_EARLY  = trapz(Xval(37 : 56), B_cat_means(1 : end, 37 : 56), 2);
% RL_EARLY  = trapz(Xval(37 : 56), C_cat_means(1 : end, 37 : 56), 2);
% UL_LATE  = trapz(Xval(37 : 56), BB_cat_means(1 : end, 37 : 56), 2);
% RL_LATE  = trapz(Xval(37 : 56), CC_cat_means(1 : end, 37 : 56), 2);

% %% AUC 1.1 2
% UL_EARLY  = trapz(Xval(37 : 46), B_cat_means(1 : end, 37 : 46), 2);
% RL_EARLY  = trapz(Xval(37 : 46), C_cat_means(1 : end, 37 : 46), 2);
% UL_LATE  = trapz(Xval(37 : 46), BB_cat_means(1 : end, 37 : 46), 2);
% RL_LATE  = trapz(Xval(37 : 46), CC_cat_means(1 : end, 37 : 46), 2);

% %% AUC 2.1 3
% UL_EARLY  = trapz(Xval(47 : 56), B_cat_means(1 : end, 47 : 56), 2);
% RL_EARLY  = trapz(Xval(47 : 56), C_cat_means(1 : end, 47 : 56), 2);
% UL_LATE  = trapz(Xval(47 : 56), BB_cat_means(1 : end, 47 : 56), 2);
% RL_LATE  = trapz(Xval(47 : 56), CC_cat_means(1 : end, 47 : 56), 2);

% %% AUC 1.6 3
% UL_EARLY  = trapz(Xval(42 : 56), B_cat_means(1 : end, 42 : 56), 2);
% RL_EARLY  = trapz(Xval(42 : 56), C_cat_means(1 : end, 42 : 56), 2);
% UL_LATE  = trapz(Xval(42 : 56), BB_cat_means(1 : end, 42 : 56), 2);
% RL_LATE  = trapz(Xval(42 : 56), CC_cat_means(1 : end, 42 : 56), 2);

% % Peak 2.1 3
% 
% BBB=B_cat_means(:,47 : 56);
% DDD=C_cat_means(:,47 : 56);
% EEE=BB_cat_means(:,47 : 56);
% FFF=CC_cat_means(:,47 : 56);
% 
% UL_EARLY  = max(BBB,[],2);
% RL_EARLY = max(DDD,[],2);
% UL_LATE  = max(EEE,[],2);
% RL_LATE = max(FFF,[],2);

%  %%MIN peak 2.1 3
% 
% BBB=B_cat_means(:,47 : 56);
% DDD=C_cat_means(:,47 : 56);
% EEE=BB_cat_means(:,47 : 56);
% FFF=CC_cat_means(:,47 : 56);
% 
% UL_EARLY  = min(BBB,[],2);
% RL_EARLY = min(DDD,[],2);
% UL_LATE  = min(EEE,[],2);
% RL_LATE = min(FFF,[],2);

% % Peak 0.1 3
% 
% BBB=B_cat_means(:,27 : 56);
% DDD=C_cat_means(:,27 : 56);
% EEE=BB_cat_means(:,27 : 56);
% FFF=CC_cat_means(:,27 : 56);
% 
% UL_EARLY  = max(BBB,[],2);
% RL_EARLY = max(DDD,[],2);
% UL_LATE  = max(EEE,[],2);
% RL_LATE = max(FFF,[],2);

%  %%MIN peak 0.1 3
% 
% BBB=B_cat_means(:,27 : 56);
% DDD=C_cat_means(:,27 : 56);
% EEE=BB_cat_means(:,27 : 56);
% FFF=CC_cat_means(:,27 : 56);
% 
% UL_EARLY  = min(BBB,[],2);
% RL_EARLY = min(DDD,[],2);
% UL_LATE  = min(EEE,[],2);
% RL_LATE = min(FFF,[],2);

% %% Individual trace of RL/UL Early & Late
% 
% 
% RL_Early = C_cat_means;
% RL_Late = CC_cat_means;
% 
% UL_Early = B_cat_means;
% UL_Late = BB_cat_means;
% 
% % Names = ["27212"; "52505";"67440"; "79257"; "83657"; "83694"; "97084"; "97413"; "97424"];
% % Names = ["27212"; "52505";"67440"; "79257"; "83657"; "83694"; "97084"; "97413"; "97424"];
% 
% % Colors = {[1 0 0];[0 1 0];[0 0 1];[1 1 0];[1 0 1];[0 1 1];[0.2 0 0.8];[0.8 0 0.2];[0.5 0.5 1]};
% Colors = [1 0 0;0 1 0;0 0 1;1 1 0;1 0 1;0 1 1;0.2 0.7 0.8;0.8 0 0.2;0.5 0.5 1];
% 
% hold on 
% 
% 
% for i = 1:size(RL_Late,1) 
%     plot(Xval, RL_Late(i,:) ,'LineWidth', 2, 'LineStyle', ':');
% end
% 
% % for i = 1:size(RL_Early,1) 
% %     plot(Xval, RL_Early(i,:) ,'LineWidth', 2, 'LineStyle', '-');
% % end
% 
% % for i = 1:size(UL_Early,1) 
% %     plot(Xval, UL_Early(i,:) ,'LineWidth', 2, 'LineStyle', '-');
% % end
% 
% % for i = 1:size(UL_Late,1) 
% %     plot(Xval, UL_Late(i,:) ,'LineWidth', 2, 'LineStyle', ':');
% % end
% 
% xline(0,":r",'LP','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
% 
% 
% yline(0,'-', HandleVisibility='off'); 
% ylabel(['Z-Score of ∆F/F'],'FontSize',15, 'FontWeight','bold');
% xlabel(["Time from Lever Press onset (s)"],"FontSize",15, "FontWeight","bold");  
% xt = get(gca, 'XTick');  
% xtl = get(gca, 'LineWidth');
% xtl = 1;
% yt = get(gca, 'YTick');
% ytl = get(gca, 'LineWidth');
% ytl = 1;
% ax = gca;
% ax.FontSize =15;
% ax.ColorOrder = Colors;
% xlim([-2.5 12]);
% % ylim([-1.5 2]);
% % lgd = legend;
% legend({"27212", "52505","67440", "79257", "83657", "83694", "97084", "97413", "97424"}, 'FontSize', 12, 'Location', 'northwest');
% 
% % set(lgd, {"27212", "52505","67440", "79257", "83657", "83694", "97084", "97413", "97424"}, 'FontSize', 12, 'Location', 'northwest');
% 
% x0 = 5;
% y0 = 0;
% w = 13;
% % h = 18; 
% h = 13; 
% set(gcf, 'units', 'centimeters', 'position', [x0, y0, w, h]);
% 
% hold off



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %% Calculation of slope
% 
% vecteur_temps = Xval;
% % matrice_donnees = B_cat_means; % UL EARLY
% matrice_donnees = CC_cat_means; % RL EARLY
% % matrice_donnees = BB_cat_means; % UL LATE
% % matrice_donnees = CC_cat_means; % RL LATE
% 
% 
% % matrice_donnees = C.means; % UL
% % t_debut = 0.5;
% t_debut = 0;
% t_fin = 2.5;
% 
% 
% %% CHOIX DU MODE DE FENÊTRAGE
% % mode = 'global' : même fenêtre pour tous les individus
% % mode = 'individuel' : fenêtre ajustée par individu
% mode_fenetrage = 'global';  % 'global' ou 'individuel'
% 
% %% DÉFINITION DES FENÊTRES SELON LE MODE
% 
% if strcmp(mode_fenetrage, 'global')
%     %% MODE FENÊTRE GLOBALE
%     fprintf('Mode sélectionné : Fenêtre globale\n');
%     
%     % Définir une seule fenêtre pour tous
%     t_debut_global = 0;  % À ajuster selon vos données
%     t_fin_global = 3;    % À ajuster selon vos données
%     
%     % Appliquer à tous les individus
%     indices_fenetre = find(vecteur_temps >= t_debut_global & vecteur_temps <= t_fin_global);
%     donnees_fenetre = matrice_donnees(:, indices_fenetre);
%     temps_fenetre = vecteur_temps(indices_fenetre);
%     
%     % Trouver min/max pour chaque individu dans cette fenêtre
%     [valeurs_min, indices_min] = min(donnees_fenetre, [], 2);
%     [valeurs_max, indices_max] = max(donnees_fenetre, [], 2);
%     
%     temps_min = temps_fenetre(indices_min);
%     temps_max = temps_fenetre(indices_max);
%     
%     fprintf('Fenêtre appliquée : [%.2f, %.2f]\n', t_debut_global, t_fin_global);
%     
% elseif strcmp(mode_fenetrage, 'individuel')
%     %% MODE FENÊTRES INDIVIDUELLES
%     fprintf('Mode sélectionné : Fenêtres individuelles\n');
%     
%     % Définir les fenêtres par individu
%     % Option 1 : Fenêtres prédéfinies dans une matrice
%     % fenêtres_individuelles = [t_debut1, t_fin1; t_debut2, t_fin2; ...]
%     
%     % Option 2 : Fenêtres basées sur des critères automatiques
%     % Par exemple : centrer autour du pic global ± delta
%     fenetres_individuelles = definir_fenetres_individuelles(matrice_donnees, vecteur_temps);
%     
%     % Initialiser les résultats
%     nb_individus = size(matrice_donnees, 1);
%     temps_min = zeros(nb_individus, 1);
%     temps_max = zeros(nb_individus, 1);
%     valeurs_min = zeros(nb_individus, 1);
%     valeurs_max = zeros(nb_individus, 1);
%     
%     % Traiter chaque individu avec sa fenêtre spécifique
%     for i = 1:nb_individus
%         t_debut_i = fenetres_individuelles(i, 1);
%         t_fin_i = fenetres_individuelles(i, 2);
%         
%         indices_fenetre_i = find(vecteur_temps >= t_debut_i & vecteur_temps <= t_fin_i);
%         donnees_individu_i = matrice_donnees(i, indices_fenetre_i);
%         temps_fenetre_i = vecteur_temps(indices_fenetre_i);
%         
%         [valeurs_min(i), idx_min] = min(donnees_individu_i);
%         [valeurs_max(i), idx_max] = max(donnees_individu_i);
%         
%         temps_min(i) = temps_fenetre_i(idx_min);
%         temps_max(i) = temps_fenetre_i(idx_max);
%         
%         fprintf('Individu %d : fenêtre [%.2f, %.2f]\n', i, t_debut_i, t_fin_i);
%     end
% end
% 
% %% CALCUL DES PENTES (identique pour les deux modes)
% pentes_moyennes = zeros(size(matrice_donnees, 1), 1);
% nb_points_utilises = zeros(size(matrice_donnees, 1), 1);
% r_squared = zeros(size(matrice_donnees, 1), 1);
% 
% for i = 1:size(matrice_donnees, 1)
%     % Déterminer l'intervalle entre min et max
%     t_debut_individu = min(temps_min(i), temps_max(i));
%     t_fin_individu = max(temps_min(i), temps_max(i));
%     
%     indices_individu = find(vecteur_temps >= t_debut_individu & ...
%                            vecteur_temps <= t_fin_individu);
%     
%     temps_individu = vecteur_temps(indices_individu);
%     valeurs_individu = matrice_donnees(i, indices_individu);
%     
%     if length(temps_individu) >= 2
%         % Régression linéaire
%         p = polyfit(temps_individu, valeurs_individu, 1);
%         pentes_moyennes(i) = p(1);
%         nb_points_utilises(i) = length(temps_individu);
%         
%         % Calcul R²
%         y_regression = polyval(p, temps_individu);
%         y_mean = mean(valeurs_individu);
%         ss_tot = sum((valeurs_individu - y_mean).^2);
%         ss_res = sum((valeurs_individu - y_regression).^2);
%         r_squared(i) = 1 - (ss_res / ss_tot);
%     else
%         pentes_moyennes(i) = NaN;
%         nb_points_utilises(i) = length(temps_individu);
%         r_squared(i) = NaN;
%     end
% end
% 
% 
% %% RÉSULTATS
% resultats = table((1:size(matrice_donnees,1))', temps_min.', valeurs_min, ...
%                   temps_max.', valeurs_max, pentes_moyennes, r_squared, ...
%                   'VariableNames', {'Individu', 'Temps_Min', 'Valeur_Min', ...
%                                    'Temps_Max', 'Valeur_Max', 'Pente_Moyenne', 'R_Carre'});
% 
% fprintf('\n=== RÉSULTATS ===\n');
% disp(resultats);
% 
% %% VISUALISATION AVEC INDICATION DU MODE
% % [Code de visualisation précédent avec titre modifié]
% figure('Position', [100, 100, 1200, 800]);
% nb_cols = 4;
% nb_rows = ceil(size(matrice_donnees, 1) / nb_cols);
% 
% for i = 1:size(matrice_donnees, 1)
%     subplot(nb_rows, nb_cols, i);
%     
%     % [Même code de visualisation que précédemment]
%     t_debut_individu = min(temps_min(i), temps_max(i));
%     t_fin_individu = max(temps_min(i), temps_max(i));
%     indices_individu = find(vecteur_temps >= t_debut_individu & ...
%                            vecteur_temps <= t_fin_individu);
%     
%     temps_individu = vecteur_temps(indices_individu);
%     valeurs_individu = matrice_donnees(i, indices_individu);
%     
%     if length(temps_individu) >= 2
%         plot(temps_individu, valeurs_individu, 'bo-', 'MarkerSize', 4, 'LineWidth', 1);
%         hold on;
%         
%         p = polyfit(temps_individu, valeurs_individu, 1);
%         y_regression = polyval(p, temps_individu);
%         plot(temps_individu, y_regression, 'r-', 'LineWidth', 2);
%         
%         title(sprintf('Ind %d (p=%.3f, R²=%.3f)', i, p(1), r_squared(i)));
%     else
%         plot(temps_individu, valeurs_individu, 'bo', 'MarkerSize', 6);
%         title(sprintf('Individu %d (Insuff.)', i));
%     end
%     
%     xlabel('Temps'); ylabel('Valeur'); grid on; hold off;
% end
% 
% sgtitle(sprintf('Régressions linéaires - Mode : %s', mode_fenetrage));
% 
% 
% 
% %% ENREGISTREMENT DANS EXCEL SELON LE MODE DE FENÊTRAGE (TYPES COMPATIBLES)
% 
% % Nom du fichier Excel
% nom_fichier = sprintf('Resultats_Slope_%s_%s.xlsx', mode_fenetrage, datestr(now, 'yyyymmdd_HHMMSS'));
% 
% if strcmp(mode_fenetrage, 'global')
%     %% MODE FENÊTRE GLOBALE
%     
%     % Créer le titre avec les valeurs de la fenêtre globale
%     titre_fenetre = sprintf('Global_%.0f_%.0f', t_debut_global, t_fin_global);
%     
%     % Limiter à 31 caractères si nécessaire
%     if length(titre_fenetre) > 31
%         titre_fenetre = titre_fenetre(1:31);
%     end
%     
%     % Préparer le tableau des résultats SANS les informations d'en-tête
%     resultats_excel = table((1:size(matrice_donnees,1))', temps_min.', valeurs_min, ...
%                            temps_max.', valeurs_max, pentes_moyennes, r_squared, nb_points_utilises, ...
%                            'VariableNames', {'Individu', 'Temps_Min', 'Valeur_Min', ...
%                                             'Temps_Max', 'Valeur_Max', 'Pente_Moyenne', ...
%                                             'R_Carre', 'Nb_Points'});
%     
%     % Ajouter une colonne avec les informations de fenêtre
%     fenetre_info = repmat({sprintf('Global[%.1f-%.1f]', t_debut_global, t_fin_global)}, height(resultats_excel), 1);
%     resultats_excel.Type_Fenetre = fenetre_info;
%     
%     resultats_final = resultats_excel;
%     
% elseif strcmp(mode_fenetrage, 'individuel')
%     %% MODE FENÊTRES INDIVIDUELLES
%     
%     titre_fenetre = 'Individuelles';
%     
%     % Créer le tableau avec les fenêtres individuelles
%     resultats_excel = table((1:size(matrice_donnees,1))', ...
%                            fenetres_individuelles(:,1), fenetres_individuelles(:,2), ...
%                            temps_min, valeurs_min, temps_max, valeurs_max, ...
%                            pentes_moyennes, r_squared, nb_points_utilises, ...
%                            'VariableNames', {'Individu', 'Fenetre_Debut', 'Fenetre_Fin', ...
%                                             'Temps_Min', 'Valeur_Min', 'Temps_Max', 'Valeur_Max', ...
%                                             'Pente_Moyenne', 'R_Carre', 'Nb_Points'});
%     
%     % Ajouter une colonne indiquant le type
%     type_info = repmat({'Individuelle'}, height(resultats_excel), 1);
%     resultats_excel.Type_Fenetre = type_info;
%     
%     resultats_final = resultats_excel;
% end
% 
% % Écrire dans Excel
% writetable(resultats_final, nom_fichier, 'Sheet', titre_fenetre, 'WriteRowNames', false);
% 
% %% MÉTHODE ALTERNATIVE : ÉCRIRE DIRECTEMENT SANS COMBINER LES TABLES
% 
% % Version plus simple et plus sûre
% nom_fichier_simple = sprintf('Resultats_%s_%s.xlsx', mode_fenetrage, datestr(now, 'yyyymmdd_HHMMSS'));
% 
% if strcmp(mode_fenetrage, 'global')
%     % Tableau principal
%     resultats_propres = table((1:size(matrice_donnees,1))', temps_min.', valeurs_min, ...
%                              temps_max.', valeurs_max, pentes_moyennes, r_squared, nb_points_utilises, ...
%                              'VariableNames', {'Individu', 'Temps_Min', 'Valeur_Min', ...
%                                               'Temps_Max', 'Valeur_Max', 'Pente_Moyenne', ...
%                                               'R_Carre', 'Nb_Points'});
%     
%     % Feuille de résultats
%     writetable(resultats_propres, nom_fichier_simple, 'Sheet', 'Resultats', 'WriteRowNames', false);
%     
%     % Feuille avec les paramètres de fenêtre globale
%     info_fenetre = table({'PARAMETRES_FENETRE_GLOBALE'; 'Debut'; 'Fin'; 'Mode'}, ...
%                         {sprintf('Fenetre globale appliquee a tous'); t_debut_global; t_fin_global; mode_fenetrage}, ...
%                         'VariableNames', {'Description', 'Valeur'});
%     
% else
%     % Mode individuel
%     resultats_propres = table((1:size(matrice_donnees,1))', ...
%                              fenetres_individuelles(:,1), fenetres_individuelles(:,2), ...
%                              temps_min, valeurs_min, temps_max, valeurs_max, ...
%                              pentes_moyennes, r_squared, nb_points_utilises, ...
%                              'VariableNames', {'Individu', 'Fenetre_Debut', 'Fenetre_Fin', ...
%                                               'Temps_Min', 'Valeur_Min', 'Temps_Max', 'Valeur_Max', ...
%                                               'Pente_Moyenne', 'R_Carre', 'Nb_Points'});
%     
%     % Feuille de résultats
%     writetable(resultats_propres, nom_fichier_simple, 'Sheet', 'Resultats', 'WriteRowNames', false);
%     
%     % Feuille avec les paramètres
%     info_fenetre = table({'PARAMETRES_FENETRES_INDIVIDUELLES'; 'Fenetre_Min_Debut'; 'Fenetre_Max_Fin'; 'Mode'}, ...
%                         {sprintf('Fenetres ajustees par individu'); min(fenetres_individuelles(:,1)); ...
%                          max(fenetres_individuelles(:,2)); mode_fenetrage}, ...
%                         'VariableNames', {'Description', 'Valeur'});
% end
% 
% % Écrire les informations de fenêtrage
% writetable(info_fenetre, nom_fichier_simple, 'Sheet', 'Parametres_Fenetre', 'WriteRowNames', false);
% 
% %% FEUILLE D'INFORMATIONS GÉNÉRALES
% info_generale = table({'Date_Analyse'; 'Heure_Analyse'; 'Mode_Fenetrage'; 'Nb_Total_Individus'; ...
%                       'Individus_Valides'; 'Pente_Moyenne'; 'R_Carre_Moyen'}, ...
%                      {datestr(now, 'dd/mm/yyyy'); datestr(now, 'HH:MM:SS'); mode_fenetrage; ...
%                       size(matrice_donnees,1); sum(~isnan(pentes_moyennes)); ...
%                       nanmean(pentes_moyennes); nanmean(r_squared)}, ...
%                      'VariableNames', {'Parametre', 'Valeur'});
% 
% writetable(info_generale, nom_fichier_simple, 'Sheet', 'Info_Generale', 'WriteRowNames', false);
% 
% %% FEUILLE STATISTIQUES DÉTAILLÉES
% stats_detaillees = table({'Statistique'; 'Pente_Moyenne'; 'Pente_Mediane'; 'Pente_Ecart_Type'; ...
%                          'Pente_Min'; 'Pente_Max'; 'R_Carre_Moyen'; 'R_Carre_Mediane'; ...
%                          'R_Carre_Min'; 'R_Carre_Max'; 'Nb_Points_Moyen'}, ...
%                         {'Valeur'; nanmean(pentes_moyennes); nanmedian(pentes_moyennes); ...
%                          nanstd(pentes_moyennes); nanmin(pentes_moyennes); nanmax(pentes_moyennes); ...
%                          nanmean(r_squared); nanmedian(r_squared); nanmin(r_squared); ...
%                          nanmax(r_squared); nanmean(nb_points_utilises)}, ...
%                         'VariableNames', {'Type', 'Valeur'});
% 
% writetable(stats_detaillees, nom_fichier_simple, 'Sheet', 'Statistiques', 'WriteRowNames', false);
% 
% % %% VERSION ENCORE PLUS SIMPLE : UN SEUL FICHIER AVEC TOUT
% % nom_fichier_tout = sprintf('Analyse_Complete_%s.xlsx', datestr(now, 'yyyymmdd_HHMMSS'));
% % 
% % % Créer une grande table avec toutes les informations
% % if strcmp(mode_fenetrage, 'global')
% %     % Ajouter les informations de fenêtre comme colonnes
% %     fenetre_debut_col = repmat(t_debut_global, size(matrice_donnees,1), 1);
% %     fenetre_fin_col = repmat(t_fin_global, size(matrice_donnees,1), 1);
% %     
% %     tableau_complet = table((1:size(matrice_donnees,1))', fenetre_debut_col, fenetre_fin_col, ...
% %                            temps_min.', valeurs_min, temps_max.', valeurs_max, ...
% %                            pentes_moyennes, r_squared, nb_points_utilises, ...
% %                            'VariableNames', {'Individu', 'Fenetre_Globale_Debut', 'Fenetre_Globale_Fin', ...
% %                                             'Temps_Min', 'Valeur_Min', 'Temps_Max', 'Valeur_Max', ...
% %                                             'Pente_Moyenne', 'R_Carre', 'Nb_Points'});
% % else
% %     tableau_complet = table((1:size(matrice_donnees,1))', ...
% %                            fenetres_individuelles(:,1), fenetres_individuelles(:,2), ...
% %                            temps_min.', valeurs_min, temps_max.', valeurs_max, ...
% %                            pentes_moyennes, r_squared, nb_points_utilises, ...
% %                            'VariableNames', {'Individu', 'Fenetre_Debut', 'Fenetre_Fin', ...
% %                                             'Temps_Min', 'Valeur_Min', 'Temps_Max', 'Valeur_Max', ...
% %                                             'Pente_Moyenne', 'R_Carre', 'Nb_Points'});
% % end
% % 
% % writetable(tableau_complet, nom_fichier_tout, 'Sheet', 'Donnees_Completes', 'WriteRowNames', false);
% % 
% % fprintf('\n=== SAUVEGARDE TERMINÉE ===\n');
% % fprintf('Fichier principal : %s\n', nom_fichier);
% % fprintf('Fichier simple : %s\n', nom_fichier_simple);
% % fprintf('Fichier complet : %s\n', nom_fichier_tout);
% % 
% % % Affichage des résultats
% % fprintf('\n=== RÉSUMÉ ===\n');
% % disp(tableau_complet(1:min(5,end), :));  % Afficher les 5 premiers
% 
% 
% %% FONCTION POUR DÉFINIR LES FENÊTRES INDIVIDUELLES
% function fenetres = definir_fenetres_individuelles(matrice, temps)
%     nb_individus = size(matrice, 1);
%     fenetres = zeros(nb_individus, 2);
%     
%     % Exemple de stratégies pour définir les fenêtres individuelles :
%     
%     for i = 1:nb_individus
% %         % Stratégie 1 : Basée sur le pic global de chaque individu
% %         [~, idx_pic_global] = max(matrice(i, :));
% %         temps_pic = temps(idx_pic_global);
% %         delta_temps = 15;  % ± 15 unités de temps autour du pic
% %         
% %         fenêtres(i, 1) = max(temps(1), temps_pic - delta_temps);
% %         fenêtres(i, 2) = min(temps(end), temps_pic + delta_temps);
%         
%         % Stratégie 2 : Basée sur un seuil de la valeur maximale
%         % seuil = 0.8 * max(matrice(i, :));
%         % indices_seuil = find(matrice(i, :) >= seuil);
%         % fenêtres(i, 1) = temps(indices_seuil(1));
%         % fenêtres(i, 2) = temps(indices_seuil(end));
%         
% %         Stratégie 3 : Fenêtres prédéfinies manuellement
%         fenetres = [0, 2.5;   % Individu 1
%                     1, 2.5;  % Individu 2
%                     0, 2.5; % Individu 3, etc.
%                     0, 2.5;
%                     1, 2.5;
%                     0, 2.5;
%                     1, 2.5;
%                     0, 2.5;
%                     0.2, 2.5;]; 
%     end
% end
% 
% 
% %% FONCTION POUR VALIDER LES NOMS DE FEUILLES
% function nom_valide = valider_nom_feuille(nom_propose)
%     % Supprimer les caractères interdits
%     caracteres_interdits = {':', '\', '/', '?', '*', '[', ']'};
%     nom_valide = nom_propose;
%     
%     for i = 1:length(caracteres_interdits)
%         nom_valide = strrep(nom_valide, caracteres_interdits{i}, '_');
%     end
%     
%     % Limiter à 31 caractères
%     if length(nom_valide) > 31
%         nom_valide = nom_valide(1:31);
%     end
%     
%     % S'assurer qu'il n'est pas vide
%     if isempty(nom_valide)
%         nom_valide = 'Feuille1';
%     end
% end
% 
