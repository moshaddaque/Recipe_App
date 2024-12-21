import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/data/models/video_model.dart';
import 'package:recipe_app/ui/controllers/video_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late Video video;

  VideoController videoController = Get.put(VideoController());
  late YoutubePlayerController controller;

  @override
  void initState() {
    video = Get.arguments as Video;
    controller = YoutubePlayerController(
      initialVideoId: videoController.getYouTubeVideoId(video.url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    debugPrint(videoController.getYouTubeVideoId(video.url)!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watch Video"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: YoutubePlayer(
                  controller: controller,
                  showVideoProgressIndicator: true,
                  thumbnail: Image.network(
                    videoController.getYoutubeThumbnail(video.url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                video.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                video.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
