import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Counter.dart';

class RiverpodExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: Text('Riverpod Simple Example')),
        body: Row(
          children: [
            ElevatedButton(
              child: Text('-'),
              onPressed: () => ref.read(counterProvider.notifier).decrement(),
            ),
            Text('${ref.watch(counterProvider)}'),
            ElevatedButton(
              child: Text('+'),
              onPressed: () => ref.read(counterProvider.notifier).increment(),
            ),
          ],
        ));
  }
}
