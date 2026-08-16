// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wirid_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(wiridRepository)
final wiridRepositoryProvider = WiridRepositoryProvider._();

final class WiridRepositoryProvider
    extends
        $FunctionalProvider<WiridRepository, WiridRepository, WiridRepository>
    with $Provider<WiridRepository> {
  WiridRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wiridRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wiridRepositoryHash();

  @$internal
  @override
  $ProviderElement<WiridRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WiridRepository create(Ref ref) {
    return wiridRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WiridRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WiridRepository>(value),
    );
  }
}

String _$wiridRepositoryHash() => r'7518091eff1ad571ed54525ab1974b263cb04f82';

@ProviderFor(wiridItems)
final wiridItemsProvider = WiridItemsProvider._();

final class WiridItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WiridItem>>,
          List<WiridItem>,
          FutureOr<List<WiridItem>>
        >
    with $FutureModifier<List<WiridItem>>, $FutureProvider<List<WiridItem>> {
  WiridItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wiridItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wiridItemsHash();

  @$internal
  @override
  $FutureProviderElement<List<WiridItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WiridItem>> create(Ref ref) {
    return wiridItems(ref);
  }
}

String _$wiridItemsHash() => r'660da21c55ba06c901960b45df81b591138f020c';
