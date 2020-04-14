
## using full matrix (order might be wrong, less power anyway)
# design matrix for randomise
cat sim_models.csv > temp.txt # for a single condition
Text2Vest temp.txt design.mat

regressorID=1;
while [ $regressorID -le 17 ]; do
	rm temp.txt
	# contrast matrix
	for n in $(seq 1 17); do
		if [ $n -eq $regressorID ]; then
			echo -n "1 " >> temp.txt
		else
			echo -n "0 " >> temp.txt
		fi
	done
	echo " " >> temp.txt
	Text2Vest temp.txt design$regressorID.con
	echo ./randwrapv6_1T.sh allISCpairs.nii reg$regressorID design.mat design$regressorID.con /m/nbe/scratch/braindata/shared/HarvardOxford/MNI152_T1_2mm_brain_mask.nii  100
	./randwrapv6_1T.sh allISCpairs.nii reg$regressorID design.mat design$regressorID.con /m/nbe/scratch/braindata/shared/HarvardOxford/MNI152_T1_2mm_brain_mask.nii  100

	let regressorID=regressorID+1;
done

