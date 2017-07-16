#!/bin/bash -e

BUILD_DIR=$(pwd)

echo ":s3: Seeding cache"

mkdir -f ${BUILD_DIR}/cache
aws s3 sync s3://dius-dev-build-cache/${BUILDKITE_PIPELINE_SLUG}/caches ${BUILD_DIR}/cache

echo ":hammer: Building app"

docker run \
        -v ${BUILD_DIR}:/work \
        -v ${BUILD_DIR}/cache:/root/.m2 \
        -w /work \
        openjdk:8 ./mvnw package

echo ":s3: Syncing cache"
aws s3 sync --delete ${BUILD_DIR}/cache s3://dius-dev-build-cache/${BUILDKITE_PIPELINE_SLUG}/caches 
