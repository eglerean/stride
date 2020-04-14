data=$1;
filename="${data##*/}";
fileonly=$(echo $filename|cut -d. -f1);
outtag=$2;
des=$3;
con=$4;
mask=$5;
perms=$6;
echo "randomise -i $data -o pos-$outtag -d $des -t $con -m $mask -n $perms -T -D -v 8"
randomise -i $data -o pos-$outtag -d $des -t $con -m $mask -n $perms -T -D -v 8
echo fslmaths $data -mul -1 neg-"$outtag-$filename"
fslmaths $data -mul -1 neg-"$outtag-$filename"
echo randomise -i neg-$outtag-$filename -o neg-$outtag -d $des -t $con -m $mask -n $perms -T -D -v 8
randomise -i neg-$outtag-$filename -o neg-$outtag -d $des -t $con -m $mask -n $perms -T -D -v 8
echo fslmaths pos-"$outtag"_tfce_corrp_tstat1.nii.gz -thr 0.95 posp-$outtag
fslmaths pos-"$outtag"_tfce_corrp_tstat1.nii.gz -thr 0.95 posp-$outtag
echo fslmaths neg-"$outtag"_tfce_corrp_tstat1.nii.gz -thr 0.95 negp-$outtag
fslmaths neg-"$outtag"_tfce_corrp_tstat1.nii.gz -thr 0.95 negp-$outtag
echo fslmaths posp-$outtag -bin posmask-$outtag
fslmaths posp-$outtag -bin posmask-$outtag
echo fslmaths negp-$outtag -bin negmask-$outtag
fslmaths negp-$outtag -bin negmask-$outtag
echo fslmaths posmask-$outtag -add negmask-$outtag TFCEmask-$outtag
fslmaths posmask-$outtag -add negmask-$outtag TFCEmask-$outtag
echo fslmaths pos-"$outtag"_tstat1.nii.gz -mul TFCEmask-$outtag "$outtag"_tstat1_Corrected.nii.gz
fslmaths pos-"$outtag"_tstat1.nii.gz -mul TFCEmask-$outtag "$outtag"_tstat1_Corrected.nii.gz
cp pos-"$outtag"_tstat1.nii.gz "$outtag"_tstat1_Uncorrected.nii.gz

