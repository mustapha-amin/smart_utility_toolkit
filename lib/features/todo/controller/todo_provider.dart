import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import '../model/todo_model.dart';
import '../service/todo_service.dart';

enum TodoFilter { pending, completed, overdue }

final todoBoxProvider = Provider<Box<TodoModel>>((ref) {
  throw UnimplementedError('todoBoxProvider not initialized');
});

final todoServiceProvider = Provider<TodoService>((ref) {
  final box = ref.watch(todoBoxProvider);
  return TodoService(box);
});

final todoProvider = NotifierProvider<TodoNotifier, List<TodoModel>>(
  TodoNotifier.new,
);

final todoFilterProvider = StateProvider<TodoFilter>(
  (ref) => TodoFilter.pending,
);

final filteredTodosProvider = Provider<List<TodoModel>>((ref) {
  final todos = ref.watch(todoProvider);
  final filter = ref.watch(todoFilterProvider);
  final now = DateTime.now();

  return switch (filter) {
    TodoFilter.pending => todos.where((t) => !t.isCompleted).toList(),
    TodoFilter.completed => todos.where((t) => t.isCompleted).toList(),
    TodoFilter.overdue => todos.where((t) {
      if (t.dueDate == null || t.isCompleted) return false;
      return t.dueDate!.isBefore(now);
    }).toList(),
  };
});

class TodoNotifier extends Notifier<List<TodoModel>> {
  late final TodoService _service;

  @override
  List<TodoModel> build() {
    _service = ref.read(todoServiceProvider);
    return _service.getTodos();
  }

  void addTodo(String content, {DateTime? dueDate}) {
    if (content.trim().isEmpty) return;
    _service.addTodo(content.trim(), dueDate: dueDate);
    state = _service.getTodos();
  }

  void updateTodo(String id, String content, {DateTime? dueDate}) {
    if (content.trim().isEmpty) return;
    _service.updateTodo(id, content.trim(), dueDate: dueDate);
    state = _service.getTodos();
  }

  void deleteTodo(String id) {
    _service.deleteTodo(id);
    state = _service.getTodos();
  }

  void toggleComplete(String id) {
    _service.toggleComplete(id);
    state = _service.getTodos();
  }
}
