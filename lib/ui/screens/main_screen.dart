import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/ui/screens/home_screen.dart';
import 'package:recipe_app/ui/screens/settings_screen.dart';
import 'package:recipe_app/ui/screens/tutorial_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int selectedScreen = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const TutorialScreen(),
    const SettingsScreen(),
  ];
  changeScreen(int item) {
    setState(() {
      selectedScreen = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          changeScreen(value);
        },
        children: _pages,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        kBottomRadius: 30,
        kIconSize: 30,
        showLabel: true,
        notchBottomBarController:
            NotchBottomBarController(index: selectedScreen),
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.home_outlined, color: Colors.blueGrey),
            activeItem: Icon(Icons.home_filled, color: Colors.blueAccent),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem:
                Icon(Icons.video_collection_outlined, color: Colors.grey),
            activeItem: Icon(Icons.video_collection, color: Colors.blueAccent),
            itemLabel: 'Tutorials',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.settings_outlined, color: Colors.grey),
            activeItem: Icon(Icons.settings, color: Colors.blueAccent),
            itemLabel: 'Settings',
          ),
        ],
        onTap: (index) {
          changeScreen(index);
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
