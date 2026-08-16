import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirid_al_busyro/core/providers/shared_preferences_provider.dart';
import 'package:wirid_al_busyro/core/router/app_router.dart';
import 'package:wirid_al_busyro/core/theme/app_theme.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/providers/preferences_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const WiridAlBusyroApp(),
    ),
  );
}

class WiridAlBusyroApp extends ConsumerWidget {
  const WiridAlBusyroApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      title: 'Wirid Al-Busyro',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
