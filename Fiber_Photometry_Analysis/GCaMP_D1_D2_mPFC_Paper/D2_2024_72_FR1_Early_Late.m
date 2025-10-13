% D2GLUN2B mPFC 2024-72 FR1 Early Late

% Analyse 2024-72 num session total et pas juste FR ; de 14 à 21 = de 1 à 8
% Refaire analyse avec bon format pour Pool D2 total

% AUC -1 0 %% WARNING : Xval depuis -3 donc décalage des X (21:31) pour

clc
clear

cd 'F:\Fiber_Photometry\2024-72 D1cre D2cre mPFC Peptide 2024 total\2024-72_D2cre_D1cre_mPFC_Peptide_juin2024\2024-72_FR1\RESULTS_D2_FR1_Bsl-Indiv_-2500ms_-1000ms_Evt_Group_Session_Mouse'

%% EARLY SCR

B1 = load("L1_press_Scr_14.mat");
B2 = load("L1_press_Scr_15.mat");

% B1 = load("Levers_presentation_Scr_14.mat");
% B2 = load("Levers_presentation_Scr_15.mat");

% B1 = load("Licks_Scr_14.mat");
% B2 = load("Licks_Scr_15.mat");


B = cat(3, B1.means, B2.means);
B_cat_means = mean(B, 3, "omitnan");
B_means = mean(B_cat_means,1, "omitnan");
B_std = std(B_cat_means,1, "omitnan");
B_sem = B_std/sqrt(size(B_cat_means,1));

%% EARLY IL3

BB1 = load("L1_press_IL3_14.mat");
BB2 = load("L1_press_IL3_15.mat");

% BB1 = load("Levers_presentation_IL3_14.mat");
% BB2 = load("Levers_presentation_IL3_15.mat");
% 
% BB1 = load("Licks_IL3_14.mat");
% BB2 = load("Licks_IL3_15.mat");


BB = cat(3, BB1.means, BB2.means);
BB_cat_means = mean(BB, 3, "omitnan");
BB_means = mean(BB_cat_means,1);
BB_std = std(BB_cat_means,1);
BB_sem = BB_std/sqrt(size(BB_cat_means,1));


%% LATE SCR

D1 = load("L1_press_Scr_20.mat");
D2 = load("L1_press_Scr_21.mat");

% D1 = load("Levers_presentation_Scr_20.mat");
% D2 = load("Levers_presentation_Scr_21.mat");

% D1 = load("Licks_Scr_20.mat");
% D2 = load("Licks_Scr_21.mat");


D = cat(3, D1.means, D2.means);
D_cat_means = mean(D, 3, "omitnan");
D_means = mean(D_cat_means, 1);
D_std = std(D_cat_means,1);
D_sem = D_std/sqrt(size(D_cat_means,1));

%% LATE IL3

DD1 = load("L1_press_IL3_20.mat");
DD2 = load("L1_press_IL3_21.mat");

% DD1 = load("Levers_presentation_IL3_20.mat");
% DD2 = load("Levers_presentation_IL3_21.mat");

% DD1 = load("Licks_IL3_20.mat");
% DD2 = load("Licks_IL3_21.mat");



DD = cat(3, DD1.means, DD2.means);
DD_cat_means = mean(DD, 3, "omitnan");
DD_means = mean(DD_cat_means, 1);
DD_std = std(DD_cat_means,1);
DD_sem = DD_std/sqrt(size(DD_cat_means,1));

%% X axis

Xval = B1.x_values;
% Xval = C.x_values;
Xval = Xval/1000;


%% Graph

hold on

plot(Xval,B_means, 'Color', [0.7255 0 0.4353], 'LineWidth', 2, 'DisplayName', 'Early'); %D2R-Scr-
plot(Xval,B_means-B_sem,'LineWidth', 1 , 'Color', [0.7255 0 0.4353] , 'LineStyle', ':', 'HandleVisibility', 'off');
plot(Xval,B_means+B_sem,'LineWidth', 1 , 'Color', [0.7255 0 0.4353] , 'LineStyle', ':', 'HandleVisibility', 'off');

