import 'package:get/get.dart';
import 'package:recipe_app/ui/controllers/home_controller.dart';
import 'package:recipe_app/ui/controllers/search_controller.dart';
import 'package:recipe_app/ui/controllers/settings_controller.dart';
import 'package:recipe_app/ui/controllers/video_controller.dart';

class BindingController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.put(RecipeSearchController());
    Get.put(VideoController());
    Get.put(SettingsController());
  }
}
