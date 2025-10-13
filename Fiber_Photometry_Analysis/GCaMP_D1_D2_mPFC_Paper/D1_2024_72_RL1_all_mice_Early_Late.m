% D1GLUN1 mPFC Pool 2024-72 I & II RL1 Sess01

clc
clear

 cd 'F:\Fiber_Photometry\2024-72 D1cre D2cre mPFC Peptide 2024 total\2024-72_D1Cre\RESULTS_2024-72_Total_RL1_D1cre_BSLindiv_-2500ms_-1000ms_Lim_-2.5s_12s_Event_Group_Sess_Mouse'


% B1 = load("L1_press_Del_1.mat");
% B2 = load("L1_press_Del_2.mat");

% B1 = load("L2_press_Del_1.mat");
% B2 = load("L2_press_Del_2.mat");


B1 = load("L1_press_C1_1.mat");
B2 = load("L1_press_C1_2.mat");

% B1 = load("Levers_presentation_Del_1.mat");
% B2 = load("Levers_presentation_Del_2.mat");

% B1 = load("Levers_presentation_C1_1.mat");
% B2 = load("Levers_presentation_C1_2.mat");


B = cat(3, B1.means, B2.means);
B_cat_means = mean(B, 3, "omitnan");
B_means = mean(B_cat_means, 1);
B_std = std(B_cat_means,1);
B_sem = B_std/sqrt(size(B_cat_means,1));

% BB1 = load("L2_press_Del_1.mat");
% BB2 = load("L2_press_Del_2.mat");

BB1 = load("L2_press_C1_1.mat");
BB2 = load("L2_press_C1_2.mat");

% BB1 = load("L1_press_C1_1.mat");
% BB2 = load("L1_press_C1_2.mat");


BB = cat(3, BB1.means, BB2.means);
BB_cat_means = mean(BB, 3, "omitnan");
BB_means = mean(BB_cat_means, 1);
BB_std = std(BB_cat_means,0,1);
BB_sem = BB_std/sqrt(size(BB_cat_means,1));



% D1 = load("L1_press_Del_7.mat");
% D2 = load("L1_press_Del_8.mat");
% 
% row_indexD2 = 1;
% nan_rowD2 = nan(1, size(D2.means,2));
% D2.means = [D2.means(1:row_indexD2-1,:); nan_rowD2; D2.means(row_indexD2:end, :)]; %Pour L2/L1 DETA sess8

% D1 = load("L2_press_Del_7.mat");
% D2 = load("L2_press_Del_8.mat");

D1 = load("L1_press_C1_7.mat");
D2 = load("L1_press_C1_8.mat");


% D1 = load("Levers_presentation_Del_7.mat");
% D2 = load("Levers_presentation_Del_8.mat");

% D1 = load("Levers_presentation_C1_7.mat");
% D2 = load("Levers_presentation_C1_8.mat");

D = cat(3, D1.means, D2.means);
D_cat_means = mean(D, 3, "omitnan");
D_means = mean(D_cat_means, 1);
D_std = std(D_cat_means,1);
D_sem = D_std/sqrt(size(D_cat_means,1));



% DD1 = load("L2_press_Del_7.mat");
% DD2 = load("L2_press_Del_8.mat");
% 
% row_indexDD2 = 1;
% nan_rowDD2 = nan(1, size(DD2.means,2));
% DD2.means = [DD2.means(1:row_indexD2-1,:); nan_rowDD2; DD2.means(row_indexDD2:end, :)]; %Pour L2 DETA sess8
 
DD1 = load("L2_press_C1_7.mat");
DD2 = load("L2_press_C1_8.mat");

% DD1 = load("L1_press_C1_7.mat");
% DD2 = load("L1_press_C1_8.mat");


% % % row_indexDD2 = 1;
% % % nan_rowDD2 = nan(1, size(DD2.means,2));
% % % DD2.means = [DD2.means(1:row_indexDD2-1,:); nan_rowDD2;
% % % DD2.means(row_indexDD2:end, :)]; %Pour L2 DETA sess8

