import 'package:esamudaay_themes/esamudaay_themes.dart';
import 'package:flutter/material.dart';

class CreateAccountLabelButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String labelText;
  final String buttonText;

  const CreateAccountLabelButton(
      {Key? key,
      required this.onTap,
      required this.labelText,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: labelText,
                style: EsamudaayTheme.of(context).textStyles.cardTitleFaded),
            TextSpan(
                text: buttonText,
                style: EsamudaayTheme.of(context).textStyles.cardTitlePrimary)
          ],
        ),
      ),
    );
  }
}
