%% Gilad Hecht and Ronen Rahamim, June 4th 2017
% In this script we'll run find_relevant_electrodes function we created earlier
% to delete the bad electrodes from our data for each stim and each repeat
% of the experiment.

clear;
clc;

%% adding the path to the data and to the functions

prompt={'Enter the place you want to take the clean files from:',...
    'Enter the place you want to place the relevant electrodes files:',...
    'Enter code folder:'};
title  = 'Directories';
directories      = inputdlg(prompt,title);

%% Splitting directories

clean_data_direct         = directories{1};
bad_electrodes_direct     = directories{2};
code_direct      = genpath(directories{3});
                            % adds all subfolders of code to path.
addpath(code_direct)
cellfun(@(x) addpath(x), directories);
cd (bad_electrodes_direct)

%% Finding the good and the bad electrodes

allfiles = dir(clean_data_direct);
allnames = {allfiles.name}.';
N = length(allnames);
c = 0;
threshold = 100;
% std_bound = 7e-5;
eta = 5;
num_of_electrodes = 68;
good_electrodes = zeros(num_of_electrodes,N-2);    
[row_good, col_good] = size(good_electrodes);

for ii=1:N
    good_str = ~isempty(strfind(allnames{ii},'trial'));
        if good_str == 1
            c = c + 1;
            tmp_elec  = load(allnames{ii});
            tmp_elec  = tmp_elec.clean_data;
            str_split = strsplit(allnames{ii},'_');
            new_name  = [str_split{1:end-1}];
            good_electrodes_tmp = find_relevant_electrodes(tmp_elec, threshold, eta);
            size_tmp = length(good_electrodes_tmp);
            good_electrodes(:, c) = [good_electrodes_tmp;zeros(row_good-size_tmp, 1)];
        end        
end

intersect_elec = intersect(good_electrodes(:, 1),good_electrodes(:, 2));
for jj=3:col_good
    intersect_elec = intersect(intersect_elec,good_electrodes(:, jj));
end

real_good_electrodes = intersect_elec(intersect_elec>0);
save(['good_electrodes of_',str_split{2},'_',str_split{3},'.mat'],...
                                                'real_good_electrodes');


