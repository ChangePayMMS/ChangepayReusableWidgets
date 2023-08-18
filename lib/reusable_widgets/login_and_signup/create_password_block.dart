import 'package:esamudaay_themes/esamudaay_themes.dart';
import 'package:flutter/material.dart';

class CreatePasswordBlock extends StatefulWidget {
  final String enterNameHintText;
  final String createPasswordHintText;
  final String confirmPasswordHintText;
  final void Function(String) submitPassword;
  final void Function(String)? submitName;
  final String submitButtonText;
  final String confirmPasswordErrorText;
  final String? Function(String?) nameValidator;
  final String? Function(String?) createPasswordValidator;

  const CreatePasswordBlock({
    Key? key,
    required this.createPasswordHintText,
    required this.confirmPasswordHintText,
    required this.enterNameHintText,
    required this.submitPassword,
    required this.submitButtonText,
    required this.confirmPasswordErrorText,
    required this.nameValidator,
    required this.createPasswordValidator,
    this.submitName,
  }) : super(key: key);

  @override
  _CreatePasswordBlockState createState() => _CreatePasswordBlockState();
}

class _CreatePasswordBlockState extends State<CreatePasswordBlock> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cofirmPasswordController =
      TextEditingController();

  bool isConfirmPasswordValid = true;

  GlobalKey<FormState> formKey = new GlobalKey();

  @override
  void dispose() {
    passwordController.dispose();
    nameController.dispose();
    cofirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              children: [
                if (widget.submitName != null)
                  TextFormField(
                    controller: nameController,
                    validator: widget.nameValidator,
                    decoration: InputDecoration(
                      hintText: widget.enterNameHintText,
                      hintStyle: EsamudaayTheme.of(context)
                          .textStyles
                          .sectionHeading2
                          .copyWith(
                              color: EsamudaayTheme.of(context)
                                  .colors
                                  .disabledAreaColor),
                      // override the error styling here to match it with custom error text shown for phone number validation error.
                      errorStyle:
                          EsamudaayTheme.of(context).textStyles.body2.copyWith(
                                color: EsamudaayTheme.of(context)
                                    .colors
                                    .secondaryColor,
                              ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              EsamudaayTheme.of(context).colors.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                TextFormField(
                  controller: passwordController,
                  validator: widget.createPasswordValidator,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: widget.createPasswordHintText,
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
                          color:
                              EsamudaayTheme.of(context).colors.secondaryColor,
                        ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: EsamudaayTheme.of(context).colors.secondaryColor,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: cofirmPasswordController,
                  onChanged: (_) {
                    validateConfirmPassword();
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: widget.confirmPasswordHintText,
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
                          color:
                              EsamudaayTheme.of(context).colors.secondaryColor,
                        ),
                    focusedBorder: !isConfirmPasswordValid
                        ? UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: EsamudaayTheme.of(context)
                                  .colors
                                  .secondaryColor,
                            ),
                          )
                        : null,
                    enabledBorder: !isConfirmPasswordValid
                        ? UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: EsamudaayTheme.of(context)
                                  .colors
                                  .secondaryColor,
                            ),
                          )
                        : null,
                    border: !isConfirmPasswordValid
                        ? UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: EsamudaayTheme.of(context)
                                  .colors
                                  .secondaryColor,
                            ),
                          )
                        : null,
                  ),
                ),
                if (!isConfirmPasswordValid) ...[
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.confirmPasswordErrorText,
                      style:
                          EsamudaayTheme.of(context).textStyles.body2.copyWith(
                                color: EsamudaayTheme.of(context)
                                    .colors
                                    .secondaryColor,
                              ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 157.4,
            height: 42,
            child: ElevatedButton(
              //We need to show the cta button in disabled color in case any of the field inputs are invalid.
              style: ElevatedButton.styleFrom(
                foregroundColor: ((formKey.currentState?.validate() ?? true) &&
                        validateConfirmPassword())
                    ? EsamudaayTheme.of(context).colors.primaryColor
                    : EsamudaayTheme.of(context).colors.disabledAreaColor,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                if ((formKey.currentState?.validate() ?? false) &&
                    validateConfirmPassword()) {
                  if (widget.submitName != null) {
                    widget.submitName!(nameController.text);
                  }
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

  bool validateConfirmPassword() {
    final isValid = passwordController.text == cofirmPasswordController.text;
    setState(
      () {
        isConfirmPasswordValid = isValid;
      },
    );
    return isValid;
  }
}
