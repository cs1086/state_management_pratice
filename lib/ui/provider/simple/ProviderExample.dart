import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CountProvider.dart';

class ProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Provider Simple Example')),
        body: Consumer<CountProvider>(
          builder: (context, provider, child) => Row(
            children: [
              ElevatedButton(
                child: Text('-'),
                onPressed: () => provider.decrement(),
              ),
              Text('${provider.count}'),
              ElevatedButton(
                child: Text('+'),
                onPressed: () => provider.increment(),
              ),
            ],
          ),
        ));
  }
}
