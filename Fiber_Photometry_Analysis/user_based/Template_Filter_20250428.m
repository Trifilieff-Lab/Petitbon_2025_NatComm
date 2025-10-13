%% CLEAN
clear;close all;clc; %clean old residues

params.extract_databases = 0;
params.extract_pivot_table = 0;

params.export_png=0;
params.export_fig=0;
params.export_txt=0;
params.export_mat=1;

params.data_type = 'dff';

params.PEATS_binsize_ms = 100; %en ms
params.PEATS_x_tickfreq = .1; %1/10


%% FILTERING SEQUENCE

%filtering_sequence = {'eventname','group','mouse'};
%filtering_sequence = {'eventname','group','session','mouse'};

%filtering_sequence = {'eventname','mouse','session'};
%filtering_sequence = {'eventname','mouse'};
filtering_sequence = {'eventname','session','mouse'};

%% LOAD DATA

params.data_folder = 'F:\Fiber_Photometry\GRAB-DA-mPFC\2024-132 GRAB DA2m mPFC WT Yassiny 2025\FR1_DATA';
params.analysis_folder = 'F:\Fiber_Photometry\GRAB-DA-mPFC\2024-132 GRAB DA2m mPFC WT Yassiny 2025\FR1_ANALYSIS_bsl_indiv_tri_79338';
params.figure.folder = params.analysis_folder;
params.results_folder = [params.analysis_folder filesep 'RESULTS'];
params.results_path = [params.results_folder filesep 'RESULTS.mat'];
res = load_results(params);

metadata = res.metadata;

try
    i_lines = isnan(metadata.periodnum);
    metadata(i_lines,:)=[];
    metadata = convertvars(metadata,{'periodnum'},'string');
    cprintf('*#C5283D','AQUINEURO WARNING ----------------------------------------------------------------------------------------\n')
    cprintf('#C5283D','%2.2 perc.  lines were removed for the metada\n', sum(i_lines)/size(i_lines,1)*100);
catch
    cprintf('*#C5283D','AQUINEURO WARNING ----------------------------------------------------------------------------------------\n')
    cprintf('#C5283D','periodnum absent from metadata\n');
end

matrix = res.matrix;
matrix_fitiso = res.matrix_fitiso;
matrix_physio = res.matrix_physio;

params = res.params;
sfreq = res.sfreq;

PEATS_original_binsize_ms = 1/sfreq*1000;

df = params.PEATS_binsize_ms / PEATS_original_binsize_ms;

p = res.PEATS;

nc = p.matrix_nc/df;

idx_gap = -ms2idx(p.before_msec, sfreq, -1)/df;


% before_idx = 1;
% after_idx = ms2idx(p.after_msec, sfreq, idx_gap);
% params.AUC_start_idx = ms2idx(AUC_start_msec, sfreq, idx_gap);
% params.AUC_stop_idx = ms2idx(AUC_stop_msec, sfreq, idx_gap);
params.x_values = linspace(p.before_msec,p.after_msec,nc);
params.zero_idx =  idx_gap+1;

x =  linspace(p.before_msec,p.after_msec,p.matrix_nc);
y = 1:size(matrix,1);
[X,Y] = meshgrid(x,y);

xq =  p.before_msec:params.PEATS_binsize_ms:p.after_msec;

[matrix_nr, matrix_nc] = size(matrix);
new_matrix_nr = matrix_nr;
new_matrix_nc = length(xq);

new_matrix = nan(new_matrix_nr, new_matrix_nc);
new_matrix_fitiso = nan(new_matrix_nr, new_matrix_nc);
new_matrix_physio = nan(new_matrix_nr, new_matrix_nc);

for i_r = 1:new_matrix_nr
    new_matrix(i_r, :) = interp1(x, matrix(i_r, :), xq);
    new_matrix_fitiso(i_r, :) = interp1(x, matrix_fitiso(i_r, :), xq);
    new_matrix_physio(i_r, :) = interp1(x, matrix_physio(i_r, :), xq);
