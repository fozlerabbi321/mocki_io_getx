import 'package:flutter/material.dart';

import '../../constants/colors_data.dart';

class DefaultBtn extends StatelessWidget {
  final String title;
  final Function? onPress;
  final bool isChange;
  final double radius;
  final double border;
  final Color borderColor;
  final Color textColor;
  final Color btnColor;
  final double? width;
  final TextStyle? textStyle;
  final double height;
  final double textPadding;
  final bool outlineButton;
  const DefaultBtn({
    Key? key,
    required this.title,
    this.width,
    this.textStyle,
    this.height = 40,
    this.textColor = Colors.white,
    this.btnColor = kPrimaryColor,
    this.borderColor = kPrimaryColor,
    this.border = 0,
    this.onPress,
    this.isChange = false,
    this.outlineButton = false,
    this.radius = 30,
    this.textPadding = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: textStyle ??
            Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: outlineButton ? kStUnderLineColor : textColor,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
      ),
      onPressed: onPress as void Function()?,
      style: ElevatedButton.styleFrom(
        primary: btnColor,
        onPrimary: outlineButton ? btnColor : kStUnderLineColor,
        padding: EdgeInsets.symmetric(horizontal: textPadding, vertical: 0),
        elevation: 0.0,
        side: BorderSide(
          width: outlineButton ? 1 : border,
          color: outlineButton
              ? borderColor
              : border == 0
                  ? Colors.transparent
                  : borderColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
