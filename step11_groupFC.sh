#!/bin/bash
#step11
# fsl commands to perform FC group stats

# for each nodeName
nodes=(MFGLPFC PrecuneusL MFGPremot IFGL IFGR);
for n in ${nodes[@]}; do
    # for each type
    for dtype in $(seq 0 2); do
        basepath='./output/FCmaps/'
        tag=""
        if [ $dtype -eq 1 ];then
            basepath='./output/FCmaps_posval/'
            tag="posval"
        fi
        if [ $dtype -eq 2 ]; then
            basepath='./output/FCmaps_negval/'
            tag="negval"
        fi
        # merge all files for both groups 
        gID=$(seq 1 29)
        for s in $gID; do 
            subjlist=$(echo -n $subjlist" "$basepath"subj"$s"_"$n".nii")
        done 
        fileout=$basepath"/ALL_"$n
        echo "fslmerge -t $fileout $subjlist"
        fslmerge -t $fileout $subjlist
        cd randomise
        echo "./randwrapvs.sh ../"$fileout" ESCIvsPLAC_"$tag"_"$n" designESCI_vs_PLAC.mat designESCI_vs_PLAC.con /m/nbe/scratch/braindata/shared/HarvardOxford/MNI152_T1_2mm_brain_mask.nii 100"
        #./randwrapvs.sh ../"$fileout" ESCIvsPLAC_"$tag"_"$n" designESCI_vs_PLAC.mat designESCI_vs_PLAC.con /m/nbe/scratch/braindata/shared/HarvardOxford/MNI152_T1_2mm_brain_mask.nii 100
        cd .. 
    done
    echo "##############"
done
