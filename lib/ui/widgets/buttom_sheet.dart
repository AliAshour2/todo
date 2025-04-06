import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/common/widgets/custom_elevated_button.dart';
import 'package:todo/common/widgets/custom_text_field.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/ui/taps/tasks/models/task_model.dart';
import 'package:todo/utils/date_time_extension.dart';

class ButtomSheet extends StatefulWidget {
  const ButtomSheet({super.key});

  @override
  State<ButtomSheet> createState() => _ButtomSheetState();
}

class _ButtomSheetState extends State<ButtomSheet> {
  TextEditingController taskNamecontroller = TextEditingController();
  TextEditingController taskDescriptioncontroller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TasksProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Important to prevent layout issues
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Add New Task",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: "Task Name",
                controller: taskNamecontroller,
                borderRadius: 8,
                maxLines: 1,
                validator: (p0) {
                  if (p0!.isEmpty) return "Task Name is required";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: "Task Description",
                controller: taskDescriptioncontroller,
                borderRadius: 8,
                maxLines: 4,
                validator: (p0) {
                  if (p0!.isEmpty) return "Task Description is required";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => showMyDatePicker(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded,
                          color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        selectedDate.formattedDate,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    TaskModel task = TaskModel(
                      name: taskNamecontroller.text.trim(),
                      description: taskDescriptioncontroller.text.trim(),
                      date: selectedDate,
                    );
                    setState(() => isLoading = true);
                    await provider.addTask(task);
                    if (mounted) Navigator.of(context).pop();
                  }
                },
                text: "Add",
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMyDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate =
            DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
      });
    }
  }
}
