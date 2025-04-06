import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/ui/taps/tasks/models/task_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDone = widget.taskModel.isDone;

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      dismissThresholds: const {DismissDirection.endToStart: 0.2},
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            color: AppColors.redColor, borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.delete_outline_rounded,
            color: Colors.white, size: 28),
      ),
      onDismissed: (direction) {
        Provider.of<TasksProvider>(context, listen: false)
            .deleteTask(widget.taskModel);
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    )
                  ],
            border: isDone
                ? Border.all(
                    color: AppColors.greenColor.withOpacity(0.5), width: 1)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Task status checkbox
                    InkWell(
                      onTap: () {
                        Provider.of<TasksProvider>(context, listen: false)
                            .updateTaskCompletion(widget.taskModel);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isDone
                              ? AppColors.greenColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isDone
                                ? AppColors.greenColor
                                : AppColors.textGrayColor,
                            width: 2,
                          ),
                        ),
                        child: isDone
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : null,
                      ),
                    ).animate().scale(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        ),

                    const SizedBox(width: 12),

                    // Task name with strike-through if completed
                    Expanded(
                      child: Text(
                        widget.taskModel.name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  decoration: isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: isDone
                                      ? AppColors.textGrayColor
                                      : Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.color,
                                  fontWeight: FontWeight.bold,
                                ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Priority indicator
                    Container(
                      width: 8,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Task description
                Text(
                  widget.taskModel.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textGrayColor,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 16),

                // Task metadata
                Row(
                  children: [
                    // Date and time
                    Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.textGrayColor,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('dd MMM yyyy').format(widget.taskModel.date),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textGrayColor,
                          ),
                    ),

                    const SizedBox(width: 16),

                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDone
                            ? AppColors.lightGreenColor
                            : AppColors.lightRedColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isDone ? "Completed" : "Pending",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isDone
                                  ? AppColors.greenColor
                                  : AppColors.redColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
