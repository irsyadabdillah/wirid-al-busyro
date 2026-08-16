import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wirid_al_busyro/features/wirid/data/models/wirid_item.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/providers/counter_provider.dart';

/// Repetition counter (F-04). Renders nothing when the item has no
/// repeatCount. Item 18 (Ya Ghani) shows "Round X/4 — Y/10" via
/// CounterState.isMultiRound; every other item just shows the count.
class CounterWidget extends ConsumerWidget {
  const CounterWidget({super.key, required this.item});

  final WiridItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (item.repeatCount == null) return const SizedBox.shrink();

    final state = ref.watch(counterProvider(item));
    final notifier = ref.read(counterProvider(item).notifier);
    final colorScheme = Theme.of(context).colorScheme;

    final label = state.isComplete
        ? 'Selesai'
        : state.isMultiRound
        ? 'Ronde ${state.round}/${state.totalRounds}  •  ${state.current}/${state.perRound}'
        : '${state.current}';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: state.isComplete ? null : notifier.decrement,
          child: Container(
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: state.isComplete
                  ? colorScheme.primary
                  : colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: state.isComplete
                    ? colorScheme.onPrimary
                    : colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ),
        TextButton(onPressed: notifier.reset, child: const Text('Ulangi')),
      ],
    );
  }
}
