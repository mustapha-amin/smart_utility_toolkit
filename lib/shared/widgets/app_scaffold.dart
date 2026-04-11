import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showBack;
  final List<Widget>? actions;

  const AppScaffold({
    super.key,
    required this.title,
    required this.child,
    this.showBack = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: AppTextStyles.headingLarge),
        automaticallyImplyLeading: false,
        leading: showBack
            ? GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              )
            : null,
        actions: actions,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.pagePadding,
          ),
          child: child,
        ),
      ),
    );
  }
}
