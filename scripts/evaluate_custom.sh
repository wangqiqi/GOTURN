#!/bin/bash

if [ -z "$1" ]
  then
    echo "No folder supplied!"
    echo "Usage: bash `basename "$0"` alov_video_folder alov_annotations_folder"
    exit
fi

# Choose which GPU the tracker runs on
GPU_ID=0

# Whether to evaluate on the training set or the validation set
USE_TRAIN=0

# Whether or not to save videos of the tracking output
SAVE_VIDEOS=0

VIDEOS_FOLDER=$1
ANNOTATIONS_FOLDER=$2
MODEL_DIR=models/smlr_scrtch_npd
FOLDER=GOTURN1_val

DEPLOY_PROTO=$MODEL_DIR/tracker.prototxt

RESULT_FILE=$MODEL_DIR/val_evaluation.log


for i in $(seq 1 4)
do 
	echo $i
	iter=$(($i*50000))
	echo $iter

OUTPUT_FOLDER=$MODEL_DIR/tracker_output_$iter


# Compute validation score
matlab -nodisplay -r "addpath(genpath('scripts/Fscore_v1.0')); evaluate_all $ANNOTATIONS_FOLDER $OUTPUT_FOLDER $RESULT_FILE;    exit" 
done
