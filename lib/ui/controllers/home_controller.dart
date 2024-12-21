import 'package:get/get.dart';
import 'package:recipe_app/data/models/network_response.dart';
import 'package:recipe_app/data/models/recipe_model.dart';
import 'package:recipe_app/data/services/network_service.dart';
import 'package:recipe_app/data/utils/urls.dart';
import 'package:recipe_app/ui/controllers/search_controller.dart';

class HomeController extends GetxController {
  bool _taskInProcess = false;
  String _errorMessage = '';

  var recipeModel = RecipeModel().obs;

  final RecipeSearchController searchController =
      Get.put(RecipeSearchController());

  bool get taskInProcess => _taskInProcess;
  String get errorMessage => _errorMessage;

  Future<bool> getDefaultRecipe() async {
    bool result = false;

    _taskInProcess = true;
    update();

    NetworkResponse response = await NetworkService.getRequest(Urls.recipes);

    if (response.isSuccess) {
      recipeModel.value = RecipeModel.fromJson(response.responseData);
      // Pass data to SearchController
      searchController.initializeRecipes(recipeModel.value.recipes ?? []);
      result = true;
    } else {
      _errorMessage = response.errorMessage ?? "Failed to get recipes";
    }
    _taskInProcess = false;
    update();

    return result;
  }
}
