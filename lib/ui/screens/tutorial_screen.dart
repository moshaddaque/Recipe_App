import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/ui/controllers/video_controller.dart';
import 'package:recipe_app/ui/utils/text_style.dart';
import 'package:recipe_app/ui/widgets/progress_loader.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VideoController controller = Get.put(VideoController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Obx(() {
          return controller.isSearching.value
              ? TextField(
                  autofocus: true,
                  onChanged: (value) => controller.searchVideos(value),
                  decoration: const InputDecoration(
                    hintText: 'Search videos...',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black87),
                )
              : Text(
                  'Tutorials',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                );
        }),
        actions: [
          Obx(() {
            return IconButton(
              icon: controller.isSearching.value
                  ? const Icon(
                      Icons.cancel_outlined,
                      size: 35,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.search,
                      size: 35,
                      color: Colors.blueAccent,
                    ),
              onPressed: () {
                if (controller.isSearching.value) {
                  controller.clearSearch();
                } else {
                  controller.isSearching.value = true;
                }
              },
            );
          }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchVideos();
        },
        child: Column(
          children: [
            // category list
            Obx(
              () {
                if (controller.isLoading.value) {
                  return const LinearProgressIndicator();
                }

                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return GestureDetector(
                        onTap: () {
                          controller.changeCategory(category);
                        },
                        child: Obx(
                          () {
                            final isSelected =
                                controller.selectedCategory.value == category;

                            return Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.blue.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                category.toString(),
                                style: CustomTextStyle.poppins.copyWith(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // video list
            Expanded(
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return progessLoader();
                  }

                  final videos = controller.filteredVideos;
                  if (videos.isEmpty) {
                    return const Center(
                        child: Text('No videos found for this category.'));
                  }

                  return ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      String image = controller.getYoutubeThumbnail(video.url);
                      debugPrint(image);
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: InkWell(
                          onTap: () => Get.toNamed('/video', arguments: video),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  image,
                                  height: 200,
                                  width: MediaQuery.of(context).size.width - 50,
                                  loadingBuilder: (context, child,
                                          loadingProgress) =>
                                      loadingProgress == null
                                          ? child
                                          : const CircularProgressIndicator(),
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.error,
                                    size: 50,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  video.title,
                                  style: CustomTextStyle.recipeTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  video.description,
                                  style: CustomTextStyle.poppins,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
