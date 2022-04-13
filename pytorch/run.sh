#!/bin/bash
set -x
set -e

GPU=1

clean_up_instances () {
	sudo nvidia-smi mig -dci | true
	sudo nvidia-smi mig -dgi | true
}
run_in_mig_instance () {
	gip=$1
	cip=$2
	name=$3
	sudo nvidia-smi mig -i ${GPU} -cgi ${gip}
	sudo nvidia-smi mig -i ${GPU} -cci ${cip}
	sleep 1 # let mig settle before starting docker
	docker run -it --gpus all --rm --shm-size=64g --pid host \
		-v /data:/data -v $(pwd)/scripts:/scripts -v $(pwd)/results:/results nvcr.io/nvidia/pytorch:20.10-py3 \
		/bin/bash -c "cp -r /scripts/* /workspace; export PYTORCH_NO_CUDA_MEMORY_CACHING=1;
			./run_benchmark.sh A100_PCIe fp32"
	mv results/A100_PCIe/ results/A100_PCIe_${name}
}

clean_up_instances
run_in_mig_instance 19 0 1slice
clean_up_instances
run_in_mig_instance 14 1 2slice
clean_up_instances
run_in_mig_instance 9 2 3slice
clean_up_instances
run_in_mig_instance 5 3 4slice
clean_up_instances
run_in_mig_instance 0 4 7slice
clean_up_instances
