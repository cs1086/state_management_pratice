import 'package:flutter/cupertino.dart';

import '../../../repository/AuthRepository.dart';
import 'LoginState.dart';

class LoginProvider extends ChangeNotifier {
  LoginState _state = LoginState();

  LoginState get state => _state;

  final AuthRepository _authRepository;

  LoginProvider(this._authRepository);

  void updateEmail(String email) {
    _state = LoginState(
        email: email,
        password: _state.password,
        isEmailValid: email.contains('@'),
        isPasswordValid: _state.isPasswordValid,
        isSubmitting: _state.isSubmitting,
        isSuccess: _state.isSuccess,
        error: _state.error);
    notifyListeners();
  }

  void updatePassword(String password) {
    _state = LoginState(
        email: _state.email,
        password: password,
        isEmailValid: _state.isEmailValid,
        isPasswordValid: password.length >= 6,
        isSubmitting: _state.isSubmitting,
        isSuccess: _state.isSuccess,
        error: _state.error);
    notifyListeners();
  }

  Future<void> submit() async {
    if (!_state.isEmailValid || !_state.isPasswordValid) return;

    _state = LoginState(
        email: _state.email,
        password: _state.password,
        isEmailValid: _state.isEmailValid,
        isPasswordValid: _state.isPasswordValid,
        isSubmitting: true);
    notifyListeners();

    try {
      await _authRepository.login(_state.email, _state.password);
      _state = LoginState(
          email: _state.email,
          password: _state.password,
          isEmailValid: _state.isEmailValid,
          isPasswordValid: _state.isPasswordValid,
          isSuccess: true);
    } catch (e) {
      _state = LoginState(
          email: _state.email,
          password: _state.password,
          isEmailValid: _state.isEmailValid,
          isPasswordValid: _state.isPasswordValid,
          error: e.toString());
    }
    notifyListeners();
  }
}
