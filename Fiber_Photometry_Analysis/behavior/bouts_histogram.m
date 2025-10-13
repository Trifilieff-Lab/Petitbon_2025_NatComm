analysis_folder = 'E:\NAS_SD\SuiviClient\Triffilieff\2024\Analysis\PRP5_last_3';
liste_step1 = dir([analysis_folder filesep '*_step1.mat']);
n_files = size(liste_step1,1);
dt_L1_press_onset = [];
for i=1:n_files
    load([analysis_folder filesep liste_step1(i).name])
    L1_press_onset = step1_data.behavioral_events.L1_press.on_ts;
    dt_L1_press_onset = [dt_L1_press_onset diff(L1_press_onset)'];
end

figure();
hold on
histogram(dt_L1_press_onset,0:0.01:20);
disp('here')

