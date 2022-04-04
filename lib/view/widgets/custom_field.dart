import 'package:flutter/material.dart';

import '../../constants/colors_data.dart';
import '../../constants/style_data.dart';

class CustomField extends StatelessWidget {
  ///input form
  final String? hintText;
  final TextEditingController? fieldController;
  final Function? onSaved;
  final Function? onConfirm;
  final Function? validation;
  final IconData? icon;
  final IconData? prefixIcon;
  final int? maxLines;
  final String? preText;
  final Color? fillColor;
  final double? elevation;
  final double borderWidth;
  final Color? shadowColor;
  final Color borderColor;
  final bool isProtected;
  final bool? isEditable;
  final bool centerText;
  final bool autoFocus;
  final FocusNode? focusNode;
  final TextInputType? keyType;
  final double? height;
  final double radius;
  final bool absorbing;

  const CustomField({
    Key? key,
    this.preText,
    this.prefixIcon,
    this.isEditable,
    this.maxLines,
    this.shadowColor,
    this.elevation,
    this.centerText = false,
    this.validation,
    this.focusNode,
    this.autoFocus = false,
    this.fillColor,
    this.isProtected = false,
    this.hintText,
    this.icon,
    this.fieldController,
    this.keyType,
    this.onSaved,
    this.onConfirm,
    this.height,
    this.borderColor = kStUnderLineColor,
    this.radius = 5,
    this.borderWidth = .3,
    this.absorbing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AbsorbPointer(
        absorbing: absorbing,
        child: TextFormField(
          maxLines: maxLines ?? 1,
          enabled: isEditable,
          validator: validation as String? Function(String?)?,
          controller: fieldController,
          keyboardType: keyType,
          obscureText: isProtected,
          obscuringCharacter: '*',
          onChanged: onSaved as void Function(String)?,
          onFieldSubmitted: onConfirm as void Function(String?)?,
          focusNode: focusNode,
          textAlign: centerText == true ? TextAlign.center : TextAlign.start,
          autofocus: autoFocus,
          cursorColor: kStUnderLineColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide.none,
            ),
            errorStyle: const TextStyle(fontSize: 11, height: 0.3),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide.none),
            prefixText: preText,
            prefixStyle: const TextStyle(
              fontSize: 16,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon!,
                    color: kSecondaryColor.withOpacity(.4),
                    size: 20,
                  )
                : null,
            hintText: hintText,
            hintStyle: kRegularText2.copyWith(
              color: kSecondaryColor.withOpacity(.4),
            ),
            filled: fillColor == null ? false : true,
            fillColor: fillColor ?? Colors.transparent,

            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),

            alignLabelWithHint: false,
            // border: const OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
