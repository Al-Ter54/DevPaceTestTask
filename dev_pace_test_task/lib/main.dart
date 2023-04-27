import 'package:dev_pace_test_task/bloc/dev_pace_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'service/service.dart';
import 'widget/home_page.dart';

void main() {
  runApp(MyApp(service: Service(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.service});
  final Service service;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DevPaceBloc>(
      create: (_) => DevPaceBloc(service),
      child: MaterialApp(
        title: 'DevPace Test Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

