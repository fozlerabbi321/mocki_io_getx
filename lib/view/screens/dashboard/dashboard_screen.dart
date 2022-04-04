import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mystarter/constants/colors_data.dart';
import 'package:mystarter/constants/images.dart';

import '../../widgets/custom_alert_dialog.dart';
import '../home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = 'dashboard';
  const DashboardScreen({Key? key, this.index = 0}) : super(key: key);
  final int? index;

  @override
  YourPageState createState() => YourPageState();
}

class YourPageState extends State<DashboardScreen> {
  var pageController = PageController();
  late int _selectedIndex;
  final List<Widget> _screen = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.index!;

    ///Code Codecanyon Version
    ///Design Image Include 1.0
    ///Design Image hide 1.0
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          return _onBackPressed();
        } else {
          setState(() {
            _selectedIndex = 0;
          });
        }
        return false;
      },
      child: Scaffold(
        body: _screen[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: _onPageChanged,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.home,
                color: _selectedIndex == 0
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Home".tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.category,
                color: _selectedIndex == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Category".tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.review,
                color: _selectedIndex == 2
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Review".tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.cart,
                color: _selectedIndex == 3
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Cart".tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.account,
                color: _selectedIndex == 4
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Account".tr,
            ),
          ],
        ),
      ),
    );
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
