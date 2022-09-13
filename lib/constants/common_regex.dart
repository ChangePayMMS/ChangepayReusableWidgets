class CommonRegex {
  // regex to check if phone start with `+` then followed by 91 and then 10 digits
  // without any space
  static final RegExp phoneRegexIN = RegExp(r'^\+91\d{10}$');
}
