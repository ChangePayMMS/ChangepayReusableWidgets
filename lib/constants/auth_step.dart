enum AuthStep {
  ///  This indicates that the auth process hasn't been initiated yet or the previous
  ///  one completed successfully. This state is also used for conditional checking
  ///  in the login/sign-up related actions, for doing required cleanups, navigating
  ///  to the correct page.
  ///  This is also the default/initial value
  initialStep,

  /// This state indicates user is on login with pasword step.
  ///
  loginWithPasswordStep,

  /// This state indicated that user is on the OTP verification step and post this
  /// they'd have successfully authenticated
  loginWithOTPStep,

  /// This state indicates user is on signup with pasword step.
  signupWithPasswordStep
}