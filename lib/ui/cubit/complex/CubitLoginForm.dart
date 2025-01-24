import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/AuthRepository.dart';
import 'LoginCubit.dart';
import 'LoginState.dart';

class CubitLoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cubit Complex Example')),
      body: BlocProvider(
          create: (_) => LoginCubit(AuthRepository()),
          child: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (email) =>
                          context.read<LoginCubit>().emailChanged(email),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText: !state.isEmailValid && state.email.isNotEmpty
                            ? '無效的Email'
                            : null,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      onChanged: (password) =>
                          context.read<LoginCubit>().passwordChanged(password),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: '密碼',
                        errorText:
                            !state.isPasswordValid && state.password.isNotEmpty
                                ? '密碼至少6位'
                                : null,
                      ),
                    ),
                    SizedBox(height: 24),
                    if (state.isSubmitting)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                          onPressed: state.isEmailValid && state.isPasswordValid
                              ? () => context.read<LoginCubit>().submit()
                              : null,
                          child: Text('登入')),
                    if (state.error != null)
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          state.error!,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                  ],
                ),
              ),
            );
          })),
    );
  }
}
