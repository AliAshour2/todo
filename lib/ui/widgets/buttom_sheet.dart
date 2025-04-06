import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/common/widgets/custom_elevated_button.dart';
import 'package:todo/common/widgets/custom_text_field.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/ui/taps/tasks/models/task_model.dart';
import 'package:todo/utils/date_time_extension.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sheet Handle
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Header with Animation
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Add New Task",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.add_task_rounded,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 24),

              // Task Name Field with Animation
              ShakeAnimatedContainer(
                child: CustomTextField(
                  hintText: "Task Name",
                  controller: taskNamecontroller,
                  borderRadius: 8,
                  prefixIcon: const Icon(Icons.task_alt_rounded),
                  maxLines: 1,
                  validator: (p0) {
                    if (p0!.isEmpty) return "Task Name is required";
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Task Description Field
              ShakeAnimatedContainer(
                child: CustomTextField(
                  hintText: "Task Description",
                  controller: taskDescriptioncontroller,
                  borderRadius: 8,
                  prefixIcon: const Icon(Icons.description_outlined),
                  maxLines: 4,
                  validator: (p0) {
                    if (p0!.isEmpty) return "Task Description is required";
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Date Picker with Enhanced UI
              ShakeAnimatedContainer(
                child: InkWell(
                  onTap: () => showMyDatePicker(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          selectedDate.formattedDate,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textGrayColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Add Task Button with Animation
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
                text: "Add Task",
                isLoading: isLoading,
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 300))
                  .slideY(
                      begin: 0.5,
                      end: 0,
                      duration: const Duration(milliseconds: 300)),
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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate =
            DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
      });
    }
  }
}

// Custom Animated Container for Form Fields
class ShakeAnimatedContainer extends StatelessWidget {
  final Widget child;

  const ShakeAnimatedContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    ).animate().fadeIn(duration: const Duration(milliseconds: 300)).slideX(
        begin: 0.1, end: 0, duration: const Duration(milliseconds: 300));
  }
}
