#!/bin/bash

set -euo pipefail

export CARGO_TARGET_DIR=/target

if [ "${FFI:-1}" -eq 1 ]; then
    FFI_TARGETS=("aarch64-apple-ios" "x86_64-apple-ios" "aarch64-apple-ios-sim")

    for target in "${FFI_TARGETS[@]}"; do
        CARGO_BUILD_TARGET="${target}" ./swift/ffi.sh --release ${VERBOSE:+-v}
    done
fi

if [ "${JNI:-1}" -eq 1 ]; then
    ./android/jni.sh ${VERBOSE:+-v}
fi

find artifacts -type f \( -name '*.a' -o -name '*.so' \) -exec sha256sum {} \; | sort -k2 > artifacts/checksums.txt
