import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';

class UnitDropdown extends StatelessWidget {
  final List<String> units;
  final String selected;
  final ValueChanged<String> onChanged;

  const UnitDropdown({
    super.key,
    required this.units,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.inputRadius),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          isExpanded: true,
          dropdownColor: AppColors.elevated,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
            size: 18,
          ),
          style: AppTextStyles.body,
          onChanged: (v) { if (v != null) onChanged(v); },
          items: units
              .map(
                (u) => DropdownMenuItem<String>(
                  value: u,
                  child: Text(u, style: AppTextStyles.body),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
