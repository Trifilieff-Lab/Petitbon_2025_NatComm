
%% CLEAR AND INITIALIZE
clear;close all;clc;tic;

%% DEFINE THE STRUCTURE THAT WILL HOLD ALL THE PARAMETERS
params = [];

%% DEFINE INPUTS AND OUTPUTS
params.data_folder = 'F:\Fiber_Photometry\GRAB-DA-mPFC\2024-132 GRAB DA2m mPFC WT Yassiny 2025\Pavlovian_DATA';
params.analysis_folder = 'F:\Fiber_Photometry\GRAB-DA-mPFC\2024-132 GRAB DA2m mPFC WT Yassiny 2025\Pavlovian_ANALYSIS_bsl_indiv_Tri_79338';
params.figure.folder = params.analysis_folder;


%%  STEP1  %% %% %% %%

% ENUMERATE EVENTS TRIAL BY TRIAL
params.period_enumeration = 0;

%% DEFINE THE ACQUISITION SYSTEM
params.acquisition_system = 'RWD'; % 'Doric' or 'RWD'
params.behavioral_task = 'PAVLOV'; % 'PAVLOV', 'FR' or 'INJECTION', 'FR5FR10FR15', 'EXT', 'RL_INTRA_SESSION'

%% IF DATA WERE RECORDED WITH DIFFERENT SAMPLING RATES
% NOT RECOMMENDED OTHERWISE
params.resample_photometry = 1;
params.photometry_resampling_frequency = 100;

%% TO REMOVE INITIAL EXPONENCIAL PHOTOBLEATCHING DECAY
params.left_trim_dur_sec=0;


%% PERI EVENT AVERAGED TIME SERIES (PEATS)
%% STEP2 %% %% %% %%

% PEATS TIME WINDOW
params.PEATS.before_msec = -2500;
params.PEATS.after_msec  = 12000;
% params.PEATS.bin_size_msec = 100;
% AUC
params.PEATS.measure_AUC = 0;
params.PEATS.AUC_before_msec = 0;
params.PEATS.AUC_after_msec  = 500;


% INDIVIDUAL BASELINE TIME WINDOW
params.PEATS.use_periodic_bl = 0;
params.PEATS.use_individual_bl = 1;
params.PEATS.use_session_bl = 0;
params.PEATS.bl_before_msec = -2500;
params.PEATS.bl_after_msec  = -1000;
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

params.step1_postprocessing_functions = {};
params.step1_postprocessing_functions{end+1} = @resample_data;

if strcmp(params.acquisition_system,'RWD') && strcmp(params.behavioral_task,'FR')
    params.step1_postprocessing_functions{end+1} = @merge_licks;
end


%% Analyse des bouts de L1 et L2
if strcmp(params.behavioral_task, 'FR')
    params.step1_postprocessing_functions{end+1} = @add_bout_start_event;
end


if strcmp(params.behavioral_task, 'FR')
    params.step1_postprocessing_functions{end+1} = @add_bout_start_event;
end

if strcmp(params.behavioral_task, 'RL_INTRA_SESSION')
    params.step1_postprocessing_functions{end+1} = @add_RL_events;
end



%params.step1_postprocessing_functions{end+1} = @divide_events_into_periods;

% %% Analyse du numéro d'appuis dans un essai
%
% if strcmp(params.behavioral_task, 'FR')
%     params.step1_postprocessing_functions{end+1} = @tag_fr;
% end



%% ALL ANALYSIS DONE BY THIS MAIN FUNCTION
main(params)

%% EXPLAINS THE FORMAT YOU CHOOSE FOR YOUR FILENAMES
%f = '83305_20230307_sess01_rec1_def_nac_1'
function info = parse_filenames(f)
switch nargin
    case 0
        info=struct('mouse','','date','','session','','rec','','beh_task','','genotype','','group','');
    case 1
        f = split(f,'.');
        f = f{1};
        fields = split(f,'_');
        info.mouse = fields{1};
        info.date = fields{2};
        info.session = fields{3}(5:end);
        info.rec = fields{4}(4:end);
        info.beh_task = fields{5};
        info.genotype = fields{6};
        info.group = fields{7};
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


