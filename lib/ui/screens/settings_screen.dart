import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/ui/controllers/settings_controller.dart';
import 'package:recipe_app/ui/utils/text_style.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => SwitchListTile(
                    title: Text(
                      'Dark Mode',
                      style: CustomTextStyle.recipeTitle,
                    ),
                    value: controller.isDarkMode.value,
                    onChanged: (value) => controller.toggleTheme(),
                    thumbIcon: WidgetStateProperty.all(
                        const Icon(Icons.nightlight_round)),
                  )),
              ListTile(
                title: Text(
                  'Notification',
                  style: CustomTextStyle.poppins,
                ),
                leading: const Icon(Icons.notifications),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.toNamed('/notification');
                },
              ),
              ListTile(
                title: Text(
                  'About',
                  style: CustomTextStyle.poppins,
                ),
                leading: const Icon(Icons.info),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.toNamed('/about');
                },
              ),
              ListTile(
                title: Text(
                  'Privecy Policy',
                  style: CustomTextStyle.poppins,
                ),
                leading: const Icon(Icons.privacy_tip),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.toNamed('/privacy');
                },
              ),
              ListTile(
                title: Text(
                  'Terms & Conditions',
                  style: CustomTextStyle.poppins,
                ),
                leading: const Icon(Icons.info),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.toNamed('/terms');
                },
              ),
              ListTile(
                title: Text(
                  'Rate Us',
                  style: CustomTextStyle.poppins,
                ),
                leading: const Icon(Icons.star),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.toNamed('/rate');
                },
              ),
              ListTile(
                title: Text(
                  'Share',
                  style: CustomTextStyle.poppins,
                ),
                leading: const Icon(Icons.share),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.toNamed('/share');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
