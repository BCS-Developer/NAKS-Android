import 'package:flutter/material.dart';
import 'package:top_examer/models/reel_model.dart';
import 'package:top_examer/ui/reels_page/reel_menu_options.dart';
import 'package:top_examer/utils/themes.dart';
import 'package:video_player/video_player.dart';

class VideoReelWidget extends StatefulWidget {
  final Message? reelModel;
  final VoidCallback onVideoCompleted;

  const VideoReelWidget(this.reelModel, this.onVideoCompleted, {super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoReelWidget> {
  late VideoPlayerController _controller;
  bool isVideoCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.reelModel?.assetDetails?.videoUrl ?? ""))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.play();
    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.position > Duration.zero &&
          _controller.value.position.inSeconds >=
              _controller.value.duration.inSeconds) {
        if (!isVideoCompleted) {
          isVideoCompleted = true;
          widget.onVideoCompleted();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        color: colorScheme.background,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Center(
                child: _controller.value.isInitialized
                    ? SizedBox(
                        // width: 300, // specify desired width
                        // height: 700, // specify desired height
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      )
                    : Center(child: Text("Loading video...")),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Visibility(
                visible: _controller.value.isInitialized,
                child: IconButton(
                  padding: const EdgeInsets.all(60),
                  icon: Icon(
                      _controller.value.isPlaying ? null : Icons.play_arrow),
                  color: Themes.white_color,
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.reelModel?.assetDetails?.videoTitle ?? "No Title",
                style: const TextStyle(
                  color: Themes.black_color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: ReelMenuOptions(widget.reelModel),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
