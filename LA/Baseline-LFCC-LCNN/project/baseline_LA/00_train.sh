#!/bin/bash
########################
# Script for evaluation
# Usage:
#   1. please check that config.py has been properly configured
#   2. $: bash 00_train.sh > /dev/null 2>&1 &
#   3. please check log_train and log_err to monitor the training 
#      process
#   
# Note:
#   1. The script by default uses the pre-trained model from ASVspoof2019
#      If you don't want to use it, just delete the option --trained-model
#   2. For options, check $: python main.py --help
########################
tag="baseline"
log_name=log_train_${tag}
pretrained_model=__pretrained/trained_network.pt
output_dir=./output_model_${tag}
mkdir ${output_dir}

echo -e "Training"
echo -e "Please monitor the log trainig: $PWD/${log_name}.txt\n"
source $PWD/../../env.sh
python main.py --model-forward-with-file-name \
       --num-workers 3 --epochs 100 \
       --no-best-epochs 50 --batch-size 64 \
       --sampler block_shuffle_by_length \
       --lr-decay-factor 0.5 --lr-scheduler-type 1 \
       --trained-model ${pretrained_model} \
       --ignore-training-history-in-trained-model \
       --save-model-dir ${output_dir} \
       --lr 0.0003 --seed 1000 2>${log_name}_err.txt |tee ${log_name}.txt
    #    --l2-penalty 0.0001 \
echo -e "Training process finished"
echo -e "Trainig log has been written to $PWD/${log_name}.txt"





