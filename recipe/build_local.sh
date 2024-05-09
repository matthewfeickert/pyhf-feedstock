#!/bin/bash

if [[ ! -d ".ci_support" ]]; then
    echo "This script should be run from the root of the feedstock."
    echo -e "Example:\n# bash recipe/build_local.sh"
    exit 1
fi

docker system prune -f

rm -rf \
    build_artifacts \
    build.log
mkdir -p build_artifacts/{noarch,linux-64}/

# Match the file name of the .yaml file under .ci_support/
export CONFIG=linux_64_
export DOCKER_IMAGE=quay.io/condaforge/linux-anvil-cos7-x86_64
export UPLOAD_PACKAGES=False
export CPU_COUNT="$(nproc --ignore 4)"

.scripts/run_docker_build.sh | tee build.log
