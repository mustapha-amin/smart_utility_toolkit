import 'package:flutter/material.dart';
import '../../../core/enums/conversion_category.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../utils/greeting_utils.dart';
import '../widgets/category_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: GreetingUtils.getGreeting(),
      showBack: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text('convert', style: AppTextStyles.displayLarge),
          const SizedBox(height: 4),
          Text(
            'anything.',
            style: AppTextStyles.displayLarge.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '6 categories. instant results.',
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: ConversionCategory.values.length,
            itemBuilder: (context, i) =>
                CategoryCard(category: ConversionCategory.values[i]),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
