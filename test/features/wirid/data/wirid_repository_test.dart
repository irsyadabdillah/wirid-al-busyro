import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wirid_al_busyro/features/wirid/data/wirid_repository.dart';

class _FakeAssetBundle extends CachingAssetBundle {
  _FakeAssetBundle(this._json);

  final String _json;

  @override
  Future<ByteData> load(String key) async {
    final bytes = utf8.encode(_json);
    return ByteData.view(Uint8List.fromList(bytes).buffer);
  }
}

const _sampleJson = '''
{
  "schema_version": 1,
  "category": {
    "id": "wirid_subuh",
    "title": "Wirid Setelah Subuh",
    "subtitle": "Majlis Al-Busyro",
    "compiler": "Prof. Dr. Habib Segaf Baharun"
  },
  "items": [
    {
      "id": "item_b",
      "order": 2,
      "title": "ب",
      "title_latin": "B",
      "arabic": "ب",
      "latin": null,
      "translation": null,
      "repeat_count": null,
      "source": null,
      "faidah": null,
      "note": null
    },
    {
      "id": "item_a",
      "order": 1,
      "title": "ا",
      "title_latin": "A",
      "arabic": "ا",
      "latin": "alif",
      "translation": "the letter A",
      "repeat_count": 3,
      "source": "test",
      "faidah": "test faidah",
      "note": null
    }
  ]
}
''';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('parses items and sorts by order', () async {
    final repository = WiridRepository(_FakeAssetBundle(_sampleJson));

    final items = await repository.getWiridItems();

    expect(items.map((e) => e.id), ['item_a', 'item_b']);
    expect(items.first.repeatCount, 3);
    expect(items.first.translation, 'the letter A');
    expect(items.last.repeatCount, isNull);
  });
}
