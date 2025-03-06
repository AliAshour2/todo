import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/common/remote/firebase_services.dart';
import 'package:todo/ui/taps/tasks/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  Future<List<TaskModel>>? _tasksFuture;

  Future<List<TaskModel>> getTasksByDate() async {
    _tasksFuture ??= _fetchTasks();
    return _tasksFuture!;
  }

  Future<List<TaskModel>> _fetchTasks() async {
    try {
      tasks = await FirebaseServices.getTasksByDate(selectedDate);
      notifyListeners();
      return tasks;
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return [];
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await FirebaseServices.addTask(task);
      // Fetch the updated tasks immediately
      tasks = await FirebaseServices.getTasksByDate(selectedDate);
      _tasksFuture = Future.value(tasks); // Update the cached future
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

  Future<void> deleteTask(TaskModel taskId) async {
    try {
      await FirebaseServices.deleteTask(taskId);
      tasks = await FirebaseServices.getTasksByDate(selectedDate);
      _tasksFuture = Future.value(tasks);
      notifyListeners();

      Fluttertoast.showToast(
          msg: "Card Deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: AppColors.greenColor,
          fontSize: 16.0);
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

  void changeSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    _tasksFuture = _fetchTasks();
    notifyListeners();
  }

  void updateTaskCompletion(TaskModel task) async {
    await FirebaseServices.toggleTaskCompletion(task);
    notifyListeners();
  }
}
