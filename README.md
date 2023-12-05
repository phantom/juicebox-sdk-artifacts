This repo contains prebuilt reproducible artifacts for the [Juicebox SDK](https://github.com/juicebox-systems/juicebox-sdk).

In general, it is only intended for use as a submodule of that repository located at the `./aritfacts` path.

To build the latest artifacts from the SDK repository, you can run `./artifacts/build.sh`.

By default, the script will build both the FFI and JNI artifacts. However, passing the `--ffi` or `--jni` flags allows selectively targeting the desired artifacts.

You can verify the integrity of the artifacts in this repo by comparing the sha256sums in [checksums.txt](checksums.txt) after running the build.

In general, new artifacts will only be committed to this repository corresponding to published and tagged releases.
