%% INIT

clear;close all;clc;tic;% clear all previous actions
params = [];
params.data_folder = 'H:\Fiber\2024-99\FR3\Datatest';
params.analysis_folder = 'H:\Fiber\2024-99\FR3\testanalysis';
params.figure.folder = params.analysis_folder;

params.acquisition_system = 'RWD'; %DEFINE ACQUISITION SYSTEM 'Doric' or 'RWD'
params.behavioral_task = 'FR' ; % DEFINE BEHAVIORAL TASK 'PAVLOV', 'FR', 'INJECTION' or 'FR1FR5FR10',  'RL_INTRA_SESSION'

%%  ANALYSIS STEP1
params.period_enumeration = 1; % ENUMERATE EVENTS TRIAL BY TRIAL
params.fr_period_enumeration = 0;
if strcmp(params.behavioral_task, 'FR1FR5FR10'), params.fr_period_enumeration = 1; end

% If all the data were not recorded with the same sampling rate, we resample the data, not recommended otherwise
params.resample_photometry = 1;
params.photometry_resampling_frequency = 100;

%% TO REMOVE INITIAL EXPONENTIAL DECAY (PHOTOBLEATCHING )
params.left_trim_dur_sec=0;

%%  ANALYSIS STEP2
% PERI EVENT AVERAGED TIME SERIES (PEATS)

% PEATS TIME WINDOW
params.PEATS.before_msec = -3000;
params.PEATS.after_msec  = 15000;
% params.PEATS.bin_size_msec = 100;
% AUC
params.PEATS.measure_AUC = 1;
params.PEATS.AUC_before_msec = 0;
params.PEATS.AUC_after_msec  = 500;

% INDIVIDUAL BASELINE TIME WINDOW
params.PEATS.use_periodic_bl = 1;
params.PEATS.use_individual_bl = 0;
params.PEATS.use_session_bl = 0;

% FOR INDIVIDUAL BASELINE
params.PEATS.bl_before_msec = -3500;
params.PEATS.bl_after_msec  = -500;

params.PEATS.apply_zscore = 1;


%% DEFINE FIGURE CREATION
params.figure.savepng = 1;
params.figure.savefig = 1;
params.figure.closefig = 1;

%% CREATE FIGURES TO CHECK INTERMEDIATE STEPS
params.debug.mode = 0;
params.debug.folder = [params.analysis_folder filesep 'debug_figures'];
params.debug.savepng = params.figure.savepng;
params.debug.savefig = params.figure.savefig;
params.debug.closefig = params.figure.closefig;
params.debug.prefix = '';

%% CONFIGURATION OF DIGITAL AND ANALOG INPUTS/OUTPUTS
params.recording_config = get_recording_config(params.acquisition_system,params.behavioral_task);

%% THE LINK TO THE FILE THAT CONTAINS ALL METADATA
params.info_table_path = [params.data_folder filesep 'info_table.txt'];
creates_info_table(params.data_folder, params.acquisition_system, params.info_table_path, @parse_filenames);
% Otherwise create a file like this one using tabulations
% MOUSE	DATE	SESSION	REC	TASK	GROUP	GENDER	FILEPATH
% M1	20221207	01	1	Pavlovien	DELTA	M	E:\NAS_SD\SuiviClient\Triffilieff\RevueCodeJulien\20221115\data\M1_20221207_sess01_rec1_Pavlovien_M_DELTA_2.csv
% M1	20221208	02	1	Pavlovien	DELTA	M	E:\NAS_SD\SuiviClient\Triffilieff\RevueCodeJulien\20221115\data\M1_20221208_sess02_rec1_Pavlovien_M_DELTA_2.csv
% M1	20221209	03	1	Pavlovien	DELTA	M	E:\NAS_SD\SuiviClient\Triffilieff\RevueCodeJulien\20221115\data\M1_20221209_sess03_rec1_Pavlovien_M_DELTA_2.csv
% M2	20221207	01	1	Pavlovien	DELTA	M	E:\NAS_SD\SuiviClient\Triffilieff\RevueCodeJulien\20221115\data\M2_20221207_sess01_rec1_Pavlovien_M_DELTA_2.csv
% M2	20221208	02	1	Pavlovien	DELTA	M	E:\NAS_SD\SuiviClient\Triffilieff\RevueCodeJulien\20221115\data\M2_20221208_sess02_rec1_Pavlovien_M_DELTA_2.csv
% M2	20221209	03	1	Pavlovien	DELTA	M	E:\NAS_SD\SuiviClient\Triffilieff\RevueCodeJulien\20221115\data\M2_20221209_sess03_rec1_Pavlovien_M_DELTA.csv
params.info_table = readtable(params.info_table_path,'Delimiter','\t');
params.info_struct =  parse_filenames();

