FFmpeg

# 简介

ffmepg是最常用的开源视频处理软件。

# 基础知识。

**容器**：我们常见的mp4、AVI、mkv等视频文件后缀实际是一种封装格式，是一个容器，容器里包了各种音频流，视频流，字母流

mux: 复用，将多路流混在一路的过程，demux 将一路流解开为音视频字母等多路流测过程。

### ffmpeg ffplay ffprobe关系

ffmpeg偏向编码器，ffplay简单媒体播放器，ffprobe 多媒体流分析器

### H264码流格式

Annex-B：（MPEG-2 transport stream format ts格式）由start code分个NAL，sps，pps按流的方式写在头部

AVCC：（也叫AVC1格式，MPEG-4格式） 使用NALU长度分个NAL。头部有格式封装sps pps

#  FFmepg 常用命令

 FFmpeg  {全局参数}  {输入文件参数}  -i  {输入文件} {输出文件参数}  {输出文件}

```
-c : encoder
-c copy: 复制不重新编码
-c:v  : 指定视频编码器
-c:a  : 指定音频编码器
-i ： 输入文件
-an ： 去除音频
-vn ： 去除视频
```

mp4文件提取h264 裸流

```
ffmpeg -i output.mp4 -an -vcodec copy -bsf:v h264_mp4toannexb output.h264   # 注意这个bsf。h264有两种格式，不带不好直接ffplay。ffplay只可以annexb格式。-bsf:h264_mp4toannexb 从MP4拷贝到annexB封装
```

播放h264 问价可以直接ffplay。播放yuv必须制定宽高。

ffplay  -video_size 1920x1080 a.yuv







[cnblog FFmpeg封装格式处理](https://www.cnblogs.com/leisure_chn/p/10506636.html)

[阮一峰 FFmpeg](http://www.ruanyifeng.com/blog/2020/01/ffmpeg.html)

[ffmpeg 命令介绍](https://zhuanlan.zhihu.com/p/117523405)

[ffmpeg命令使用](https://www.suninf.net/2017/02/ffmpeg-command-usage.html)

[ffmpeg 命令 掘金](https://juejin.im/post/5a59993cf265da3e4f0a1e4b)

