%% Example of pipeline with default parameters
%   - Notes:
%   Refer to wiki page:
%   https://wiki.aalto.fi/pages/viewpage.action?pageId=92445275 for
%   detailed documentation
%	Last edit: EG 2014-07-14


%%
% Copy this to your folder, specify subject folders with correct file names
%
% Subject folders should contain:
% -epi.nii (functional data)
% -bet.nii (brain-extracted anatomical image)
% -if drifter was used, also .acq file with respiration and heartbeat.
%%

clear cfg; % Running also "clearn all" is good practice to start from an empty and clean workspace

addpath(genpath('/scratch/nbe/braindata/shared/toolboxes/bramila/bramila'));
addpath('/scratch/nbe/braindata/shared/toolboxes/NIFTI');


%% List subject input folders
subjects = {
% find $(pwd)"/data" -type d -mindepth 1 | sed "s/^/'/g"|sed "s/$/\/'/g"|sort
'/scratch/nbe/braindata/eglerean/code/stride/data/01/'
'/scratch/nbe/braindata/eglerean/code/stride/data/02/'
'/scratch/nbe/braindata/eglerean/code/stride/data/103/'
'/scratch/nbe/braindata/eglerean/code/stride/data/104/'
'/scratch/nbe/braindata/eglerean/code/stride/data/106/'
'/scratch/nbe/braindata/eglerean/code/stride/data/107/'
'/scratch/nbe/braindata/eglerean/code/stride/data/109/'
'/scratch/nbe/braindata/eglerean/code/stride/data/110/'
'/scratch/nbe/braindata/eglerean/code/stride/data/111/'
'/scratch/nbe/braindata/eglerean/code/stride/data/113/'
'/scratch/nbe/braindata/eglerean/code/stride/data/114/'
'/scratch/nbe/braindata/eglerean/code/stride/data/115/'
'/scratch/nbe/braindata/eglerean/code/stride/data/116/'
'/scratch/nbe/braindata/eglerean/code/stride/data/117A/'
'/scratch/nbe/braindata/eglerean/code/stride/data/118/'
'/scratch/nbe/braindata/eglerean/code/stride/data/119/'
'/scratch/nbe/braindata/eglerean/code/stride/data/120/'
'/scratch/nbe/braindata/eglerean/code/stride/data/121/'
'/scratch/nbe/braindata/eglerean/code/stride/data/122/'
'/scratch/nbe/braindata/eglerean/code/stride/data/123/'
'/scratch/nbe/braindata/eglerean/code/stride/data/124/'
'/scratch/nbe/braindata/eglerean/code/stride/data/126/'
'/scratch/nbe/braindata/eglerean/code/stride/data/127/'
'/scratch/nbe/braindata/eglerean/code/stride/data/129/'
'/scratch/nbe/braindata/eglerean/code/stride/data/130/'
'/scratch/nbe/braindata/eglerean/code/stride/data/131/'
'/scratch/nbe/braindata/eglerean/code/stride/data/132/'
'/scratch/nbe/braindata/eglerean/code/stride/data/135/'
'/scratch/nbe/braindata/eglerean/code/stride/data/136/'
'/scratch/nbe/braindata/eglerean/code/stride/data/137/'
'/scratch/nbe/braindata/eglerean/code/stride/data/141/'
'/scratch/nbe/braindata/eglerean/code/stride/data/144/'
};

%% List subjects output folders
subjects_out = {
'/scratch/nbe/braindata/eglerean/code/stride/dataout/01/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/02/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/103/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/104/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/106/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/107/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/109/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/110/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/111/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/113/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/114/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/115/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/116/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/117A/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/118/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/119/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/120/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/121/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/122/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/123/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/124/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/126/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/127/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/129/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/130/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/131/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/132/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/135/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/136/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/137/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/141/'
'/scratch/nbe/braindata/eglerean/code/stride/dataout/144/'
};
% subjects_out = subjects; % in case you want to store everything under the same original folder


%% General settings
cfg.overwrite = 1; % set to one if you are re-running preprocessing and you want to overwrite existing files
%cfg.bramilapath = '/scratch/nbe/braindata/shared/toolboxes/bramila/bramila'; % bramila toolbox path
cfg.bramilapath = '/scratch/nbe/braindata/shared/toolboxes/bramila/bramila'; % bramila toolbox path
cfg.StdTemplate='/scratch/nbe/braindata/shared/HarvardOxford/MNI152_T1_2mm_brain.nii'; % 2mm MNI template from FSL
cfg.TR = 1.7; % TR from scanning protocol, used in bramila
cfg.rmvframes = 0; % How many volumes to remove in the beginning (sync trial)

