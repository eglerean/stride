#!/bin/bash

for n in $(ls -1 /m/nbe/archive/braindata/2016/SSRI_depression/); do
	echo  tar xvfz /m/nbe/archive/braindata/2016/SSRI_depression/$n -C . 
done


for n in $(find . -maxdepth 2 -type d -name "[0-9]*");do 
	for sf in $(ls $n);do 
		sID=$(echo $n|cut -d\/ -f3);
		echo mkdir -p data/$sID;
		mkdir -p data/$sID;
		echo dcm2nii -g n -x y -d y -o data/$sID $n/$sf;
		dcm2nii -g n -x y -d y -o data/$sID $n/$sf;
	done;
done
