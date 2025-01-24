import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CounterBloc.dart';

class BlocExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Bloc Simple Example')),
        body: BlocBuilder<CounterBloc, int>(
          builder: (context, count) => Row(
            children: [
              ElevatedButton(
                child: Text('-'),
                onPressed: () =>
                    context.read<CounterBloc>().add(DecrementEvent()),
              ),
              Text('$count'),
              ElevatedButton(
                child: Text('+'),
                onPressed: () =>
                    context.read<CounterBloc>().add(IncrementEvent()),
              ),
            ],
          ),
        ));
  }
}
