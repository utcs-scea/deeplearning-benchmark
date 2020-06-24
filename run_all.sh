#!/bin/bash
#
#docker run --gpus '"device=0"' --rm --shm-size=64g -v ~/data:/data -v $(pwd)"/scripts":/scripts -v $(pwd)"/results":/results nvcr.io/nvidia/pytorch:20.01-py3 /bin/bash -c "cp -r /scripts/* /workspace; ./run_benchmark.sh 2080Ti all"
#
#
#docker run --gpus '"device=0,1"' --rm --shm-size=64g -v ~/data:/data -v $(pwd)"/scripts":/scripts -v $(pwd)"/results":/results nvcr.io/nvidia/pytorch:20.01-py3 /bin/bash -c "cp -r /scripts/* /workspace; ./run_benchmark.sh 2x2080TiNVlink all"
#
#docker run --gpus '"device=0,1,2,3"' --rm --shm-size=64g -v ~/data:/data -v $(pwd)"/scripts":/scripts -v $(pwd)"/results":/results nvcr.io/nvidia/pytorch:20.01-py3 /bin/bash -c "cp -r /scripts/* /workspace; ./run_benchmark.sh 4x2080TiNVlink all"
#
docker run --gpus all --rm --shm-size=64g -v ~/data:/data -v $(pwd)"/scripts":/scripts -v $(pwd)"/results":/results nvcr.io/nvidia/pytorch:20.01-py3 /bin/bash -c "cp -r /scripts/* /workspace; ./run_benchmark.sh 8x2080TiNVlink tacotron2_fp16"
