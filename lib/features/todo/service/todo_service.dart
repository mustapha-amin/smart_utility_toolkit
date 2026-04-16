import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';
import '../model/todo_model.dart';

class TodoService {
  final Box<TodoModel> _box;
  final _uuid = const Uuid();

  TodoService(this._box);

  List<TodoModel> getTodos() {
    return _box.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  TodoModel addTodo(String content, {DateTime? dueDate}) {
    final todo = TodoModel(
      id: _uuid.v4(),
      content: content,
      timestamp: DateTime.now(),
      dueDate: dueDate,
    );
    _box.put(todo.id, todo);
    return todo;
  }

  void updateTodo(String id, String content, {DateTime? dueDate}) {
    final existing = _box.get(id);
    if (existing == null) return;

    final updated = existing.copyWith(content: content, dueDate: dueDate);
    _box.put(id, updated);
  }

  void deleteTodo(String id) {
    _box.delete(id);
  }

  TodoModel? toggleComplete(String id) {
    final existing = _box.get(id);
    if (existing == null) return null;

    final updated = existing.copyWith(isCompleted: !existing.isCompleted);
    _box.put(id, updated);
    return updated;
  }
}
