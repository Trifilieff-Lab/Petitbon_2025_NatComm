function data = extract_events_from_file(filepath, data, rc)

    [path_,name,ext] = fileparts(filepath);
 
    n = size(rc,2);
    for i=1:n
        tmp = rc{i};
        if strcmp(tmp{1},'EventFile')    
            if length(tmp)==4
                e = readtable([path_ filesep tmp{3}]);
                event_times_msec = e.Time_msec(find(strcmp(e.Events, tmp{2})))
                cmd = sprintf('data.%s.%s.on_ts=event_times_msec/1000;',tmp{4},tmp{2});
                eval(cmd);
            end
%             if length(tmp)==5
%                 e = readtable([tmp{5} filesep tmp{3}]);
%             end            

        end
    end

end

