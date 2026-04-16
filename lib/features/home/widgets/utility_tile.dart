import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class UtilityTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  const UtilityTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });

  @override
  State<UtilityTile> createState() => _UtilityTileState();
}

class _UtilityTileState extends State<UtilityTile> {
  bool _isPressed = false;

  void _onTapDown(_) => setState(() => _isPressed = true);
  void _onTapUp(_) => setState(() => _isPressed = false);
  void _onTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () => Navigator.pushNamed(context, widget.route),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: _isPressed
              ? AppColors.activeGradient
              : AppColors.cardGradient,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isPressed ? AppColors.white : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              widget.icon,
              color: _isPressed ? AppColors.black : AppColors.textSecondary,
              size: 40,
            ),
            const Spacer(),
            Text(
              widget.title,
              style: AppTextStyles.categoryTitle.copyWith(
                fontSize: 20,
                color: _isPressed ? AppColors.black : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              style: AppTextStyles.bodySecondary.copyWith(
                color: _isPressed ? AppColors.black : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
