import 'package:get_it/get_it.dart';

import '../../screens/bloc/todo_bloc.dart';
import '../common.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<LocalDataSource>(const LocalDataSourceImpl());
  locator.registerSingleton<TodoRepository>(
      TodoRepositoryImpl(dataSource: locator()));
  locator.registerSingleton<TodoBloc>(TodoBloc(repository: locator()));
}
