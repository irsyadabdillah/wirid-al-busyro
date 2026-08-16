import 'package:json_annotation/json_annotation.dart';

part 'wirid_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WiridItem {
  const WiridItem({
    required this.id,
    required this.order,
    required this.title,
    required this.titleLatin,
    required this.arabic,
    required this.latin,
    required this.translation,
    required this.repeatCount,
    required this.source,
    required this.faidah,
    required this.note,
  });

  factory WiridItem.fromJson(Map<String, dynamic> json) =>
      _$WiridItemFromJson(json);

  final String id;
  final int order;
  final String title;
  final String titleLatin;
  final String arabic;
  final String? latin;
  final String? translation;

  /// Times to repeat this item. Null means no counter is shown.
  final int? repeatCount;
  final String? source;
  final String? faidah;
  final String? note;

  Map<String, dynamic> toJson() => _$WiridItemToJson(this);
}
