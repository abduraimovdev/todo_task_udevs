import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task_udevs/src/common/core/utils/app_utils.dart';

import '../../common/common.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import 'widgets/calendar/calendar_widget.dart';
import 'widgets/calendar_bottom.dart';
import 'widgets/home_screen_app_bar.dart';
import 'widgets/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, HomeState>(
      listener: (context, state) {
        if(state.status == HomeStatus.successCreatedData) {
          AppUtils.msg(context, "Todo Successfully Created", color: Colors.blue);
        }
        if(state.status == HomeStatus.successDeletedData) {
          AppUtils.msg(context, "Todo Successfully Deleted", color: Colors.blue);
        }
        if(state.status == HomeStatus.successUpdatedData) {
          AppUtils.msg(context, "Todo Successfully Updated", color: Colors.blue);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const HomeScreenAppBar(),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: BlocBuilder<TodoBloc, HomeState>(
                builder: (context, state) {
                  return Calendar(
                    todos: state.todoModel.allTodos,
                  );
                },
              ),
            ),
            CalendarBottom(
              addEvent: () async {
                AppRoute.pushAddEvent(context).whenComplete(() {
                  locator.get<TodoBloc>().add(const GetDataEvent());
                });
              },
            ),
            AppSized.sized(context, height: 0.02),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: BlocBuilder<TodoBloc, HomeState>(
                    buildWhen: (previous, current) {
                      return current.status == HomeStatus.successData;
                    },
                    builder: (context, state) {
                      return ListView.separated(
                        primary: false,
                        itemBuilder: (context, index) {
                          final todo = state.todoModel.todos[index];
                          final Color color =
                          Colors.primaries[todo.priorityColor];
                          return GestureDetector(
                            onTap: () async {
                              AppRoute.pushDetailsEvent(context, todo)
                                  .whenComplete(() {
                                locator.get<TodoBloc>().add(
                                    const GetDataEvent());
                              });
                            },
                            child: TodoTile(
                              eventName: todo.eventName,
                              eventTitle: todo.eventTitle,
                              color: color.withOpacity(0.8),
                              eventTime:
                              "${todo.time.startTime.toHM()} - ${todo.time
                                  .finishTime.toHM()}",
                              eventLocation: todo.eventLocation,
                              textColor: color,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                        itemCount: state.todoModel.todos.length,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
