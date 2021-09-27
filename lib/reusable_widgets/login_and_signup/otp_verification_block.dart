import 'dart:async';

import 'package:esamudaay_themes/esamudaay_themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationBlock extends StatefulWidget {
  final String? phoneNumber;
  final bool otpEntered;
  final Function(String pin) verifyOTP;
  final Function(String pin) updateValidationRequest;
  final Function resendOtpRequest;
  final Function(bool) updateOtpEnterStatus;
  final String resendOtpButtonLabelText;
  final String resendOtpText;
  final String resendSecondsText;
  final String verifyButtonText;
  final String pleaseVerifyOtpToastMsg;

  const OtpVerificationBlock({
    Key? key,
    required this.phoneNumber,
    required this.otpEntered,
    required this.verifyOTP,
    required this.updateValidationRequest,
    required this.resendOtpRequest,
    required this.updateOtpEnterStatus,
    required this.resendOtpButtonLabelText,
    required this.resendOtpText,
    required this.resendSecondsText,
    required this.verifyButtonText,
    required this.pleaseVerifyOtpToastMsg,
  }) : super(key: key);

  @override
  _OtpVerificationBlockState createState() => _OtpVerificationBlockState();
}

class _OtpVerificationBlockState extends State<OtpVerificationBlock> {
  late Timer _timer;
  final _textEditingController = TextEditingController();
  int _start = 30;

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (mounted) {
          setState(
            () {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start = _start - 1;
              }
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
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
          SizedBox(
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 10, top: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Icon(
                      Icons.phone,
                      size: 30,
                      color: EsamudaayTheme.of(context).colors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: PinCodeTextField(
                      animationType: AnimationType.scale,
                      autoFocus: true,
                      keyboardType: TextInputType.number,
                      appContext: context,
                      length: 6,
                      pinTheme: PinTheme(
                          activeColor:
                              EsamudaayTheme.of(context).colors.primaryColor,
                          inactiveColor: EsamudaayTheme.of(context)
                              .colors
                              .disabledAreaColor,
                          shape: PinCodeFieldShape.underline,
                          fieldWidth: 25,
                          fieldHeight: 30),
                      textStyle: EsamudaayTheme.of(context)
                          .textStyles
                          .topTileTitle
                          .copyWith(
                              color: EsamudaayTheme.of(context)
                                  .colors
                                  .primaryColor),
                      onChanged: (pin) {
                        widget.updateOtpEnterStatus(pin.length == 6);
                      },
                      onCompleted: (pin) async {
                        widget.updateOtpEnterStatus(pin.length == 6);

                        widget.updateValidationRequest(pin);
                      },
                      controller: _textEditingController,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: 157.4,
            height: 42,
            child: RaisedButton(
              color: EsamudaayTheme.of(context).colors.primaryColor,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onPressed: widget.otpEntered
                  ? () async {
                      if (widget.otpEntered) {
                        // widget.verifyOTP(pin);
                      } else {
                        Fluttertoast.showToast(
                            msg: widget.pleaseVerifyOtpToastMsg);
                      }
                    }
                  : null,
              child: Center(
                child: Text(
                  widget.verifyButtonText,
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
          const SizedBox(
            height: 14,
          ),
          _start == 0
              ? InkWell(
                  onTap: () {
                    _textEditingController.clear();
                    widget.resendOtpRequest();
                    _start = 30;
                    _startTimer();
                  },
                  child: Text(widget.resendOtpButtonLabelText,
                      style: EsamudaayTheme.of(context)
                          .textStyles
                          .sectionHeading1Regular
                          .copyWith(
                              color: EsamudaayTheme.of(context)
                                  .colors
                                  .primaryColor),
                      textAlign: TextAlign.left),
                )
              : Text(
                  widget.resendOtpText + ' $_start ' + widget.resendSecondsText,
                  style: EsamudaayTheme.of(context)
                      .textStyles
                      .sectionHeading1Regular
                      .copyWith(
                          color: EsamudaayTheme.of(context)
                              .colors
                              .disabledAreaColor),
                  textAlign: TextAlign.left)
        ],
      ),
    );
  }
}
