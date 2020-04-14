data=$1;
filename="${data##*/}";
fileonly=$(echo $filename|cut -d. -f1);
outtag=$2;
mask=$3;
perms=$4;
echo "randomise -i $data -o pos-$outtag -m $mask -n $perms -T -1 --tfce_C=6 -v 6"
randomise -i $data -o pos-$outtag -m $mask -n $perms -T -1 --tfce_C=6 -v 6
echo fslmaths $data -mul -1 neg-"$filename"
fslmaths $data -mul -1 neg-"$filename"
echo "randomise -i neg-$filename -o neg-$outtag -m $mask -n $perms -T -1 --tfce_C=6 -v 6"
randomise -i neg-$filename -o neg-$outtag -m $mask -n $perms -T -1 --tfce_C=6 -v 6
echo fslmaths pos-"$outtag"_tfce_corrp_tstat1.nii.gz -thr 0.95 posp
fslmaths pos-"$outtag"_tfce_corrp_tstat1.nii.gz -thr 0.95 posp
echo fslmaths neg-"$outtag"_tfce_corrp_tstat1.nii.gz -thr 0.95 negp
fslmaths neg-"$outtag"_tfce_corrp_tstat1.nii.gz -thr 0.95 negp
echo fslmaths posp -bin posmask
fslmaths posp -bin posmask
echo fslmaths negp -bin negmask
fslmaths negp -bin negmask
echo fslmaths posmask -add negmask TFCEmask
fslmaths posmask -add negmask TFCEmask
echo fslmaths pos-"$outtag"_tstat1.nii.gz -mul TFCEmask "$outtag"_tstat1_Corrected.nii.gz
fslmaths pos-"$outtag"_tstat1.nii.gz -mul TFCEmask "$outtag"_tstat1_Corrected.nii.gz
cp pos-"$outtag"_tstat1.nii.gz "$outtag"_tstat1_Uncorrected.nii.gz
