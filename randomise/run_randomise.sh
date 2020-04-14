## doing one sample ttests


./randwrap1STT_postail.sh AiA_coupling.nii AiA1stt ../iscmask.nii 5000

./randwrap1STT_postail.sh AV_coupling.nii AV1stt ../iscmask.nii 5000
#./randwrap1STT_postail.sh iscpairsAV.nii mixedAV1stt ../iscmask.nii 100
./randwrap1STT_postail.sh AR_coupling.nii AR1stt ../iscmask.nii 5000
./randwrap1STT_postail.sh RV_coupling.nii RV1stt ../iscmask.nii 5000

exit 0

## using full matrix (order might be wrong, less power anyway)
# design matrix for randomise
cat allscoresAV.csv > temp.txt # for a single condition
Text2Vest temp.txt designM1.mat
# contrast matrix
echo "1" > temp.txt
Text2Vest temp.txt designM1.con
./randwrapv6.sh iscpairsAV.nii.nii ScoresAV designM1.mat designM1.con ../iscmask.nii 5000


# design matrix for randomise
cat allratingsAV.csv > temp.txt # for a single condition
Text2Vest temp.txt designM2.mat
# contrast matrix
echo "1" > temp.txt
Text2Vest temp.txt designM2.con
./randwrapv6.sh iscpairsAV.nii.nii RatingsAV designM2.mat designM2.con ../iscmask.nii 5000


# design matrix for randomise
cat allscoresV.csv > temp.txt # for a single condition
Text2Vest temp.txt designM3.mat
# contrast matrix
echo "1" > temp.txt
Text2Vest temp.txt designM3.con
./randwrapv6.sh iscpairsV.nii.nii ScoresV designM3.mat designM3.con ../iscmask.nii 5000


# design matrix for randomise
cat allratingsV.csv > temp.txt # for a single condition
Text2Vest temp.txt designM4.mat
# contrast matrix
echo "1" > temp.txt
Text2Vest temp.txt designM4.con
./randwrapv6.sh iscpairsV.nii.nii RatingsV designM4.mat designM4.con ../iscmask.nii 5000



