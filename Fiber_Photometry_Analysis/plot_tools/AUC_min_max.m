function [auc, min_val, max_val] = AUC_min_max(data, timevec, t_window)
    idx_start = find(timevec >= t_window(1), 1, 'first');
    idx_end   = find(timevec <= t_window(2), 1, 'last');

    n = size(data,1);
    auc = nan(n,1);
    min_val = nan(n,1);
    max_val = nan(n,1);

    for i = 1:n
        if all(isnan(data(i, :)))
            continue
        end
        y_seg = data(i, idx_start:idx_end);
        t_seg = timevec(idx_start:idx_end);
        auc(i) = trapz(t_seg, y_seg);
        min_val(i) = min(y_seg);
        max_val(i) = max(y_seg);
    end
end