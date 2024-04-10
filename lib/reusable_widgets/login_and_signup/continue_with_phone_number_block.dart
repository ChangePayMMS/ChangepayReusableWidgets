import 'package:esamudaay_themes/esamudaay_themes.dart';
import 'package:esamudaay_widgets/constants/common_regex.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ContinueWithPhoneNumberBlock extends StatefulWidget {
  final Function(String) submitPhoneNumber;
  final String validPhoneErrorMessage;
  final String submitButtonText;
  final String phoneFieldHintText;
  final bool Function(String) isValidPhoneNumber;

  const ContinueWithPhoneNumberBlock({
    Key? key,
    required this.submitPhoneNumber,
    required this.validPhoneErrorMessage,
    required this.submitButtonText,
    required this.phoneFieldHintText,
    required this.isValidPhoneNumber,
  }) : super(key: key);

  @override
  _ContinueWithPhoneNumberBlockState createState() =>
      _ContinueWithPhoneNumberBlockState();
}

class _ContinueWithPhoneNumberBlockState
    extends State<ContinueWithPhoneNumberBlock> {
  final TextEditingController _phoneController = TextEditingController();

  // this formkey wraps the username field and provide default input validation.
  GlobalKey<FormState> _formKey = new GlobalKey();

  FocusNode _focusNode = new FocusNode();

  bool _isPhoneNumberFieldFocused = false;

  // the error styling for validation in intl_phone_number_input field does not meet the UI requirements.
  // so using this variable to create custom input validation for phone number field.
  bool _showPhoneNumberError = false;

  bool _isPhoneNumberValid = false;

  PhoneNumber? _phoneNumber;

  void focusNodeListener() {
    setState(() {
      _isPhoneNumberFieldFocused = _focusNode.hasFocus;
    });
  }

  @override
  void initState() {
    _focusNode.addListener(focusNodeListener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(focusNodeListener);
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 351,
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
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: _isPhoneNumberFieldFocused
                      ? EsamudaayTheme.of(context).colors.primaryColor
                      : EsamudaayTheme.of(context)
                          .colors
                          .disabledAreaColor
                          .withOpacity(0.3)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: InternationalPhoneNumberInput(
              textFieldController: _phoneController,
              focusNode: _focusNode,
              scrollPadding: EdgeInsets.zero,
              selectorConfig: SelectorConfig(
                  showFlags: true, selectorType: PhoneInputSelectorType.DIALOG),
              initialValue: _phoneNumber != null
                  ? PhoneNumber(isoCode: _phoneNumber!.isoCode)
                  : PhoneNumber(isoCode: 'IN'),
              onInputChanged: validatePhoneNumber,
              selectorTextStyle:
                  EsamudaayTheme.of(context).textStyles.sectionHeading2,
              inputDecoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  hintText: widget.phoneFieldHintText,
                  hintStyle: EsamudaayTheme.of(context)
                      .textStyles
                      .sectionHeading2
                      .copyWith(
                          color: EsamudaayTheme.of(context)
                              .colors
                              .disabledAreaColor),
                  labelStyle: EsamudaayTheme.of(context).textStyles.cardTitle),
              spaceBetweenSelectorAndTextField: 0.0,
            ),
          ),
          // show error text if phone number is not valid.
          if (_showPhoneNumberError) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.validPhoneErrorMessage,
                style: EsamudaayTheme.of(context).textStyles.body2.copyWith(
                      color: EsamudaayTheme.of(context).colors.secondaryColor,
                    ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: 157.4,
            height: 42,
            child: ElevatedButton(
              //We need to show the cta button in disabled color in case any of the field inputs are invalid.
              style: ElevatedButton.styleFrom(
                backgroundColor: _isPhoneNumberValid
                    ? EsamudaayTheme.of(context).colors.primaryColor
                    : EsamudaayTheme.of(context).colors.disabledAreaColor,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: _isPhoneNumberValid
                  ? () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      widget.submitPhoneNumber(_phoneNumber?.phoneNumber ?? "");
                    }
                  // in case any field's input valus is invalid, we trigger validity check to display relevant error.
                  : () {
                      _formKey.currentState?.validate();
                      validatePhoneNumber(_phoneNumber);
                      if (!_isPhoneNumberValid) {
                        setState(() {
                          _showPhoneNumberError = true;
                        });
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

  void validatePhoneNumber(PhoneNumber? number) {
    _phoneNumber = number;
    setState(
      () {
        if (CommonRegex.phoneRegexIN
            .hasMatch(_phoneNumber?.phoneNumber ?? '')) {
          this._isPhoneNumberValid = true;
          this._showPhoneNumberError = false;
          return;
        }
        this._isPhoneNumberValid = false;
        this._showPhoneNumberError = true;
        return;
      },
    );
  }
}
