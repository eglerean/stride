#!/bin/bash
#step10
# fsl commands to perform FC stats

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
        # merge all files for each group 1 and run 1 sample ttest
        for group in $(seq 1 2);do
            subjlist='';
            if [ $group -eq 1 ]; then
                gID=$(seq 1 15)
                gOUT='ESCI'
            else
                gID=$(seq 16 29)
                gOUT='PLAC'
            fi
            for s in $gID; do 
                subjlist=$(echo -n $subjlist" "$basepath"subj"$s"_"$n".nii")
            done 
            fileout=$basepath"/"$gOUT"_"$n
            echo "fslmerge -t $fileout $subjlist"
            # fslmerge -t $fileout $subjlist
            cd randomise
            echo "./randwrap1STT_postail.sh ../$fileout $gOUT$tag"_"$n /m/nbe/scratch/braindata/shared/HarvardOxford/MNI152_T1_2mm_brain_mask.nii 100"
            #./randwrap1STT_postail.sh ../$fileout $gOUT$tag"_"$n /m/nbe/scratch/braindata/shared/HarvardOxford/MNI152_T1_2mm_brain_mask.nii 100
            cd .. 
        done
    done
    echo "##############"
done
