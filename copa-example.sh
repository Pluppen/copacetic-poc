#!/bin/env bash

IMAGE=docker.io/library/nginx:1.21.6
if [ $# -gt 0 ]; then
    IMAGE=$1
fi

echo "======================================="
echo "Running trivy scan and copa patch against"
echo "image: $IMAGE"
echo "======================================="

echo "======================================="
echo "Running first trivy scan"
echo "======================================="

trivy image --vuln-type os --ignore-unfixed $IMAGE

echo "======================================="
echo "Running trivy scan and outputting to json"
echo "======================================="

trivy image --vuln-type os --ignore-unfixed -f json -o $(basename $IMAGE).json $IMAGE

echo "======================================="
echo "Patching image using Copa and Trivy output"
echo "======================================="

copa patch -r $(basename $IMAGE).json -i $IMAGE

echo "======================================="
echo "Running trivy scan on patched image"
echo "======================================="

trivy image --vuln-type os --ignore-unfixed $IMAGE-patched
