import 'package:get/get.dart';
import 'package:recipe_app/data/models/network_response.dart';
import 'package:recipe_app/data/models/recipe_model.dart';
import 'package:recipe_app/data/services/network_service.dart';
import 'package:recipe_app/data/utils/urls.dart';

class RecipeSearchController extends GetxController {
  bool _taskInProcess = false;
  String _errorMessage = "";
  final List<RecipeModel> _searchRecipeList = [];
  List<Recipes> allRecipes = [];
  var query = ''.obs;

  var searchResults = <Recipes>[].obs;

  bool get taskInProcess => _taskInProcess;
  String get errorMessage => _errorMessage;
  List<RecipeModel> get searchRecipeList => _searchRecipeList;

  void initializeRecipes(List<Recipes> recipes) {
    allRecipes = recipes;
  }

  Future<bool> getSearchRecipe(String? quary) async {
    bool result = false;
    _searchRecipeList.clear();
    _taskInProcess = true;
    update();

    NetworkResponse response =
        await NetworkService.getRequest(Urls.query(quary));

    if (response.isSuccess) {
      for (dynamic data in response.responseData) {
        _searchRecipeList.add(RecipeModel.fromJson(data));
      }
      result = true;
    } else {
      _errorMessage = response.errorMessage ?? "Failes to get recipes";
    }
    _taskInProcess = false;
    update();

    return result;
  }

  // Search method
  bool searchRecipes(String? searchQuery) {
    bool result = false;
    _searchRecipeList.clear();
    _taskInProcess = true;
    update();

    query.value = searchQuery!;
    if (searchQuery.isEmpty) {
      searchResults.value = allRecipes;
      result = true;
    } else {
      searchResults.value = allRecipes
          .where((recipe) =>
              (recipe.name?.toLowerCase() ?? '')
                  .contains(searchQuery.toLowerCase()) ||
              (recipe.cuisine?.toLowerCase() ?? '')
                  .contains(searchQuery.toLowerCase()))
          .toList();
      result = true;
    }
    _taskInProcess = false;
    update();

    return result;
  }
}
