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
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<List<TaskModel>> getTasksByDate() async {
    setLoading(true);
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
    } finally {
      setLoading(false);
    }
  }

  Future<List<TaskModel>> _fetchTasks() async {
    setLoading(true);
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
    } finally {
      setLoading(false);
    }
  }

  Future<void> addTask(TaskModel task) async {
    setLoading(true);
    try {
      await FirebaseServices.addTask(task);
      // Fetch the updated tasks immediately
      tasks = await FirebaseServices.getTasksByDate(selectedDate);
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
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteTask(TaskModel taskId) async {
    setLoading(true);
    try {
      await FirebaseServices.deleteTask(taskId);
      tasks = await FirebaseServices.getTasksByDate(selectedDate);
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
    } finally {
      setLoading(false);
    }
  }

  void changeSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    getTasksByDate();
  }

  void updateTaskCompletion(TaskModel task) async {
    try {
      task.isDone = !task.isDone;
      await FirebaseServices.toggleTaskCompletion(task);
      
      // Update task in the local list
      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = task;
        notifyListeners();
      }
    } catch (e) {
      // If error occurs, revert the change
      task.isDone = !task.isDone;
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }
}
