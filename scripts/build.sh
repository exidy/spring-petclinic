#!/bin/bash -e

docker  run -v `pwd`:/work \
        -w /work \
        openjdk:8 ./mvnw package
        