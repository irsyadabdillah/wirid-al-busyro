import 'package:flutter/services.dart' show rootBundle;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wirid_al_busyro/features/wirid/data/models/wirid_item.dart';
import 'package:wirid_al_busyro/features/wirid/data/wirid_repository.dart';

part 'wirid_provider.g.dart';

@riverpod
WiridRepository wiridRepository(Ref ref) => WiridRepository(rootBundle);

@riverpod
Future<List<WiridItem>> wiridItems(Ref ref) {
  return ref.watch(wiridRepositoryProvider).getWiridItems();
}