% RWD System
if strcmp(system,'RWD') && ( strcmp(behavioral_task,'FR') || strcmp(behavioral_task,'RL_INTRA_SESSION'))
    recording_config = {
        {'Input1','pulse','extract_as_TTL','hardware_events'},...
        {'Input2','ComplexTTL1','extract_as_ComplexTTL','behavioral_events',{'Licks1','Levers_presentation', 'CS', 'Licks2'},{[0.00,0.05],[0.05,0.15],[0.15,0.25],[0.25,0.35]}},...
        {'Input3','L2_press','extract_as_TTL','behavioral_events'},...
        {'Input4','L1_press','extract_as_TTL','behavioral_events'},...
        {'Imetronic_Synchro','Input2','CS',@get_cs_from_dat},...
        {'Imetronic_Event','FIN_CS',@get_fin_cs_from_dat,'behavioral_events'},...
        {'Imetronic_Event','US',@get_us_from_dat,'behavioral_events'},...
        {'behavioral_periods_starts','Levers_presentation'},...
        {'behavioral_periods_baselines','Levers_presentation', -5000,0},...
        {'FR#', 'L1_press'},...
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
        {'behavioral_periods_baselines','CS', -2500,-1000}
        };
end


if strcmp(system,'RWD') && strcmp(behavioral_task,'EXT')
    recording_config = {
        {'Input1','pulse','extract_as_TTL','hardware_events'},...
        {'Input2','lick','extract_as_TTL','behavioral_events'},...
        {'Input3','L2_press','extract_as_TTL','behavioral_events'},...
        {'Input4','L1_press','extract_as_TTL','behavioral_events'},...
        {'Imetronic_Synchro','Input1','pulse',@get_TTL1_from_dat},...
        {'behavioral_periods_starts','Levers_presentation'},...
        {'behavioral_periods_baselines','Levers_presentation', -5000,0},...
        {'FR#', 'L1_press'},...
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

function lever2 = get_Lever2_from_dat(imetronic_DB)
tmp = imetronic_DB(2).num(2).info;
i=find(diff(tmp(:,6))==1);
lever2 =  tmp(i+1,1);
end

function fin_cs = get_fin_cs_from_dat(imetronic_DB)
sounds = imetronic_DB(6).num(2).info;
idx = find(sounds(:,8)>0); %remove trial 0
sounds = sounds(idx,:);
idx = find(sounds(:,4)==1);
sounds_onsets = sounds(idx,1);
sounds_offsets = [];
fin_cs = [];
for i=1:size(idx,1)
    try
        sounds_offsets(end+1) = sounds(idx(i)+1,1);
    catch
        fprintf('error in get_fin_cs_from_dat');
    end
end
fin_cs = sounds_offsets';
end

function cs = get_cs_from_dat(imetronic_DB)
sounds = imetronic_DB(6).num(2).info;
idx = find(sounds(:,8)>0); %remove trial 0
sounds = sounds(idx,:);
idx = find(sounds(:,4)==1);
sounds_onsets = sounds(idx,1);
cs = sounds_onsets;
end

function us = get_us_from_dat(imetronic_DB)
us_info = imetronic_DB(5).num(1).info;
if size(us_info,1)
    us = us_info(find(us_info(:,10)==1),1);
else
    us = [];
end
end



function TTL = get_TTL_from_dat(imetronic_DB, TTL_num)
tmp = imetronic_DB(15).num(TTL_num).info;
TTL = unique(tmp( find(tmp(:,4)==1) ,1));
end
function TTL = get_TTL1_from_dat(imetronic_DB)
TTL = get_TTL_from_dat(imetronic_DB, 1)
end
function TTL = get_TTL2_from_dat(imetronic_DB)
TTL = get_TTL_from_dat(imetronic_DB, 2)
end
function TTL = get_TTL3_from_dat(imetronic_DB)
TTL = get_TTL_from_dat(imetronic_DB, 3)
end
function TTL = get_TTL4_from_dat(imetronic_DB)
TTL = get_TTL_from_dat(imetronic_DB, 4)
end



function step1_data = resample_data(step1_data, rec_config, params)
if params.resample_photometry
    time = step1_data.time;
    n = size(time,1);
    original_sfreq = 1/median(diff(time));
    correction_factor = params.photometry_resampling_frequency / original_sfreq;
    x = 1:n;
    xq = 1:1/correction_factor:n;
    time_rs = interp1(x,time,xq,'linear');
    
    var2interp = {'time', 'iso', 'physio', 'dff', 'fit_iso'};
    nVars = size(var2interp,2);
    for iVar=1:nVars
        tmp = interp1(x, step1_data.(var2interp{iVar}),xq,'spline')';
        %             figure()
        %             hold on
        %             plot(x, step1_data.(var2interp{iVar}),'k+--')
        %             plot(xq, tmp,'r.')
        step1_data.(var2interp{iVar})=tmp;
    end
    
end

end

function step1_data = merge_licks(step1_data, rec_config, params)
Licks1 = step1_data.behavioral_events.Licks1;
Licks2 = step1_data.behavioral_events.Licks2;
f = fieldnames(Licks1);
for i=1:size(f,1)
    cmd=sprintf('Licks.%s=sort([Licks1.%s; Licks2.%s]);',f{i},f{i},f{i});eval(cmd);
end
step1_data.behavioral_events.Licks=Licks;
step1_data.behavioral_events = rmfield(step1_data.behavioral_events,'Licks1');
step1_data.behavioral_events = rmfield(step1_data.behavioral_events,'Licks2');
end

function step1_data = divide_events_into_periods(step1_data, rec_config, params)


n = size(rec_config,2);

% establish period starts based on behavioral_periods_starts in
% rec_config
for i=1:n
    tmp = rec_config{i};
    if strcmp(tmp{1},'behavioral_periods_starts')
        cmd = sprintf('starts=step1_data.behavioral_events.%s.on_ts;',tmp{2});eval(cmd);
        m = size(starts,1);
        for j=1:m
            step1_data.behavioral_periods(j).period_start_ts = starts(j);
        end
    end
end

% establish baseline_periods based on behavioral_periods_baselines in
% rec_config
for i=1:n
    tmp = rec_config{i};
    if strcmp(tmp{1},'behavioral_periods_baselines')
        cmd = sprintf('starts=step1_data.behavioral_events.%s.on_ts;', tmp{2});eval(cmd);
        m = size(starts,1);
        for j=1:m
            step1_data.behavioral_periods(j).baseline_start_ts = starts(j) + tmp{3}/1000;
            step1_data.behavioral_periods(j).baseline_stop_ts = starts(j) + tmp{4}/1000;
        end
    end
end


behavioral_event_fields = fieldnames(step1_data.behavioral_events);
nE = size(behavioral_event_fields,1);
nP = size(step1_data.behavioral_periods,2);

for iE=1:nE
    
    step1_data.behavioral_events.(behavioral_event_fields{iE}).id_in_period=[];
    step1_data.behavioral_events.(behavioral_event_fields{iE}).periods=[];
    
    s = step1_data.behavioral_events.(behavioral_event_fields{iE});
    on_ts = s.on_ts;
    
    nO = size(on_ts,1);
    
    if nO
        
        %determine the period in which each event happens
        periods = discretize(s.on_ts,[step1_data.behavioral_periods.period_start_ts step1_data.time(end)]);
        step1_data.behavioral_events.(behavioral_event_fields{iE}).periods=periods;
        
        %determine the occurence of each event within each trial,
        %for ex the third lever press of each trial
        id_in_period = [];
        prev_period = periods(1);
        cur_id = 1;
        id_in_period(end+1)=1;
        
        if nO>1
            for iO=2:nO
                if periods(iO)==prev_period
                    cur_id = cur_id + 1;
                else
                    cur_id =  1;
                end
                id_in_period(iO)=cur_id;
                prev_period = periods(iO);
            end
        end
        
        
        nan_idx = isnan(periods);
        id_in_period(nan_idx)=nan;
        step1_data.behavioral_events.(behavioral_event_fields{iE}).id_in_period=id_in_period;
        
    end
    
end

end

function step1_data = tag_fr(step1_data, rec_config, params)
%             {'FR#', 'L1_press'}

rec_config_valid = false
n = size(rec_config,2);
for i=1:n
    tmp = rec_config{i};
    if strcmp(tmp{1},'FR#')
        event_name = tmp{2};
        cmd = sprintf('tmp2=step1_data.behavioral_events.%s',tmp{2});eval(cmd);
        rec_config_valid = true
    end
end

if ~rec_config_valid
    cprintf('*#C5283D','AQUINEURO WARNING ----------------------------------------------------------------------------------------\n')
    cprintf('#C5283D','you are performing a preprocessing step to label the lever press occurence within each trial\n')
    cprintf('#C5283D','please double check your recording_config\n');
    cprintf('#C5283D','does it contains a line like this one\n');
    cprintf('#C5283D','{''FR#'', ''L1_press''}\n');
    cprintf('#C5283D','If you don''t want to perform this preprocessing step\n')
    cprintf('#C5283D','please comment this line\n')
    cprintf('#C5283D','params.step1_postprocessing_functions{end+1} = @tag_fr;\n');
end

id_in_period = tmp2.id_in_period;
ids = unique(tmp2.id_in_period);

ids(isnan(ids))=[];
for i = 1:size(ids,2)
    id_ = ids(i);
    pos = find(id_in_period==i)
    cmd = sprintf('step1_data.behavioral_events.%s_%d=step1_data.behavioral_events.%s',event_name,id_,event_name)
    eval(cmd);
    fields = fieldnames(step1_data.behavioral_events.L1_press_1)
    for j = 1:size(fields,1)
        cmd = sprintf('step1_data.behavioral_events.%s_%d.%s=step1_data.behavioral_events.%s.%s(pos);',event_name,id_,fields{j},event_name,fields{j});
        eval(cmd);
    end
end
end



function step1_data = add_bout_start_event(step1_data, rec_config, params)

rec_config_valid = false;
n = size(rec_config,2);
for i=1:n
    tmp = rec_config{i};
    if strcmp(tmp{1},'bout_ILPI')
        bout_ILPI = tmp{2};
        rec_config_valid = true
    end
    if strcmp(tmp{1},'min_bout_size')
        min_bout_size = tmp{2};
        rec_config_valid = true
    end
    
end

if ~rec_config_valid
    cprintf('*#C5283D','AQUINEURO WARNING ----------------------------------------------------------------------------------------\n')
    cprintf('#C5283D','you are detecting detect_press_bouts\n')
    cprintf('#C5283D','please double check your recording_config\n');
    cprintf('#C5283D','does it contains a line like this one\n');
    cprintf('#C5283D','{''bout_ILPI'', 0.6s}\n');
    cprintf('#C5283D','If you don''t want to perform this preprocessing step\n')
    cprintf('#C5283D','please comment this line\n')
    cprintf('#C5283D','params.step1_postprocessing_functions{end+1} = @add_bout_start_event;\n');
end


onset = step1_data.behavioral_events.L1_press.on_ts;
offset = step1_data.behavioral_events.L1_press.off_ts;
[on_ts, off_ts, bouts_sizes, bouts_durations] = detect_press_bouts(onset, offset, bout_ILPI,min_bout_size,params,'L1');
step1_data.behavioral_events.L1_bout_P1 = struct()
step1_data.behavioral_events.L1_bout_P1.on_ts = on_ts';
step1_data.behavioral_events.L1_bout_P1.off_ts = off_ts';

onset = step1_data.behavioral_events.L2_press.on_ts;
offset = step1_data.behavioral_events.L2_press.off_ts;
[on_ts, off_ts, bouts_sizes, bouts_durations] = detect_press_bouts(onset, offset, bout_ILPI,min_bout_size, params,'L2');
step1_data.behavioral_events.L2_bout_P1 = struct()
step1_data.behavioral_events.L2_bout_P1.on_ts = on_ts';
step1_data.behavioral_events.L2_bout_P1.off_ts = off_ts';



end


function [on_ts, off_ts, bouts_sizes, bouts_durations] = detect_press_bouts(onset, offset, bout_ILPI,min_bout_size, params, tag)

on_ts = []
off_ts = []
bouts_sizes = []
bouts_durations = []

if min(size(onset))>0
    
    
    dt_onset = [0 diff(onset)'];
    
    n_onset = size(dt_onset,2);
    
    ts = [];
    
    bouts = {};
    ibout=1;
    
    bouts{ibout} = struct();
    bouts{ibout}.ts_onset = [];
    bouts{ibout}.ts_offset = [];
    for i=1:n_onset
        
        if dt_onset(i)>=bout_ILPI
            ibout=ibout+1;
            bouts{ibout} = struct();
            bouts{ibout}.ts_onset = [];
            bouts{ibout}.ts_offset = [];
        end
        
        bouts{ibout}.ts_onset = [bouts{ibout}.ts_onset onset(i)'];
        bouts{ibout}.ts_offset = [bouts{ibout}.ts_offset offset(i)'];
    end
    
    
    n_bouts = size(bouts,2);
    bouts_sizes = [];
    bouts_durations = [];
    on_ts = [];
    off_ts = []
    
    for ibout=1:n_bouts
        cur_bout_size =  size(bouts{ibout}.ts_onset,2);
        if cur_bout_size>=min_bout_size
            bouts_sizes = [bouts_sizes cur_bout_size];
            bouts_durations = [bouts_durations (bouts{ibout}.ts_offset(end)-bouts{ibout}.ts_onset(1))];
            on_ts = [on_ts bouts{ibout}.ts_onset(1)];
            off_ts = [off_ts bouts{ibout}.ts_offset(1)];
        end
    end
    
    n_bouts = size(bouts_sizes,2);
    mean_duration = mean(bouts_durations);
    
    params.bout_ouputname = [params.analysis_folder filesep tag '_bouts.xls'];
    params.bout_fod = fopen(params.bout_ouputname,'a');
    fprintf(params.bout_fod,"%s_%s_sizes",params.figure.prefix,tag);
    for ibout=1:n_bouts
        fprintf(params.bout_fod,"\t%d",bouts_sizes(ibout));
    end
    fprintf(params.bout_fod,"\n");
    fprintf(params.bout_fod,"%s_%s_duration",params.figure.prefix,tag);
    for ibout=1:n_bouts
        fprintf(params.bout_fod,"\t%f",bouts_durations(ibout));
    end
    fprintf(params.bout_fod,"\n");
    
    
    params.bout_fod = fclose(params.bout_fod);
    
end


end


function  step1_data = add_RL_events(step1_data, rec_config, params)

    imetronic_rawdata = step1_data.imetronic_rawdata;
    idx = find(imetronic_rawdata(:,2)==10);
    imetronic_line_changes = [imetronic_rawdata(idx,1) imetronic_rawdata(idx,8)];
    imetronic_line_numbers = [[2, 6, 10];[11, 15, 19]];
    var_names = {'start', 'CS','TO'};
    tmp_block = {};

    for i = 1:2
        tmp = struct();
        for i_var = 1:3
            idx = find(imetronic_line_changes(:,2)==imetronic_line_numbers(i, i_var));
            cmd = sprintf('tmp.%s =  imetronic_line_changes(idx,1);', var_names{i_var});
            eval(cmd);
        end
        tmp_block{i} = tmp;
    end

    all_starts = []; all_CS = []; all_TO = []; all_reversal_ids = [];
    for i = 1:2
        all_starts = [all_starts tmp_block{i}.start'];
        all_CS = [all_CS tmp_block{i}.CS'];
        all_TO = [all_TO tmp_block{i}.TO'];
        all_reversal_ids = [all_reversal_ids i*ones(1,length(tmp_block{i}.start))];
    end
    [all_starts, new_idx] = sort(all_starts);
    all_reversal_ids = all_reversal_ids(new_idx);
    all_stops = [all_starts(2:end) imetronic_rawdata(end,1)];




    nblocks = length(all_starts);

    blocks = {}
    for i=1:nblocks
        blocks{i}.start = all_starts(i);
        blocks{i}.stop = all_stops(i);
        CS = get_sub_ts(all_CS, blocks{i}.start,  blocks{i}.stop);
        TO =  get_sub_ts(all_TO, blocks{i}.start,  blocks{i}.stop);
        blocks{i}.CS = CS;
        blocks{i}.TO = TO;
        resp_times = [CS TO];
        resp_values = [ones(1,length(CS)) zeros(1,length(TO))];
        resp_block_id = ones(1,length(resp_values))*i;
        [blocks{i}.resp_times, idx] = sort(resp_times);
        blocks{i}.resp_values = [resp_values(idx)];
        blocks{i}.resp_block_id = [resp_block_id(idx)];
        blocks{i}.ID = all_reversal_ids(i);
        blocks{i}.ntrials = length(blocks{i}.CS) + length(blocks{i}.TO);
    end

    completed_block_number = nblocks -1;

%     trial_num_to_criterion = 0;
%     num_TO_to_criterion = 0;
%     num_CS_to_criterion = 0;
%     for i=1:completed_block_number
%         trial_num_to_criterion = trial_num_to_criterion + blocks{i}.ntrials;
%         num_TO_to_criterion = num_TO_to_criterion + length(blocks{i}.TO);
%         num_CS_to_criterion = num_CS_to_criterion + length(blocks{i}.CS);
%     end


    total_trial_number = 0;
    all_resp_values = []; all_resp_block_id= [];
    all_resp_times = []; all_resp_blockchange = [];

    for i=1:nblocks
        total_trial_number = total_trial_number + blocks{i}.ntrials;
        all_resp_values = [all_resp_values blocks{i}.resp_values];
        all_resp_blockchange = [all_resp_blockchange 1 zeros(1, blocks{i}.ntrials-1)];
        all_resp_block_id = [all_resp_block_id blocks{i}.resp_block_id];
        all_resp_times = [all_resp_times blocks{i}.resp_times];
    end

    a = all_resp_values;
    all_strategies = sum([a(1,1:end-1)*1; a(1,2:end)*2]);
    all_strategies_historic =  [-1 all_strategies]; % W_St_W etc strategies (x8), effect of last choice on next choice + outcome (on trial n+1)
    all_strategies_anticipation =  [all_strategies -1]; % W_St etc strategies (x4), effect of outcome on next choice during trial n
    all_strategies_and_blockchange = all_strategies_historic + all_resp_blockchange*4;
    all_strategies_and_blockchange(1) = -1;
    all_strategies_anticipation(end) = -1;
    data = [all_resp_values; all_resp_block_id; all_resp_times; all_strategies_historic;  all_strategies_and_blockchange; all_strategies_anticipation];
    
    
    
    rl_beh_names_1 = {
        'L_St_L',
        'W_Sh_L',
        'L_Sh_W',
        'W_St_W',
        'L_St_W',
        'W_Sh_W',
        'L_Sh_L',
        'W_St_L'
        }
    for i=1:8
        idx = find(all_strategies_and_blockchange==(i-1));
        ts = all_resp_times(idx);
        cmd = sprintf('step1_data.behavioral_events.%s.on_ts=ts/1000;',rl_beh_names_1{i});
        eval(cmd);
    end

     rl_beh_names_2 = {
        'L_St',
        'W_Sh',
        'L_Sh',
        'W_St'
        }
    for i=1:4
        idx = find(all_strategies_anticipation==(i-1));
        ts = all_resp_times(idx);
        cmd = sprintf('step1_data.behavioral_events.%s.on_ts=ts/1000;',rl_beh_names_2{i});
        eval(cmd);
    end

    rl_beh_names_3 = {
        'Loss',
        'Win'
        }
    for i=1:2
        idx = find(all_resp_values==(i-1));
        ts = all_resp_times(idx);
        cmd = sprintf('step1_data.behavioral_events.%s.on_ts=ts/1000;',rl_beh_names_3{i});
        eval(cmd);
    end    

end


