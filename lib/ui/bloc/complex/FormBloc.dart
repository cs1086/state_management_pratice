import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/AuthRepository.dart';
import 'BlocEvent.dart';
import 'BlocState.dart';

class FormBloc extends Bloc<FormEvent, LoginFormState> {
  final AuthRepository authRepository;

  FormBloc({required this.authRepository}) : super(LoginFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginFormState> emit) {
    final email = event.email;
    final isEmailValid = email.contains('@');
    emit(state.copyWith(
      email: email,
      isEmailValid: isEmailValid,
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginFormState> emit) {
    final password = event.password;
    final isPasswordValid = password.length >= 6;
    emit(state.copyWith(
      password: password,
      isPasswordValid: isPasswordValid,
    ));
  }

  Future<void> _onSubmitted(
      FormSubmitted event, Emitter<LoginFormState> emit) async {
    if (state.isEmailValid && state.isPasswordValid) {
      emit(state.copyWith(isSubmitting: true));
      try {
        if (authRepository.login(state.email, state.password)) {
          emit(state.copyWith(isSuccess: true));
        }
        emit(state.copyWith(isSuccess: false));
      } catch (error) {
        emit(state.copyWith(error: error.toString()));
      }
      emit(state.copyWith(isSubmitting: false));
    }
  }
}
