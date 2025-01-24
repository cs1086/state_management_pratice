import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LoginProvider.dart';

class ProvierLoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Provider Complex Example')),
      body: Consumer<LoginProvider>(builder: (context, provider, _) {
        final state = provider.state;

        return Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  onChanged: provider.updateEmail,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: !state.isEmailValid && state.email.isNotEmpty
                        ? '無效的Email'
                        : null,
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  onChanged: provider.updatePassword,
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
                          ? provider.submit
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
      }),
    );
  }
}
