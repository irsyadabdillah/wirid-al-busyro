import 'dart:convert';

import 'package:flutter/services.dart' show AssetBundle;
import 'package:wirid_al_busyro/features/wirid/data/models/wirid_data.dart';
import 'package:wirid_al_busyro/features/wirid/data/models/wirid_item.dart';

class WiridRepository {
  WiridRepository(this._bundle);

  final AssetBundle _bundle;

  static const _assetPath = 'assets/data/wirid_items.json';

  /// PRD §7.1: the JSON is ~50KB and parses in well under 50ms, so no
  /// isolate/loading-screen is needed — parsing on the main isolate is
  /// both simpler and, for a payload this small, effectively as fast as
  /// paying isolate-spawn overhead would be.
  Future<List<WiridItem>> getWiridItems() async {
    final raw = await _bundle.loadString(_assetPath);
    final data = WiridData.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    return data.items..sort((a, b) => a.order.compareTo(b.order));
  }
}
