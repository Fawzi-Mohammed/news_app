class AppValidators {
  AppValidators._();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? required(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  static String? userName(String? value) {
    return required(value, fieldName: 'user name');
  }

  static String? email(String? value) {
    final String? requiredError = required(value, fieldName: 'your email');
    if (requiredError != null) {
      return requiredError;
    }

    if (!_emailRegExp.hasMatch(value!.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? password(String? value) {
    return required(value, fieldName: 'password');
  }

  static String? confirmPassword(String? value, {required String password}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
