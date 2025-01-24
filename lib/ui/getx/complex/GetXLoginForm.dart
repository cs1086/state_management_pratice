import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management_pratice/repository/AuthRepository.dart';

import 'LoginController.dart';

class GetXLoginForm extends StatelessWidget {
  final controller = Get.put(LoginController(AuthRepository()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX Complex Example')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Obx(() => Column(
                children: [
                  TextFormField(
                    onChanged: controller.emailChanged,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: !controller.state.value.isEmailValid &&
                              controller.state.value.email.isNotEmpty
                          ? '無效的Email'
                          : null,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    onChanged: controller.passwordChanged,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '密碼',
                      errorText: !controller.state.value.isPasswordValid &&
                              controller.state.value.password.isNotEmpty
                          ? '密碼至少6位'
                          : null,
                    ),
                  ),
                  SizedBox(height: 24),
                  if (controller.state.value.isSubmitting)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: controller.state.value.isEmailValid &&
                              controller.state.value.isPasswordValid
                          ? controller.submit
                          : null,
                      child: Text('登入'),
                    ),
                  if (controller.state.value.error != null)
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        controller.state.value.error!,
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                ],
              )),
        ),
      ),
    );
  }
}
