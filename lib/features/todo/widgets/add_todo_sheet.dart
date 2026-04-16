import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit/core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';

class AddTodoSheet extends StatefulWidget {
  final String? initialContent;
  final DateTime? initialDueDate;
  final Function(String, DateTime?) onSubmit;

  const AddTodoSheet({
    super.key,
    this.initialContent,
    this.initialDueDate,
    required this.onSubmit,
  });

  @override
  State<AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _isValid = false;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialContent != null) {
      _controller.text = widget.initialContent!;
      _isValid = widget.initialContent!.trim().isNotEmpty;
    }
    _dueDate = widget.initialDueDate;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {
      _isValid = value.trim().isNotEmpty;
    });
  }

  void _onSubmit() {
    if (!_isValid) return;
    widget.onSubmit(_controller.text.trim(), _dueDate);
    Navigator.pop(context);
  }

  Future<void> _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.white,
              onPrimary: AppColors.black,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.initialContent == null ? 'New todo' : 'Edit todo',
            style: AppTextStyles.headingLarge,
          ),
          const SizedBox(height: 20),
          Container(
            height: AppConstants.inputHeight,
            decoration: BoxDecoration(
              color: AppColors.inputFill,
              borderRadius: BorderRadius.circular(AppConstants.inputRadius),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: _onChanged,
              onSubmitted: (_) => _onSubmit(),
              textCapitalization: .sentences,
              style: AppTextStyles.body,
              decoration: InputDecoration(
                hintText: 'What needs to be done?',
                hintStyle: AppTextStyles.body.copyWith(
                  color: AppColors.textMuted,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _pickDueDate,
            child: Container(
              height: AppConstants.inputHeight,
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(AppConstants.inputRadius),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _dueDate == null
                        ? 'Add due date (optional)'
                        : 'Due: ${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}',
                    style: AppTextStyles.body.copyWith(
                      color: _dueDate == null
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                    ),
                  ),
                  if (_dueDate != null) ...[
                    const Spacer(),
                    GestureDetector(
                      onTap: () => setState(() => _dueDate = null),
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _isValid ? _onSubmit : null,
            child: Container(
              width: double.infinity,
              height: AppConstants.buttonHeight,
              decoration: BoxDecoration(
                gradient: _isValid ? AppColors.activeGradient : null,
                color: _isValid ? null : AppColors.surface,
                borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
                border: Border.all(
                  color: _isValid ? AppColors.white : AppColors.border,
                ),
              ),
              child: Center(
                child: Text(
                  widget.initialContent == null ? 'Add' : 'Save',
                  style: AppTextStyles.body.copyWith(
                    color: _isValid ? AppColors.black : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: context.bottomPadding),
        ],
      ),
    );
  }
}
