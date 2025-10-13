function sub_ts = get_sub_ts(ts_serie, start, stop)
    mask = ones(1,length(ts_serie));
    mask =  ts_serie >= start;
    mask =  ts_serie & (ts_serie <= stop);
    sub_ts = ts_serie(mask);
end

