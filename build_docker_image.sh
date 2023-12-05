#!/bin/sh

set -eux

# cd to build directory
cd -P -- "$(dirname -- "$0")"

docker build -t juicebox-sdk-artifacts .
