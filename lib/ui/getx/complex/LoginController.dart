import 'package:get/get.dart';

import '../../../repository/AuthRepository.dart';
import 'LoginState.dart';

class LoginController extends GetxController {
  final state = LoginState().obs;
  final AuthRepository _authRepository;

  LoginController(this._authRepository);

  void emailChanged(String email) {
    state.update((s) {
      s?.email = email;
      s?.isEmailValid = email.contains('@');
    });
  }

  void passwordChanged(String password) {
    state.update((s) {
      s?.password = password;
      s?.isPasswordValid = password.length >= 6;
    });
  }

  Future<void> submit() async {
    if (!state.value.isEmailValid || !state.value.isPasswordValid) return;

    state.update((s) {
      s?.isSubmitting = true;
      s?.error = null;
    });

    try {
      await _authRepository.login(state.value.email, state.value.password);
      state.update((s) {
        s?.isSubmitting = false;
        s?.isSuccess = true;
      });
    } catch (e) {
      state.update((s) {
        s?.isSubmitting = false;
        s?.error = e.toString();
      });
    }
  }
}
