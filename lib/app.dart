import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipe_app/ui/screens/home_screen.dart';
import 'package:recipe_app/ui/screens/main_screen.dart';
import 'package:recipe_app/ui/screens/notification_screen.dart';
import 'package:recipe_app/ui/screens/search_result_screen.dart';
import 'package:recipe_app/ui/screens/single_recipe_screen.dart';
import 'package:recipe_app/ui/screens/tutorial_screen.dart';
import 'package:recipe_app/ui/screens/video_player.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: const Color.fromARGB(255, 53, 6, 134),
      //   ),
      //   useMaterial3: true,
      //   appBarTheme: const AppBarTheme(
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //     centerTitle: true,
      //     scrolledUnderElevation: 0,
      //   ),
      // ),

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => const MainScreen(),
        ),
        GetPage(
          name: "/recipe",
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: "/search",
          page: () => const RecipeSearchResultScreen(),
        ),
        GetPage(
          name: "/details",
          page: () => const SingleRecipeScreen(),
        ),
        GetPage(
          name: "/notification",
          page: () => const NotificationScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/tutorial",
          page: () => const TutorialScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: "/video",
          page: () => const VideoPlayer(),
          transition: Transition.native,
        ),
      ],
    );
  }
}
