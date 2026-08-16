import 'package:flutter/material.dart';

/// PRD §8 UI Direction — single green accent, warm-white light bg,
/// dark-grey (not pure black) dark bg to avoid thin Arabic strokes
/// vibrating on OLED. No hardcoded hex colors outside this file.
abstract final class AppColors {
  static const green = Color(0xFF2E5339);
  static const lightBackground = Color(0xFFFAFAF7);
  static const darkBackground = Color(0xFF1A1A1A);

  /// Card surfaces need visible contrast against the background above —
  /// pure white / a lighter grey than the page, not a seeded M3 surface
  /// tone (too close to the background to read as "floating").
  static const cardLight = Color(0xFFFFFFFF);
  static const cardDark = Color(0xFF262626);

  /// Darker end of the splash screen's gradient — a deeper shade of
  /// [green], not an unrelated color, to keep the single-accent rule.
  static const greenDark = Color(0xFF17281B);
}
