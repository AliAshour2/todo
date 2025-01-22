import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/ui/taps/tasks/models/task_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      dismissThresholds: const {DismissDirection.endToStart: 0.2},
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            color: AppColors.redColor, borderRadius: BorderRadius.circular(16)),
        child: Icon(Icons.delete_outline_outlined, color: Colors.white),
      ),
      onDismissed: (direction) {
        Provider.of<TasksProvider>(context, listen: false)
            .deleteTask(widget.taskModel);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 12,
            children: [
              Row(
                children: [
                  Text(widget.taskModel.name,
                      style: Theme.of(context).textTheme.titleSmall),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: widget.taskModel.isDone
                            ? AppColors.lightGreenColor
                            : AppColors.lightRedColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: InkWell(
                      onTap: () {
                        Provider.of<TasksProvider>(context, listen: false)
                            .updateTaskCompletion(widget.taskModel);
                      },
                      child: Text(
                        widget.taskModel.isDone ? "Complete" : "Not Complete ",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: widget.taskModel.isDone
                                ? AppColors.greenColor
                                : AppColors.redColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.star_rate_rounded, color: AppColors.yellowColor)
                ],
              ),
              Row(
                children: [
                  Text(widget.taskModel.description,
                      style: Theme.of(context).textTheme.titleMedium)
                ],
              ),
              Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.access_time,
                    color: AppColors.textGrayColor,
                    size: 18,
                  ),
                  Text("15 OCT 2022",
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text("10:00 AM",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.textBlack)),
                  Spacer(),
                  Transform.rotate(
                      angle: 4.4,
                      child: Icon(Icons.attachment,
                          color: AppColors.textGrayColor))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
