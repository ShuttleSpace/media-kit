#!/usr/bin/env bash

# 确保环境变量能被子进程继承
set -a

if [ $# -lt 1 ]; then
    echo "Usage: $0 {aar|apk|appbundle|ios|ios-framework|ipa|macos|macos-framework|windows|linux} [video|audio]"
    exit 1
fi

# 创建临时环境变量文件
ENV_FILE=$(mktemp)
trap 'rm -f "$ENV_FILE"' EXIT

case $1 in
    # Android 相关
    aar|apk|appbundle)
        case $2 in
            video)
                # 只设置视频相关环境变量
                export LIBMPV_URL_ARM64=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-android-video-build/v1.1.5/default-arm64-v8a.jar
                export LIBMPV_MD5_ARM64=5f521b08692d7fef73c5df9bcc00ca4d
                export LIBMPV_URL_ARMV7=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-android-video-build/v1.1.5/default-armeabi-v7a.jar
                export LIBMPV_MD5_ARMV7=08d500ca1116c13e9c1296cc6f2207b0
                export LIBMPV_URL_X64=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-android-video-build/v1.1.5/default-x86_64.jar
                export LIBMPV_MD5_X64=0880d5fbc3ff0053409704617f54cb55
                export LIBMPV_URL_X86=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-android-video-build/v1.1.5/default-x86.jar
                export LIBMPV_MD5_X86=f6f51aa42b30d747099506cdc3277352
                ;;
            audio)
                # 只设置音频相关环境变量
                export LIBMPV_URL_ARM64=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-android-audio-build/v1.1.5/default-arm64-v8a.jar
                export LIBMPV_MD5_ARM64=c8cd2366bb53863f4a6979e47af38930
                export LIBMPV_URL_ARMV7=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-android-audio-build/v1.1.5/default-armeabi-v7a.jar
                export LIBMPV_MD5_ARMV7=eb497cc09626d592ef620dcc8a53e5dd
                export LIBMPV_URL_X64=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-android-audio-build/v1.1.5/default-x86_64.jar
                export LIBMPV_MD5_X64=f18901201382268aa127ebd636d8a934
                export LIBMPV_URL_X86=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-android-audio-build/v1.1.5/default-x86.jar
                export LIBMPV_MD5_X86=76351a613bfa0bee02b0bd6ae547f74b
                ;;
            *)
                # 默认设置全部
                # export LIBMPV_URL_ARM64=
                # export LIBMPV_MD5_ARM64=
                # export LIBMPV_URL_ARMV7=
                # export LIBMPV_MD5_ARMV7=
                # export LIBMPV_URL_X64=
                # export LIBMPV_MD5_X64=
                # export LIBMPV_URL_X86=
                # export LIBMPV_MD5_X86=
                ;;
        esac
        ;;

    # iOS 相关
    ios|ios-framework|ipa)
        case $2 in
            video)
                export MPV_XCFRAMEWORKS_VERSION=0.6.0
                export MPV_XCFRAMEWORKS_SHA256SUM=a95bc18508af26136b8a408341c05b5585d644ec013f00ac07db09d2e28d36ae
                export MPV_XCFRAMEWORKS=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-darwin-build/v0.6.0/libmpv-xcframeworks_v0.6.0_ios-universal-video-default.tar.gz
                ;;
            audio)
                export MPV_XCFRAMEWORKS_VERSION=0.6.0
                export MPV_XCFRAMEWORKS_SHA256SUM=8b8de92dc5482b8950c18bce6b8fa90204fd15af18f371acc9f5be07a4234e49
                export MPV_XCFRAMEWORKS=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-darwin-build/v0.6.0/libmpv-xcframeworks_v0.6.0_ios-universal-audio-default.tar.gz
                ;;
            *)
                # export MPV_XCFRAMEWORKS_VERSION=
                # export MPV_XCFRAMEWORKS_SHA256SUM=
                # export MPV_XCFRAMEWORKS=
                ;;
        esac
        ;;

    # macOS 相关
    macos|macos-framework)
        case $2 in
            video)
                export MPV_XCFRAMEWORKS_VERSION=0.6.0
                export MPV_XCFRAMEWORKS_SHA256SUM=84d2ad98e046e82c6dc34d8547d76c2afeaee89c0f53032773be8985c95536d6
                export MPV_XCFRAMEWORKS=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-darwin-build/v0.6.0/libmpv-xcframeworks_v0.6.0_macos-universal-video-default.tar.gz
                ;;
            audio)
                export MPV_XCFRAMEWORKS_VERSION=0.6.0
                export MPV_XCFRAMEWORKS_SHA256SUM=916220b7b4fe9209de41264382966ac90a2de2ac11956a4b6041cf66a8110732
                export MPV_XCFRAMEWORKS=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-darwin-build/v0.6.0/libmpv-xcframeworks_v0.6.0_macos-universal-audio-default.tar.gz
                ;;
            *)
                # export MPV_XCFRAMEWORKS_VERSION=
                # export MPV_XCFRAMEWORKS_SHA256SUM=
                # export MPV_XCFRAMEWORKS=
                ;;
        esac
        export MPV_HEADERS=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/mpv_headers_darwin/mpv-0.36.0.tar.gz
        export MPV_HEADERS_SHA256SUM=29abc44f8ebee013bb2f9fe14d80b30db19b534c679056e4851ceadf5a5e8bf6
        export MPV_HEADERS_VERSION=0.36.0
        ;;

    # Windows 相关
    windows)
        case $2 in
            video)
                export LIBMPV_URL=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-win32-video-build/2023-09-24/mpv-dev-x86_64-20230924-git-652a1dd.7z
                export LIBMPV_MD5=a832ef24b3a6ff97cd2560b5b9d04cd8
                ;;
            audio)
                export LIBMPV_URL=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/libmpv-win32-audio-build/2023-09-24/mpv-dev-x86_64-20230924-git-652a1dd.7z
                export LIBMPV_MD5=cd738e16e2a19626d7cfa48801524f8c
                ;;
            *)
                # export LIBMPV_URL=
                # export LIBMPV_MD5=
                ;;
        esac
        ;;

    # Linux 相关
    linux)
        # Linux 没有区分 video/audio
        export MIMALLOC_URL=https://hangf-1253488539.cos.ap-nanjing.myqcloud.com/libs/mimalloc/v2.1.2/mimalloc-2.1.2.tar.gz
        export MIMALLOC_MD5=5179c8f5cf1237d2300e2d8559a7bc55
        ;;
    *)
        echo "Usage: $0 {aar|apk|appbundle|ios|ios-framework|ipa|macos|macos-framework|windows|linux} [video|audio]"
        exit 1
        ;;
esac

# 将环境变量导出到文件
export | grep -E '^(LIBMPV_|MPV_|MIMALLOC_)' > "$ENV_FILE"

env $(cat "$ENV_FILE") flutter pub get
env $(cat "$ENV_FILE") flutter run -d macos -vv