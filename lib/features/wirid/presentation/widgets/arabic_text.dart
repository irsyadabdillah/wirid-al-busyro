import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/providers/preferences_provider.dart';

/// Renders Arabic text with the user's font-size preference. Bundled
/// fonts only — never system fonts, so harakat render consistently
/// across devices. Use [isQuran] for Qur'anic ayat (AmiriQuran has more
/// accurate mushaf-style harakat placement); everything else uses Amiri.
class ArabicText extends ConsumerWidget {
  const ArabicText(
    this.text, {
    super.key,
    this.isQuran = false,
    this.color,
    this.textAlign = TextAlign.right,
  });

  final String text;
  final bool isQuran;
  final Color? color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(arabicFontSizeProvider);

    return Text(
      text,
      textDirection: TextDirection.rtl,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: isQuran ? 'AmiriQuran' : 'Amiri',
        fontSize: fontSize.points,
        height: 2.0,
        color: color,
      ),
    );
  }
}
