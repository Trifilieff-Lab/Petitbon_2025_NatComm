% GRAB DA mPFC test mice

clc
clear

cd 'F:\Fiber_Photometry\GRAB-DA-mPFC\2024-132 GRAB DA2m mPFC WT Yassiny 2025\RESULTS_GRAB_DA_PAVLOV_BSL-Indiv_-2500ms_-1000ms_Event_Sess_Mouse_Tri_79338'

% B1 = load("lick_1.mat");
% B2 = load("lick_2.mat");
% % B3 = load("lick_3.mat");

B1 = load("CS_1.mat");
B2 = load("CS_2.mat");
B3 = load("CS_3.mat");


% B1 = load("FIN_CS_GRABDA_1.mat");
% B2 = load("FIN_CS_GRABDA_2.mat");
% B3 = load("FIN_CS_GRABDA_3.mat");

B_cat_means = cat(3, B1.means, B2.means);
% B_cat_means = cat(3, B1.means, B2.means, B3.means);
B = mean(B_cat_means,3);
B = B(1:8,:); % remove last animal outlier for Lick (test)
B_means = mean(B, 1);
B_std = std(B,1);
B_sem = B_std/sqrt(size(B,1));
 
C1 = load("lick_5.mat");
C2 = load("lick_6.mat");

% C1 = load("CS_5.mat");
% C2 = load("CS_6.mat");
% 
% % C1 = load("FIN_CS_GRABDA_5.mat");
% % C2 = load("FIN_CS_GRABDA_6.mat");
% % C3 = load("FIN_CS_GRABDA_7.mat");

C_cat_means = cat(3, C1.means, C2.means);
C = mean(C_cat_means,3);
C_means = mean(C, 1);
C_std = std(C,1);
C_sem = C_std/sqrt(size(C,1));

% D1 = load("lick_9.mat");
% D2 = load("lick_10.mat");
% % D3 = load("lick_8.mat");

D1 = load("CS_9.mat");
D2 = load("CS_10.mat");
% D3 = load("CS_8.mat");



% D1 = load("FIN_CS_GRABDA_10.mat");
% D2 = load("FIN_CS_GRABDA_11.mat");
% D3 = load("FIN_CS_GRABDA_12.mat");

D_cat_means = cat(3, D1.means, D2.means);
% D_cat_means = cat(3, D1.means, D2.means, D3.means);
D = mean(D_cat_means,3);
D = D(1:8,:); % remove last animal outlier for Lick (test)
D_means = mean(D, 1);
D_std = std(D,1);
D_sem = D_std/sqrt(size(D,1));

Xval = B1.x_values;
% Xval = C.x_values;
Xval = Xval/1000;

hold on

% Plot each animal in a different color
colorsA = lines(size(B, 1));  % Generate distinguishable colors (same number as animals)
for i = 1:size(B, 1)
    if all(isnan(B(i, :)))
        continue  % skip NaN-only rows
    end
    plot(Xval, B(i, :), 'Color', colorsA(i, :), 'LineWidth', 2, 'DisplayName', [num2str(i)]); 
end
legend('show');

% % Plot each animal in a different color
% colorsA = lines(size(D, 1));  % Generate distinguishable colors (same number as animals)
% for i = 1:size(D, 1)
%     if all(isnan(D(i, :)))
%         continue  % skip NaN-only rows
%     end
%     plot(Xval, D(i, :), 'Color', colorsA(i, :), 'LineWidth', 2, 'DisplayName', [num2str(i)]); 
% end
% legend('show');

