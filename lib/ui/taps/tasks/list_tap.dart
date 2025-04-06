import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/ui/taps/tasks/models/task_model.dart';
import 'package:todo/ui/widgets/task_card.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class ListTap extends StatefulWidget {
  const ListTap({super.key});

  @override
  State<ListTap> createState() => _ListTapState();
}

class _ListTapState extends State<ListTap> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  bool _isAnimationReady = false;

  @override
  void initState() {
    super.initState();
    // Initialize task fetch
    Provider.of<TasksProvider>(context, listen: false).getTasksByDate();

    // Delay animation setup to avoid initState issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Setup animations after the first frame
        _animationController = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        );

        _animation = CurvedAnimation(
          parent: _animationController!,
          curve: Curves.easeInOut,
        );

        setState(() {
          _isAnimationReady = true;
        });

        _animationController!.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TasksProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Header section with conditional animation
        _isAnimationReady
            ? FadeTransition(
                opacity: _animation!,
                child: _buildDateHeaderSection(provider, isDark),
              )
            : _buildDateHeaderSection(provider, isDark),

        // Task List Section
        Expanded(
          child: Consumer<TasksProvider>(
            builder: (context, taskProvider, child) {
              if (taskProvider.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 3,
                  ),
                );
              }

              if (taskProvider.tasks.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        size: 80,
                        color: AppColors.primaryColor.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No tasks for ${_getShortDateDisplay(provider.selectedDate)}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap + to add a new task',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                );
              }

              return AnimationLimiter(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: TaskCard(
                            taskModel: taskProvider.tasks[index],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: taskProvider.tasks.length,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Extract date header section to a separate method
  Widget _buildDateHeaderSection(TasksProvider provider, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Current Month & Year Header
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(provider.selectedDate),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
              ),
              Row(
                children: [
                  _buildDateControlButton(
                    icon: Icons.calendar_today_rounded,
                    onTap: () => _showCalendarPicker(context, provider),
                  ),
                  const SizedBox(width: 8),
                  _buildDateControlButton(
                    icon: Icons.today_rounded,
                    onTap: () {
                      provider.changeSelectedDate(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                      ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),

        // Enhanced Date Timeline
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C1C1C) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: EasyInfiniteDateTimeLine(
              firstDate: DateTime(2022),
              focusDate: provider.selectedDate,
              lastDate: DateTime.now().add(const Duration(days: 365)),
              activeColor: AppColors.primaryColor,
              selectionMode: const SelectionMode.autoCenter(),
              timeLineProps: const EasyTimeLineProps(
                hPadding: 16,
                separatorPadding: 16,
              ),
              dayProps: EasyDayProps(
                width: 60,
                height: 80,
                todayHighlightStyle: TodayHighlightStyle.withBackground,
                todayHighlightColor: AppColors.primaryColor.withOpacity(0.1),
                dayStructure: DayStructure.dayStrDayNum,
                inactiveDayStyle: DayStyle(
                  borderRadius: 12.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  dayNumStyle:
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 18.0,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                  dayStrStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12.0,
                        color: isDark ? Colors.grey[500] : Colors.grey[700],
                      ),
                ),
                activeDayStyle: DayStyle(
                  borderRadius: 12,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  dayNumStyle:
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 20.0,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                  dayStrStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13.0,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              onDateChange: (date) {
                provider.changeSelectedDate(date);
              },
            ),
          ),
        ),

        // Today's Date Display
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            _getSelectedDateDisplay(provider.selectedDate),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textGrayColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),

        const Divider(
          height: 32,
          indent: 24,
          endIndent: 24,
        ),
      ],
    );
  }

  Widget _buildDateControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppColors.primaryColor,
          size: 20,
        ),
      ),
    );
  }

  Future<void> _showCalendarPicker(
      BuildContext context, TasksProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).textTheme.bodyLarge!.color!,
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

    if (picked != null) {
      provider.changeSelectedDate(picked);
    }
  }

  String _getSelectedDateDisplay(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final selectedDate = DateTime(date.year, date.month, date.day);

    if (selectedDate == today) {
      return "Today's Tasks";
    } else if (selectedDate == yesterday) {
      return "Yesterday's Tasks";
    } else if (selectedDate == tomorrow) {
      return "Tomorrow's Tasks";
    } else {
      return "Tasks for ${DateFormat('EEEE, MMMM d, y').format(date)}";
    }
  }

  String _getShortDateDisplay(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final selectedDate = DateTime(date.year, date.month, date.day);

    if (selectedDate == today) {
      return "today";
    } else if (selectedDate == yesterday) {
      return "yesterday";
    } else if (selectedDate == tomorrow) {
      return "tomorrow";
    } else {
      return DateFormat('MMM d').format(date);
    }
  }
}
