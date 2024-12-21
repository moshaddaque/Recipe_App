import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/ui/controllers/home_controller.dart';
import 'package:recipe_app/ui/utils/text_style.dart';
import 'package:recipe_app/ui/widgets/progress_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  HomeController controller = Get.put(HomeController());

  Future<void> _getRecipes() async {
    await controller.getDefaultRecipe();
  }

  @override
  void initState() {
    _getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Food Recies",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/notification');
            },
            icon: const Icon(
              Icons.circle_notifications_outlined,
              size: 35,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getRecipes,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: SizedBox(
                width: width > 500 ? width * .5 : width,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: searchController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "You need to enter a recipe name or title";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final query = searchController.text;

                            Get.toNamed(
                              '/search',
                              arguments: query,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.search_rounded,
                          color: Colors.blueAccent,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Search Recipe",
                      hintStyle: CustomTextStyle.poppins,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _titleText("Lets Cook Something New Today!"),
            _buildRecipeList(),
          ],
        ),
      ),
    );
  }

  _titleText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: CustomTextStyle.titlePoppins,
      ),
    );
  }

  _buildRecipeList() {
    final size = MediaQuery.of(context).size;
    var width = size.width;
    return Expanded(child: GetBuilder<HomeController>(
      builder: (controller) {
        final recipes = controller.recipeModel.value.recipes;

        if (recipes == null) {
          return progessLoader();
        }
        if (recipes.isEmpty) {
          return const Center(child: Text("No recipes found."));
        }

        return Visibility(
          visible: controller.taskInProcess == false,
          replacement: progessLoader(),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width < 301
                  ? 1
                  : width < 900
                      ? 2
                      : 3,
              childAspectRatio: width < 301
                  ? 1
                  : width <= 395
                      ? 0.7
                      : width <= 495 && width > 344
                          ? .8
                          : width <= 657 && width > 495
                              ? .9
                              : width <= 877 && width > 657
                                  ? 1.4
                                  : width < 900
                                      ? 2
                                      : 1.2,
            ),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: InkWell(
                  onTap: () => Get.toNamed(
                    '/details',
                    arguments: recipe,
                  ),
                  child: Card(
                    elevation: 4,
                    surfaceTintColor: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            recipe.image ?? "",
                            height: width < 231
                                ? 80
                                : width > 974
                                    ? 140
                                    : 100,
                          ),
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              recipe.name ?? "Unknown Title",
                              style: width < 231
                                  ? CustomTextStyle.recipeTitle.copyWith(
                                      fontSize: 16,
                                    )
                                  : CustomTextStyle.recipeTitle,
                              maxLines: width < 231 ? 1 : 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ingredients: ${recipe.ingredients}",
                                style: CustomTextStyle.poppins,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Instructions : ${recipe.instructions}",
                                style: CustomTextStyle.poppins,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    ));
  }
}