xC1L_=[Xval fliplr(Xval)];
yC1L_=[B_means+B_sem, fliplr(B_means-B_sem)];
patch(xC1L_,yC1L_,[0.7255 0 0.4353], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');


% 
% plot(Xval,BB_means, 'Color', [0.0431 0.4549 0.0470], 'LineWidth', 2, 'DisplayName', 'Early'); %D2R-IL3-
% plot(Xval,BB_means-BB_sem,'LineWidth', 1 , 'Color', [0.0431 0.4549 0.0470] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,BB_means+BB_sem,'LineWidth', 1 , 'Color', [0.0431 0.4549 0.0470] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[BB_means+BB_sem, fliplr(BB_means-BB_sem)];
% patch(xC1L_,yC1L_,[0.0431 0.4549 0.0470], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');



plot(Xval,D_means, 'Color', [0.7255 0 0.4353], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Late'); %D2R-Scr-
plot(Xval,D_means-D_sem,'LineWidth', 1 , 'Color', [0.7255 0 0.4353] , 'LineStyle', ':', 'HandleVisibility', 'off');
plot(Xval,D_means+D_sem,'LineWidth', 1 , 'Color', [0.7255 0 0.4353] , 'LineStyle', ':', 'HandleVisibility', 'off');

xC1L_=[Xval fliplr(Xval)];
yC1L_=[D_means+D_sem, fliplr(D_means-D_sem)];
patch(xC1L_,yC1L_,[0.7255 0 0.4353], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');



% plot(Xval,DD_means, 'Color', [0.0431 0.4549 0.0470], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Late'); %D2R-IL3-
% plot(Xval,DD_means-DD_sem,'LineWidth', 1 , 'Color', [0.0431 0.4549 0.0470] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,DD_means+DD_sem,'LineWidth', 1 , 'Color', [0.0431 0.4549 0.0470] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[DD_means+DD_sem, fliplr(DD_means-DD_sem)];
% patch(xC1L_,yC1L_,[0.0431 0.4549 0.0470], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');



%xline([0 3000 10000],":r",{'CS', 'US', 'Fin CS'},'LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=1.5, FontSize=15);
%xline(0,":r",'CS','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'RL','LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=15);
% xline(0,":r",'LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=17);
xline(0,":r",'LP','LabelOrientation','horizontal', 'LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=17);
% xline(0,":r",'Lick','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'US','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
%xline(0,":r",'LP-Out','LabelOrientation','horizontal','LabelHorizontalAlignment', 'left' , HandleVisibility='off',LineWidth=2.5, FontSize=15);

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
%ylim([-2 3]);
%ylim([-0.6 1.6]);
ylim([-2 3]); %LP
% ylim([-3.5 1]); % LICKS
% set(gca, 'ytick', -0.6:0.2:1.6);
xL = xlim;
yL = ylim;
lgd = legend;
set(lgd, 'FontSize', 17, 'FontWeight', 'normal','Location', 'southwest');
text(0.92*xL(1), 0.99*yL(2),'D2R-Scr','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[0.7255 0 0.4353], 'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);
% text(0.92*xL(1), 0.99*yL(2),'D2R-IL3','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[0.0431 0.4549 0.0470],'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);


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


%% AUC -1 0 %% WARNING : Xval depuis -3 donc décalage des X (21:31) pour
%-1;0 et (31:41) pour 0;1

% % %AUC_C1_LPR_CS_I0-2000I_all  
% % AAA = trapz(Xval(21 : 31), B_cat_means(1 : end, 21 : 31), 2);
% % %AUC_C1_LPN_CS_I0-200I_all 
% % CCC = trapz(Xval(21 : 31), BB_cat_means(1 : end, 21 : 31), 2);
% % %AUC_DELTA_LPN_CS_I0-200I_all 
% % DDD = trapz(Xval(21 : 31), D_cat_means(1 : end, 21 : 31), 2);
% % %AUC_DELTA_LPR_CS_I0-2000I_all 
% % EEE = trapz(Xval(21 : 31), DD_cat_means(1 : end, 21 : 31), 2);
% 
% 
% % %% AUC 0 1
% % %AUC_C1_LPR_CS_I0-2000I_all  
% % AAA = trapz(Xval(31 : 41), B_cat_means(1 : end, 31 : 41), 2);
% % %AUC_C1_LPN_CS_I0-200I_all 
% % CCC = trapz(Xval(31 : 41), BB_cat_means(1 : end, 31 : 41), 2);
% % %AUC_DELTA_LPN_CS_I0-200I_all 
% % DDD = trapz(Xval(31 : 41), D_cat_means(1 : end, 31 : 41), 2);
% % %AUC_DELTA_LPR_CS_I0-2000I_all 
% % EEE = trapz(Xval(31 : 41), DD_cat_means(1 : end, 31 : 41), 2);
% 
% % %% Peak -1 0
% % 
% % AAA=B_cat_means(:,21 : 31);
% % CCC=BB_cat_means(:,21 : 31);
% % DDD=D_cat_means(:,21 : 31);
% % EEE=DD_cat_means(:,21 : 31);
% % 
% % Del_Early = max(AAA,[],2);
% % C1_Early = max(CCC,[],2);
% % Del_Late = max(DDD,[],2);
% % C1_Late = max(EEE,[],2);
% 
% % % Peak 0 1
% % 
% % AAA=B_cat_means(:,31 : 41);
% % CCC=BB_cat_means(:,31 : 41);
% % DDD=D_cat_means(:,31 : 41);
% % EEE=DD_cat_means(:,31 : 41);
% % 
% % Del_Early = max(AAA,[],2);
% % C1_Early = max(CCC,[],2);
% % Del_Late = max(DDD,[],2);
% % C1_Late = max(EEE,[],2);

% %% AUC -0.9 0
% 
% %AUC_C1_LPR_CS_I0-2000I_all  
% AAA = trapz(Xval(22 : 31), B_cat_means(1 : end, 22 : 31), 2);
% %AUC_C1_LPN_CS_I0-200I_all 
% CCC = trapz(Xval(22 : 31), BB_cat_means(1 : end, 22 : 31), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% DDD = trapz(Xval(22 : 31), D_cat_means(1 : end, 22 : 31), 2);
% %AUC_DELTA_LPR_CS_I0-2000I_all 
% EEE = trapz(Xval(22 : 31), DD_cat_means(1 : end, 22 : 31), 2);


% %% AUC 0.1 1
% %AUC_C1_LPR_CS_I0-2000I_all  
% AAA = trapz(Xval(32 : 41), B_cat_means(1 : end, 32 : 41), 2);
% %AUC_C1_LPN_CS_I0-200I_all 
% CCC = trapz(Xval(32 : 41), BB_cat_means(1 : end, 32 : 41), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% DDD = trapz(Xval(32 : 41), D_cat_means(1 : end, 32 : 41), 2);
% %AUC_DELTA_LPR_CS_I0-2000I_all 
% EEE = trapz(Xval(32 : 41), DD_cat_means(1 : end, 32 : 41), 2);

%% AUC 1.1 2
%AUC_C1_LPR_CS_I0-2000I_all  
AAA = trapz(Xval(42 : 51), B_cat_means(1 : end, 42 : 51), 2);
%AUC_C1_LPN_CS_I0-200I_all 
CCC = trapz(Xval(42 : 51), BB_cat_means(1 : end, 42 : 51), 2);
%AUC_DELTA_LPN_CS_I0-200I_all 
DDD = trapz(Xval(42 : 51), D_cat_means(1 : end, 42 : 51), 2);
%AUC_DELTA_LPR_CS_I0-2000I_all 
EEE = trapz(Xval(42 : 51), DD_cat_means(1 : end, 42 : 51), 2);

% %% Peak -0.9 0
% 
% AAA=B_cat_means(:,22 : 31);
% CCC=BB_cat_means(:,22 : 31);
% DDD=D_cat_means(:,22 : 31);
% EEE=DD_cat_means(:,22 : 31);
% 
% Del_Early = max(AAA,[],2);
% C1_Early = max(CCC,[],2);
% Del_Late = max(DDD,[],2);
% C1_Late = max(EEE,[],2);

% % Peak 0.1 1
% 
% AAA=B_cat_means(:,32 : 41);
% CCC=BB_cat_means(:,32 : 41);
% DDD=D_cat_means(:,32 : 41);
% EEE=DD_cat_means(:,32 : 41);
% 
% Del_Early = max(AAA,[],2);
% C1_Early = max(CCC,[],2);
% Del_Late = max(DDD,[],2);
% C1_Late = max(EEE,[],2);