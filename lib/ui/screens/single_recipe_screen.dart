import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/data/models/recipe_model.dart';

class SingleRecipeScreen extends StatelessWidget {
  const SingleRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Recipes recipe = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name ?? "Recipe Details"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.image != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      recipe.image!,
                      height: 200,
                      width: MediaQuery.of(context).size.width - 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            Text(
              recipe.name ?? "Unknown Recipe",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Cuisine: ${recipe.cuisine ?? "N/A"}"),
            Text("Difficulty: ${recipe.difficulty ?? "N/A"}"),
            Text("Prep Time: ${recipe.prepTimeMinutes ?? 0} mins"),
            Text("Cook Time: ${recipe.cookTimeMinutes ?? 0} mins"),
            Text("Servings: ${recipe.servings ?? 0}"),
            Text("Calories per Serving: ${recipe.caloriesPerServing ?? 0}"),
            const SizedBox(height: 16),
            const Text(
              "Ingredients",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...?recipe.ingredients?.map((ingredient) => Text("- $ingredient")),
            const SizedBox(height: 16),
            const Text(
              "Instructions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...?recipe.instructions
                ?.map((instruction) => Text("- $instruction")),
            const SizedBox(height: 16),
            if (recipe.tags != null && recipe.tags!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tags",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: recipe.tags!
                        .map((tag) => Chip(label: Text(tag)))
                        .toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
