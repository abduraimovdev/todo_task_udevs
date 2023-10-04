
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task_udevs/src/common/core/utils/app_utils.dart';
import '../../common/common.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import 'widgets/app_back_button.dart';
import 'widgets/app_time_picker.dart';
import 'widgets/custom_drop_button.dart';
import 'widgets/custom_field_location.dart';
import 'widgets/custom_text_field.dart';
import '../views/custom_button.dart';
import 'widgets/input_hint_text.dart';

part './mixin/crate_mixin.dart';

class AddEventScreen extends StatefulWidget {
  static const String id = "add_event";

  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> with CreateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: const AppBackButton(),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.88,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 13,
                    right: 13,
                    top: 10,
                    bottom: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // -- Name
                      const InputHintText(
                        label: "Event name",
                      ),
                      AppSized.sized(context, height: 0.005),
                      CustomTextField(
                        controller: eventNameController,
                      ),

                      AppSized.sized(context, height: 0.02),

                      // -- Subtitle
                      const InputHintText(
                        label: "Event title",
                      ),
                      AppSized.sized(context, height: 0.005),
                      CustomTextField(
                        controller: eventTitleController,
                      ),

                      AppSized.sized(context, height: 0.02),

                      // -- Description
                      const InputHintText(
                        label: "Event description",
                      ),
                      AppSized.sized(context, height: 0.005),
                      CustomTextField(
                        line: 4,
                        controller: descriptionController,
                      ),

                      AppSized.sized(context, height: 0.02),

                      // -- Location
                      const InputHintText(
                        label: "Event location",
                      ),
                      AppSized.sized(context, height: 0.005),
                      CustomFieldLocation(
                        controller: eventLocationController,
                      ),

                      AppSized.sized(context, height: 0.02),

                      // -- Color
                      const InputHintText(
                        label: "Priority color",
                      ),
                      AppSized.sized(context, height: 0.01),

                      CustomDropButton(
                        colors: [for (int i = 0; i <= 17; i++) i],
                        onChange: (color) {
                          priorityColorController = color;
                        },
                      ),

                      AppSized.sized(context, height: 0.02),

                      // -- Time
                      const InputHintText(
                        label: "Event time",
                      ),
                      AppSized.sized(context, height: 0.01),

                      BlocBuilder<TodoBloc, HomeState>(
                        buildWhen: (previous, current) {
                          return current.status == HomeStatus.changeTime;
                        },
                        builder: (context, state) {
                          return AppDateTimePicker(
                            startTime: startTime,
                            finishTime: finishTime,
                            startComplete: (TimeOfDay time) {
                              startTime = time;
                              context.read<TodoBloc>().add(CreateChangeStartDateEvent(time: time));
                            },
                            finishComplete: (TimeOfDay time) {
                              finishTime = time;
                              context.read<TodoBloc>().add(CreateChangeFinishDateEvent(time: time));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  width: MediaQuery.sizeOf(context).width * 0.95,
                  height: MediaQuery.sizeOf(context).height * 0.06,
                  onPressed: addEvent,
                  child: Text(
                    "Add",
                    style: Styles.poppins400.copyWith(
                      fontSize: 16,
                      color: AppColors.white,
                    ),
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

