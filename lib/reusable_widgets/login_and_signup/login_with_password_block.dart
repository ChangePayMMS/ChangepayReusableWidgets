import 'package:esamudaay_themes/esamudaay_themes.dart';
import 'package:flutter/material.dart';

class LoginWithPasswordBlock extends StatefulWidget {
  final String enterPasswordHintText;
  final Function(String) submitPassword;
  final String submitButtonText;
  final String? Function(String?) enterPasswordValidator;

  const LoginWithPasswordBlock({
    Key? key,
    required this.enterPasswordHintText,
    required this.submitPassword,
    required this.submitButtonText,
    required this.enterPasswordValidator,
  }) : super(key: key);

  @override
  _LoginWithPasswordBlockState createState() => _LoginWithPasswordBlockState();
}

class _LoginWithPasswordBlockState extends State<LoginWithPasswordBlock> {
  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = new GlobalKey();

  late bool isFormValid;

  @override
  void initState() {
    isFormValid = false;
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 351,
      padding: const EdgeInsets.only(bottom: 12, left: 17, right: 17),
      decoration: BoxDecoration(
        color: EsamudaayTheme.of(context).colors.backgroundColor,
        border:
            Border.all(color: EsamudaayTheme.of(context).colors.primaryColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            onChanged: () {
              setState(() {
                isFormValid = formKey.currentState?.validate() ?? false;
              });
            },
            child: TextFormField(
              controller: passwordController,
              validator: widget.enterPasswordValidator,
              obscureText: true,
              decoration: InputDecoration(
                hintText: widget.enterPasswordHintText,
                hintStyle: EsamudaayTheme.of(context)
                    .textStyles
                    .sectionHeading2
                    .copyWith(
                        color: EsamudaayTheme.of(context)
                            .colors
                            .disabledAreaColor),
                // override the error styling here to match it with custom error text shown for phone number validation error.
                errorStyle: EsamudaayTheme.of(context)
                    .textStyles
                    .body2
                    .copyWith(
                      color: EsamudaayTheme.of(context).colors.secondaryColor,
                    ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: EsamudaayTheme.of(context).colors.secondaryColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 157.4,
            height: 42,
            child: RaisedButton(
              //We need to show the cta button in disabled color in case any of the field inputs are invalid.
              color: isFormValid
                  ? EsamudaayTheme.of(context).colors.primaryColor
                  : EsamudaayTheme.of(context).colors.disabledAreaColor,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                if (isFormValid) {
                  widget.submitPassword(passwordController.text);
                }
              },
              child: Center(
                child: Text(
                  widget.submitButtonText,
                  style: EsamudaayTheme.of(context)
                      .textStyles
                      .cardTitle
                      .copyWith(
                          color: EsamudaayTheme.of(context)
                              .colors
                              .backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
