import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:smart_utility_toolkit/hive_registrar.g.dart';
import 'core/theme/app_theme.dart';
import 'features/home/views/home_view.dart';
import 'features/converter/views/converter_view.dart';
import 'features/converter/views/converter_home_view.dart';
import 'features/todo/views/todo_view.dart';
import 'features/todo/model/todo_model.dart';
import 'features/todo/controller/todo_provider.dart';
import 'core/enums/conversion_category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();
  final todoBox = await Hive.openBox<TodoModel>('todos');

  runApp(
    ProviderScope(
      overrides: [todoBoxProvider.overrideWithValue(todoBox)],
      child: const SmartUtilityApp(),
    ),
  );
}

class SmartUtilityApp extends StatelessWidget {
  const SmartUtilityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Utility Toolkit',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = const HomeView();
          case '/converter_home':
            page = const ConverterHomeView();
          case '/converter':
            final category = settings.arguments as ConversionCategory;
            page = ConverterView(category: category);
          case '/todo':
            page = const TodoView();
          default:
            return null;
        }
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 260),
        );
      },
    );
  }
}
