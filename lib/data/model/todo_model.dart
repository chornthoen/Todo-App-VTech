import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final Timestamp createdAt;
  final String id;
  final bool isCompleted;
  final String title;
  final Timestamp updatedAt;

  TodoModel({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TodoModel.fromMap(Map<String, dynamic> json) {
    return TodoModel(
      createdAt: json['createdAt'] as Timestamp,
      id: json['id'] as String,
      isCompleted: json['isCompleted'] as bool,
      title: json['title'] as String,
      updatedAt: json['updatedAt'] as Timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'id': id,
      'isCompleted': isCompleted,
      'title': title,
      'updatedAt': updatedAt,
    };
  }
}
