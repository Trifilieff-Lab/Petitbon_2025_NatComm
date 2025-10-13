%% CLEAN
clear;close all;clc; %clean old residues

%% FILTERING SEQUENCE
filters = {'eventname','regime','session'};

%% LOAD DATA
params.analysis_folder = 'E:\NAS_SD\SuiviClient\Triffilieff\2023\Analyses\Lola AMP 20230605';
params.figure.folder = params.analysis_folder;

params.results_folder = [params.analysis_folder filesep 'RESULTS'];
params.results_folder = 'E:\NAS_SD\SuiviClient\Triffilieff\2023\Data\Lola 20230930'; %%for debug only
params.results_path = [params.results_folder filesep 'RESULTS2.mat'];

res = load_results(params);

metadata = res.metadata;
matrix = res.matrix;
params = res.params;
sfreq = res.sfreq;

seq_size = size(filters,2);

descend(filters, seq_size, metadata)

function descend(filters, i_filter, metadata)
    if size(filters,2)>1
        filter = filters{i_filter};
        filter_options = unique(metadata(:,filter))
        i_filter = i_filter - 1
        descend({filters{1:end-1}}, i_filter, metadata)
    end
    if size(filters,2)==1
        fprintf('touching bottom')
         filter_options = unique(metadata(:,filters{1}))
    end
   
end















function res = load_results(p)
    as=[];
    load(p.results_path);
    b=1:size(as.metadata,1);
    as.metadata.('LINE_NUM')= b';
    res.metadata = as.metadata;
    res.matrix = as.PEATS.matrix;
    res.auc = as.PEATS.auc;
    res.sfreq = as.sfreq;
    res.PEATS = as.PEATS;
    for fn = fieldnames(p)'
       params.(fn{1}) = p.(fn{1});
    end
    res.params = params;
end