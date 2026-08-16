import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wirid_al_busyro/core/providers/shared_preferences_provider.dart';

part 'preferences_provider.g.dart';

enum ArabicFontSize {
  small(22, 'Kecil'),
  medium(26, 'Sedang'),
  large(30, 'Besar'),
  extraLarge(36, 'Sangat Besar');

  const ArabicFontSize(this.points, this.label);

  final double points;

  /// Indonesian, Title Case — shown directly in the font-size menu.
  final String label;
}

const _fontSizePrefsKey = 'arabic_font_size';
const _themeModePrefsKey = 'theme_mode';

@riverpod
class ArabicFontSizeNotifier extends _$ArabicFontSizeNotifier {
  @override
  ArabicFontSize build() {
    final stored = ref.watch(
      sharedPreferencesProvider,
    ).getString(_fontSizePrefsKey);
    return ArabicFontSize.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => ArabicFontSize.medium,
    );
  }

  Future<void> setFontSize(ArabicFontSize size) async {
    state = size;
    await ref.read(sharedPreferencesProvider).setString(
      _fontSizePrefsKey,
      size.name,
    );
  }
}

@riverpod
class AppThemeModeNotifier extends _$AppThemeModeNotifier {
  @override
  ThemeMode build() {
    final stored = ref.watch(
      sharedPreferencesProvider,
    ).getString(_themeModePrefsKey);
    return ThemeMode.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(
      _themeModePrefsKey,
      mode.name,
    );
  }
}
