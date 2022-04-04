import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors_data.dart';
import '../../../constants/style_data.dart';
import '../../../controler/theme_controller.dart';
import '../../../services/api/app_config.dart';
import '../../../services/localization_services.dart';
import 'widgets/setting_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'.tr),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          AccountBtnWidget(
            title: 'Login/Register'.tr,
            icon: Icons.power_settings_new,
            onPress: () {
            },
          ),
          AccountBtnWidget(
            title: 'My Order'.tr,
            icon: Icons.bookmark_border,
            onPress: () {
            },
          ),
          AccountBtnWidget(
            title: 'My Profile'.tr,
            icon: Icons.person,
            onPress: () {
            },
          ),
          Divider(
            thickness: 6,
            color: kOrdinaryColor.withOpacity(.1),
          ),
          AccountBtnWidget(
            title: LocalizationService().getCurrentLang() == 'Bangla'
                ? 'Bangla'.tr
                : 'English',
            icon: Icons.language,
            onPress: () {
              if (LocalizationService().getCurrentLang() == 'Bangla') {
                LocalizationService().changeLocale('English');
              } else {
                LocalizationService().changeLocale('Bangla');
              }
            },
          ),
          GetBuilder<ThemeController>(
            builder: (themeController) {
              return AccountBtnWidget(
                title: 'Change Theme'.tr,
                icon: themeController.darkTheme
                    ? Icons.light_mode
                    : Icons.dark_mode,
                onPress: () {
                  Get.find<ThemeController>().toggleTheme();
                },
              );
            },
          ),
          Divider(
            thickness: 6,
            color: kOrdinaryColor.withOpacity(.1),
          ),
          Divider(
            thickness: 6,
            color: kOrdinaryColor.withOpacity(.1),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Version'.tr + ' ' + kAppVersion,
              style: kRegularText,
            ),
          ),
        ],
      ),
    );
  }
}
