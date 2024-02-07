FROM --platform=linux/amd64 rust:1.75.0-bookworm

# for cbindgen
RUN apt-get update && apt-get install --yes libclang-dev

# iOS Targets
RUN rustup target add aarch64-apple-ios x86_64-apple-ios aarch64-apple-ios-sim

# Android Targets
RUN rustup target add aarch64-linux-android armv7-linux-androideabi x86_64-linux-android i686-linux-android

# NDK for android
RUN wget https://dl.google.com/android/repository/android-ndk-r26b-linux.zip -O /android-ndk-r26b-linux.zip
RUN unzip /android-ndk-r26b-linux.zip -d / && rm /android-ndk-r26b-linux.zip
ENV ANDROID_NDK_HOME /android-ndk-r26b