%% Add Postprocessing functions
params.step1_postprocessing_functions = {};
params.step1_postprocessing_functions{end+1} = @resample_data;
% merge the two different categories of licks
if strcmp(params.acquisition_system,'RWD') && (strcmp(params.behavioral_task,'FR') || strcmp(params.behavioral_task,'FR1FR5FR10') || strcmp(behavioral_task,'RL_INTRA_SESSION'))
    params.step1_postprocessing_functions{end+1} = @merge_licks;
end
% analyse des bouts for Lever1 and Lever2
if (strcmp(params.behavioral_task,'FR') || strcmp(params.behavioral_task,'FR1FR5FR10') || strcmp(behavioral_task,'RL_INTRA_SESSION'))
    params.step1_postprocessing_functions{end+1} = @add_bout_start_event;
end
% divide_events_into_periods / trials
params.step1_postprocessing_functions{end+1} = @divide_events_into_periods;


% detect_schedule_changes (détection des changements de régime)
if strcmp(params.behavioral_task,'FR1FR5FR10')
    params.step1_postprocessing_functions{end+1} = @detect_schedule_changes;
end

if strcmp(params.behavioral_task, 'RL_INTRA_SESSION')
    params.step1_postprocessing_functions{end+1} = @add_RL_events;
end

params.step1_postprocessing_functions{end+1} = @tag_all_events_all_occurences;


%% ALL ANALYSIS DONE BY THIS MAIN FUNCTION
%% ALL ANALYSIS DONE BY THIS MAIN FUNCTION
main(params)

%% EXPLAINS THE FORMAT YOU CHOOSE FOR YOUR FILENAMES
%Anna, f = '83305_20230307_sess01_rec1_def'
% function info = parse_filenames(f)
%      switch nargin
%         case 0
%             info=struct('session', '', 'mouse','','task','','date','');
%         case 1
%             f = split(f,'.');
%             f = f{1};
%             fields = split(f,'_');
%             info.session = fields{1};
%             info.mouse = fields{2};
%             info.task = fields{3};
%             info.date = fields{4};
%     end
% end

%% EXPLAINS THE FORMAT YOU CHOOSE FOR YOUR FILENAMES
% Lola, f = '83305_20230307_sess01_rec1_def_nac_1'
% function info = parse_filenames(f)
%     switch nargin
%         case 0
%         info=struct('mouse','','date','','session','','sex','','genotype','','task','');
%     case 1
%         f = split(f,'.');
%         f = f{1};
%         fields = split(f,'_');
%         info.mouse = fields{1};
%         info.date = fields{2};
%         info.session = fields{3}(8:end);
%         info.sex = fields{4};
%         info.genotype = fields{5};
%         info.task = fields{6};
        function info = parse_filenames(f)
switch nargin
    case 0
        info=struct('mouse','','date','','session','','rec','','group', ''); %,'earlylate',''
    case 1
        f = split(f,'.');
        f = f{1};
        fields = split(f,'_');
        info.mouse = fields{1};
        info.date = fields{2};
        info.session = fields{3}(5:end);
        info.rec = fields{4}(4:end);
        info.diet = fields{5};
%         info.earlylate = fields{6};
    end
end

%% CONFIGURATION OF DIGITAL AND ANALOG INPUTS/OUTPUTS
function recording_config = get_recording_config(system,behavioral_task)

%% FOR DORIC FR OR PAVLOV
if strcmp(system,'Doric') && strcmp(behavioral_task,'FR')
    recording_config = {
        {'DIO1','LED405'},...
        {'DIO2','LED470'},...
        {'DIO3','Camera','extract_as_TTL','hardware_events'},...
        {'DIO4','Pulse','extract_as_TTL','hardware_events'},...
        {'AIn1','GCaMP'},...
        {'AIn2','ComplexTTL1','extract_as_ComplexTTL','behavioral_events',{'Licks1','Levers_presentation', 'CS', 'Licks2'},{[0.00,0.05],[0.05,0.15],[0.15,0.25],[0.25,0.35]}},...
        {'AIn3','L2','extract_as_TTL','behavioral_events'},...
        {'AIn4','L1','extract_as_TTL','behavioral_events'},...
        %{'Imetronic_Synchro','AIn2','Lever1',@get_TTL2_from_dat},...
        %{'Imetronic_Event','Lever2',@get_Lever2_from_dat,'behavioral_events'},...
        {'behavioral_periods_starts','Levers_presentation'},...
        {'behavioral_periods_baselines','Levers_presentation', -3000,0}
        };
