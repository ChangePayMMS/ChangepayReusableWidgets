import 'package:esamudaay_themes/esamudaay_themes.dart';
import 'package:flutter/material.dart';

class PopupBanner extends StatelessWidget {
  final double height;
  final VoidCallback onTap;
  final VoidCallback onHide;
  final String bannerText;
  final String buttonText;
  const PopupBanner({
    Key? key,
    required this.height,
    required this.onTap,
    required this.onHide,
    required this.bannerText,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: EsamudaayTheme.of(context).colors.backgroundColor,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: kElevationToShadow[8],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  bannerText,
                  style: EsamudaayTheme.of(context).textStyles.body1,
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              TextButton(
                child: Text(
                  buttonText,
                  style: EsamudaayTheme.of(context)
                      .textStyles
                      .buttonText2
                      .copyWith(
                          color: EsamudaayTheme.of(context)
                              .colors
                              .backgroundColor),
                ),
                style: TextButton.styleFrom(
                  backgroundColor:
                      EsamudaayTheme.of(context).colors.secondaryColor,
                ),
                onPressed: onTap,
              ),
              const SizedBox(
                width: 12.0,
              ),
              InkWell(
                onTap: onHide,
                child: const Icon(
                  Icons.close,
                  size: 18.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
