import 'package:hive_ce/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final DateTime timestamp;

  @HiveField(3)
  final bool isCompleted;

  @HiveField(4)
  final DateTime? dueDate;

  TodoModel({
    required this.id,
    required this.content,
    required this.timestamp,
    this.isCompleted = false,
    this.dueDate,
  });

  TodoModel copyWith({
    String? id,
    String? content,
    DateTime? timestamp,
    bool? isCompleted,
    DateTime? dueDate,
  }) {
    return TodoModel(
      id: id ?? this.id,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
