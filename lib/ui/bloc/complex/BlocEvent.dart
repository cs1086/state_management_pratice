abstract class FormEvent {}

class EmailChanged extends FormEvent {
  final String email;

  EmailChanged(this.email);
}

class PasswordChanged extends FormEvent {
  final String password;

  PasswordChanged(this.password);
}

class FormSubmitted extends FormEvent {}
