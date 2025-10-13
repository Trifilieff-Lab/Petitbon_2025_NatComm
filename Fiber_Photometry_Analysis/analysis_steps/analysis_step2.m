function as = analysis_step2(params, as, step1, iFile)

info_table=params.info_table;
info_struct = params.info_struct;
info_fields = fieldnames(info_struct);
nFields = max(size(info_fields));
[r_res,~]=size(as.metadata);
t = step1.time;

signals = {step1.dff, step1.fit_iso, step1.physio};

for iSig=1:3
    
    
    if (iFile==1), i_res=0; else, i_res=r_res; end
    
    sig = signals{iSig};
    
    sfreq = round(1/median(diff(t)));
    before_idx = ceil((params.PEATS.before_msec/1000)*sfreq);
    after_idx = ceil((params.PEATS.after_msec/1000)*sfreq);
    
    if params.PEATS.measure_AUC
        auc_idx1 = ceil((params.PEATS.AUC_before_msec/1000)*sfreq) - before_idx;
        auc_idx2 = ceil((params.PEATS.AUC_after_msec/1000)*sfreq) - before_idx;
    end
    
    
    
    fields = fieldnames(step1.behavioral_events);
    nCat = size(fields,1);
    
    period_enumeration = 0;
    use_periodic_bl=0;
    use_individual_bl=1;
    use_session_bl=1;
    
    if isfield(params,'period_enumeration')
        period_enumeration = params.period_enumeration;
    end
    if isfield(params.PEATS,'use_periodic_bl')
        use_periodic_bl = params.PEATS.use_periodic_bl;
    end
    if isfield(params.PEATS,'use_individual_bl')
        use_individual_bl = params.PEATS.use_individual_bl;
    end
    if isfield(params.PEATS,'use_session_bl')
        use_session_bl = params.PEATS.use_session_bl;
    end
    
    
    if use_session_bl
        bl_mean = nanmean(sig);
        bl_std = nanstd(sig);
    end
    
    nSamples = size(sig,1);
    
    
    for iCat = 1:nCat
        
        
        % We collect all the timestamps of this event category
        event_category = step1.behavioral_events.(fields{iCat});
        E_ts = event_category.on_ts;
        nE = length(E_ts); % total number of timestamps for this category of event
        
        if(nE>0)
            
            % calculating start and stop indices to cut a fragment of signal (dff) around the event
            for iE = 1:nE
                
                % for each event_ts, we look into the photometry time
                % vector to find the corresponding index, then knowing the
                % size of the tilme window of the PEAT, we find the index
                % at the limit of this time window eg. i1 and i2
                
                %                 bl_mean=NaN;bl_std=NaN;
                
                if use_periodic_bl
                    eP = event_category.periods(iE);
                    if ~isnan(eP) && eP
                        bl_start_ts = step1.behavioral_periods(eP).baseline_start_ts;
                        bl_stop_ts = step1.behavioral_periods(eP).baseline_stop_ts;
                        bl_start_idx = find_best_idx(bl_start_ts,t);
                        bl_stop_idx = find_best_idx(bl_stop_ts,t);
                        if (bl_start_idx>=1) && (bl_stop_idx<=nSamples) && ~isnan(bl_start_idx) && ~isnan(bl_stop_idx)
                            bl_dff = sig(bl_start_idx:bl_stop_idx);
                            bl_mean = nanmean(bl_dff);
                            bl_std = nanstd(bl_dff);
                        else
                            bl_mean=NaN;
                            bl_std=NaN;
                        end
                    else
                        bl_mean=NaN;
                        bl_std=NaN;
                    end
                    
                end
                
                if use_individual_bl
                    bl_start_ts = E_ts(iE) + params.PEATS.bl_before_msec/1000;
                    bl_stop_ts = E_ts(iE) + params.PEATS.bl_after_msec/1000;
                    bl_start_idx = find_best_idx(bl_start_ts,t);
                    bl_stop_idx = find_best_idx(bl_stop_ts,t);
                    if (bl_start_idx>=1) && (bl_stop_idx<=nSamples)  && ~isnan(bl_start_idx) && ~isnan(bl_stop_idx)
                        bl_dff = sig(bl_start_idx:bl_stop_idx);
                        bl_mean = nanmean(bl_dff);
                        bl_std = nanstd(bl_dff);
                    else
                        bl_mean=NaN;
                        bl_std=NaN;
                    end
                end
                
                i_res = i_res+1;
                
                warning('off','all')
                for iField=1:nFields, cmd = sprintf('as.metadata.%s(i_res) = info_table.%s(iFile);',info_fields{iField},info_fields{iField});eval(cmd);end
                warning('on','all')
                
                if iSig==1
                    as.metadata.filepath(i_res) = info_table.filepath(iFile);
                    as.metadata.eventname(i_res) = fields{iCat};
                    as.metadata.eventnum(i_res) = iE;
                    if period_enumeration
                        as.metadata.periodnum(i_res) = event_category.periods(iE);
                        as.metadata.eventinperiodnum(i_res) =  event_category.id_in_period(iE);
                        % Zoe Omission, Period Type
                        %                     try
                        %                         as.metadata.periodtype(i_res) = sprintf("%d",step1.periodtype(as.metadata.periodnum(i_res)));
                        %                     catch
                        %                         warning('periodtype not found, 0 is the default value')
                        %                         as.metadata.periodtype(i_res) = "0";
                        %                     end
                        
                    end
                end
                
                
                center_idx = find_best_idx(E_ts(iE),t);
                
                i1 = center_idx+before_idx;
                i2 = center_idx+after_idx-1;
                
                if i1>=1 && i2<=nSamples
                    sig_ = sig(i1:i2);
                    if params.PEATS.apply_zscore
                        if ~isnan(bl_mean) && ~isnan(bl_std)
                            sig_ = sig(i1:i2);
                            sig_ = sig_ - bl_mean;
                            sig_ = sig_ ./bl_std;
                        else
                            sig_ = nan(i2-i1+1, 1);
                        end
                    end
                    
                    switch iSig
                        case 1
                            as.PEATS.matrix(i_res,:)=sig_;
                        case 2
                            as.PEATS.matrix_fitiso(i_res,:)=sig_;
                        case 3
                            as.PEATS.matrix_physio(i_res,:)=sig_;
                    end
                    
                    if iSig==1
                        if params.PEATS.measure_AUC
                            as.PEATS.auc(i_res)=nansum(sig_(auc_idx1:auc_idx2));
                        end
                    end
                    
                else
                    
                    switch iSig
                        case 1
                            as.PEATS.matrix(i_res,:) = nan(1,as.PEATS.matrix_nc);
                        case 2
                            as.PEATS.matrix_fitiso(i_res,:) = nan(1,as.PEATS.matrix_nc);
                        case 3
                            as.PEATS.matrix_physio(i_res,:) = nan(1,as.PEATS.matrix_nc);
                    end
                    
                    
                    if iSig==1
                        if params.PEATS.measure_AUC
                            as.PEATS.auc(i_res)=nan;
                        end
                    end
                    
                    
                end
                
                
                
                %                     try
                %                         t1=t(i1);t2=t(i2);
                %                         idx1 = find(step1.transients.time>t1);idx2 = find(step1.transients.time<t2);
                %                         idx = intersect(idx1,idx2);
                %                         as.PEATS.transients_matrix(i_res,:)=histcounts(step1.transients.time(idx)-evt_ts(j),transient_histo_edges_msec/1000);
                %                     catch
                %                         warning('Problem for %s(%d) in transients section only',fields{i_event},j);
                %                     end
                
                
            end
        end
    end
    
    
end





end

function idx = find_best_idx(t,time_serie)
diff_ = abs(time_serie-t);
[~, idx] = min(diff_);
if t<time_serie(1)
    idx=NaN;
end
if t>time_serie(end)
    idx=NaN;
end
end

