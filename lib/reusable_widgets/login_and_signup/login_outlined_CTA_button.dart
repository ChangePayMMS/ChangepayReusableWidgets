import 'package:esamudaay_themes/esamudaay_themes.dart';
import 'package:flutter/material.dart';

class LoginOutlineBorderButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonTitle;
  final bool useIntrinsicWidth;

  const LoginOutlineBorderButton(
      {Key? key,
      required this.onTap,
      required this.buttonTitle,
      this.useIntrinsicWidth = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: useIntrinsicWidth ? null : 305,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: EsamudaayTheme.of(context).colors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Padding(
            padding: useIntrinsicWidth
                ? const EdgeInsets.symmetric(horizontal: 20)
                : EdgeInsets.zero,
            child: Text(
              buttonTitle,
              style: EsamudaayTheme.of(context)
                  .textStyles
                  .sectionHeading1Regular
                  .copyWith(color: EsamudaayTheme.of(context).colors.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
