import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repository/AuthRepository.dart';
import '../../cubit/complex/LoginState.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(AuthRepository());
});

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;

  LoginNotifier(this._authRepository) : super(LoginState());

  void emailChanged(String email) {
    state = state.copyWith(
      email: email,
      isEmailValid: email.contains('@'),
    );
  }

  void passwordChanged(String password) {
    state = state.copyWith(
      password: password,
      isPasswordValid: password.length >= 6,
    );
  }

  Future<void> submit() async {
    if (!state.isEmailValid || !state.isPasswordValid) return;

    state = state.copyWith(isSubmitting: true);

    try {
      await _authRepository.login(state.email, state.password);
      state = state.copyWith(
        isSubmitting: false,
        isSuccess: true,
      );
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        error: e.toString(),
      );
    }
  }
}
