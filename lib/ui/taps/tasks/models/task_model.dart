import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String name;
  String description;
  DateTime date;
  bool isDone;

  TaskModel({
    this.id = "",
    required this.name,
    required this.description,
    required this.date,
    this.isDone = false,
  });

  // fromJson Constructor
  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          description: json['description'],
          date: (json['date'] as Timestamp).toDate(),
          isDone: json['isDone'],
        );

  // toJson Method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': Timestamp.fromDate(date),
      'isDone': isDone,
    };
  }
}