end

if strcmp(system,'Doric') && strcmp(behavioral_task,'PAVLOV')
    recording_config = {
        {'DIO1','LED405'},...
        {'DIO2','LED470'},...
        {'DIO3','Camera','extract_as_TTL','hardware_events'},...
        {'DIO4','Pulse','extract_as_TTL','hardware_events'},...
        {'AIn1','GCaMP'},...
        {'AIn2','Licks','extract_as_TTL','behavioral_events'},...
        {'AIn3','CS','extract_as_TTL','behavioral_events'},...
        {'AIn4','US','extract_as_TTL','behavioral_events'},...
        {'behavioral_periods_starts','CS'},...
        {'behavioral_periods_baselines','CS', -23000,-20000}
        };
end


% {'Imetronic_Synchro','Input2','CS',@get_cs_from_dat},...
%         {'Imetronic_Synchro','Input3','L2_press',@get_L2press_from_dat},...
% RWD System
if strcmp(system,'RWD') && (strcmp(behavioral_task,'FR') || strcmp(behavioral_task,'RL_INTRA_SESSION'))
    recording_config = {
        {'Input1','pulse','extract_as_TTL','hardware_events'},...
        {'Input2','ComplexTTL1','extract_as_ComplexTTL','behavioral_events',{'Licks1','Levers_presentation', 'CS', 'Licks2'},{[0.00,0.05],[0.05,0.15],[0.15,0.25],[0.25,0.35]}},...
        {'Input3','L2_press','extract_as_TTL','behavioral_events'},...
        {'Input4','L1_press','extract_as_TTL','behavioral_events'},...
        {'Imetronic_Synchro','Input2','CS',@get_cs_from_dat},...
        {'Imetronic_Event','FIN_CS',@get_fin_cs_from_dat,'behavioral_events'},...
        {'Imetronic_Event','US',@get_us_from_dat,'behavioral_events'},...
        {'behavioral_periods_starts','Levers_presentation'},...
        {'behavioral_periods_baselines','Levers_presentation', -3000,-500},...
        {'#', 'L1_press', 'L2_press', 'L1_bout_P1'},...
        {'bout_ILPI', 0.6},...
        {'min_bout_size', 2},...
        };
end

if strcmp(system,'RWD') && strcmp(behavioral_task,'PAVLOV')
    recording_config = {
        {'Input1','pulse','extract_as_TTL','hardware_events'},...
        {'Input2','lick','extract_as_TTL','behavioral_events'},...
        {'Input3','CS','extract_as_TTL','behavioral_events'},...
        {'Input4','US','extract_as_TTL','behavioral_events'},...
        {'Imetronic_Synchro','Input4','US',@get_TTL4_from_dat},...
        {'Imetronic_Event','FIN_CS',@get_fin_cs_from_dat,'behavioral_events'},...
        {'behavioral_periods_starts','CS'},...
        {'behavioral_periods_baselines','CS', -3000,0}
        };
end

if strcmp(system,'RWD') && strcmp(behavioral_task,'FR1FR5FR10')
    recording_config = {
        {'Input1','pulse','extract_as_TTL','hardware_events'},...
        {'Input2','ComplexTTL1','extract_as_ComplexTTL','behavioral_events',{'Licks1','Levers_presentation', 'CS', 'Licks2'},{[0.00,0.05],[0.05,0.15],[0.15,0.25],[0.25,0.35]}},...
        {'Input3','L2_press','extract_as_TTL','behavioral_events'},...
        {'Input4','L1_press','extract_as_TTL','behavioral_events'},...
        {'Imetronic_Synchro','Input2','CS',@get_cs_from_dat},...
        {'Imetronic_Event','FIN_CS',@get_fin_cs_from_dat,'behavioral_events'},...
        {'Imetronic_Event','US',@get_us_from_dat,'behavioral_events'},...
        {'behavioral_periods_starts','Levers_presentation'},...
        {'behavioral_periods_baselines','Levers_presentation', -3000,0},...
        {'num_events_within_period', 'L1_press', 'L1_bout_P1'},...
        {'bout_ILPI', 0.6},...
        {'min_bout_size', 2},...
        };
end



%% FOR RWD AND INJECTION
if strcmp(system,'RWD') && strcmp(behavioral_task,'INJECTION')
    recording_config = {
        {'EventFile','stimA','my_events.txt','behavioral_events'}
        };
end


end



% #001219
% #005f73
% #0a9396
% #94d2bd
% #e9d8a6
% #ee9b00
% #ca6702
% #bb3e03
% #ae2012
% #9b2226
