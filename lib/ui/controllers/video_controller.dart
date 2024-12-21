import 'package:get/get.dart';
import 'package:recipe_app/data/models/video_model.dart';

import 'package:recipe_app/data/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

//=================================

class VideoController extends GetxController {
  var isLoading = true.obs;
  var videoList = <Video>[].obs;
  var categories = <String>[].obs;
  var selectedCategory = 'Trending'.obs;
  var isSearching = false.obs;
  var filteredVideos = <Video>[].obs;

  late Video video;
  late YoutubePlayerController controller;

  @override
  void onInit() {
    fetchVideos();
    super.onInit();
  }

  // get youtube video id
  String? getYouTubeVideoId(String url) {
    final regExp = RegExp(
        r"(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})");

    final match = regExp.firstMatch(url);
    return match?.group(1); // Returns the video ID or null if not found
  }

  // get youtube thumbnail
  String getYoutubeThumbnail(String url) {
    if (url.isEmpty) return '';
    final videoId = getYouTubeVideoId(url);
    if (videoId == null || videoId.isEmpty) {
      return 'https://www.rootinc.com/wp-content/uploads/2022/11/placeholder-1.png';
    }
    final thumbnail = 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
    update();
    return thumbnail;
  }

  // fetch videos
  void fetchVideos() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(Urls.videoApi));
      if (response.statusCode == 200) {
        final data = parseCSV(response.body);
        videoList.value = data;
        filteredVideos.value = data
            .where((video) => video.category == selectedCategory.value)
            .toList();
        categories.value = extractCategories(data);
        isLoading(false);
      } else {
        Get.snackbar('Error', 'Failed to load videos: ${response.statusCode}');
        isLoading(false);
      }
    } catch (e) {
      Get.snackbar("Error", "SOmething went wrong");
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  //change category
  void changeCategory(String category) {
    selectedCategory.value = category;
    filterVideos();
  }

  // filtered videos
  void filterVideos() {
    filteredVideos.value = videoList
        .where((video) => video.category == selectedCategory.value)
        .toList();
  }

  // fetch video from youtube
  fetchVideoFromYoutube(String id) {
    controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    update();
  }

  // search videos
  void searchVideos(String query) {
    if (query.isEmpty) {
      filterVideos();
      isSearching(false);
      return;
    } else {
      isSearching(true);
      filteredVideos.value = videoList
          .where((video) =>
              video.title.toLowerCase().contains(query.toLowerCase()) |
              video.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    update();
  }

  // clear search
  void clearSearch() {
    isSearching(false);
    filterVideos();
  }

  // parseCSV
  List<Video> parseCSV(String csvData) {
    final lines = csvData.split('\n');
    final List<Video> videos = [];

    for (int i = 1; i < lines.length; i++) {
      final fields = lines[i].split(',');
      if (fields.length >= 4) {
        videos.add(Video(
          url: fields[0].trim(),
          title: fields[1].trim(),
          description: fields[2].trim(),
          category: fields[3].trim(),
        ));
      } else {
        print('Skipping malformed row: ${lines[i]}');
      }
    }

    return videos;
  }

  // extract categories
  List<String> extractCategories(List<Video> videos) {
    final categories = videos.map((video) => video.category).toSet().toList();
    categories.sort();
    return categories;
  }

  @override
  void onClose() {
    // Dispose of the YouTube Player Controller
    controller.dispose();
    super.onClose();
  }
}
