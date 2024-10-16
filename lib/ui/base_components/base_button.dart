import 'package:binbear/ui/base_components/base_text.dart';
import 'package:binbear/utils/base_colors.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final double? btnHeight, btnWidth;
  final double? borderRadius, fontSize;
  final double? bottomMargin, topMargin, rightMargin, leftMargin;
  final EdgeInsetsGeometry? padding;
  final Color? btnColor;
  final bool? enableHapticFeedback, hideKeyboard;
  final void Function()? onPressed;
  const BaseButton({super.key, required this.title, this.btnHeight, this.btnWidth, this.btnColor, this.onPressed, this.bottomMargin, this.topMargin, this.rightMargin, this.leftMargin, this.enableHapticFeedback, this.hideKeyboard, this.padding, this.borderRadius, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: rightMargin??0, left: leftMargin??0, top: topMargin??0, bottom: bottomMargin??0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(btnWidth ?? double.infinity, btnHeight ?? 55),
            backgroundColor: btnColor ?? BaseColors.primaryColor,
            foregroundColor: btnColor ?? BaseColors.primaryColor,
            disabledBackgroundColor: btnColor ?? BaseColors.primaryColor,
            disabledForegroundColor: btnColor ?? BaseColors.primaryColor,
            elevation: 0,
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius??14),
            ),
        ),
        onPressed: (){
          if (enableHapticFeedback ?? true) {
            triggerHapticFeedback();
          }
          if (hideKeyboard ?? true) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: AbsorbPointer(
          child: BaseText(
            value: title,
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: fontSize??16.5,
          ),
        ),
      ),
    );
  }
}
