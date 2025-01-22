import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/ui/taps/tasks/models/task_model.dart';

class FirebaseServices {
  static CollectionReference<TaskModel> getTasksCollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromJson(snapshot.data() ?? {}),
            toFirestore: (value, _) => value.toJson(),
          );
  static Future<void> addTask(TaskModel task) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
    DocumentReference<TaskModel> docReference = taskCollection.doc();
    task.id = docReference.id;
    docReference.set(task);
  }

  static deleteTask(TaskModel task) {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
    taskCollection.doc(task.id).delete();
  }

  static Future<List<TaskModel>> getTasks() async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
    QuerySnapshot<TaskModel> tasksQuery = await taskCollection.get();
    return tasksQuery.docs.map((ele) => ele.data()).toList();
  }

  static Future<List<TaskModel>> getTasksByDate(DateTime date) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
    QuerySnapshot<TaskModel> tasksQuery = await taskCollection
        .where('date', isEqualTo: Timestamp.fromDate(date))
        .get();
    return tasksQuery.docs.map((ele) => ele.data()).toList();
  }

  static Future<void> toggleTaskCompletion(TaskModel task) async {
    CollectionReference<TaskModel> taskCollection = getTasksCollection();
    task.isDone = !task.isDone;
    taskCollection.doc(task.id).update(task.toJson());
  }
}
