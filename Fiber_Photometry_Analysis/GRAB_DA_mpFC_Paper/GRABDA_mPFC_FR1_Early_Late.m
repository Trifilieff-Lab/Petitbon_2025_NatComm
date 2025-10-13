% GRAB DA mPFC test mice

clc
clear

cd 'F:\Fiber_Photometry\GRAB-DA-mPFC\2024-132 GRAB DA2m mPFC WT Yassiny 2025\RESULTS_GRAB_DA_FR1_BSL-Indiv_-2500ms_-1000ms_Event_Sess_Mouse_tri_79338'

B1 = load("L1_press_1.mat");
B2 = load("L1_press_2.mat");

% B1 = load("L2_press_1.mat");
% B2 = load("L2_press_2.mat");

% B1 = load("Licks_1.mat");
% B2 = load("Licks_2.mat");

% B1 = load("Levers_presentation_1.mat");
% B2 = load("Levers_presentation_2.mat");

nan_rowB1 = nan(1, size(B1.means,2));
B1.means = [B1.means(1:1,:); nan_rowB1; B1.means(2:end, :);nan_rowB1]; %For Sess 1 FR1 missing 2 animals --> pb analysis sessions

B_cat_means = cat(3, B1.means, B2.means);
B = mean(B_cat_means,3,"omitnan");
B_means = mean(B, 1,"omitnan");
B_std = std(B,1);
B_sem = B_std/sqrt(size(B,1));

C1 = load("L1_press_4.mat");
C2 = load("L1_press_5.mat");
%C2_means = mean(C2.matrix,1,'omitnan');

C_cat_means = cat(3, C1.means, C2.means);
C = mean(C_cat_means,3);
C_means = mean(C, 1);
C_std = std(C,1);
C_sem = C_std/sqrt(size(C,1));

D1 = load("L1_press_7.mat");
D2 = load("L1_press_8.mat");
% 
% D1 = load("L2_press_7.mat");
% D2 = load("L2_press_8.mat");

% D1 = load("Licks_7.mat");
% D2 = load("Licks_8.mat");

% D1 = load("Levers_presentation_7.mat");
% D2 = load("Levers_presentation_8.mat");


D_cat_means = cat(3, D1.means, D2.means);
D = mean(D_cat_means,3);
D_means = mean(D, 1);
D_std = std(D,1);
D_sem = D_std/sqrt(size(D,1));


E1 = load("L2_press_1.mat");
E2 = load("L2_press_2.mat");

nan_rowE1 = nan(1, size(E1.means,2));
E1.means = [E1.means(1:1,:); nan_rowE1; E1.means(2:end, :);nan_rowE1]; %For Sess 1 FR1 missing 2 animals --> pb analysis sessions

E_cat_means = cat(3, E1.means, E2.means);
E = mean(E_cat_means,3,"omitnan");
E_means = mean(E, 1,"omitnan");
E_std = std(E,1);
E_sem = E_std/sqrt(size(E,1));

Xval = B1.x_values;
% Xval = C.x_values;
Xval = Xval/1000;


%% GRAPH 


hold on


% % Plot each animal in a different color
% colorsA = lines(size(D, 1));  % Generate distinguishable colors (same number as animals)
% for i = 1:size(D, 1)
%     if all(isnan(D(i, :)))
%         continue  % skip NaN-only rows
%     end
%     plot(Xval, D(i, :), 'Color', colorsA(i, :), 'LineWidth', 2, 'DisplayName', [num2str(i)]); 
% end
% legend('show');


