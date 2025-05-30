#!/bin/bash

# Script to reproduce ML training, prediction, and analysis runs for
# UniKP models on CatPred-DB datasets for kcat, Km and Ki

# Author: Veda Sheersh Boorla
# Date: 12-09-2024
# Related to Figure 5 of the manuscript

# Exit script on error
set -e

BASE_DIR=$(pwd)

LOG_DIR="$BASE_DIR/../data/results/reproduce_logs"
OUTPUT_DIR="$BASE_DIR/../data/results/reproduce_results"

# Main pipeline
usage() {
  echo "Usage: $0 [training|analysis]"
  exit 1
}

if [ "$#" -ne 1 ]; then
  usage
fi

case $1 in
  training)
    echo "Running pipeline: Training -> Analysis"
    echo "Training runs will take several hours"
    python ./external/UniKP/train_UniKP_Kroll.py > $LOG_DIR/UniKP_Kroll_km_training.log

    ;;
  analysis)
    echo "Running pipeline: Analysis"
    # Analyze results for each parameter and save outputs to the results directory
    python ./external/UniKP/parse_logs.py $LOG_DIR/UniKP_Kroll_km_training.log "$OUTPUT_DIR/km/km_KrollDB_UniKP_results.csv"
    echo "Saved results to: $OUTPUT_DIR/km/km_KrollDB_UniKP_results.csv"
    ;;
  *)
    usage
    ;;
esac