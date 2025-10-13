clear;clc;

% imetronic_path = "E:\NAS_SD\SuiviClient\Triffilieff\2025\Reversal intra session Anna\97084_20250311_sess04_rec1_RLintraSess_WT_DA\2025_03_11-11_33_47\05_97084_43.dat";
data_folder = 'F:\Fiber_Photometry\GRAB-DA-mPFC\2024-132 GRAB DA2m mPFC WT Yassiny 2025\test_intraSess';

% [filepath,name,ext] = fileparts(imetronic_path)
% info = parse_filenames(name);

info_table_path = [data_folder filesep 'info_table.txt'];
creates_info_table(data_folder, 'imetronic', info_table_path, @parse_filenames);
info_table = readtable(info_table_path,'Delimiter','\t');

res_struct = table2struct(info_table);
res_struct_blockX = res_struct

complexdata_struct = res_struct
complexdata_struct_blockX = res_struct

nFiles = size(info_table,1);

if ~nFiles, warning('Please check system and task at the top of your config file!'); end

%% STEP 1
for iFile = 1: nFiles % for each file
    
    fluo_file = info_table.filepath(iFile);
    [filepath,name,ext] = fileparts(fluo_file{1})
    dat_list = dir([filepath filesep '*.dat']);
    dat_file = dat_list(1).name;
    dat_path = [filepath filesep dat_file];
    
    %we run the analysis on the entire experiment
    nblocks=0;
    [res_struct, complexdata_struct] = process_one_file(dat_path, res_struct, complexdata_struct, iFile, nblocks);
    
    %we run the analysis only on one block
    nblocks=1;
    [res_struct_blockX, complexdata_struct_blockX] = process_one_file(dat_path, res_struct_blockX, complexdata_struct_blockX, iFile, nblocks);
    
end


a = complexdata_struct(4).resp_values;


function [res_struct, complexdata_struct]  = process_one_file(dat_path, res_struct, complexdata_struct, iFile, nblocks)
    imetronic_rawdata = load_imetronic_rawdata(dat_path);
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
    
    
    

    if ~nblocks
        nblocks = length(all_starts);
    end
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

    trial_num_to_criterion = 0;
    num_TO_to_criterion = 0;
    num_CS_to_criterion = 0;
    for i=1:completed_block_number
        trial_num_to_criterion = trial_num_to_criterion + blocks{i}.ntrials;
        num_TO_to_criterion = num_TO_to_criterion + length(blocks{i}.TO);
        num_CS_to_criterion = num_CS_to_criterion + length(blocks{i}.CS);
    end
    
    
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

    res_struct(iFile).completed_block_number = completed_block_number;
    res_struct(iFile).avg_trial_num_to_criterion  = trial_num_to_criterion / completed_block_number;
    res_struct(iFile).perc_TO_to_criterion  = num_TO_to_criterion / trial_num_to_criterion * 100.0;
    
    res_struct(iFile).total_trial_number  =  total_trial_number;
    res_struct(iFile).total_CS_number  =  length(all_CS);
    res_struct(iFile).percent_CS  =  length(all_CS) / total_trial_number * 100.0;
    
    a = all_resp_values;
    all_strategies = sum([a(1,1:end-1)*1; a(1,2:end)*2]);
    all_strategies =  [-1 all_strategies]
    all_strategies_and_blockchange = all_strategies + all_resp_blockchange*4;
    all_strategies_and_blockchange(1) = -1;
    complexdata_struct(iFile).resp_values = [all_resp_values; all_resp_block_id; all_resp_times; all_strategies;  all_strategies_and_blockchange];
    
    res_struct(iFile).percent_WinStay = length(find(all_strategies==3)) / (length(all_strategies)) *100.0;
    res_struct(iFile).percent_LooseShift = length(find(all_strategies==2)) / (length(all_strategies)) *100.0;
    res_struct(iFile).percent_WinShift = length(find(all_strategies==1)) / (length(all_strategies)) *100.0;
    res_struct(iFile).percent_LooseStay = length(find(all_strategies==0)) / (length(all_strategies)) *100.0;
    
end

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
