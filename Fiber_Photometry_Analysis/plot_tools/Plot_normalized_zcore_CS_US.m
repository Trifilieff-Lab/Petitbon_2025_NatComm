clc
clear

%Script to plot lines per animal (normalized z score) + AUC CS_US

cd 'E:\Fiber\2025-19\PAVLOV\ANALYSIS\RESULTS' %%% set le  file directory

folder_path = 'E:\Fiber\TEST'; %%% choose folder to save excel and figures

eventname = 'CS'; %%% put event name for figure names and excel name


A=load('CS_con.mat'); %%%load le fichier .mat d'un Event/Group (par exemple, si tri en Event/Group/Session)
   
    % Exclude one or more animals 
          %A.means(3, :) = nan(1, size(A.means, 2)); % for examble exclude animals 3
    
%             A.means(3, :) = nan(1, size(A.means, 2));
%             A.means(5, :) = nan(1, size(A.means, 2));

B=load('CS_def.mat'); %%%load le fichier .mat d'un Event/Group (par exemple, si tri en Event/Group/Session)

    % Exclude one or more animals 
    %B.means(3, :) = nan(1, size(B.means, 2)); % for examble exclude animals 3



%% Group A
% % Normalization around 0 (if you do not wish to normalize around 0 comment)
% 
%     % Find indices corresponding to the baseline period (-3000 to 0 ms)
%     baseline_indices_A = find(A.x_values>= -3000 & A.x_values <= 0);
%     
%     
%     % Loop through each animal (each row)
%     for i = 1:size(A.means, 1)
%         baseline_mean_A = mean(A.means(i, baseline_indices_A));
%         A.means(i, :) = A.means(i, :) - baseline_mean_A;
%     end

% from ms to seconds

Xval = A.x_values;
Xval = Xval / 1000;

%Figure 1

figure; 

subplot(2,1,1)
hold on

% Plot each animal in a different color
colorsA = lines(size(A.means, 1));  % Generate distinguishable colors (same number as animals)
for i = 1:size(A.means, 1)
    if all(isnan(A.means(i, :)))
        continue  % skip NaN-only rows
    end
    plot(Xval, A.means(i, :), 'Color', colorsA(i, :), 'LineWidth', 1, 'DisplayName', ['Animal ' num2str(i)]);
