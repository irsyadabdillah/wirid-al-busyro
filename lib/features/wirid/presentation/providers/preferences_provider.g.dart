// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArabicFontSizeNotifier)
final arabicFontSizeProvider = ArabicFontSizeNotifierProvider._();

final class ArabicFontSizeNotifierProvider
    extends $NotifierProvider<ArabicFontSizeNotifier, ArabicFontSize> {
  ArabicFontSizeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'arabicFontSizeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$arabicFontSizeNotifierHash();

  @$internal
  @override
  ArabicFontSizeNotifier create() => ArabicFontSizeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArabicFontSize value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArabicFontSize>(value),
    );
  }
}

String _$arabicFontSizeNotifierHash() =>
    r'bf95d14f7bfc1dac3788e02706f18e33abf1b70e';

abstract class _$ArabicFontSizeNotifier extends $Notifier<ArabicFontSize> {
  ArabicFontSize build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ArabicFontSize, ArabicFontSize>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ArabicFontSize, ArabicFontSize>,
              ArabicFontSize,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AppThemeModeNotifier)
final appThemeModeProvider = AppThemeModeNotifierProvider._();

final class AppThemeModeNotifierProvider
    extends $NotifierProvider<AppThemeModeNotifier, ThemeMode> {
  AppThemeModeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeModeNotifierHash();

  @$internal
  @override
  AppThemeModeNotifier create() => AppThemeModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$appThemeModeNotifierHash() =>
    r'7036164df7d6662f236721fedaa917089ee06fbd';

abstract class _$AppThemeModeNotifier extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
