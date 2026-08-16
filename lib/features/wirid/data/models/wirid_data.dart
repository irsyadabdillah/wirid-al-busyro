import 'package:json_annotation/json_annotation.dart';
import 'package:wirid_al_busyro/features/wirid/data/models/wirid_category.dart';
import 'package:wirid_al_busyro/features/wirid/data/models/wirid_item.dart';

part 'wirid_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WiridData {
  const WiridData({
    required this.schemaVersion,
    required this.category,
    required this.items,
  });

  factory WiridData.fromJson(Map<String, dynamic> json) =>
      _$WiridDataFromJson(json);

  final int schemaVersion;
  final WiridCategory category;
  final List<WiridItem> items;

  Map<String, dynamic> toJson() => _$WiridDataToJson(this);
}
