import 'package:esamudaay_themes/esamudaay_themes.dart';
import 'package:flutter/material.dart';

class UpdateSingleTextBlock extends StatefulWidget {
  final String hintText;
  final String initialText;
  final Function(String) submit;
  final String submitButtonText;
  final String? Function(String?) validator;

  const UpdateSingleTextBlock({
    Key? key,
    required this.hintText,
    required this.initialText,
    required this.submit,
    required this.submitButtonText,
    required this.validator,
  }) : super(key: key);

  @override
  _UpdateSingleTextBlockState createState() => _UpdateSingleTextBlockState();
}

class _UpdateSingleTextBlockState extends State<UpdateSingleTextBlock> {
  final TextEditingController textEditingController = TextEditingController();

  GlobalKey<FormState> formKey = new GlobalKey();

  late bool isFormValid;

  @override
  void initState() {
    textEditingController.text = widget.initialText;
    isFormValid = false;
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            onChanged: () {
              setState(() {
                isFormValid = formKey.currentState?.validate() ?? true;
              });
            },
            child: TextFormField(
              controller: textEditingController,
              validator: widget.validator,
              decoration: InputDecoration(
                hintText: widget.hintText,
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
            height: 16,
          ),
          ElevatedButton(
            //We need to show the cta button in disabled color in case any of the field inputs are invalid.
            style: ElevatedButton.styleFrom(
              foregroundColor: isFormValid
                  ? EsamudaayTheme.of(context).colors.primaryColor
                  : EsamudaayTheme.of(context).colors.disabledAreaColor,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14.0),
            ),
            onPressed: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              if (isFormValid) {
                widget.submit(textEditingController.text);
              }
            },
            child: Center(
              child: Text(
                widget.submitButtonText,
                style: EsamudaayTheme.of(context)
                    .textStyles
                    .sectionHeading2
                    .copyWith(
                        color:
                            EsamudaayTheme.of(context).colors.backgroundColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
