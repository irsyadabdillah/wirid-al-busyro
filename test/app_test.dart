import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirid_al_busyro/core/providers/shared_preferences_provider.dart';
import 'package:wirid_al_busyro/main.dart';

void main() {
  testWidgets('boots app and loads the real wirid list from the bundled asset', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const WiridAlBusyroApp(),
      ),
    );
    await tester.pump();
    expect(find.text('AL-BUSYRO'), findsOneWidget);

    // The splash screen auto-navigates after a real Timer fires — fast
    // forward past it (real Timers are fake-clock-controllable, unlike
    // the file I/O below).
    await tester.pump(const Duration(milliseconds: 2300));

    // Real (non-mocked) asset I/O runs against the actual file system and
    // doesn't resolve inside pumpAndSettle's FakeAsync zone — runAsync
    // escapes into the real event loop so the read can complete.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Wirid Al Busyro'), findsOneWidget);
    expect(find.textContaining('Wirdul Lathif'), findsOneWidget);

    await tester.tap(find.textContaining('Wirdul Lathif'));
    await tester.pumpAndSettle();

    expect(find.text('Wirdul Lathif'), findsOneWidget);
  });
}
