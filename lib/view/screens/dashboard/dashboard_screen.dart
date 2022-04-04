import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mystarter/constants/colors_data.dart';
import 'package:mystarter/constants/images.dart';

import '../../widgets/custom_alert_dialog.dart';
import '../explore/explore_screen.dart';
import '../home/home_screen.dart';
import '../shop/shop_screen.dart';
import 'widgets/bottom_nav_item.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = 'dashboard';
  const DashboardScreen({Key? key, this.index = 0}) : super(key: key);
  final int index;

  @override
  YourPageState createState() => YourPageState();
}

class YourPageState extends State<DashboardScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const ShopScreen(),
  ];
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.index;

    _pageController = PageController(initialPage: widget.index);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (_canExit) {
            return true;
          } else {
            return _onBackPressed();
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomAppBar(
          elevation: 5,
          notchMargin: 5,
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(children: [
              BottomNavItem(
                iconData: Images.home,
                label: "Home".tr,
                isSelected: _pageIndex == 0,
                onTap: () => _setPage(0),
              ),
              BottomNavItem(
                  iconData: Images.explore,
                  label: "Explore".tr,
                  size: 20,
                  isSelected: _pageIndex == 1,
                  onTap: () => _setPage(1)),
              Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: FloatingActionButton(
                  elevation: 5,
                  backgroundColor: Get.isDarkMode ?  kWhiteColor : const Color(0xFF040415),
                  onPressed: () {

                  },
                  child: Icon(
                    Icons.add,
                    color: Get.isDarkMode ?  kBlackColor2 : kWhiteColor,
                  ),
                ),
              ),
              BottomNavItem(
                  iconData: Images.inbox,
                  label: "Inbox".tr,
                  isSelected: _pageIndex == 3,
                  onTap: () => _setPage(3)),
              BottomNavItem(
                  iconData: Images.cart,
                  label: "Shop".tr,
                  isSelected: _pageIndex == 4,
                  onTap: () => _setPage(4)),
            ]),
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController?.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
  Future<bool> _onBackPressed() {
    return CustomAlertDialog()
        .customAlert(
          context: context,
          title: 'Are you sure?',
          body: 'Do you want to exit an app!',
          color: kPrimaryColor,
          onPress: () {
            SystemNavigator.pop();
          },
        )
        .show()
        .then((value) => value as bool);
  }
}