%% temporal filtering
cfg.do_temporal_filtering = 1;
cfg.filtertype = 'butter'; % allowed are butter, fir, fslhp. Use fslhp if you are not doing functional connectivity. Use butter to do like in Power 2014

%% Smoothing
cfg.do_spatial_smooth = 1;
cfg.smooth_FWHM = 6; % used in susan smoothing
cfg.smooth_method = 'FSLgauss'; % 'SPM', 'AFNI', 'FSL' or 'none'

%% slice number parameters, use only one, either slicenum or sliceseq
%cfg.slicenum = 33; % slice count: used in slicetimer, in Siemens scanner odd number of slices starts from 1, even starts from 2
cfg.sliceseq = [1:2:33 2:2:33]; % prespecified slice acquisition sequence

%% Drifter settings
cfg.drifter = 0; % 1 if you have biopac measurements
cfg.driftermode = 0; % 0 = BOLD estimate only, 1 = BOLD+residual added back

%% Biopac settings, these are setup according to the template that Dima and Heini use
% Which channels were active 1 - active, 0 - not active
biopacfile.CH1=1; %usually breath data from belt
biopacfile.CH2=0; %usually ECG
biopacfile.CH3=0; %usually GSR
biopacfile.CH4=1; %usually heart rate from pulse oxymeter_left
biopacfile.CH5=0; %usually heart rate from pulse oxymeter_right
biopacfile.CH35=1; %usually MRI scan off/on information
% sampling interval of physiodata and fMRI
biopacfile.dt=0.001; % in seconds/sample
biopacfile.controlplot=1 ;% plots all data and save as filename.fig
biopacfile.breath=0.01;%new sampling interval for breath it should not be higher than 2.4( for 25 inhales/min)
biopacfile.HR=0.01; %new sampling interval for heart rate, should not be higher than 0.75(for 80 bpm)
% set the range for frequencies in signals in bpm (try to keep those as narrow as posible)
biopacfile.freqBreath=10:25; % in breaths per min
biopacfile.freqHR=40:90; % in beats per minutes
biopacfile.filter=1; % bandpass filter for reference data 1 - active, 0 - not active
cfg.biopacfile = biopacfile;

%% Bramila parameters for optimized cleaning of artefacts
% OPTIONAL parameters (otherwise use defaults as marked here in the example)
% Modify only if needed (see "bramila_checkparameters.m" for defaults)
cfg.motion_reg_type = 'friston'; % motion regression type
% cfg.voxelsize=[2,2,2];        % voxelsize
% cfg.mask = [];                % initial EPI mask
% cfg.tissue_derivatives = 0;   % tissue regressor derivative order
% cfg.min_tissue_var_expl = 75; % minimum variance percentage for tissue PCA regressors
% cfg.max_tissue_pca_count = 7; % upper limit for tissue PCA regressors
% cfg.remove_global = 0;        % remove global signal
% cfg.mot_derivatives = 1;  % motion regressor derivatives
% cfg.white_mask_th = 0.90; % probability threshold for white matter tissue
% cfg.csf_mask_th = 0.90;   % probability threshold for ventricle tissue
cfg.detrend_type='Savitzky-Golay';   % detrending type
% cfg.filter_type = 'butter';   % temporal filter type
% cfg.filter_limits = [0,0.01,0.08,0.09];   % filter limits in Hz
cfg.write = 0;    % write all intermediate EPI's
% cfg.save_path = '/scratch/nbe/braindata/kauttoj2/code/bramila_git/bramila/out'; % custom save path for bramila motion cleaning results


%% Running preprocessing. Do not modify the code below
cfg = bramila_parhandle(cfg,subjects,subjects_out); % reslices the cfg so that it can be used in parfor loop
if ~strcmp(cfg{1}.gridtype,'slurm')
    parfor i = 1:length(subjects)
        bramila_preprocessor(cfg{i});
    end
else
    for i = 1:length(subjects)
        bramila_slurmprepro(cfg{i});
    end
end
