#!/usr/bin/env sh
set -e

LOG=/home/pi/vision/cpm/models/cpm/training/prototxt/LEEDS_validation/log/cpm_LEEDS_train_`date +%Y-%m-%d-%H-%M-%S`.log

/home/pi/vision/cpm/build/tools/caffe train \
    --solver=/home/pi/vision/cpm/models/cpm/training/prototxt/LEEDS_validation/pose_solver.prototxt  2>&1 | tee -a $LOG
