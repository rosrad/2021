#!/bin/bash
########################
# Script for evaluation
# Usage:
#   1. please check that config.py has been properly configured
#   2. please specify the trained model
#      here, we use a pre-trained model from ASVspoof2019
#   2. $: bash 01_eval.sh
########################

tag=base_gfcc
log_name=log_eval_${tag}
trained_model=output_model_${tag}/trained_network.pt 

echo -e "Run evaluation"
source $PWD/../../env.sh
python main.py --inference --model-forward-with-file-name \
       --trained-model ${trained_model} 2>${log_name}_err.txt > ${log_name}.txt 
cat ${log_name}.txt | grep "Output," | awk '{print $2" "$4}' | sed 's:,::g' > ${log_name}_score.txt
echo -e "Process log has been written to $PWD/${log_name}.txt"
echo -e "Score has been written to $PWD/${log_name}_score.txt"
