#!/bin/bash

set -euo pipefail

usage() {
  cat >&2 <<END
USAGE: $(basename "$0") [-v] [--ffi|--jni]

Reproducibly builds the cross-compiled artifacts for the Juicebox SDK.

OPTIONS:
  -v, --verbose           verbose build
  --ffi                   build the ffi artifacts
  --jni                   build the jni artifacts

  -h, --help              show this help information
END
}

VERBOSE=
FFI=
JNI=

while [ "${1:-}" != "" ]; do
  case $1 in
    -v | --verbose )
      VERBOSE=1
      ;;
    --ffi )
      FFI=1
      JNI=${JNI:-0}
      ;;
    --jni )
      JNI=1
      FFI=${FFI:-0}
      ;;
    -h | --help )
      usage
      exit
      ;;
    * )
      usage
      exit 2
  esac
  shift
done

# cd to repo root directory
cd -P -- "$(dirname -- "$0")/.."

docker pull juiceboxsystems/juicebox-sdk-artifacts

docker run --rm \
    --platform=linux/amd64 \
    -v "$PWD:/sdk:ro" \
    -v "$PWD/artifacts:/sdk/artifacts:rw" \
    -w /sdk \
    -e FFI=${FFI} \
    -e JNI=${JNI} \
    -e VERBOSE=${VERBOSE} \
    juiceboxsystems/juicebox-sdk-artifacts:latest \
    /sdk/artifacts/build_inner.sh