% plot(Xval,B_means, 'Color', [0.25 0 0.5], 'LineWidth', 2, 'DisplayName', 'Early');
plot(Xval,B_means, 'Color', [0.25 0 0.5], 'LineWidth', 2, 'DisplayName', 'RL');
plot(Xval,B_means-B_sem,'LineWidth', 1 , 'Color', [0.25 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
plot(Xval,B_means+B_sem,'LineWidth', 1 , 'Color', [0.25 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');

xC1L_=[Xval fliplr(Xval)];
yC1L_=[B_means+B_sem, fliplr(B_means-B_sem)];
patch(xC1L_,yC1L_,[0.25 0 0.5], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');

% plot(Xval,C_means, 'Color', [0.5 0 1], 'LineWidth', 2, 'LineStyle', '--', 'DisplayName', 'Middle');
% plot(Xval,C_means-C_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,C_means+C_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[C_means+C_sem, fliplr(C_means-C_sem)];
% patch(xC1L_,yC1L_,[0.5 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');

% plot(Xval,D_means, 'Color', [0.25 0 0.5], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Late');
% plot(Xval,D_means-D_sem,'LineWidth', 1 , 'Color', [0.25 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,D_means+D_sem,'LineWidth', 1 , 'Color', [0.25 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[D_means+D_sem, fliplr(D_means-D_sem)];
% patch(xC1L_,yC1L_,[0.25 0 0.5], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');

% plot(Xval,E_means, 'Color', [0.8 0 0.5], 'LineWidth', 2, 'LineStyle', '-' , 'DisplayName', 'UL');
% plot(Xval,E_means-E_sem,'LineWidth', 1 , 'Color', [0.8 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,E_means+E_sem,'LineWidth', 1 , 'Color', [0.8 0 0.5] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[E_means+E_sem, fliplr(E_means-E_sem)];
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
% ylim([-3 3]);
xL = xlim;
yL = ylim;
lgd = legend;
set(gca, 'xtick', -2:1:3);
% set(lgd, 'FontSize', 12, 'Location', 'northwest');
set(lgd, 'FontSize', 17, 'FontWeight', 'normal','Location', 'northwest');
% set(lgd, 'FontSize', 11, 'FontWeight', 'bold','Location', 'northwest');
% text(0.92*xL(1), 0.99*yL(2),'RL','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[0 0 0], 'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);
% text(0.92*xL(1), -0.56*yL(2),'RL','HorizontalAlignment','left','VerticalAlignment','top','FontSize', 17, 'Color',[0 0 0], 'BackgroundColor', [0.95 0.95 0.95], 'Margin', 0.01);


x0 = 5;
y0 = 0;
%w = 12;
%h = 16.5; 
w = 13;
% w = 10.5;
% h = 18; 
h = 13; 
set(gcf, 'units', 'centimeters', 'position', [x0, y0, w, h]);

hold off


%% AUC & PEAK & Min

% %% AUC -0.9 0
% BBB = trapz(Xval(17 : 26), B(1 : end, 17 : 26), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% DDD = trapz(Xval(17 : 26), D(1 : end, 17 : 26), 2);
% EEE = trapz(Xval(17 : 26), E(1 : end, 17 : 26), 2);



% %% AUC 0.1 1
% BBB = trapz(Xval(27 : 36), B(1 : end, 27 : 36), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% DDD = trapz(Xval(27 : 36), D(1 : end, 27 : 36), 2);
% EEE = trapz(Xval(27 : 36), E(1 : end, 27 : 36), 2);

%% AUC 0.1 2
BBB = trapz(Xval(27 : 46), B(1 : end, 27 : 46), 2);
%AUC_DELTA_LPN_CS_I0-200I_all 
DDD = trapz(Xval(27 : 46), D(1 : end, 27 : 46), 2);
EEE = trapz(Xval(27 : 46), E(1 : end, 27 : 46), 2);


% %% Peak -0.9 0
% 
% BBB=B(:,17:26);
% DDD=D(:,17:26);
% 
% Early = max(BBB,[],2);
% Late = max(DDD,[],2);

% %% Peak -0.9 0 MINIMUM
% 
% BBB=B(:,17:26);
% DDD=D(:,17:26);
% 
% Early = min(BBB,[],2);
% Late = min(DDD,[],2);
% EEE=E(:,17:26);
% Early = min(EEE,[],2);

% % Peak 0.1 1
% 
% BBB=B(:,27 : 36);
% DDD=D(:,27 : 36);
% 
% Early = max(BBB,[],2);
% Late = max(DDD,[],2);

% % MIN Peak 2.1 3
% 
% BBB=B(:,47 : 56);
% DDD=D(:,47 : 56);
% 
% Early = min(BBB,[],2);
% Late = min(DDD,[],2);

% % Peak 0.1 3
% 
% BBB=B(:,27 : 56);
% DDD=D(:,27 : 56);
% 
% Early = max(BBB,[],2);
% Late = max(DDD,[],2);
% EEE=E(:,27 : 56);
% Early = max(EEE,[],2);

% % MIN 0.1 3
% 
% BBB=B(:,27 : 56);
% DDD=D(:,27 : 56);
% 
% Early = min(BBB,[],2);
% Late = min(DDD,[],2);
% EEE=E(:,27 : 56);
% Early = min(EEE,[],2);



% %% AUC 1.1 3
% RL_EARLY  = trapz(Xval(37 : 56), B(1 : end, 37 : 56), 2);
% RL_LATE  = trapz(Xval(37 : 56), D(1 : end, 37 : 56), 2);

% %% AUC 1.1 2
% RL_EARLY  = trapz(Xval(37 : 46), B(1 : end, 37 : 46), 2);
% RL_LATE  = trapz(Xval(37 : 46), D(1 : end, 37 : 46), 2);
% UL_EARLY  = trapz(Xval(37 : 46), E(1 : end, 37 : 46), 2);


% %% AUC 2.1 3
% RL_EARLY  = trapz(Xval(47 : 56), B(1 : end, 47 : 56), 2);
% RL_LATE  = trapz(Xval(47 : 56), D(1 : end, 47 : 56), 2);
% UL_EARLY  = trapz(Xval(47 : 56), E(1 : end, 47 : 56), 2);




% %% HEATMAP
% 
% hold on
% 
% minValue = min([B(:);D(:)]);
% maxValue = max([B(:);D(:)]);
% 
% tiledlayout(2,1);
% 
% % Tile 1
% nexttile
% y = [1 9];
% imagesc(Xval,y,B);
% colormap('parula');
% clims = [minValue maxValue];
% xline(0,"-k", HandleVisibility='off',LineWidth=1, FontSize=15);
% xlim([1 3]);
% %ylim([1 9])
% xlabel (['Time from LP (s)'])
% ylabel('# Mice')
% title('FR1 RL Early');
% 
% % Tile 2
% nexttile
% y = [1 9];
% imagesc(Xval,y,D);
% %colormap('turbo');
% clims = [minValue maxValue];
% xline(0,"-k", HandleVisibility='off',LineWidth=1, FontSize=15);
% xlim([1 3]);
% %ylim([1 9])
% xlabel (['Time from LP (s)'])
% ylabel('# Mice')
% title('FR1 RL Late');
% 
% 
% cb = colorbar;
% cb.Label.String = 'Z-Score of ∆F/F';
% cb.Layout.Tile = 'north';
% 
% x0 = 17;
% y0 = 5;
% %w = 12;
% %h = 16.5; 
% w = 13;
% h = 18; 
% set(gcf, 'units', 'centimeters', 'position', [x0, y0, w, h]);
% 
% 
% 
% hold off