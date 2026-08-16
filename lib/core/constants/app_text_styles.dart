import 'package:flutter/material.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/providers/preferences_provider.dart';

/// PRD §8 — translation text is 80% of the Arabic font size, 60%
/// opacity: subordinate to the Arabic but still readable.
abstract final class AppTextStyles {
  static TextStyle translation(BuildContext context, ArabicFontSize fontSize) {
    final base = Theme.of(context).textTheme.bodyLarge;
    return (base ?? const TextStyle()).copyWith(
      fontSize: fontSize.points * 0.8,
      color: (base?.color ?? Colors.black).withValues(alpha: 0.6),
    );
  }
}
