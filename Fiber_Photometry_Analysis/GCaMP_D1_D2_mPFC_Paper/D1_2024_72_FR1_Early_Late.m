% D1GLUN1 mPFC Pool 2024-72 I & II PVL Early Late

clc
clear

cd 'F:\Fiber_Photometry\2024-72 D1cre D2cre mPFC Peptide 2024 total\2024-72_D1Cre\RESULTS_2024-72_Total_FR1_D1cre_BSLindiv_-2500ms_-1000ms_Lim_-2.5s_12s_Event_Group_Sess_Mouse'


B1 = load("L1_press_Del_1.mat");
B2 = load("L1_press_Del_2.mat");

AN1 = load('L1_press_Del_1_45222.mat');
AN2 = load('L1_press_Del_1_58948.mat');
AN3 = load('L1_press_Del_1_78953.mat');
AN4 = load('L1_press_Del_1_79137.mat');
AN5 = load('L1_press_Del_1_79529.mat');

B1_means = cat(1, AN1.means, AN2.means, AN3.means, AN4.means, AN5.means);

B = cat(3, B1_means, B2.means);

% B1 = load("Levers_presentation_Del_1.mat");
% B2 = load("Levers_presentation_Del_2.mat");

% B1 = load("Licks_Del_1.mat");
% B2 = load("Licks_Del_2.mat");


% B = cat(3, B1.means, B2.means);
B_cat_means = mean(B, 3, "omitnan");
B_means = mean(B_cat_means,1, "omitnan");
B_std = std(B_cat_means,1, "omitnan");
B_sem = B_std/sqrt(size(B_cat_means,1));


BB1 = load("L1_press_C1_1.mat");
BB2 = load("L1_press_C1_2.mat");

% BB1 = load("Levers_presentation_C1_1.mat");
% BB2 = load("Levers_presentation_C1_2.mat");

% BB1 = load("Licks_C1_1.mat");
% BB2 = load("Licks_C1_2.mat");

BB = cat(3, BB1.means, BB2.means);
BB_cat_means = mean(BB, 3, "omitnan");
BB_means = mean(BB_cat_means,1);
BB_std = std(BB_cat_means,1);
BB_sem = BB_std/sqrt(size(BB_cat_means,1));

% C1 = load("L2_press_Del_4.mat");
% C2 = load("L2_press_Del_5.mat");
% %C2_means = mean(C2.matrix,1,'omitnan');
% 
% C = cat(1, C1.means, C2.means);
% C_means = mean(C, 1);
% C_std = std(C,1);
% C_sem = C_std/sqrt(size(C,1));


D1 = load("L1_press_Del_7.mat");
D2 = load("L1_press_Del_8.mat");

% D1 = load("Levers_presentation_Del_7.mat");
% D2 = load("Levers_presentation_Del_8.mat");

% D1 = load("Licks_Del_7.mat");
% D2 = load("Licks_Del_8.mat");


D = cat(3, D1.means, D2.means);
D_cat_means = mean(D, 3, "omitnan");
D_means = mean(D_cat_means, 1);
D_std = std(D_cat_means,1);
D_sem = D_std/sqrt(size(D_cat_means,1));


DD1 = load("L1_press_C1_7.mat");
DD2 = load("L1_press_C1_8.mat");

% DD1 = load("Levers_presentation_C1_7.mat");
% DD2 = load("Levers_presentation_C1_8.mat");

% DD1 = load("Licks_C1_7.mat");
% DD2 = load("Licks_C1_8.mat");


DD = cat(3, DD1.means, DD2.means);
DD_cat_means = mean(DD, 3, "omitnan");
DD_means = mean(DD_cat_means, 1);
DD_std = std(DD_cat_means,1);
DD_sem = DD_std/sqrt(size(DD_cat_means,1));


Xval = B1.x_values;
% Xval = C.x_values;
Xval = Xval/1000;


%% Graph 
hold on

