import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CounterCubit.dart';

class CubitExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Cubit Simple Example')),
        body: BlocBuilder<CounterCubit, int>(
          builder: (context, count) => Row(
            children: [
              ElevatedButton(
                child: Text('-'),
                onPressed: () => context.read<CounterCubit>().decrement(),
              ),
              Text('$count'),
              ElevatedButton(
                child: Text('+'),
                onPressed: () => context.read<CounterCubit>().increment(),
              ),
            ],
          ),
        ));
  }
}
