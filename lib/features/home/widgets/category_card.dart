import 'package:flutter/material.dart';
import '../../../core/enums/conversion_category.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';

class CategoryCard extends StatefulWidget {
  final ConversionCategory category;
  const CategoryCard({super.key, required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        Navigator.pushNamed(context, '/converter', arguments: widget.category);
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          border: Border.all(
            color: _pressed ? AppColors.white : AppColors.border,
            width: _pressed ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  widget.category.icon,
                  size: 40,
                  color: AppColors.textSecondary,
                ),
                const Icon(
                  Icons.arrow_outward_rounded,
                  size: 14,
                  color: AppColors.textMuted,
                ),
              ],
            ),
            const Spacer(),
            Text(
              widget.category.label,
              style: AppTextStyles.categoryTitle.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(
              widget.category.units.take(3).join(' · '),
              style: AppTextStyles.label.copyWith(
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
