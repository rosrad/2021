# example of use of the evaluate_tDCF_asvspoof19 function using
# the ASVspoof 2019 official baseline contermeasure systems.
# (score files stored in folder "scores")

from evaluate_tDCF_asvspoof19 import evaluate_tDCF_asvspoof19
import pandas as pd

    
# set here the track and baseline system to use
track = 'LA';   # 'LA' or 'PA'
tag = 'baseline'; # 'B01' or 'B02'

protocal_file = "/home/boren/data/LA/protocol.txt"
wkd = "/home/boren/asvspoof_2021/LA/Baseline-LFCC-LCNN/project"

asv_scorefile = f'{wkd}/tDCF_python_v2/scores/ASVspoof2019_' + track + '_eval_asv_scores.txt'
cm_scorefile = f'{wkd}/tDCF_python_v2/scores/' + tag + '_' + track + '_primary_eval.txt'

score_file = f"{wkd}/baseline_LA/log_eval_{tag}_score.txt"
score_df = pd.read_csv(score_file, sep="\s+", names=["utt_id", "score"])
protocal_df = pd.read_csv(protocal_file, sep="\s+", names=["source", "utt_id", "unk1", "unk2", "keys"])
cm_score_df = score_df.merge(protocal_df, how="left", on="utt_id")
cm_score_df[["source", "utt_id", "unk1", "unk2", "keys","score"]].to_csv(cm_scorefile, sep=" ", header=False, index=False)

# set the 3rd argument to true to use the legacy t-DCF formulation
evaluate_tDCF_asvspoof19(cm_scorefile, asv_scorefile, False);   

