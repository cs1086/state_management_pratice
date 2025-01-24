import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'LoginNotifier.dart';

class RiverpadLoginForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Riverpod Complex Example')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                onChanged: (email) =>
                    ref.read(loginProvider.notifier).emailChanged(email),
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
                    ref.read(loginProvider.notifier).passwordChanged(password),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '密碼',
                  errorText: !state.isPasswordValid && state.password.isNotEmpty
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
                        ? () => ref.read(loginProvider.notifier).submit()
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
      ),
    );
  }
}
