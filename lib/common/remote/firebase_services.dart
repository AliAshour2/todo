import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/auth/models/user_data_model.dart';
import 'package:todo/ui/taps/tasks/models/task_model.dart';

class FirebaseServices {
  static CollectionReference<TaskModel> getTasksCollection() =>
      getUserCollection()
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromJson(snapshot.data() ?? {}),
            toFirestore: (value, _) => value.toJson(),
          );

  static CollectionReference<UserDataModel> getUserCollection() =>
      FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserDataModel>(
            fromFirestore: (snapshot, _) =>
                UserDataModel.fromJson(snapshot.data() ?? {}),
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
    await taskCollection.doc(task.id).update({'isDone': task.isDone});
  }

  static Future login(String email, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseAuth.instance.currentUser!.uid;
    return getUser();
  }

  static Future<UserDataModel> register(UserDataModel user) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email!, password: user.password!);
    user.id = credential.user?.uid;
    await creatUser(user);
    return user;
  }

  static Future<UserDataModel?> getUser() async {
    DocumentSnapshot<UserDataModel> documentReference =
        await getUserCollection()
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    return documentReference.data();
  }

  static Future<void> creatUser(UserDataModel user) async {
    return await getUserCollection().doc(user.id).set(user);
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
