#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Incorrect usage."
	echo "usage: dgs_batcher.sh <model_list>"
	echo "example: dgs_batcher.sh hyperparameters.csv"
	exit 1
fi

# CUDA settings
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:10000
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7

# read in parameters
parameter_file=$1
#parameters=`cat $parameter_file`

#constant variables for all runs
method='distmult'
bridge='CMP-linear'
kg1f='./data/yago/yago_insnet_train.txt'
kg2f='./data/yago/yago_ontonet_train.txt'
alignf='./data/yago/yago_InsType_train.txt'
v_link_A='euclidean'
v_link_B='hyperbolic'
h_link_A='euclidean'
h_link_B='hyperbolic'
v_link_AM='hyperbolic'
AM_loss_metric='L2'

# runtime parameters
total_epochs=1000	# default: 1. Roshni: E/E needs 500, E/H needs 1000, S/H needs 5000
batch_K1=256		# default: 256
batch_K2=64		# default 64
batch_A=128			# default: 128

date=`date +%Y-%m-%d`
i=0
batcher_log="./batcher_log/"$date"_log.txt"
echo $date > $batcher_log
echo $batcher_log
while IFS=, read dim1 dim2 a1 a2 m1 m2 fold lr_A_vert lr_A_horiz lr_B_vert lr_B_horiz lr_AM;
do
	start=$SECONDS
	modelname=$date"_batcher_model_"$i
	echo "Starting $modelname" | tee -a $batcher_log
	echo "python ./run/training_model.py --method $method --bridge $bridge --kg1f $kg1f --kg2f $kg2f --alignf $alignf --modelname $modelname --AM_loss_metric $AM_loss_metric --vertical_links_A $v_link_A --vertical_links_B $v_link_B --horizontal_links_A $h_link_A --horizontal_links_B $h_link_B --vertical_links_AM $v_link_AM --total_epochs $total_epochs --dim1 $dim1 --dim2 $dim2 --a1 $a1 --a2 $a2 --m1 $m1 --m2 $m2 --fold $fold --lr_A_vert $lr_A_vert --lr_A_horiz $lr_A_horiz --lr_B_vert $lr_B_vert --lr_B_horiz $lr_B_horiz --lr_AM $lr_AM --batch_K1 $batch_K1 --batch_K2 $batch_K2 --batch_A $batch_A" | tee -a $batcher_log
	python ./run/training_model.py --method $method --bridge $bridge --kg1f $kg1f --kg2f $kg2f --alignf $alignf --modelname $modelname --AM_loss_metric $AM_loss_metric --vertical_links_A $v_link_A --vertical_links_B $v_link_B --horizontal_links_A $h_link_A --horizontal_links_B $h_link_B --vertical_links_AM $v_link_AM --total_epochs $total_epochs --dim1 $dim1 --dim2 $dim2 --a1 $a1 --a2 $a2 --m1 $m1 --m2 $m2 --fold $fold --lr_A_vert $lr_A_vert --lr_A_horiz $lr_A_horiz --lr_B_vert $lr_B_vert --lr_B_horiz $lr_B_horiz --lr_AM $lr_AM --batch_K1 $batch_K1 --batch_K2 $batch_K2 --batch_A $batch_A
	i=$((i+1))
	duration=$(( SECONDS-start ))
	echo "Elapsed time for $modelname: $duration seconds" | tee -a $batcher_log
done < $parameter_file
