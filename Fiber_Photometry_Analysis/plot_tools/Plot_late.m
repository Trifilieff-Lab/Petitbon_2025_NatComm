% LATE Script to plot lines per animal (normalized z score) + AUC CS
clear;

cd 'E:\Fiber\2025-19\PAVLOV\ANALYSIS\RESULTS_SESSION' %%% set le  file directory

folder_path = 'E:\Fiber\2025-19\PAVLOV\LATE'; %%% choose folder to save excel and figures

eventname = 'lick'; %%% put event name for figure names and excel name


A_late1=load('lick_con_session11.mat');

A_late2=load('lick_con_session12.mat');

A_late3=load('lick_con_session13.mat');


B_late1=load('lick_def_session11.mat');

B_late2=load('lick_def_session12.mat');

B_late3=load('lick_def_session13.mat');


%% Group A

%If you need to add NAN for missing session/replace NAN if you want to exclude animal
    % (if you don't find configuration you need ask chat gpt by precising wich
    % row of A_lateX.means you want to either be replaced with NANS or if you want to add NAN
    % between 2 rows etc 
    % 
    % (mostly when you have an error while concatenating)
    %Error using cat
    %Dimensions of arrays being concatenated are not consistent.

    % nan_rowA1 = nan(1, size(Alate1.means, 2)); 
    % A_late1.means = [ZAlate1.means; nan_rowA1]; %For Session missing last animal

    %  A.means(4, :) = nan(1, size(A.means, 2)); %For excluding mouse 4

% mean per mouse
A_late_3D_means = cat(3, A_late1.means, A_late2.means, A_late3.means);
A_late_2D_means = mean(A_late_3D_means,3,"omitnan");

A.means = A_late_2D_means

%If you need to add NAN for missing session/replace NAN if you want to exclude animal
    % (if you don't find configuration you need ask chat gpt by precising wich
    % row of A_lateX.means you want to either be replaced with NANS or if you want to add NAN
    % between 2 rows etc 
    % 
    % (mostly when you have an error while concatenating)
    %Error using cat
    %Dimensions of arrays being concatenated are not consistent.

%  A.means(4, :) = nan(1, size(A.means, 2));


% z score normalization (comment if you don't want to noralize to 0)
    % Variation of z-score 
    baseline_indices_A = find(A_late1.x_values>= -3000 & A_late1.x_values <= -500);
    
      % Loop through each animal (each row)
    for i = 1:size(A.means, 1)
        baseline_mean_A = mean(A.means(i, baseline_indices_A));
        A.means(i, :) = A.means(i, :) - baseline_mean_A;
    end


%Figure 1
% from ms to seconds

Xval = A_late1.x_values  ;
Xval = Xval / 1000;

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
            xlabel(['Time from ' eventname ' onset (s)']); %change label en fonction de l'event
            xt = get(gca, 'XTick'); 
            legend;
            hold off

            % hold on
            % xline(3,":r",'US','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
            % yline(0,'-', HandleVisibility='off'); %ligne à y=0
            % ylabel(['Z-Score of ∆F/F +/- SEM']);
            % xlabel(['Time from ' eventname ' onset (s)']); %change label en fonction de l'event
            % % xt = get(gca, 'XTick'); 
            % legend;
            % 
            % hold off
            % 
            % hold on
            % xline(10,":r",'CS off','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
            % yline(0,'-', HandleVisibility='off'); %ligne à y=0
            % ylabel(['Z-Score of ∆F/F +/- SEM']);
            % xlabel(['Time from ' eventname ' onset (s)']); %change label en fonction de l'event
            % % xt = get(gca, 'XTick'); 
            % legend;
            % 
            % hold off
 
        
       
%% Group B

%If you need to add NAN for missing session/replace NAN if you want to exclude animal
    % (if you don't find configuration you need ask chat gpt by precising wich
    % row of A_lateX.means you want to either be replaced with NANS or if you want to add NAN
    % between 2 rows etc 
    % 
    % (mostly when you have an error while concatenating)

    % nan_rowA1 = nan(1, size(Alate1.means, 2)); 
    % A_late1.means = [ZAlate1.means; nan_rowA1]; %For Session missing last animal
B_late1.means(6, :) = nan(1, size(B_late1.means, 2)); % for examble exclude animals 3

% mean per mouse

B_late_3D_means = cat(3, B_late1.means, B_late2.means, B_late3.means);
B_late_2D_means = mean(B_late_3D_means,3,"omitnan");

B.means= B_late_2D_means

% z score normalization (comment if you don't want to noralize to 0)
    % Variation of z-score
    baseline_indices_B = find(B_late1.x_values>= -3000 & B_late1.x_values <= -500);
    
    
         % Loop through each animal (each row)
    for i = 1:size(B.means, 1)
        baseline_mean_B = mean(B.means(i, baseline_indices_B));
        B.means(i, :) = B.means(i, :) - baseline_mean_B;
    end


%Figure
subplot(2,1,2)


    hold on
    % Plot each animal in a different color
    colorsA = lines(size(B.means, 1));  % Generate distinguishable colors (same number as animals)
    for i = 1:size(B.means, 1)
        if all(isnan(B.means(i, :)))
            continue  % skip NaN-only rows
        end
        plot(Xval, B.means(i, :), 'Color', colorsA(i, :), 'LineWidth', 1, 'DisplayName', ['Animal ' num2str(i)]);
    end
    legend('show');
    
            % add lines to indicate events
            hold on
            xline(0,":r", eventname ,'Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
            yline(0,'-', HandleVisibility='off'); %ligne à y=0
            ylabel(['Z-Score of ∆F/F +/- SEM']);
            xlabel(['Time from ' eventname ' onset (s)']); %change label en fonction de l'event
            xt = get(gca, 'XTick'); 
            legend;
            hold off

             % hold on
            % xline(3,":r",'US','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
            % yline(0,'-', HandleVisibility='off'); %ligne à y=0
            % ylabel(['Z-Score of ∆F/F +/- SEM']);
            % xlabel(['Time from ' eventname ' onset (s)']); %change label en fonction de l'event
            % % xt = get(gca, 'XTick'); 
            % legend;
            % 
            % hold off
            % 
            % hold on
            % xline(10,":r",'CS off','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
            % yline(0,'-', HandleVisibility='off'); %ligne à y=0
            % ylabel(['Z-Score of ∆F/F +/- SEM']);
            % xlabel(['Time from ' eventname ' onset (s)']); %change label en fonction de l'event
            % % xt = get(gca, 'XTick'); 
            % legend;
            % 
            % hold off


% Save figure 
% Create full file path
saveFileName = fullfile(folder_path, ['individual_traces_' eventname '.fig']);

% Save the current figure
savefig(saveFileName);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 2 Mean per group

con_late = nanmean(A_late_2D_means)
def_late = nanmean(B_late_2D_means)


con_late_std = nanstd(A_late_2D_means)
def_late_std = nanstd(B_late_2D_means)


con_late_sem = con_late_std/sqrt(size(A_late_2D_means,1));
def_late_sem = def_late_std/sqrt(size(B_late_2D_means,1));


Xval = A_late1.x_values  ;
Xval = Xval / 1000;


figure;
subplot(1,1,1)

%PLOT
hold on
plot(Xval,con_late,'Color', [0.00,0.00,0.00], 'LineWidth', 1.5, 'DisplayName', 'Control' );
plot(Xval,con_late-con_late_sem,'LineWidth', 1 , 'Color', [0.00,0.00,0.00] , 'LineStyle', ':', 'HandleVisibility', 'off');
plot(Xval,con_late+con_late_sem,'LineWidth', 1 , 'Color', [0.00,0.00,0.00] , 'LineStyle', ':', 'HandleVisibility', 'off');
xA_=[Xval fliplr(Xval)];
yA_=[con_late+con_late_sem, fliplr(con_late-con_late_sem)];
patch(xA_,yA_,[0.00,0.00,0.00], 'FaceAlpha',.1, 'Edgecolor', 'none', 'HandleVisibility', 'off'); %pour avoir le fond coloré entre les SEM
hold off

hold on
plot(Xval,def_late, 'Color', [0.64 0.08 0.18], 'LineWidth', 1.5, 'DisplayName', 'n-3 Deficient' );
plot(Xval,def_late-def_late_sem,'LineWidth', 1 , 'Color', [0.64 0.08 0.18] , 'LineStyle', ':', 'HandleVisibility', 'off');
plot(Xval,def_late+def_late_sem,'LineWidth', 1 , 'Color', [0.64 0.08 0.18] , 'LineStyle', ':', 'HandleVisibility', 'off');
xB_=[Xval fliplr(Xval)];
yB_=[def_late+def_late_sem, fliplr(def_late-def_late_sem)];
patch(xB_,yB_,[0.64 0.08 0.18], 'FaceAlpha',.1, 'Edgecolor', 'none', 'HandleVisibility', 'off');
hold off



hold on
xline(0,":r", eventname,'Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
yline(0,'-', HandleVisibility='off'); %ligne à y=0
ylabel(['Z-Score of ∆F/F +/- SEM']);
xlabel(['Time from ' eventname ' onset (s)']); %change label en fonction de l'event
% xt = get(gca, 'XTick'); 
legend;

hold off


% hold on
% xline(3,":r",'US','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
% yline(0,'-', HandleVisibility='off'); %ligne à y=0
% ylabel(['Z-Score of ∆F/F +/- SEM']);
% xlabel(['Time from ' eventname ' onset (s)']); %change label en fonction de l'event
% % xt = get(gca, 'XTick'); 
% legend;
% 
% hold off
% 
% hold on
% xline(10,":r",'CS off','Color', [0.00,0.00,0.00],'LabelOrientation','horizontal',HandleVisibility='off',LineWidth=1.5); %Ligne à 0, change label en fonction de l'event
% yline(0,'-', HandleVisibility='off'); %ligne à y=0
% ylabel(['Z-Score of ∆F/F +/- SEM']);
% xlabel(['Time from ' eventname ' onset (s)']); %change label en fonction de l'event
% % xt = get(gca, 'XTick'); 
% legend;
% 
% hold off

% Save figure 
% Create full file path
saveFileName = fullfile(folder_path, ['mean_' eventname '.fig']);

% Save the current figure
savefig(saveFileName);


%% AUC Calcultaion
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
%     TA_dip = table(dip_A_auc, dip_A_min_val, dip_A_max_val)
%         'VariableNames', {'AUC', 'MAx_val', 'Min_val'});
% 
%     TB_dip = table(dip_B_auc, dip_B_min_val, dip_B_max_val)
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