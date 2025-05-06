#!/usr/bin/expect -f
set workspace [pwd]
# 定义发布函数
proc pub {dir} {
    global workspace
    cd "$workspace/$dir"

    puts "检查发布地址..."
    if {[catch {exec which yq} result]} {
        puts "错误: yq 未安装，请先安装 yq (https://github.com/mikefarah/yq)"
        exit 1
    }
    # 检查并修改发布地址
    if {[catch {set publish_to [exec yq eval .publish_to pubspec.yaml]} error]} {
        puts "读取发布地址失败: $error"
        puts "尝试使用备用查询语法..."
        if {[catch {set publish_to [exec yq .publish_to pubspec.yaml]} error]} {
            puts "仍无法读取发布地址: $error"
            exit 1
        }
    }
    if {$publish_to != "http://localhost:4000"} {
        # 修改发布地址
        if {[catch {exec yq eval '.publish_to = "http://localhost:4000"' -i pubspec.yaml} error]} {
            puts "尝试使用备用修改语法..."
            if {[catch {exec yq -i '.publish_to = "http://localhost:4000"' pubspec.yaml} error]} {
                puts "修改发布地址失败: $error"
                exit 1
            }
        }
        puts "已将 pubspec.yaml 发布地址修改为 http://localhost:4000"
    } else {
        puts "pubspec.yaml 已配置发布地址 http://localhost:4000"
    }

    puts "正在发布: $dir"
    spawn dart pub publish
    expect {
        "(y/N)" { send "y\r" }
        timeout { 
            puts "错误: 等待确认提示超时"
            exit 1 
        }
    }
    # expect eof
    cd $workspace
}

# 依次发布各个包
pub libs/android/media_kit_libs_android_audio
pub libs/android/media_kit_libs_android_video
pub libs/ios/media_kit_libs_ios_audio
pub libs/ios/media_kit_libs_ios_video
pub libs/linux/media_kit_libs_linux
pub libs/macos/media_kit_libs_macos_audio
pub libs/macos/media_kit_libs_macos_video
pub libs/universal/media_kit_libs_audio
pub libs/universal/media_kit_libs_video
pub libs/windows/media_kit_libs_windows_audio
pub libs/windows/media_kit_libs_windows_video
pub media_kit
pub media_kit_video
pub video_player_media_kit