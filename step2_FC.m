close all
clear all

addpath(genpath('/m/nbe/scratch/braindata/shared/toolboxes/bramila//bramila'));
load('brainnetome_MPM_rois_2mm') % variable rois


subjIDs={
    '01', 'B'
    '02', 'B'
    '103', 'A'
    '104', 'B'
    '106', 'A'
    '107', 'B'
    '109', 'A'
    '110', 'A'
    '111', 'A'
    '113', 'B'
    '114', 'A'
    '115', 'B'
    '116', 'A'
    '117A', 'B'
    '118', 'B'
    '119', 'A'
    '120', 'A'
    '121', 'B'
    '122', 'B'
    '123', 'A'
    '124', 'A'
    '126', 'A'
    '127', 'A'
    '129', 'B'
    '130', 'A'
    '131', 'A'
    '132', 'A'
    '134', 'A'
    '135', 'B'
    '136', 'B'
    '137', 'A'
    '141', 'B'
    '144', 'B'
    };
Nsubj=33;

for s=1:Nsubj
    basepath=['/m/nbe/scratch/braindata/eglerean/code/stride/dataout/' subjIDs{s,1} ];
    thisdatafile=[basepath '/epi_preprocessed.nii'];
    disp(thisdatafile)
    cfg=[];
    cfg.rois=rois;
    cfg.infile=thisdatafile;
    cfg.write=0;
    cfg.usemean=1;
    [nodeTS perc]=bramila_roiextract(cfg);
    toi=1:size(nodeTS,1); % we can use scrubbing
    adj=corr(nodeTS(toi,:));
    % replace NaN if any
    adj(find(adj==NaN))=0;
    save(['networks/' num2str(s) '.mat'],'adj','nodeTS')
    
    
end

for s=1:Nsubj
    if(subjIDs{s,2}=='A')
        groups(s,1)=1
    else
        groups(s,1)=2
    end
end
