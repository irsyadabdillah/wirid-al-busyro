import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wirid_al_busyro/features/wirid/data/models/wirid_item.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/providers/counter_provider.dart';

WiridItem _item({required String id, int? repeatCount}) => WiridItem(
  id: id,
  order: 1,
  title: 't',
  titleLatin: 't',
  arabic: 'a',
  latin: null,
  translation: null,
  repeatCount: repeatCount,
  source: null,
  faidah: null,
  note: null,
);

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  test('single-round item counts down to complete', () {
    final item = _item(id: 'normal_item', repeatCount: 3);
    final notifier = container.read(counterProvider(item).notifier);

    expect(container.read(counterProvider(item)).current, 3);

    notifier.decrement();
    notifier.decrement();
    expect(container.read(counterProvider(item)).current, 1);
    expect(container.read(counterProvider(item)).isComplete, isFalse);

    notifier.decrement();
    expect(container.read(counterProvider(item)).current, 0);
    expect(container.read(counterProvider(item)).isComplete, isTrue);

    // Further taps on a completed counter are a no-op.
    notifier.decrement();
    expect(container.read(counterProvider(item)).current, 0);
  });

  test('reset returns to the initial target', () {
    final item = _item(id: 'normal_item', repeatCount: 3);
    final notifier = container.read(counterProvider(item).notifier);

    notifier.decrement();
    notifier.decrement();
    notifier.reset();

    expect(container.read(counterProvider(item)).current, 3);
  });

  test('item with null repeatCount starts already at zero', () {
    final item = _item(id: 'no_counter_item');
    final state = container.read(counterProvider(item));

    expect(state.current, 0);
    expect(state.perRound, 0);
  });

  test('ya_ghani_ya_mughni auto-advances through 4 rounds of 10', () {
    final item = _item(id: 'ya_ghani_ya_mughni', repeatCount: 10);
    final notifier = container.read(counterProvider(item).notifier);

    expect(container.read(counterProvider(item)).round, 1);
    expect(container.read(counterProvider(item)).perRound, 10);

    for (var round = 1; round <= 4; round++) {
      for (var tap = 0; tap < 10; tap++) {
        notifier.decrement();
      }
      final state = container.read(counterProvider(item));
      if (round < 4) {
        expect(state.round, round + 1, reason: 'after round $round');
        expect(state.current, 10, reason: 'after round $round');
        expect(state.isComplete, isFalse);
      } else {
        expect(state.isComplete, isTrue, reason: 'after final round');
      }
    }
  });
}
