import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BlocEvent.dart';
import 'BlocState.dart';
import 'FormBloc.dart';

class BlocLoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Bloc Complex Example')),
        body: BlocBuilder<FormBloc, LoginFormState>(
          builder: (context, state) {
            return Form(
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (email) =>
                        context.read<FormBloc>().add(EmailChanged(email)),
                    decoration: InputDecoration(
                      errorText: !state.isEmailValid ? '無效的Email' : null,
                    ),
                  ),
                  TextFormField(
                    onChanged: (password) =>
                        context.read<FormBloc>().add(PasswordChanged(password)),
                    decoration: InputDecoration(
                      errorText: !state.isPasswordValid ? '密碼至少6位' : null,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: state.isEmailValid && state.isPasswordValid
                        ? () => context.read<FormBloc>().add(FormSubmitted())
                        : null,
                    child: state.isSubmitting
                        ? CircularProgressIndicator()
                        : Text('登入'),
                  ),
                  if (state.error != null)
                    Text(state.error!, style: TextStyle(color: Colors.red)),
                ],
              ),
            );
          },
        ));
  }
}