DD = cat(3, DD1.means, DD2.means);
DD_cat_means = mean(DD, 3, "omitnan");
DD_means = mean(DD_cat_means, 1);
DD_std = std(DD_cat_means,0,1);
DD_sem = DD_std/sqrt(size(DD_cat_means,1));

Xval = B1.x_values;
% Xval = C.x_values;
Xval = Xval/1000;


% %% Graph DELTA
% 
% hold on
% 
% 
% % Plot each animal in a different color
% colorsA = lines(size(DD_cat_means, 1));  % Generate distinguishable colors (same number as animals)
% for i = 1:size(DD_cat_means, 1)
%     if all(isnan(DD_cat_means(i, :)))
%         continue  % skip NaN-only rows
%     end
%     plot(Xval, DD_cat_means(i, :), 'Color', colorsA(i, :), 'LineWidth', 2, 'DisplayName', [num2str(i)]); 
% end
% legend('show');
% 
% % % plot(Xval,BB_means, 'Color', [1 0 0], 'LineWidth', 2, 'DisplayName', 'Reinforced'); %EARLY
% % plot(Xval,BB_means, 'Color', [1 0 0], 'LineWidth', 2, 'DisplayName', 'RL'); %EARLY
% % plot(Xval,BB_means-BB_sem,'LineWidth', 1 , 'Color', [1 0 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % plot(Xval,BB_means+BB_sem,'LineWidth', 1 , 'Color', [1 0 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % 
% % xC1L_=[Xval fliplr(Xval)];
% % yC1L_=[BB_means+BB_sem, fliplr(BB_means-BB_sem)];
% % patch(xC1L_,yC1L_,[1 0 0], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% % 
% % 
% % 
% % %plot(Xval,B_means, 'Color', [1 0.4784 0], 'LineWidth', 2, 'DisplayName', 'Early');
% % % plot(Xval,B_means, 'Color', [1 0.4784 0], 'LineWidth', 2, 'DisplayName', 'Unreinforced'); % EARLY
% % plot(Xval,B_means, 'Color', [1 0.4784 0], 'LineWidth', 2, 'DisplayName', 'UL'); % EARLY
% % plot(Xval,B_means-B_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % plot(Xval,B_means+B_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % 
% % xC1L_=[Xval fliplr(Xval)];
% % yC1L_=[B_means+B_sem, fliplr(B_means-B_sem)];
% % patch(xC1L_,yC1L_,[1 0.4784 0], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% 
% 
% 
% 
% 
% % % plot(Xval,DD_means, 'Color', [1 0 0], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Reinforced'); %LATE
% % plot(Xval,DD_means, 'Color', [1 0 0], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'RL'); %LATE
% % plot(Xval,DD_means-DD_sem,'LineWidth', 1 , 'Color', [1 0 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % plot(Xval,DD_means+DD_sem,'LineWidth', 1 , 'Color', [1 0 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % 
% % xC1L_=[Xval fliplr(Xval)];
% % yC1L_=[DD_means+DD_sem, fliplr(DD_means-DD_sem)];
% % patch(xC1L_,yC1L_,[1 0 0], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% % 
% % 
% % 
% % % plot(Xval,D_means, 'Color', [1 0.4784 0], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Unreinforced'); % LATE
% % plot(Xval,D_means, 'Color', [1 0.4784 0], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'UL'); % LATE
% % plot(Xval,D_means-D_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % plot(Xval,D_means+D_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % 
% % xC1L_=[Xval fliplr(Xval)];
% % yC1L_=[D_means+D_sem, fliplr(D_means-D_sem)];
% % patch(xC1L_,yC1L_,[1 0.4784 0], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% 
% 
% 
% 
% 
% %plot(Xval,C1,'Color', [1 0.4784 0], 'LineWidth', 1.5, 'LineStyle', ':',
% %'DisplayName', 'Unreinforced Lever - Delta' ); couleur DELTA [1 0 0]
% %plot(Xval,C1,'Color', [0.04117 0 1], 'LineWidth', 1.5, 'LineStyle', ':',
% %'DisplayName', 'Unreinforced Lever - C1' ); Couleur C1 [0.75 0 1]
% 
% 
% %xline([0 3000 10000],":r",{'CS', 'US', 'Fin CS'},'LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=1.5, FontSize=15);
% %xline(0,":r",'CS','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
% %xline(0,":r",'RL','LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=15);
% xline(0,":r",'LP','LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=17);
% % xline(0,":r",'LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=17);
% %xline(0,":r",'Lick','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
% %xline(0,":r",'US','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
% %xline(0,":r",'LP-Out','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
% 
% 
% yline(0,'-', LineWidth=1.5, HandleVisibility='off'); 
% ylabel(['Z-Score of ∆F/F'],'FontSize',16, 'FontWeight','bold');
% %ylabel(['Z-Score of ∆F/F +/- SEM'],'FontSize',15, 'FontWeight','bold');
% %xlabel(["Time from CS onset (s)"],"FontSize",15, "FontWeight","bold"); 
% xlabel(["Time from Lever Press ending (s)"],"FontSize",16, "FontWeight","bold"); 
% % xlabel(["Time from Lever Press (s)"],"FontSize",16, "FontWeight","bold"); 
% %xlabel(["Time from Licking onset (s)"],"FontSize",15, "FontWeight","bold"); 
% %xlabel(["Time from US onset (s)"],"FontSize",15, "FontWeight","bold"); 
% %xlabel(["Time from Lever Presentation (s)"],"FontSize",15, "FontWeight","bold"); 
% xt = get(gca, 'XTick');  
% xtl = get(gca, 'LineWidth');
% xtl = 1;
% yt = get(gca, 'YTick');
% ytl = get(gca, 'LineWidth');
% ytl = 1;
% ax = gca;
% ax.FontSize =16;
% ax.FontWeight ="bold";
% ax.LineWidth = 1.5;
% %xlim([-3000 13000]);
% %xlim([-2000 5000]);
% xlim([-2.5 2.5]);
% %ylim([-0.5 1.6]);
% %ylim([-1 2.6]);
% % ylim([-1.5 2.75]);% LP RL
% % ylim([-2 3]); %LP FR
% xL = xlim;
% yL = ylim;
% lgd = legend;
% set(lgd, 'FontSize', 17, 'FontWeight', 'normal','Location', 'southwest');
% % text(0.92*xL(1), 0.99*yL(2),'EARLY','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'BackgroundColor', [0.9 0.9 0.9], 'Margin', 0.01);
% text(0.92*xL(1), 0.99*yL(2),'LATE','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'BackgroundColor', [0.9 0.9 0.9], 'Margin', 0.01);
% 
% x0 = 20;
% y0 = 8;
% w = 13;
% % w = 11;
% %h = 18; 
% h = 13; 
% set(gcf, 'units', 'centimeters', 'position', [x0, y0, w, h]);
% 
% 
% hold off

%% Graph C1

hold on


% Plot each animal in a different color
colorsA = lines(size(DD_cat_means, 1));  % Generate distinguishable colors (same number as animals)
for i = 1:size(DD_cat_means, 1)
    if all(isnan(DD_cat_means(i, :)))
        continue  % skip NaN-only rows
    end
    plot(Xval, DD_cat_means(i, :), 'Color', colorsA(i, :), 'LineWidth', 2, 'DisplayName', [num2str(i)]); 
end
legend('show');


% % plot(Xval,BB_means, 'Color', [0.75 0 1], 'LineWidth', 2, 'DisplayName','Reinforced'); %EARLY
% plot(Xval,BB_means, 'Color', [0.75 0 1], 'LineWidth', 2, 'DisplayName','RL'); %EARLY
% plot(Xval,BB_means-BB_sem,'LineWidth', 1 , 'Color', [0.75 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,BB_means+BB_sem,'LineWidth', 1 , 'Color', [0.75 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[BB_means+BB_sem, fliplr(BB_means-BB_sem)];
% patch(xC1L_,yC1L_,[0.75 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% %plot(Xval,B_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'DisplayName', 'Early');
% % plot(Xval,B_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'DisplayName','Unreinforced'); %Early
% plot(Xval,B_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'DisplayName','UL'); %Early
% plot(Xval,B_means-B_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,B_means+B_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[B_means+B_sem, fliplr(B_means-B_sem)];
% patch(xC1L_,yC1L_,[0.04117 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');




% % plot(Xval,DD_means, 'Color', [0.75 0 1], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Reinforced');  %LATE
% plot(Xval,DD_means, 'Color', [0.75 0 1], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'RL');  %LATE
% plot(Xval,DD_means-DD_sem,'LineWidth', 1 , 'Color', [0.75 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,DD_means+DD_sem,'LineWidth', 1 , 'Color', [0.75 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[DD_means+DD_sem, fliplr(DD_means-DD_sem)];
% patch(xC1L_,yC1L_,[0.75 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% 
% 
% %plot(Xval,D_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Late');
% % plot(Xval,D_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Unreinforced'); %LATE
% plot(Xval,D_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'UL'); %LATE
% plot(Xval,D_means-D_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,D_means+D_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[D_means+D_sem, fliplr(D_means-D_sem)];
% patch(xC1L_,yC1L_,[0.04117 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');





%plot(Xval,C1,'Color', [1 0.4784 0], 'LineWidth', 1.5, 'LineStyle', ':',
%'DisplayName', 'Unreinforced Lever - Delta' ); couleur DELTA [1 0 0]
%plot(Xval,C1,'Color', [0.04117 0 1], 'LineWidth', 1.5, 'LineStyle', ':',
%'DisplayName', 'Unreinforced Lever - C1' ); Couleur C1 [0.75 0 1]


%xline([0 3000 10000],":r",{'CS', 'US', 'Fin CS'},'LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=1.5, FontSize=15);
%xline(0,":r",'CS','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'RL','LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=15);
xline(0,":r",'LP','LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=17);
% xline(0,":r",'LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=17);
%xline(0,":r",'Lick','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'US','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'LP-Out','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);


yline(0,'-', LineWidth=1.5, HandleVisibility='off'); 
ylabel(['Z-Score of ∆F/F'],'FontSize',16, 'FontWeight','bold');
%ylabel(['Z-Score of ∆F/F +/- SEM'],'FontSize',15, 'FontWeight','bold');
%xlabel(["Time from CS onset (s)"],"FontSize",15, "FontWeight","bold"); 
% xlabel(["Time from Lever Press ending (s)"],"FontSize",16, "FontWeight","bold"); 
xlabel(["Time from Lever Press (s)"],"FontSize",16, "FontWeight","bold"); 
%xlabel(["Time from Licking onset (s)"],"FontSize",15, "FontWeight","bold"); 
%xlabel(["Time from US onset (s)"],"FontSize",15, "FontWeight","bold"); 
%xlabel(["Time from Lever Presentation (s)"],"FontSize",15, "FontWeight","bold"); 

xt = get(gca, 'XTick');  
xtl = get(gca, 'LineWidth');
xtl = 1;
yt = get(gca, 'YTick');
ytl = get(gca, 'LineWidth');
ytl = 1;
ax = gca;
ax.FontSize =16;
ax.FontWeight ="bold";
ax.LineWidth = 1.5;
%xlim([-3000 13000]);
%xlim([-2000 5000]);
xlim([-2.5 2.5]);
xL = xlim;
%ylim([-0.5 1.6]);
%ylim([-1 2.6]);
% ylim([-1.5 2.75]); %LP RL1
ylim([-2 3]); %LP FR1
yL = ylim;
lgd = legend;
set(lgd, 'FontSize', 17, 'FontWeight', 'normal','Location', 'southwest');
%set(gca, 'ytick', -1:0.2:2.6);
% text(0.92*xL(1), 0.99*yL(2),'EARLY','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'BackgroundColor', [0.9 0.9 0.9], 'Margin', 0.01);
text(0.92*xL(1), 0.99*yL(2),'LATE','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'BackgroundColor', [0.9 0.9 0.9], 'Margin', 0.01);

x0 = 20;
y0 = 8;
w = 13;
% w = 11;
h = 13; 
%h = 18; 
set(gcf, 'units', 'centimeters', 'position', [x0, y0, w, h]);


hold off

% %% Graph C1/DELTA
% 
% hold on
% 
% plot(Xval,B_means, 'Color', [1 0.4784 0], 'LineWidth', 2, 'DisplayName', 'GluN1-\Delta - Early');
% %plot(Xval,B_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'DisplayName', 'UL-Early');
% plot(Xval,B_means-B_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,B_means+B_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[B_means+B_sem, fliplr(B_means-B_sem)];
% patch(xC1L_,yC1L_,[1 0.4784 0], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% plot(Xval,BB_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'DisplayName', 'GluN1-C1 - Early');
% plot(Xval,BB_means-BB_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,BB_means+BB_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[BB_means+BB_sem, fliplr(BB_means-BB_sem)];
% patch(xC1L_,yC1L_,[0.04117 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% 
% % plot(Xval,D_means, 'Color', [1 0.4784 0], 'LineWidth', 2, 'LineStyle', '--', 'DisplayName', 'GluN1-\Delta - Late');
% % %plot(Xval,D_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'UL-Late');
% % plot(Xval,D_means-D_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % plot(Xval,D_means+D_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % 
% % xC1L_=[Xval fliplr(Xval)];
% % yC1L_=[D_means+D_sem, fliplr(D_means-D_sem)];
% % patch(xC1L_,yC1L_,[1 0.4784 0], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% % 
% % plot(Xval,DD_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'LineStyle', '--', 'DisplayName', 'GluN1-C1 - Late');
% % plot(Xval,DD_means-DD_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % plot(Xval,DD_means+DD_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % 
% % xC1L_=[Xval fliplr(Xval)];
% % yC1L_=[DD_means+DD_sem, fliplr(DD_means-DD_sem)];
% % patch(xC1L_,yC1L_,[0.04117 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% 
% 
% %plot(Xval,C1,'Color', [1 0.4784 0], 'LineWidth', 1.5, 'LineStyle', ':',
% %'DisplayName', 'Unreinforced Lever - Delta' ); couleur DELTA [1 0 0]
% %plot(Xval,C1,'Color', [0.04117 0 1], 'LineWidth', 1.5, 'LineStyle', ':',
% %'DisplayName', 'Unreinforced Lever - C1' ); Couleur C1 [0.75 0 1]
% 
% 
% %xline([0 3000 10000],":r",{'CS', 'US', 'Fin CS'},'LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=1.5, FontSize=15);
% %xline(0,":r",'CS','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
% xline(0,":r",'LP-RL','LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=15);
% %xline(0,":r",'LP','LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=15);
% %xline(0,":r",'Lick','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
% %xline(0,":r",'US','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
% %xline(0,":r",'LP-Out','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
% 
% 
% yline(0,'-', HandleVisibility='off'); 
% ylabel(['Z-Score of ∆F/F +/- SEM'],'FontSize',15, 'FontWeight','bold');
% %xlabel(["Time from CS onset (s)"],"FontSize",15, "FontWeight","bold"); 
% xlabel(["Time from Lever Press onset (s)"],"FontSize",15, "FontWeight","bold"); 
% %xlabel(["Time from Licking onset (s)"],"FontSize",15, "FontWeight","bold"); 
% %xlabel(["Time from US onset (s)"],"FontSize",15, "FontWeight","bold"); 
% %xlabel(["Time from Lever Presentation (s)"],"FontSize",15, "FontWeight","bold"); 
% 
% xt = get(gca, 'XTick');  
% xtl = get(gca, 'LineWidth');
% xtl = 1;
% yt = get(gca, 'YTick');
% ytl = get(gca, 'LineWidth');
% ytl = 1;
% ax = gca;
% ax.FontSize =15;
% %xlim([-3000 13000]);
% %xlim([-2000 5000]);
% xlim([-2.5 2.5]);
% %ylim([-0.5 1.6]);
% %ylim([-1 2.6]);
% %ylim([-1.5 1.5]);
% %ylim([-1 1]);
% ylim([-1.5 2.65]);
% lgd = legend;
% set(lgd, 'FontSize', 12);
% %set(gca, 'ytick', -1:0.2:2.6);
% 
% x0 = 5;
% y0 = 0;
% %w = 12;
% %h = 16.5; 
% w = 13;
% h = 18; 
% set(gcf, 'units', 'centimeters', 'position', [x0, y0, w, h]);
% 
% 
% hold off

% %% AUC -1 0
% 
% % %AUC_C1_LPR_CS_I0-2000I_all  
% % AAA = trapz(Xval(16 : 26), B_cat_means(1 : end, 16 : 26), 2);
% % %AUC_C1_LPN_CS_I0-200I_all 
% % CCC = trapz(Xval(16 : 26), BB_cat_means(1 : end, 16 : 26), 2);
% % %AUC_DELTA_LPN_CS_I0-200I_all 
% % DDD = trapz(Xval(16 : 26), D_cat_means(1 : end, 16 : 26), 2);
% % %AUC_DELTA_LPR_CS_I0-2000I_all 
% % EEE = trapz(Xval(16 : 26), DD_cat_means(1 : end, 16 : 26), 2);
% 
% 
% % %% AUC 0 1
% % %AUC_C1_LPR_CS_I0-2000I_all  
% % AAA = trapz(Xval(26 : 36), B_cat_means(1 : end, 26 : 36), 2);
% % %AUC_C1_LPN_CS_I0-200I_all 
% % CCC = trapz(Xval(26 : 36), BB_cat_means(1 : end, 26 : 36), 2);
% % %AUC_DELTA_LPN_CS_I0-200I_all 
% % DDD = trapz(Xval(26 : 36), D_cat_means(1 : end, 26 : 36), 2);
% % %AUC_DELTA_LPR_CS_I0-2000I_all 
% % EEE = trapz(Xval(26 : 36), DD_cat_means(1 : end, 26 : 36), 2);
% 
% % %% Peak -1 0
% % 
% % AAA=B_cat_means(:,16:26);
% % CCC=BB_cat_means(:,16:26);
% % DDD=D_cat_means(:,16:26);
% % EEE=DD_cat_means(:,16:26);
% % 
% % UL_Early = max(AAA,[],2);
% % RL_Early = max(CCC,[],2);
% % UL_Late = max(DDD,[],2);
% % RL_Late = max(EEE,[],2);
% 
% % % Peak 0 1
% % 
% % AAA=B_cat_means(:,26:36);
% % CCC=BB_cat_means(:,26:36);
% % DDD=D_cat_means(:,26:36);
% % EEE=DD_cat_means(:,26:36);
% % 
% % UL_Early = max(AAA,[],2);
% % RL_Early = max(CCC,[],2);
% % UL_Late = max(DDD,[],2);
% % RL_Late = max(EEE,[],2);
% 
% 
% 
% % %% AUC 0 2
% % %AUC_C1_LPR_CS_I0-2000I_all  
% % AAA = trapz(Xval(26 : 46), B_cat_means(1 : end, 26 : 46), 2);
% % %AUC_C1_LPN_CS_I0-200I_all 
% % CCC = trapz(Xval(26 : 46), BB_cat_means(1 : end, 26 : 46), 2);
% % %AUC_DELTA_LPN_CS_I0-200I_all 
% % DDD = trapz(Xval(26 : 46), D_cat_means(1 : end, 26 : 46), 2);
% % %AUC_DELTA_LPR_CS_I0-2000I_all 
% % EEE = trapz(Xval(26 : 46), DD_cat_means(1 : end, 26 : 46), 2);
% 
% % % Peak 0 2
% % 
% % AAA=B_cat_means(:,26:46);
% % CCC=BB_cat_means(:,26:46);
% % DDD=D_cat_means(:,26:46);
% % EEE=DD_cat_means(:,26:46);
% % 
% % UL_Early = max(AAA,[],2);
% % RL_Early = max(CCC,[],2);
% % UL_Late = max(DDD,[],2);
% % RL_Late = max(EEE,[],2);
% 
% % %% AUC -0.9 -0.1
% % 
% % %AUC_C1_LPR_CS_I0-2000I_all  
% % AAA = trapz(Xval(17 : 25), B_cat_means(1 : end, 17 : 25), 2);
% % %AUC_C1_LPN_CS_I0-200I_all 
% % CCC = trapz(Xval(17 : 25), BB_cat_means(1 : end, 17 : 25), 2);
% % %AUC_DELTA_LPN_CS_I0-200I_all 
% % DDD = trapz(Xval(17 : 25), D_cat_means(1 : end, 17 : 25), 2);
% % %AUC_DELTA_LPR_CS_I0-2000I_all 
% % EEE = trapz(Xval(17 : 25), DD_cat_means(1 : end, 17 : 25), 2);
% 
% % %% Peak -0.9 -0.1
% % 
% % AAA=B_cat_means(:,17:25);
% % CCC=BB_cat_means(:,17:25);
% % DDD=D_cat_means(:,17:25);
% % EEE=DD_cat_means(:,17:25);
% % 
% % UL_Early = max(AAA,[],2);
% % RL_Early = max(CCC,[],2);
% % UL_Late = max(DDD,[],2);
% % RL_Late = max(EEE,[],2);
% 
% 
% % %% Mean Fluo Baseline [-2.5 ; -1]
% % AAA=B_cat_means(:,1:16);
% % CCC=BB_cat_means(:,1:16);
% % DDD=D_cat_means(:,1:16);
% % EEE=DD_cat_means(:,1:16);
% % 
% % UL_Early = mean(AAA,2);
% % RL_Early = mean(CCC,2);
% % UL_Late = mean(DDD,2);
% % RL_Late = mean(EEE,2);
% 
% % %% Mean Fluo Before [-0.9 ; -0.1]
% % AAA=B_cat_means(:,17:25);
% % CCC=BB_cat_means(:,17:25);
% % DDD=D_cat_means(:,17:25);
% % EEE=DD_cat_means(:,17:25);
% % 
% % UL_Early = mean(AAA,2);
% % RL_Early = mean(CCC,2);
% % UL_Late = mean(DDD,2);
% % RL_Late = mean(EEE,2);
% 
% % %% Mean Fluo After [0 ; 1]
% % AAA=B_cat_means(:,26:36);
% % CCC=BB_cat_means(:,26:36);
% % DDD=D_cat_means(:,26:36);
% % EEE=DD_cat_means(:,26:36);
% % 
% % UL_Early = mean(AAA,2);
% % RL_Early = mean(CCC,2);
% % UL_Late = mean(DDD,2);
% % RL_Late = mean(EEE,2);
% 
% % %% Mean Fluo After [0 ; 2]
% % AAA=B_cat_means(:,26:46);
% % CCC=BB_cat_means(:,26:46);
% % DDD=D_cat_means(:,26:46);
% % EEE=DD_cat_means(:,26:46);
% % 
% % UL_Early = mean(AAA,2);
% % RL_Early = mean(CCC,2);
% % UL_Late = mean(DDD,2);
% % RL_Late = mean(EEE,2);
% 
% 
% % %% MAX Fluo Baseline [-2.5 ; -1]
% % AAA=B_cat_means(:,1:16);
% % CCC=BB_cat_means(:,1:16);
% % DDD=D_cat_means(:,1:16);
% % EEE=DD_cat_means(:,1:16);
% % 
% % UL_Early = max(AAA,[],2);
% % RL_Early = max(CCC,[],2);
% % UL_Late = max(DDD,[],2);
% % RL_Late = max(EEE,[],2);


% %% AUC -0.9 0
% 
% %AUC_C1_LPR_CS_I0-2000I_all  
% UL_Early = trapz(Xval(17 : 26), B_cat_means(1 : end, 17 : 26), 2);
% %AUC_C1_LPN_CS_I0-200I_all 
% RL_Early = trapz(Xval(17 : 26), BB_cat_means(1 : end, 17 : 26), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% UL_Late = trapz(Xval(17 : 26), D_cat_means(1 : end, 17 : 26), 2);
% %AUC_DELTA_LPR_CS_I0-2000I_all 
% RL_Late = trapz(Xval(17 : 26), DD_cat_means(1 : end, 17 : 26), 2);



% %% Peak -0.9 0
% 
% AAA=B_cat_means(:,17:26);
% CCC=BB_cat_means(:,17:26);
% DDD=D_cat_means(:,17:26);
% EEE=DD_cat_means(:,17:26);
% 
% UL_Early = max(AAA,[],2);
% RL_Early = max(CCC,[],2);
% UL_Late = max(DDD,[],2);
% RL_Late = max(EEE,[],2);


% %% AUC 0.1 2
% %AUC_C1_LPR_CS_I0-2000I_all  
% UL_Early = trapz(Xval(27 : 46), B_cat_means(1 : end, 27 : 46), 2);
% %AUC_C1_LPN_CS_I0-200I_all 
% RL_Early = trapz(Xval(27 : 46), BB_cat_means(1 : end, 27 : 46), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% UL_Late = trapz(Xval(27 : 46), D_cat_means(1 : end, 27 : 46), 2);
% %AUC_DELTA_LPR_CS_I0-2000I_all 
% RL_Late = trapz(Xval(27 : 46), DD_cat_means(1 : end, 27 : 46), 2);

%% AUC 1.1 2
%AUC_C1_LPR_CS_I0-2000I_all  
UL_early = trapz(Xval(37 : 46), B_cat_means(1 : end, 37 : 46), 2);
%AUC_C1_LPN_CS_I0-200I_all 
RL_early = trapz(Xval(37 : 46), BB_cat_means(1 : end, 37 : 46), 2);
%AUC_DELTA_LPN_CS_I0-200I_all 
UL_late = trapz(Xval(37 : 46), D_cat_means(1 : end, 37 : 46), 2);
%AUC_DELTA_LPR_CS_I0-2000I_all 
RL_late = trapz(Xval(37 : 46), DD_cat_means(1 : end, 37 : 46), 2);

% % Peak 0.1 2
% 
% AAA=B_cat_means(:,27:46);
% CCC=BB_cat_means(:,27:46);
% DDD=D_cat_means(:,27:46);
% EEE=DD_cat_means(:,27:46);
% 
% UL_Early = max(AAA,[],2);
% RL_Early = max(CCC,[],2);
% UL_Late = max(DDD,[],2);
% RL_Late = max(EEE,[],2);

% %% AUC 0.1 1
% %AUC_C1_LPR_CS_I0-2000I_all  
% UL_Early = trapz(Xval(27 : 36), B_cat_means(1 : end, 27 : 36), 2);
% %AUC_C1_LPN_CS_I0-200I_all 
% RL_Early = trapz(Xval(27 : 36), BB_cat_means(1 : end, 27 : 36), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% UL_Late = trapz(Xval(27 : 36), D_cat_means(1 : end, 27 : 36), 2);
% %AUC_DELTA_LPR_CS_I0-2000I_all 
% RL_Late = trapz(Xval(27 : 36), DD_cat_means(1 : end, 27 : 36), 2);

% % Peak 0.1 1
% 
% AAA=B_cat_means(:,27:36);
% CCC=BB_cat_means(:,27:36);
% DDD=D_cat_means(:,27:36);
% EEE=DD_cat_means(:,27:36);
% 
% UL_Early = max(AAA,[],2);
% RL_Early = max(CCC,[],2);
% UL_Late = max(DDD,[],2);
% RL_Late = max(EEE,[],2);