% plot(Xval,B_means, 'Color', [0.5 0 1], 'LineWidth', 2, 'DisplayName', 'Early');
% plot(Xval,B_means-B_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,B_means+B_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[B_means+B_sem, fliplr(B_means-B_sem)];
% patch(xC1L_,yC1L_,[0.5 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% % plot(Xval,C_means, 'Color', [0.5 0 1], 'LineWidth', 2, 'LineStyle', '--', 'DisplayName', 'Middle');
% % plot(Xval,C_means-C_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % plot(Xval,C_means+C_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% % 
% % xC1L_=[Xval fliplr(Xval)];
% % yC1L_=[C_means+C_sem, fliplr(C_means-C_sem)];
% % patch(xC1L_,yC1L_,[0.5 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');
% 
% plot(Xval,D_means, 'Color', [0.5 0 1], 'LineWidth', 2, 'LineStyle', ':', 'DisplayName', 'Late');
% plot(Xval,D_means-D_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% plot(Xval,D_means+D_sem,'LineWidth', 1 , 'Color', [0.5 0 1] , 'LineStyle', ':', 'HandleVisibility', 'off');
% 
% xC1L_=[Xval fliplr(Xval)];
% yC1L_=[D_means+D_sem, fliplr(D_means-D_sem)];
% patch(xC1L_,yC1L_,[0.5 0 1], 'FaceAlpha',.05, 'Edgecolor', 'none', 'HandleVisibility', 'off');

% xline([0 3 10],":r",{'CS', 'US','CS Off'},'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);
xline(0,":r",'CS','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=17);
% xline(0,":r",'Lick','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=17);
%xline(0,":r",'FIN_CS','LabelOrientation','horizontal',HandleVisibility='off',LineWidth=2.5, FontSize=15);



yline(0,'-', LineWidth=1.5, HandleVisibility='off');  
ylabel(['Z-Score of ∆F/F'],'FontSize',16, 'FontWeight','bold');
xlabel(["Time from CS onset (s)"],"FontSize",16, "FontWeight","bold"); 
% xlabel(["Time from Lever Press onset (s)"],"FontSize",16, "FontWeight","bold"); 
% xlabel(["Time from Lever presentation onset (s)"],"FontSize",15, "FontWeight","bold"); 
% xlabel(["Time from Licking (s)"],"FontSize",16, "FontWeight","bold"); 
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
xlim([-2.5 2.5]);
% ylim([-0.5 2.5]);
% ylim([-0.5 1.5]);
ylim([-2 3]);
set(gca, 'xtick', -2:1:2);
xL = xlim;
yL = ylim;
lgd = legend;
% set(lgd, 'FontSize', 12, 'Location', 'northwest');
% set(lgd, 'FontSize', 16, 'FontWeight', 'normal','Location', 'northwest');
set(lgd, 'FontSize', 11, 'FontWeight', 'bold','Location', 'northwest');


x0 = 20;
y0 = 8;
%w = 12;
%h = 16.5; 
w = 13;
% w = 10.5;
% w = 9;
% h = 18; 
h = 13;
set(gcf, 'units', 'centimeters', 'position', [x0, y0, w, h]);

hold off


% %% AUC -0.9 0
% BBB = trapz(Xval(17 : 26), B(1 : end, 17 : 26), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% DDD = trapz(Xval(17 : 26), D(1 : end, 17 : 26), 2);



% %% AUC 0.1 1
% BBB = trapz(Xval(27 : 36), B(1 : end, 27 : 36), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% DDD = trapz(Xval(27 : 36), D(1 : end, 27 : 36), 2);

% %% AUC 1.1 2
% BBB = trapz(Xval(37 : 46), B(1 : end, 37 : 46), 2);
% %AUC_DELTA_LPN_CS_I0-200I_all 
% DDD = trapz(Xval(37 : 46), D(1 : end, 37 : 46), 2);


% %% Peak -0.9 0
% 
% BBB=B(:,17:26);
% DDD=D(:,17:26);
% 
% Early = max(BBB,[],2);
% Late = max(DDD,[],2);

% % Peak 0.1 1
% 
% BBB=B(:,27 : 36);
% DDD=D(:,27 : 36);
% 
% Early = max(BBB,[],2);
% Late = max(DDD,[],2);

% % Peak -1 2
% 
% BBB=B(:,17 : 46);
% DDD=D(:,17 : 46);
% 
% Early = max(BBB,[],2);
% Late = max(DDD,[],2);
