import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller.dart';

class GetXExample extends StatelessWidget {
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('GetX Simple Example')),
        body: Row(
          children: [
            ElevatedButton(
              child: Text('-'),
              onPressed: () => controller.decrement(),
            ),
            Obx(() => Text('${controller.count}')),
            ElevatedButton(
              child: Text('+'),
              onPressed: () => controller.increment(),
            ),
          ],
        ));
  }
}
