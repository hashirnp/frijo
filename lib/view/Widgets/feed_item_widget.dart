import 'package:flutter/material.dart';
import 'package:noviindus/core/constants/app_constants.dart';
import 'package:noviindus/view/Widgets/expandable_text.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class FeedItemWidget extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;
  final String userName;
  final String timeAgo;
  final String description;

  const FeedItemWidget({
    super.key,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.userName,
    required this.timeAgo,
    required this.description,
  });

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            setState(() {});
          });

    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: false,
      looping: false,
      allowPlaybackSpeedChanging: true,
      showOptions: false,
      fullScreenByDefault: false,
      allowFullScreen: false,
      aspectRatio: _videoController!.value.aspectRatio,
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void _playVideo() {
    setState(() {
      _isPlaying = true;
    });
    _videoController?.play();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      color: const Color(0xff171717),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/user_placeholder.jpg"),
            ),
            title: Text(
              widget.userName,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              AppConstants().timeAgo(widget.timeAgo),
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),

          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: _isPlaying && _videoController!.value.isInitialized
                ? Chewie(controller: _chewieController!)
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.thumbnailUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: _playVideo,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black54,
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ExpandableText(text: widget.description, trimLines: 3),
          ),
        ],
      ),
    );
  }
}
