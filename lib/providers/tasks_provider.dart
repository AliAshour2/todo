import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/common/remote/firebase_services.dart';
import 'package:todo/ui/taps/tasks/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<void> getTasksByDate() async {
    try {
      List<TaskModel> allTasks =
          await FirebaseServices.getTasksByDate(selectedDate);
      tasks = allTasks;
      notifyListeners();
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await FirebaseServices.addTask(task).timeout(Duration(seconds: 2),
          onTimeout: () async {
        await getTasksByDate();
      });
      changeSelectedDate(selectedDate);
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    notifyListeners();
  }

  deleteTask(TaskModel taskId) async {
    try {
      await FirebaseServices.deleteTask(taskId).then((value) {
        Fluttertoast.showToast(
            msg: "Card Deleted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: AppColors.greenColor,
            fontSize: 16.0);
      });
      getTasksByDate();
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void changeSelectedDate(DateTime newDate) async {
    selectedDate = newDate;
    await getTasksByDate();
  }

  void updateTaskCompletion(TaskModel task) async {
    await FirebaseServices.toggleTaskCompletion(task);
    notifyListeners();
  }
}
