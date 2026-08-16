// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CounterNotifier)
final counterProvider = CounterNotifierFamily._();

final class CounterNotifierProvider
    extends $NotifierProvider<CounterNotifier, CounterState> {
  CounterNotifierProvider._({
    required CounterNotifierFamily super.from,
    required WiridItem super.argument,
  }) : super(
         retry: null,
         name: r'counterProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$counterNotifierHash();

  @override
  String toString() {
    return r'counterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CounterNotifier create() => CounterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CounterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CounterState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CounterNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$counterNotifierHash() => r'f1a2533c9b9ec1afa2dcf0974e93158c12251693';

final class CounterNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CounterNotifier,
          CounterState,
          CounterState,
          CounterState,
          WiridItem
        > {
  CounterNotifierFamily._()
    : super(
        retry: null,
        name: r'counterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CounterNotifierProvider call(WiridItem item) =>
      CounterNotifierProvider._(argument: item, from: this);

  @override
  String toString() => r'counterProvider';
}

abstract class _$CounterNotifier extends $Notifier<CounterState> {
  late final _$args = ref.$arg as WiridItem;
  WiridItem get item => _$args;

  CounterState build(WiridItem item);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CounterState, CounterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CounterState, CounterState>,
              CounterState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
