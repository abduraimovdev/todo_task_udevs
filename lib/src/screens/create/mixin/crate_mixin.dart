part of '../add_event_screen.dart';

mixin CreateMixin on State<AddEventScreen> {
  final TextEditingController eventNameController = TextEditingController();

  final TextEditingController eventTitleController = TextEditingController();

  final TextEditingController eventLocationController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay finishTime = TimeOfDay.now();
  int priorityColorController = 0;
  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();

  void addEvent() {
    if (descriptionController.text.isEmpty) {
      AppUtils.msg(context, "Please Enter Description", color: Colors.red);
      return;
    }
    if (eventNameController.text.isEmpty) {
      AppUtils.msg(context, "Please Enter Name", color: Colors.red);
      return;
    }
    if (eventLocationController.text.isEmpty) {
      AppUtils.msg(context, "Please Enter Location", color: Colors.red);
      return;
    }
    if (eventTitleController.text.isEmpty) {
      AppUtils.msg(context, "Please Enter Title", color: Colors.red);
      return;
    }
    locator.get<TodoBloc>().add(CreateTodoEvent(
          name: eventNameController.text.trim(),
          description: descriptionController.text.trim(),
          location: eventLocationController.text.trim(),
          title: eventTitleController.text.trim(),
          color: priorityColorController,
          reminder: 15,
        ));
    Navigator.pop(context);
  }
}
