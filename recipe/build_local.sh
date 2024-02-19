#!/bin/bash

docker system prune -f

# repository top level
cd ..

rm -rf \
    build_artifacts \
    build.log
mkdir -p build_artifacts/{noarch,linux-64}/

export CONFIG=linux64
export DOCKER_IMAGE=quay.io/condaforge/linux-anvil-cos7-x86_64
export AZURE=False
export CPU_COUNT="$(nproc --ignore 4)"

.scripts/run_docker_build.sh | tee build.log
