import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wirid_al_busyro/features/wirid/data/models/wirid_item.dart';

part 'counter_provider.g.dart';

/// Item 18 (Ya Ghani Ya Mughni) reads 10x per round, 4 rounds total —
/// every other item is a single "round" of its repeatCount.
const _multiRoundItemId = 'ya_ghani_ya_mughni';
const _multiRoundPerRound = 10;
const _multiRoundTotalRounds = 4;

class CounterState {
  const CounterState({
    required this.current,
    required this.round,
    required this.totalRounds,
    required this.perRound,
  });

  /// Remaining taps in the current round.
  final int current;

  /// 1-based current round.
  final int round;
  final int totalRounds;
  final int perRound;

  bool get isMultiRound => totalRounds > 1;

  /// True once the final round has reached zero.
  bool get isComplete => round == totalRounds && current == 0;

  CounterState copyWith({int? current, int? round}) => CounterState(
    current: current ?? this.current,
    round: round ?? this.round,
    totalRounds: totalRounds,
    perRound: perRound,
  );
}

@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  CounterState build(WiridItem item) => _initial(item);

  CounterState _initial(WiridItem source) {
    if (source.id == _multiRoundItemId) {
      return const CounterState(
        current: _multiRoundPerRound,
        round: 1,
        totalRounds: _multiRoundTotalRounds,
        perRound: _multiRoundPerRound,
      );
    }
    final target = source.repeatCount ?? 0;
    return CounterState(
      current: target,
      round: 1,
      totalRounds: 1,
      perRound: target,
    );
  }

  /// Decrements the current round's count. When a non-final round hits
  /// zero it auto-advances to the next round immediately (same tap) —
  /// only the final round's zero is a terminal, no-op state.
  void decrement() {
    if (state.isComplete) return;

    final next = state.current - 1;
    if (next > 0) {
      state = state.copyWith(current: next);
      return;
    }

    if (state.round < state.totalRounds) {
      state = state.copyWith(current: state.perRound, round: state.round + 1);
    } else {
      state = state.copyWith(current: 0);
    }
  }

  void reset() => state = _initial(item);
}
