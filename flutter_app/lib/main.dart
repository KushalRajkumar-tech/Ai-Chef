import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'ui/screens/main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.canvasBackground,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const AiChefApp());
}

class AiChefApp extends StatelessWidget {
  const AiChefApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AiChef - Obsidian Gourmet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainShell(),
    );
  }
}
