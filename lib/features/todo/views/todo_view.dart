import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../controller/todo_provider.dart';
import '../widgets/add_todo_sheet.dart';
import '../widgets/todo_item.dart';
import '../widgets/empty_state.dart';

class TodoView extends ConsumerWidget {
  const TodoView({super.key});

  void _showAddSheet(
    BuildContext context,
    WidgetRef ref, {
    String? id,
    String? content,
    DateTime? dueDate,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => AddTodoSheet(
        initialContent: content,
        initialDueDate: dueDate,
        onSubmit: (value, newDueDate) {
          if (id == null) {
            ref.read(todoProvider.notifier).addTodo(value, dueDate: newDueDate);
          } else {
            ref
                .read(todoProvider.notifier)
                .updateTodo(id, value, dueDate: newDueDate);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodosProvider);
    final currentFilter = ref.watch(todoFilterProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Todo")),

      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<TodoFilter>(
                segments: const [
                  ButtonSegment(
                    value: TodoFilter.pending,
                    label: Text('pending'),
                  ),
                  ButtonSegment(
                    value: TodoFilter.completed,
                    label: Text('completed'),
                  ),
                  ButtonSegment(
                    value: TodoFilter.overdue,
                    label: Text('overdue'),
                  ),
                ],
                selected: {currentFilter},
                onSelectionChanged: (selection) {
                  ref.read(todoFilterProvider.notifier).state = selection.first;
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.white;
                    }
                    return AppColors.surface;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.black;
                    }
                    return AppColors.textSecondary;
                  }),
                  side: WidgetStateProperty.all(
                    BorderSide(color: AppColors.border),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Stack(
              children: [
                if (todos.isEmpty)
                  EmptyState(
                    message: switch (currentFilter) {
                      TodoFilter.pending => 'no pending todos',
                      TodoFilter.completed => 'no completed todos',
                      TodoFilter.overdue => 'no overdue todos',
                    },
                  )
                else
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    itemCount: todos.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return TodoItem(
                        todo: todo,
                        onToggle: () => ref
                            .read(todoProvider.notifier)
                            .toggleComplete(todo.id),
                        onEdit: () => _showAddSheet(
                          context,
                          ref,
                          id: todo.id,
                          content: todo.content,
                          dueDate: todo.dueDate,
                        ),
                        onDelete: () =>
                            ref.read(todoProvider.notifier).deleteTodo(todo.id),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context, ref),
        child: Icon(Icons.add, color: AppColors.black, size: 24),
      ),
    );
  }
}
