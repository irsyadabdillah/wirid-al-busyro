// Not a real test — a one-off generator run via `flutter test` so it can
// use Flutter's rendering pipeline (RepaintBoundary -> PNG) to produce
// app icon assets without any external design tool. Reuses the exact
// same gradient/font/text as the splash screen so the icon and splash
// read as one system. Re-run after any visual tweak here, then
// `dart run flutter_launcher_icons` to regenerate platform icons.
//
// Produces three images:
//  - app_icon.png            flat (gradient+glyph baked in) — iOS/legacy
//  - app_icon_foreground.png transparent bg, glyph only, safe-zone
//                            padded to 66% — Android adaptive foreground
//  - app_icon_background.png pure gradient, no glyph — Android adaptive
//                            background
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wirid_al_busyro/core/constants/app_colors.dart';

const _iconSize = 1024.0;
const _gradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.greenDark, AppColors.green],
);

Future<Uint8List> _render(WidgetTester tester, Widget child) async {
  final boundaryKey = GlobalKey();
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.rtl,
      child: RepaintBoundary(
        key: boundaryKey,
        child: SizedBox(width: _iconSize, height: _iconSize, child: child),
      ),
    ),
  );
  await tester.pumpAndSettle();

  final boundary =
      boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  return (await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 1);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }))!;
}

void _write(String path, Uint8List bytes) {
  final file = File(path)..parent.createSync(recursive: true);
  file.writeAsBytesSync(bytes);
  // ignore: avoid_print
  print('Wrote $path (${bytes.length} bytes)');
}

void main() {
  testWidgets('generate app icon assets', (tester) async {
    // flutter test doesn't load custom fonts by default — without this,
    // Amiri glyphs render as "tofu" placeholder boxes instead of text.
    final fontLoader = FontLoader('Amiri')
      ..addFont(rootBundle.load('assets/fonts/Amiri-Regular.ttf'));
    await fontLoader.load();

    tester.view.physicalSize = const Size(_iconSize, _iconSize);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    const wordmark = Text(
      'البُشْرَى',
      style: TextStyle(fontFamily: 'Amiri', fontSize: 340, color: Colors.white),
    );

    _write(
      'assets/icon/app_icon.png',
      await _render(
        tester,
        const DecoratedBox(
          decoration: BoxDecoration(gradient: _gradient),
          child: Center(child: wordmark),
        ),
      ),
    );

    _write(
      'assets/icon/app_icon_background.png',
      await _render(
        tester,
        const DecoratedBox(decoration: BoxDecoration(gradient: _gradient)),
      ),
    );

    _write(
      'assets/icon/app_icon_foreground.png',
      // Android's adaptive-icon mask can clip up to ~33% off each edge,
      // so the glyph is scaled down and kept within the center safe zone.
      await _render(
        tester,
        const Center(
          child: FractionallySizedBox(
            widthFactor: 0.62,
            heightFactor: 0.62,
            child: FittedBox(child: wordmark),
          ),
        ),
      ),
    );
  });
}
