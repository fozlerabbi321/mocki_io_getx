import 'package:flutter/material.dart';

import '../../../../constants/style_data.dart';

class AccountBtnWidget extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Function? onPress;
  const AccountBtnWidget({
    Key? key,
    this.title,
    this.onPress,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress as void Function(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            icon == null
                ? const SizedBox()
                : Icon(
              icon,
            ),
            icon == null ? const SizedBox() : kWidthBox10,
            Text(
              title ?? '',
              style: kRegularText2,
            )
          ],
        ),
      ),
    );
  }
}