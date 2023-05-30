import 'package:chat_app/core/const/color_consts.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final VoidCallback onTap;
  final bool? fullSize;
  final double? width;
  final double? height;

  const Button({
    super.key,
    required this.title,
    this.isEnabled = true,
    required this.onTap,
    this.fullSize = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullSize! ? double.infinity : width,
      height: fullSize! ? 60 : height,
      // decoration: BoxDecoration(
      //   gradient: isEnabled
      //       ? const LinearGradient(
      //           colors: [ColorConsts.white, ColorConsts.mainColor])
      //       : const LinearGradient(
      //           colors: [ColorConsts.white, ColorConsts.white]),
      //   borderRadius: BorderRadius.circular(100),
      // ),
      child: Material(
        color: ColorConsts.mainColor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: ColorConsts.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
