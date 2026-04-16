import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../model/todo_model.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  String get _formattedDate {
    return DateFormat('MMM d, yyyy · HH:mm').format(todo.timestamp);
  }

  String? get _formattedDueDate {
    if (todo.dueDate == null) return null;
    return DateFormat('MMM d, yyyy').format(todo.dueDate!);
  }

  bool get _isOverdue {
    if (todo.dueDate == null || todo.isCompleted) return false;
    return todo.dueDate!.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: onToggle,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  gradient: todo.isCompleted ? AppColors.activeGradient : null,
                  color: todo.isCompleted ? null : AppColors.inputFill,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: todo.isCompleted
                        ? AppColors.white
                        : AppColors.border,
                  ),
                ),
                child: todo.isCompleted
                    ? Icon(Icons.check, size: 16, color: AppColors.black)
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.content,
                    style: AppTextStyles.body.copyWith(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      color: todo.isCompleted
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formattedDate,
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                  ),
                  if (_formattedDueDate != null) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.event,
                          size: 12,
                          color: _isOverdue
                              ? AppColors.white
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'due $_formattedDueDate',
                          style: AppTextStyles.bodySecondary.copyWith(
                            fontSize: 12,
                            color: _isOverdue
                                ? AppColors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.cardRadius,
                      ),
                      side: BorderSide(color: AppColors.border),
                    ),
                    title: Text(
                      'Delete todo?',
                      style: AppTextStyles.headingLarge,
                    ),
                    content: Text(
                      '"${todo.content.length > 30 ? '${todo.content.substring(0, 30)}...' : todo.content}"',
                      style: AppTextStyles.body,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, false),
                        child: Text(
                          'Cancel',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(dialogContext, true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppColors.activeGradient,
                            borderRadius: BorderRadius.circular(
                              AppConstants.buttonRadius,
                            ),
                            border: Border.all(color: AppColors.white),
                          ),
                          child: Text(
                            'Delete',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                if (confirmed == true) {
                  onDelete();
                }
              },
              icon: Icon(Icons.delete_forever, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
