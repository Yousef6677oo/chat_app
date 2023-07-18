class ValidationUtils {
  static bool isValidateEmail(String email) {
    return !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(email!);
  }

  static bool isValidatePassword(String password) {
    return password!.isEmpty;
  }

  static bool isValidateName(String name) {
    return !RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
        .hasMatch(name);
  }
}
