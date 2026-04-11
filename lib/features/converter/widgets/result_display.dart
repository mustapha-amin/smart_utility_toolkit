import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/extensions/num_extensions.dart';
import '../../../core/constants/app_constants.dart';

class ResultDisplay extends StatelessWidget {
  final double? result;
  final String unit;
  final bool hasInput;

  const ResultDisplay({
    super.key,
    required this.result,
    required this.unit,
    required this.hasInput,
  });

  @override
  Widget build(BuildContext context) {
    final resultStr = result?.toSmartString() ?? '—';
    final showCopy = result != null && hasInput;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: hasInput ? AppColors.resultGradient : null,
        color: hasInput ? null : AppColors.black,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(
          color: hasInput
              ? AppColors.border
              : AppColors.border.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('RESULT', style: AppTextStyles.label),
              if (showCopy)
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: resultStr));
                    context.showSnack('copied to clipboard');
                  },
                  child: Text(
                    'copy',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              resultStr,
              style: AppTextStyles.resultDisplay.copyWith(
                color: hasInput ? AppColors.white : AppColors.textMuted,
              ),
            ),
          ),
          if (result != null && hasInput) ...[
            const SizedBox(height: 4),
            Text(unit, style: AppTextStyles.bodySecondary),
          ],
        ],
      ),
    );
  }
}