% plot(Xval,B_means, 'Color', [1 0.4784 0], 'LineWidth', 2, 'DisplayName', 'Early'); %GluN1-\Delta-
% plot(Xval,B_means-B_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,B_means+B_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[B_means+B_sem, fliplr(B_means-B_sem)];
% patch(xC1L_,yC1L_,[1 0.4784 0], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');

plot(Xval,BB_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'DisplayName', 'Early'); %GluN1-C1-
plot(Xval,BB_means-BB_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
plot(Xval,BB_means+BB_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');

xC1L_=[Xval fliplr(Xval)];
yC1L_=[BB_means+BB_sem, fliplr(BB_means-BB_sem)];
patch(xC1L_,yC1L_,[0.04117 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');



% plot(Xval,D_means, 'Color', [1 0.4784 0], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Late'); %GluN1-\Delta-
% plot(Xval,D_means-D_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,D_means+D_sem,'LineWidth', 1 , 'Color', [1 0.4784 0] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[D_means+D_sem, fliplr(D_means-D_sem)];
% patch(xC1L_,yC1L_,[1 0.4784 0], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');

plot(Xval,DD_means, 'Color', [0.04117 0 1], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Late'); %GluN1-C1-
plot(Xval,DD_means-DD_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
plot(Xval,DD_means+DD_sem,'LineWidth', 1 , 'Color', [0.04117 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');

xC1L_=[Xval fliplr(Xval)];
yC1L_=[DD_means+DD_sem, fliplr(DD_means-DD_sem)];
patch(xC1L_,yC1L_,[0.04117 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');



%plot(Xval,C1,'Color', [1 0.4784 0], 'LineWidth', 1.5, 'LineStyle', ':',
%'DisplayName', 'Unreinforced Lever - Delta' ); couleur DELTA [1 0 0]
%plot(Xval,C1,'Color', [0.04117 0 1], 'LineWidth', 1.5, 'LineStyle', ':',
%'DisplayName', 'Unreinforced Lever - C1' ); Couleur C1 [0.75 0 1]


%xline([0 3000 10000],":r",{'CS', 'US', 'Fin CS'},'LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=1.5, FontSize=15);
% xline(0,":r",'CS','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'RL','LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=15);
xline(0,":r",'LP','LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=17);
% xline(0,":r",'LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=17);
% xline(0,":r",'Lick','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'US','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'LP-Out','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);

yline(0,'-', LineWidth=1.5, HandleVisibility='off'); 
ylabel(['Z-Score of ∆F/F'],'FontSize',16, 'FontWeight','bold');
%xlabel(["Time from CS onset (s)"],"FontSize",15, "FontWeight","bold"); 
xlabel(["Time from Lever Press ending (s)"],"FontSize",16, "FontWeight","bold"); 
% xlabel(["Time from Licking onset (s)"],"FontSize",15, "FontWeight","bold"); 
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
ylim([-2 3]); % LP
%ylim([-0.6 1.6]);
% ylim([-3.5 1]); % LICKS
% set(gca, 'ytick', -0.6:0.2:1.6);
xL = xlim;
yL = ylim;
lgd = legend;
set(lgd, 'FontSize', 17, 'FontWeight', 'normal','Location', 'southwest');
% text(0.92*xL(1), 0.99*yL(2),'GluN1-\Delta','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[1 0.4784 0], 'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);
text(0.92*xL(1), 0.99*yL(2),'GluN1-C1','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[0.04117 0 1],'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);
% text(0.92*xL(1), 0.99*yL(2),'D1/Control \n GluN1-\Delta','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[1 0.4784 0], 'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);



% x0 = 5;
% y0 = 0;
% %w = 12;
% %h = 16.5; 
% w = 13;
% h = 18; 
% set(gcf, 'units', 'centimeters', 'position', [x0, y0, w, h]);

x0 = 20;
y0 = 7;
w = 13;
h = 13; 
%h = 18; 
set(gcf, 'units', 'centimeters', 'position', [x0, y0, w, h]);

hold off

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
% % Del_Early = max(AAA,[],2);
% % C1_Early = max(CCC,[],2);
% % Del_Late = max(DDD,[],2);
% % C1_Late = max(EEE,[],2);
% 
% % % Peak 0 1
% % 
% % AAA=B_cat_means(:,26:36);
% % CCC=BB_cat_means(:,26:36);
% % DDD=D_cat_means(:,26:36);
% % EEE=DD_cat_means(:,26:36);
% % 
% % Del_Early = max(AAA,[],2);
% % C1_Early = max(CCC,[],2);
% % Del_Late = max(DDD,[],2);
% % C1_Late = max(EEE,[],2);

% %% AUC -0.9 0
% 
% %AUC_C1_LPR_CS_I0-2000I_all  
% AAA = trapz(Xval(17 : 26), B_cat_means(1 : end, 17 : 26), 2);
% %AUC_C1_LPN_CS_I0-200I_all 
% CCC = trapz(Xval(17 : 26), BB_cat_means(1 : end, 17 : 26), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% DDD = trapz(Xval(17 : 26), D_cat_means(1 : end, 17 : 26), 2);
% %AUC_DELTA_LPR_CS_I0-2000I_all 
% EEE = trapz(Xval(17 : 26), DD_cat_means(1 : end, 17 : 26), 2);


% %% AUC 0.1 1
% %AUC_C1_LPR_CS_I0-2000I_all  
% AAA = trapz(Xval(27 : 36), B_cat_means(1 : end, 27 : 36), 2);
% %AUC_C1_LPN_CS_I0-200I_all 
% CCC = trapz(Xval(27 : 36), BB_cat_means(1 : end, 27 : 36), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% DDD = trapz(Xval(27 : 36), D_cat_means(1 : end, 27 : 36), 2);
% %AUC_DELTA_LPR_CS_I0-2000I_all 
% EEE = trapz(Xval(27 : 36), DD_cat_means(1 : end, 27 : 36), 2);

%% AUC 1.1 2
%AUC_C1_LPR_CS_I0-2000I_all  
AAA = trapz(Xval(37 : 46), B_cat_means(1 : end, 37 : 46), 2);
%AUC_C1_LPN_CS_I0-200I_all 
CCC = trapz(Xval(37 : 46), BB_cat_means(1 : end, 37 : 46), 2);
%AUC_DELTA_LPN_CS_I0-200I_all 
DDD = trapz(Xval(37 : 46), D_cat_means(1 : end, 37 : 46), 2);
%AUC_DELTA_LPR_CS_I0-2000I_all 
EEE = trapz(Xval(37 : 46), DD_cat_means(1 : end, 37 : 46), 2);

% %% Peak -0.9 0
% 
% AAA=B_cat_means(:,17:26);
% CCC=BB_cat_means(:,17:26);
% DDD=D_cat_means(:,17:26);
% EEE=DD_cat_means(:,17:26);
% 
% Del_Early = max(AAA,[],2);
% C1_Early = max(CCC,[],2);
% Del_Late = max(DDD,[],2);
% C1_Late = max(EEE,[],2);

% % Peak 0.1 1
% 
% AAA=B_cat_means(:,27:36);
% CCC=BB_cat_means(:,27:36);
% DDD=D_cat_means(:,27:36);
% EEE=DD_cat_means(:,27:36);
% 
% Del_Early = max(AAA,[],2);
% C1_Early = max(CCC,[],2);
% Del_Late = max(DDD,[],2);
% C1_Late = max(EEE,[],2);