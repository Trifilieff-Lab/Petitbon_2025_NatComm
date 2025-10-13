function res_table =get_PEATS_table(params)

    [~, c_info] = size(params.info_table);

    varTypes = [""];
    varNames={};

    
    for i=1:c_info
        varTypes(i)="string";
        varNames{i}= params.info_table.Properties.VariableNames{i};
    end
    varNum = c_info;
    
    varTypes(end+1)="string"; varNames{end+1}= 'eventname';
    varTypes(end+1)="double"; varNames{end+1}= 'eventnum';
    varNum = varNum +2;
    
    if params.period_enumeration
        varTypes(end+1)="double"; varNames{end+1}= 'periodnum';
        varTypes(end+1)="double"; varNames{end+1}= 'eventinperiodnum';
        varNum = varNum +2;
    end
        
    if isfield('fr_period_enumeration', params) && params.fr_period_enumeration
        varTypes(end+1)="double"; varNames{end+1}= 'fr_schedule';
        varTypes(end+1)="double"; varNames{end+1}= 'fr_schedule_id';
        varTypes(end+1)="double"; varNames{end+1}= 'in_fr_schedule_trialnum';
        varNum = varNum +3;     
    end
        
% Zoe Omission, Period Type        
%         varTypes(end+1)="string"; varNames{end+1}= 'periodtype';
%         varNum = varNum +3;


    sz = [1 varNum];    
    res_table = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

end