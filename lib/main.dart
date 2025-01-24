import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:state_management_pratice/repository/AuthRepository.dart';
import 'package:state_management_pratice/ui/bloc/complex/BlocState.dart';
import 'package:state_management_pratice/ui/cubit/complex/CubitLoginForm.dart';
import 'package:state_management_pratice/ui/cubit/complex/LoginCubit.dart';
import 'package:state_management_pratice/ui/getx/complex/GetXLoginForm.dart';
import 'package:state_management_pratice/ui/provider/complex/LoginProvider.dart';
import 'package:state_management_pratice/ui/provider/complex/ProviderLoginForm.dart';
import 'package:state_management_pratice/ui/riverpod/complex/RiverPodLoginForm.dart';
import 'package:state_management_pratice/ui/riverpod/simple/RiverpodExample.dart';

import 'ui/bloc/complex/BlocLoginForm.dart';
import 'ui/bloc/complex/FormBloc.dart';
import 'ui/bloc/simple/BlocExample.dart';
import 'ui/bloc/simple/CounterBloc.dart';
import 'ui/cubit/simple/CounterCubit.dart';
import 'ui/cubit/simple/CubitExample.dart';
import 'ui/getx/simple/GetXExample.dart';
import 'ui/provider/simple/CountProvider.dart';
import 'ui/provider/simple/ProviderExample.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management Demo',
      home: Column(
        children: [LoginStatusView(), Expanded(child: HomePage())],
      ),
    );
  }
}

class LoginStatusView extends StatelessWidget {
  const LoginStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FormBloc(authRepository: AuthRepository()),
      child: BlocBuilder<FormBloc, LoginFormState>(builder: (context, state) {
        print("state.isSuccess=${state.isSuccess}");
        return Text(state.isSuccess ? "登入" : "登出");
      }),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('State Management Examples List')),
      body: ListView(
        children: [
          ListTile(
            title: Text('[GetX] Simple Example'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => GetXExample()),
            ),
          ),
          ListTile(
            title: Text('[GetX] Complex Example'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => GetXLoginForm()),
            ),
          ),
          ListTile(
            title: Text('[Provider] Simple Example'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => provider.ChangeNotifierProvider(
                        create: (_) => CountProvider(),
                        child: ProviderExample(),
                      )),
            ),
          ),
          ListTile(
            title: Text('[Provider] Complex Example'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => provider.ChangeNotifierProvider(
                        create: (_) => LoginProvider(AuthRepository()),
                        child: ProvierLoginForm(),
                      )),
            ),
          ),
          ListTile(
            title: Text('[Riverpod] Simple Example'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProviderScope(child: RiverpodExample())),
            ),
          ),
          ListTile(
            title: Text('[Riverpod] Complex Example'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProviderScope(child: RiverpadLoginForm())),
            ),
          ),
          ListTile(
            title: Text('[Bloc] Simple Example'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider(
                        create: (_) => CounterBloc(),
                        child: BlocExample(),
                      )),
            ),
          ),
          ListTile(
            title: Text('[Bloc] Complex Example'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider(
                        create: (_) =>
                            FormBloc(authRepository: AuthRepository()),
                        child: (BlocLoginForm()),
                      )),
            ),
          ),
          ListTile(
            title: Text('[Cubit] Simple Example'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider(
                        create: (_) => CounterCubit(),
                        child: CubitExample(),
                      )),
            ),
          ),
          ListTile(
            title: Text('[Cubit] Complex Example'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider(
                        create: (_) => LoginCubit(AuthRepository()),
                        child: CubitLoginForm(),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
