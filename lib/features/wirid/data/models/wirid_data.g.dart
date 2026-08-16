// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wirid_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WiridData _$WiridDataFromJson(Map<String, dynamic> json) => WiridData(
  schemaVersion: (json['schema_version'] as num).toInt(),
  category: WiridCategory.fromJson(json['category'] as Map<String, dynamic>),
  items: (json['items'] as List<dynamic>)
      .map((e) => WiridItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WiridDataToJson(WiridData instance) => <String, dynamic>{
  'schema_version': instance.schemaVersion,
  'category': instance.category,
  'items': instance.items,
};
