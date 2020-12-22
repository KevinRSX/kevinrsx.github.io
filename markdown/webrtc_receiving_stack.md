---
title: WebRTC Receiving Stack
---

# WebRTC Receiving Stack

## Decoding

Locations of classes:

```
VideoReceiveStream2: video/video_receive_stream2.cc
VideoReceiver2: modules/video_coding/video_receiver2.cc
VCMGenericDecoder: modules/video_coding/generic_decoder.cc
```



Function calls:

```
VideoReceiveStream2::StartNextDecode() ->
VideoReceiveStream2::HandleEncodedFrame(std::unique_ptr<EncodedFrame> frame) ->
VideoReceiver2::Decode(const VCMEncodedFrame* frame) ->
VCMGenericDecoder::Decode(const VCMEncodedFrame& frame, Timestamp now)
```



Notes:

- ` frame_buffer_` is in `VideoReceiveStream2`.



## Rendering

Locations of classes:

```
VCMDecodedFrameCallback: modules/video_coding/generic_decoder.cc
VideoStreamDecoder: video/video_stream_decoder2.cc
IncomeVideoStream: common_video/income_video_stream.cc
VideoRenderFrames: common_video/video_render_frames.cc
WebRtcVideoChannel: media/engine/webrtc_video_engine.cc
VideoBroadcaster: media/base/video_broadcaster.cc
VideoRendererAdapter: sdk/objc/api/RTCVideoRendererAdapter.mm
```



Function calls:

```
VCMDecodedFrameCallback::Decoded(VideoFrame& decodedImage)
VCMDecodedFrameCallback::Decoded(VideoFrame& decodedImage, int64_t decode_time_ms) -> 
VCMDecodedFrameCallback::Decoded(VideoFrame& decodedImage, absl::optional<int32_t> decode_time_ms, absl::optional<uint8_t> qp) -> 
VideoStreamDecoder::FrameToRender(VideoFrame& video_frame, absl::optional<uint8_t> qp, int32_t decode_time_ms, VideoContentType content_type) ->
IncomingVideoStream::OnFrame(const VideoFrame& video_frame) ->
IncomingVideoStream::Dequeue() ->
[VideoReceiveStream2::OnFrame(const VideoFrame& video_frame), 
absl::optional<VideoFrame> VideoRenderFrames::FrameToRender()]

VideoReceiveStream2::OnFrame(const VideoFrame& video_frame) ->
WebRtcVideoChannel::WebRtcVideoReceiveStream::OnFrame(const webrtc::VideoFrame& frame) ->
VideoBroadcaster::OnFrame(const webrtc::VideoFrame& frame) ->
(Mac and IOS) VideoRendererAdapter::OnFrame(const webrtc::VideoFrame& nativeVideoFrame) ->
Platform-specific implementations
```



Note:

- `callback_` in `IncomingVideoStream` is a `rtc::VideoSinkInterface<VideoFrame>`, which is inherited by `VideoReceiveStream2`
- `VideoBroadcaster` implements both a source (producer of video & audio track) and sink (consumer of video & audio track), where `OnFrame()` is a method of the sink. Rendering methods are called before `VideoBroadcaster`



## Objective-C Application

- Codes are in `sdk/objc/`
- `.mm` are Objective-C++ while `.m` are Objective-C