end

params.x_values = xq;

matrix = new_matrix;
matrix_fitiso = new_matrix_fitiso;
matrix_physio = new_matrix_physio;


if params.extract_databases
    db = metadata;
    for i=1:size(matrix,2)
        if params.x_values(i)<0
            c = '_';
        else
            c='';
        end
        cmd = sprintf('db.%s_%s%d=matrix(:,i);',params.data_type,c,round(abs(params.x_values(i))));
        eval(cmd);
    end

    if params.PEATS.measure_AUC
        db.AUC = res.auc';
    end

    writetable(db,[params.results_folder filesep 'db.xlsx'],'WriteMode','overwritesheet');
end

if params.extract_pivot_table

    [r,c] = size(matrix);
    db = repmat(metadata,c,1);
    vartype = cell(1,size(db,1));
    vartype(:) =  {'matrix'};
    db.vartype = vartype';
    vartype2 = repmat(params.x_values',r,1);
    [vartype2_sorted,idx] = sort(vartype2);
    db.vartype2 = vartype2_sorted;
    %     matrix_ = 1:822*15;
    %     matrix_ = reshape(matrix_',15,822)';
    %     matrix__ = reshape(matrix_,r*c,1);
    db.value = reshape(matrix,r*c,1);


    if params.PEATS.measure_AUC
        db2 = metadata;
        vartype = cell(1,r);
        vartype(:) =  {'auc'};
        db2.vartype = vartype';
        db2.vartype2 = ones(r,1);
        db2.value = res.auc';
        db = [db; db2];

    end

    writetable(db,[params.results_folder filesep 'db_pivot_table.xlsx'],'WriteMode','overwritesheet');


end


filters = {};


descend_(matrix, matrix_fitiso, matrix_physio, metadata,filtering_sequence, filters,params);



function res = load_results(p)
as=[];
load(p.results_path);
b=1:size(as.metadata,1);
as.metadata.('LINE_NUM')= b';
res.metadata = as.metadata;
res.matrix = as.PEATS.matrix;
res.matrix_fitiso = as.PEATS.matrix_fitiso;
res.matrix_physio = as.PEATS.matrix_physio;
res.auc = as.PEATS.auc;
res.sfreq = as.sfreq;
res.PEATS = as.PEATS;
for fn = fieldnames(p)'
    params.(fn{1}) = p.(fn{1});
end
res.params = params;
end

function a_idx = ms2idx(a_ms, sfreq, before_idx)
a_idx = ceil((a_ms/1000)*sfreq) + before_idx +1;
end

function print_filters(filters)
s = size(filters,1);
for i=1:s
    fprintf('\t%s(%s)',filters{i, 1},filters{i, 2});
end
fprintf('\n');
end

function [res, f] = descend_(matrix, matrix_fitiso, matrix_physio,metadata, f_seq, f, params)

fprintf('descend ==> ');print_filters(f);

filterSequenceSize = size(f_seq,2);
currentFilterSize = size(f,1);

if currentFilterSize==filterSequenceSize
    res=compute_selection(matrix, matrix_fitiso, matrix_physio, metadata, f);
    make_the_plot(res, f, params)
    f = f(1:end-1,:);
    fprintf('leaf\n');
    return
end

for iFilter=1:filterSequenceSize

    category = f_seq{currentFilterSize+1};
    category_elements=[];
    cmd = sprintf("category_elements = unique(metadata.%s);", category);eval(cmd);

    multiple_res = {};

    for iElement=1:size(category_elements,1)
        f{end+1, 1} = category;
        f{end, 2} = category_elements{iElement};
        [multiple_res{end+1}, f] = descend_(matrix, matrix_fitiso, matrix_physio,metadata, f_seq, f, params);
    end

    fprintf('End Of Category %s\n', category);

    [means_, stds_, matrix_]=merge_res(multiple_res);
    res.matrix =matrix_;
    res.means = means_;
    res.stds = stds_;
    make_the_plot(res, f, params);
    f = f(1:end-1,:);
    return

end



% res=compute_selection(matrix, metadata, filters);
% make_the_plot(res.matrix, res.mean, res.std, results_folder, filters);


f = f(1:end-1,:);
fprintf('nothing more to filter to go down\n');

end

function res=compute_selection(matrix, matrix_fitiso, matrix_physio, metadata, filters)
nFilters = size(filters,1);
if nFilters
    output_name = filters{1,2};
    selection=sprintf('metadata.%s==\''%s\''',filters{1,1},filters{1,2});
end
if nFilters>1
    for iFilter=2:nFilters
        output_name = [output_name '_' filters{iFilter,2}];
        selection = [selection ' & ' sprintf('metadata.%s==\''%s\''',filters{iFilter,1},filters{iFilter,2})];
    end
end
selected_rows = [];


cmd=sprintf('selected_rows = find(%s);',selection);eval(cmd);

[mean_, std_] = matrix_statistics(matrix(selected_rows,:));
res.matrix = matrix(selected_rows,:);
res.means = mean_;
res.stds = std_;

[mean_fitiso, std_fitiso] = matrix_statistics(matrix_fitiso(selected_rows,:));
res.matrix_fitiso = matrix_fitiso(selected_rows,:);


[mean_physio, std_physio] = matrix_statistics(matrix_physio(selected_rows,:));
res.matrix_physio = matrix_physio(selected_rows,:);


res.selection = selection;
res.output_name = output_name;
res.selected_rows = selected_rows;
end

function [means, stds, matrix]=merge_res(multiple_res)



nRes = size(multiple_res,2);
matrix = [];
stds = [];
means = [];

if nRes>0
    for iRes=1:nRes
        matrix_ = multiple_res{iRes}.matrix;
        s = size(matrix_);
        if s(1)==1
            avg_res_matrix = matrix_;
            stds = [stds; nan(1,size(matrix_,2))];
            matrix = [matrix; matrix_];
            means = [means; avg_res_matrix];
        end
        if s(1)>=2
            avg_res_matrix = mean(matrix_, 'omitnan');
            stds = [stds; std(matrix_, 'omitnan')];
            matrix = [matrix; matrix_];
            means = [means; avg_res_matrix];
        end
    end

end

end

function make_the_plot(res, filters, params)

matrix = res.matrix;
means = res.means;
stds = res.stds;

[r,c] = size(matrix);

if r
    nFilters = size(filters,1);
    x_values = params.x_values;

    output_name = '';
    for iFilter=1:nFilters
        output_name = [output_name '_' filters{iFilter,2}];
    end
    output_name=output_name(2:end);

    if params.export_png || params.export_fig
        plot_mode = 1;
    else
        plot_mode=0;
    end

    if plot_mode
        try
            matrix_fitiso = res.matrix_fitiso;
            matrix_physio = res.matrix_physio;
        end
    end




    if plot_mode

        tfreq = round(1/params.PEATS_x_tickfreq);

        fig=figure('name', output_name);
        set(fig,'color','w');

        subplot(4,1,1)
        hold on
        title(params.data_type)
        imagesc(means)
        colorbar
        xt = get(gca, 'XTick');
        xtnew = linspace(1, size(matrix,2), length(x_values));

        set(gca, 'XTick',xtnew(1:tfreq:end), 'XTickLabel',x_values(1:tfreq:end), 'XTickLabelRotation',30)
        plot([params.zero_idx, params.zero_idx],[0 size(means,1)+1], 'color',[1 0 0],'linewidth',2)

        subplot(4,1,2)
        hold on
        title(params.data_type)
        nTraces = size(means,1);
        for iTrace=1:nTraces
            plot(means(iTrace,:),'k')
            plot(means(iTrace,:)+stds(iTrace,:),'k:')
            plot(means(iTrace,:)-stds(iTrace,:),'k:')
        end
        xt = get(gca, 'XTick');
        xtnew = linspace(1, size(matrix,2), length(x_values));
        set(gca, 'XTick',xtnew(1:tfreq:end), 'XTickLabel',x_values(1:tfreq:end), 'XTickLabelRotation',30)
        plot([params.zero_idx, params.zero_idx],[min(means-stds,[],'all') max(means+stds,[],'all')], 'color',[1 0 0],'linewidth',2)

        subplot(4,1,3)
        hold on
        title(params.data_type)
        imagesc(matrix)
        colorbar
        xt = get(gca, 'XTick');
        xtnew = linspace(1, size(matrix,2), length(x_values));

        set(gca, 'XTick',xtnew(1:tfreq:end), 'XTickLabel',x_values(1:tfreq:end), 'XTickLabelRotation',30)
        plot([params.zero_idx, params.zero_idx],[0 size(matrix,1)+1], 'color',[1 0 0],'linewidth',2)


        subplot(4,1,4)
        hold on
        title(params.data_type)
        [mean_, std_] = matrix_statistics(matrix);
        try
            [mean_physio, std_physio] = matrix_statistics(matrix_physio);
            [mean_fitiso, std_fitiso] = matrix_statistics(matrix_fitiso);
            plot(mean_fitiso,'m');
            plot(mean_physio,'b');
        end
        plot(mean_,'k')
        plot(mean_+std_,'k:')
        plot(mean_-std_,'k:')
        xt = get(gca, 'XTick');
        xtnew = linspace(1, size(matrix,2), length(x_values));
        set(gca, 'XTick',xtnew(1:tfreq:end), 'XTickLabel',x_values(1:tfreq:end), 'XTickLabelRotation',30)
        plot([params.zero_idx, params.zero_idx],[min(mean_-std_) max(mean_+std_)], 'color',[1 0 0],'linewidth',2)
    end

    if params.export_png
        f = [params.results_folder filesep output_name '.png'];
        print(fig,f, '-dpng');
    end

    if params.export_fig
        f =  [params.results_folder filesep output_name '.fig'];
        savefig(fig,f);
    end

    if params.export_txt
        f =  [params.results_folder filesep output_name '.txt'];
        fid = fopen(f,'w');
        matrix_to_file(fid,matrix,x_values, 'matrix data');
        matrix_to_file(fid,means,x_values, 'means data');
        matrix_to_file(fid,stds,x_values, 'stds data');
        fclose(fid);
    end

    if params.export_mat
        f =  [params.results_folder filesep output_name '.mat'];
        save(f,'x_values','matrix','means','stds');
    end

    if plot_mode
        close(fig);
    end
    fprintf('%s DONE\n',output_name);

end




end

function auc_to_file(fid, matrix, x_values, data_label)
sum(matrix(:,params.AUC_start_idx:params.AUC_stop_idx), 2);
params.AUC_start_idx:params.AUC_stop_idx
end

function matrix_to_file(fid,matrix,x_values, data_label)
fprintf(fid,'%s data\n\n',data_label);
s = size(matrix);
for c=1:s(2)
    fprintf(fid,'\t%d',x_values(c));
end
fprintf(fid,'\n');
for r=1:s(1)
    for c=1:s(2)
        fprintf(fid,'\t%2.4f',matrix(r,c));
    end
    fprintf(fid,'\n');
end
end

function [mean_, std_] = matrix_statistics(matrix)
    mean_ = NaN;
    std_  = NaN;
    s = size(matrix);
    if s(1)==1
        mean_ = matrix;
        std_ = nan(1,size(matrix,2));
    end
    if s(1)>=2
        mean_ = mean(matrix, 'omitnan');
        std_  = std(matrix, 'omitnan');
    end
end















% JUST FOR THE TEST
% matrix=matrix( randperm(size(matrix, 1)), randperm(size(matrix, 2)));
