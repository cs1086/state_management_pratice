import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/AuthRepository.dart';
import 'LoginState.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginState());

  void emailChanged(String email) {
    emit(state.copyWith(
      email: email,
      isEmailValid: email.contains('@'),
    ));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(
      password: password,
      isPasswordValid: password.length >= 6,
    ));
  }

  Future<void> submit() async {
    if (!state.isEmailValid || !state.isPasswordValid) return;

    emit(state.copyWith(isSubmitting: true));

    try {
      await _authRepository.login(state.email, state.password);
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        error: e.toString(),
      ));
    }
  }
}
