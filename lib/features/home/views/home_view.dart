import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../utils/greeting_utils.dart';
import '../widgets/utility_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  StreamController<DateTime> timeStreamController =
      StreamController<DateTime>.broadcast();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (_) {
      timeStreamController.sink.add(DateTime.now());
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GreetingUtils.getGreeting()),
        centerTitle: false,
        actions: [
          StreamBuilder<DateTime>(
            stream: timeStreamController.stream,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == .waiting) {
                return SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  DateFormat(
                    DateFormat.HOUR_MINUTE_SECOND,
                  ).format(asyncSnapshot.data!),
                  style: AppTextStyles.headingMedium,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                style: AppTextStyles.displayLarge,
                children: [
                  const TextSpan(text: 'smart'),
                  TextSpan(
                    text: ' utility.',
                    style: AppTextStyles.displayLarge.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'tools for everyday tasks.',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: 40),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: const [
                UtilityTile(
                  title: 'converter',
                  subtitle: '6 categories',
                  icon: Icons.swap_horiz,
                  route: '/converter_home',
                ),
                UtilityTile(
                  title: 'todo',
                  subtitle: 'with due dates',
                  icon: Icons.check_circle_outline,
                  route: '/todo',
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
