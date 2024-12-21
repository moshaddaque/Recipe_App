import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/ui/controllers/search_controller.dart';
import 'package:recipe_app/ui/utils/text_style.dart';
import 'package:recipe_app/ui/widgets/progress_loader.dart';

class RecipeSearchResultScreen extends StatefulWidget {
  const RecipeSearchResultScreen({super.key});
  // final String query;

  @override
  State<RecipeSearchResultScreen> createState() =>
      _RecipeSearchResultScreenState();
}

class _RecipeSearchResultScreenState extends State<RecipeSearchResultScreen> {
  final String query = Get.arguments;
  Future<void> _getRecipes() async {
    var result = Get.find<RecipeSearchController>().searchRecipes(query);

    result ? null : toastMessege(context, 'Failed to load recipes');
  }

  @override
  void initState() {
    super.initState();
    _getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Results',
          style: CustomTextStyle.poppins,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Search Results',
              style: CustomTextStyle.titlePoppins,
            ),
          ),
          Expanded(
            child: GetBuilder<RecipeSearchController>(
              builder: (recipeSearchController) {
                final results = recipeSearchController.searchResults;
                if (recipeSearchController.taskInProcess) {
                  return progessLoader();
                }

                if (results.isEmpty) {
                  return Center(
                    child: Text(
                      'No result found',
                      style: CustomTextStyle.titlePoppins,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final recipe = results[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            '/details',
                            arguments: recipe,
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network(recipe.image ?? ""),
                            title: Text(recipe.name ?? "Unknown Recipe"),
                            subtitle:
                                Text("Cuisine: ${recipe.cuisine ?? "N/A"}"),
                            trailing: Text("${recipe.rating ?? 0.0}⭐"),
                          ),
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
    );
  }

  toastMessege(BuildContext context, String s) {}
}