end
legend('show');

        % add lines to indicate events
        hold on
        xline(0,":r",eventname,'Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
        yline(0,'-', HandleVisibility='off'); %ligne à y=0
        ylabel(['Z-Score of ∆F/F +/- SEM']);
        xlabel(['Time from' eventname 'onset (s)']); %change label en fonction de l'event
        xt = get(gca, 'XTick'); 
        legend;
        hold off
        
%         hold on
%         xline(3,":r",'US','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
%         yline(0,'-', HandleVisibility='off'); %ligne à y=0
%         ylabel(['Z-Score of ∆F/F +/- SEM']);
%         xlabel(['Time from' eventname 'onset (s)']); %change label en fonction de l'event
%         xt = get(gca, 'XTick'); 
%         legend;
%         hold off
%         
%         hold on
%         xline(10,":r",'CS off','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
%         yline(0,'-', HandleVisibility='off'); %ligne à y=0
%         ylabel(['Z-Score of ∆F/F +/- SEM']);
%        xlabel(['Time from' eventname 'onset (s)']); %change label en fonction de l'event
%         xt = get(gca, 'XTick'); 
%         legend;
%         hold off

     

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Group B

% % Find indices corresponding to the baseline period (-3000 to 0 ms)
% baseline_indices_B = find(B.x_values>= -3000 & B.x_values <= 0);
% 
% % Loop through each animal (each row)
% for i = 1:size(B.means, 1)
%     baseline_mean_B = mean(B.means(i, baseline_indices_B));
%     B.means(i, :) = B.means(i, :) - baseline_mean_B;
% end

subplot(2,1,2)
hold on

% Plot each animal in a different color
colorsB = lines(size(B.means, 1));  % Generate distinguishable colors (same number as animals)
for i = 1:size(B.means, 1)
    if all(isnan(B.means(i, :)))
        continue  % skip NaN-only rows
    end
    plot(Xval, B.means(i, :), 'Color', colorsB(i, :), 'LineWidth', 1, 'DisplayName', ['Animal ' num2str(i)]);
end
legend('show');

        % add lines to indicate events
        hold on
        xline(0,":r",eventname,'Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
        yline(0,'-', HandleVisibility='off'); %ligne à y=0
        ylabel(['Z-Score of ∆F/F +/- SEM']);
        xlabel(['Time from' eventname 'onset (s)']); %change label en fonction de l'event
        xt = get(gca, 'XTick'); 
        legend;
        hold off
        
%         hold on
%         xline(3,":r",'US','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
%         yline(0,'-', HandleVisibility='off'); %ligne à y=0
%         ylabel(['Z-Score of ∆F/F +/- SEM']);
%         xlabel(['Time from' eventname 'onset (s)']); %change label en fonction de l'event
%         xt = get(gca, 'XTick'); 
%         legend;
%         hold off
%         
%         hold on
%         xline(10,":r",'CS off','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
%         yline(0,'-', HandleVisibility='off'); %ligne à y=0
%         ylabel(['Z-Score of ∆F/F +/- SEM']);
%         xlabel(['Time from' eventname 'onset (s)']); %change label en fonction de l'event
%         xt = get(gca, 'XTick'); 
%         legend;
%         hold off

% Save figure 
% Create full file path
saveFileName = fullfile(folder_path, ['individual_traces_' eventname '.fig']);

% Save the current figure
savefig(saveFileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Polt means on seperate figure

%Figure 2 
figure;
A_mean = nanmean(A.means);                  %Moyenne des sessions
A_std = nanstd(A.means);                    % Moyenne des std des sessions
A_sem = A_std/sqrt(size(A.means,1));    % SEM sur les colonnes de tous les trials de la matrice

B_mean = nanmean(B.means);
B_std = nanstd(B.means);
B_sem = B_std/sqrt(size(B.means,1));

subplot(1,1,1)

hold on
plot(Xval,A_mean,'Color', [0.00,0.00,0.00], 'LineWidth', 1.5, 'DisplayName', 'Control' );
plot(Xval,A_mean-A_sem,'LineWidth', 1 , 'Color', [0.00,0.00,0.00] , 'LineStyle', ':', 'HandleVisibility', 'off');
plot(Xval,A_mean+A_sem,'LineWidth', 1 , 'Color', [0.00,0.00,0.00] , 'LineStyle', ':', 'HandleVisibility', 'off');
xA_=[Xval fliplr(Xval)];
yA_=[A_mean+A_sem, fliplr(A_mean-A_sem)];
patch(xA_,yA_,[0.00,0.00,0.00], 'FaceAlpha',.1, 'Edgecolor', 'none', 'HandleVisibility', 'off'); %pour avoir le fond coloré entre les SEM
hold off

hold on
plot(Xval,B_mean, 'Color', [0.64 0.08 0.18], 'LineWidth', 1.5, 'DisplayName', 'n-3 Deficient' );
plot(Xval,B_mean-B_sem,'LineWidth', 1 , 'Color', [0.64 0.08 0.18] , 'LineStyle', ':', 'HandleVisibility', 'off');
plot(Xval,B_mean+B_sem,'LineWidth', 1 , 'Color', [0.64 0.08 0.18] , 'LineStyle', ':', 'HandleVisibility', 'off');
xB_=[Xval fliplr(Xval)];
yB_=[B_mean+B_sem, fliplr(B_mean-B_sem)];
patch(xB_,yB_,[0.64 0.08 0.18], 'FaceAlpha',.1, 'Edgecolor', 'none', 'HandleVisibility', 'off');
hold off

hold on
xline(0,":r",eventname,'Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
yline(0,'-', HandleVisibility='off'); %ligne à y=0
ylabel(['Z-Score of ∆F/F +/- SEM']);
xlabel(['Time from' eventname 'onset (s)']); %change label en fonction de l'event
xt = get(gca, 'XTick'); 
legend;

hold off


% hold on
% xline(3,":r",'US','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
% yline(0,'-', HandleVisibility='off'); %ligne à y=0
% ylabel(['Z-Score of ∆F/F +/- SEM']);
% xlabel(['Time from' eventname 'onset (s)']); %change label en fonction de l'event
% xt = get(gca, 'XTick'); 
% legend;
% 
% hold off
% 
% hold on
% xline(10,":r",'CS off','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
% yline(0,'-', HandleVisibility='off'); %ligne à y=0
% ylabel(['Z-Score of ∆F/F +/- SEM']);
% xlabel(['Time from' eventname 'onset (s)']); %change label en fonction de l'event
% xt = get(gca, 'XTick'); 
% legend;
% 
% hold off

% Save figure 
% Create full file path
saveFileName = fullfile(folder_path, ['mean_' eventname '.fig']);

% Save the current figure
savefig(saveFileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AUC 
%For one event (First lever press f.ex.)
    %time window
    time = [-0.9 6];  % or whatever you passed to AUC_min_max
    startStr = strrep(num2str(time(1)), '.', '_');
    endStr   = strrep(num2str(time(2)), '.', '_');
    
            % AUC_A  
            [A_auc, A_min_val, A_max_val] = AUC_min_max(A.means, Xval, time);
    
            % AUC_B
            [B_auc, B_min_val, B_max_val] = AUC_min_max(B.means, Xval, time);
    
        % Convert to tables (no need for same length)
        TA = table(A_auc, A_max_val, A_min_val,...
            'VariableNames', {'AUC', 'MAx_val', 'Min_val'});
        
        TB = table(B_auc, B_max_val, B_min_val,...
            'VariableNames', {'AUC', 'MAx_val', 'Min_val'});
    
        time = table(time(1), time(2), ...
        'VariableNames', {'StartTime_s', 'EndTime_s'});
    
        
        file_name = [eventname '_time_' startStr '-' endStr '_AUC_MAX_MIN.xlsx']; 
    
        full_path = fullfile(folder_path, file_name);
    
        writetable(time, full_path, 'Sheet', 'TimeWindow');
        writetable(TA, full_path, 'Sheet', 'GroupA');
        writetable(TB,  full_path, 'Sheet', 'GroupB');
% 
%  %For several events
%     %time window
%     time_CS = [0 2];  %%% or whatever you passed to AUC_min_max
%     startStr1 = strrep(num2str(time_CS(1)), '.', '_');
%     endStr1   = strrep(num2str(time_CS(2)), '.', '_');
%     time_US = [3 6];
%     startStr2 = strrep(num2str(time_US(1)), '.', '_');
%     endStr2   = strrep(num2str(time_US(2)), '.', '_');
%     time_dip= [-0.6 0]
%     startStr3 = strrep(num2str(time_dip(1)), '.', '_');
%     endStr3   = strrep(num2str(time_dip(2)), '.', '_');
% 
%         % AUC_A 
%         %CS
%         [CS_A_auc, CS_A_min_val, CS_A_max_val] = AUC_min_max(A.means, Xval, time_CS);
%         %US
%         [US_A_auc, US_A_min_val, US_A_max_val] = AUC_min_max(A.means, Xval, time_US);
%         %dip
%         [dip_A_auc, dip_A_min_val, dip_A_max_val] = AUC_min_max(A.means, Xval, time_dip);%         
% 
%         % AUC_B
%         %CS
%         [CS_B_auc, CS_B_min_val, CS_B_max_val] = AUC_min_max(B.means, Xval, time_CS);
%         %US
%         [US_B_auc, US_B_min_val, US_B_max_val] = AUC_min_max(B.means, Xval, time_US);
%         %dip
%         [dip_B_auc, dip_B_min_val, dip_B_max_val] = AUC_min_max(B.means, Xval, time_dip);
% 
% 
%     % Convert to tables (no need for same length)
% 
%     TA_CS = table(CS_A_auc, CS_A_max_val, CS_A_min_val,...
%         'VariableNames', {'AUC', 'MAx_val', 'Min_val'});
%     
%     TB_CS = table(CS_B_auc, CS_B_max_val, CS_B_min_val,...
%         'VariableNames', {'AUC', 'MAx_val', 'Min_val'});
%     
%     TA_US = table(US_A_auc, US_A_max_val, US_A_min_val,...
%         'VariableNames', {'AUC', 'MAx_val', 'Min_val'});
%     
%     TB_US = table(US_B_auc, US_B_max_val, US_B_min_val,...
%         'VariableNames', {'AUC', 'MAx_val', 'Min_val'});
% 
%     TA_dip = table(dip_A_auc, dip_A_min_val, dip_A_max_val,...
%         'VariableNames', {'AUC', 'MAx_val', 'Min_val'});
% 
%     TB_dip = table(dip_B_auc, dip_B_min_val, dip_B_max_val,...
%         'VariableNames', {'AUC', 'MAx_val', 'Min_val'});
% 
%     time_CS = table(time_CS(1), time_CS(2), ...
%     'VariableNames', {'StartTime_s', 'EndTime_s'});
%     time_US = table(time_US(1), time_US(2), ...
%     'VariableNames', {'StartTime_s', 'EndTime_s'});
%     time_dip = table(time_dip(1), time_dip(2), ...
%     'VariableNames', {'StartTime_s', 'EndTime_s'});
% 
%  
%     file_name = [eventname '_time_' startStr1 '-' endStr1 '_' startStr2 '-' endStr2 '_' startStr3 '-' endStr3 '_' '_AUC_MAX_MIN.xlsx']; 
% 
%     full_path = fullfile(folder_path, file_name);
%     
%     writetable(TA_CS, full_path, 'Sheet', 'GroupA_CS');
%     writetable(TB_CS, full_path, 'Sheet', 'GroupB_CS');
%     writetable(TA_US, full_path, 'Sheet', 'GroupA_US');
%     writetable(TB_US, full_path, 'Sheet', 'GroupB_US');
%     writetable(TA_dip, full_path, 'Sheet', 'GroupA_dip');
%     writetable(TB_dip, full_path, 'Sheet', 'GroupB_dip');
%     writetable(time_CS, full_path, 'Sheet', 'TimeWindow_CS');
%     writetable(time_US, full_path, 'Sheet', 'TimeWindow_US');
%     writetable(time_dip, full_path, 'Sheet', 'TimeWindow_dip');
% 
