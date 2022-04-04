import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/images.dart';
import '../../../constants/style_data.dart';
import '../../../controler/theme_controller.dart';
import 'language_screen.dart';
import 'widgets/profile_button.dart';
import 'widgets/profile_button2.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Card(
                  color: Theme.of(context).cardColor,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 1.0,
                  child: Column(
                    children: [
                      ProfileButton(
                          icon: Images.accountInfo,
                          title: 'Account Information'.tr,
                          onTap: () {
                          }),
                      ProfileButton(
                          icon: Images.addressBook,
                          title: 'Address Book'.tr,
                          onTap:() {}),
                      ProfileButton(
                          icon: Images.message,
                          title: 'Messages'.tr,
                          subTitle:
                          'Receive exclusive offers and personal updates'.tr,
                          onTap:() {}),
                      ProfileButton(
                          icon: Images.language,
                          title: 'Language'.tr,
                          onTap: () {
                            Get.to(
                                  () => const LanguageScreen(),

                            );
                          }),
                      ProfileButton(
                        icon: Images.makePayment,
                        title: 'Manage Payment'.tr,
                        onTap: () {
                        },
                      ),
                      ProfileButton(
                        icon: Images.policies,
                        title: 'Policies'.tr,
                          onTap:() {}),
                      ProfileButton(
                          icon: Images.helps,
                          title: 'Help'.tr,
                          onTap:() {}),
                      ProfileButton2(
                        icon: Icons.dark_mode,
                        title: 'Dark Mode'.tr,
                        radius: 5,
                        isButtonActive: Get.isDarkMode,
                          onTap:() {
                            Get.find<ThemeController>().toggleTheme();
                          }),
                    ],
                  ),
                ),
                kHeightBox40,
              ],
            ),
          ),
        ),
      ),
    );
  }
}