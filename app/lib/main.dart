import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/auth/presentation/role_selection_screen.dart';
import 'core/services/supabase_service.dart';
import 'core/services/local_db_service.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await SupabaseService.init();
  await LocalDatabaseService().init();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            details.exceptionAsString(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  };

  runApp(
    const ProviderScope(
      // ✅ MUST stay
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const RoleSelectionScreen(),
    );
  }
}
