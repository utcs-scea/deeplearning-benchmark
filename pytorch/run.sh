#!/bin/bash

docker run -it --gpus '"device=0:0"' --rm --shm-size=64g \
	-v /data:/data -v $(pwd)/scripts:/scripts -v $(pwd)/results:/results nvcr.io/nvidia/pytorch:21.04-py3 \
	/bin/bash -c "cp -r /scripts/* /workspace; ./run_benchmark.sh A100_PCIe all"

