import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/ui/taps/tasks/models/task_model.dart';
import 'package:todo/ui/widgets/task_card.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class ListTap extends StatefulWidget {
  const ListTap({super.key});

  @override
  State<ListTap> createState() => _ListTapState();
}

class _ListTapState extends State<ListTap> {
  List<TaskModel> tasks = [];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TasksProvider>(context);
    return Column(
      spacing: 6,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: EasyInfiniteDateTimeLine(
            firstDate: DateTime(2022),
            focusDate: provider.selectedDate,
            lastDate: DateTime.now().add(Duration(days: 365)),
            activeColor: Colors.white,
            selectionMode: const SelectionMode.autoCenter(),
            dayProps: EasyDayProps(
              todayHighlightStyle: TodayHighlightStyle.withBackground,
              todayHighlightColor: AppColors.textGrayColor,
              dayStructure: DayStructure.dayStrDayNum,
              inactiveDayStyle: DayStyle(
                borderRadius: 12.0,
                decoration: BoxDecoration(color: Colors.transparent),
                dayNumStyle: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              activeDayStyle: const DayStyle(
                borderRadius: 50,
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
                dayStrStyle: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
            ),
            onDateChange: (date) {
              provider.changeSelectedDate(date);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: provider.tasks[index],
              );
            },
            itemCount: provider.tasks.length,
          ),
        ),
      ],
    );
  }
}
