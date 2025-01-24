class LoginState {
  String email = '';
  String password = '';
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSubmitting = false;
  bool isSuccess = false;
  String? error;
}
