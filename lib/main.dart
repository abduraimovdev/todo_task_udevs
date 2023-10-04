import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'src/common/common.dart';
import 'src/screens/bloc/listener_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = ListenerBlocObserver();
  setupLocator();
  await LocalDataSourceImpl.init();
  runApp(const TodoApp());
}




