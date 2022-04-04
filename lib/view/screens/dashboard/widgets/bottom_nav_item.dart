import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mystarter/constants/style_data.dart';

class BottomNavItem extends StatelessWidget {
  final String iconData;
  final Function onTap;
  final bool isSelected;
  final String label;
  final double size;

  const BottomNavItem({
    Key? key,
    required this.iconData,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 35,
        icon: Column(
          children: [
            SizedBox(
              width: size,
              height: size,
              child: SvgPicture.asset(
                iconData,
                color:
                isSelected ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
            kHeightBox5,
            Text(
              label,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ),
          ],
        ),
        onPressed: onTap as void Function(),
      ),
    );
  }
}