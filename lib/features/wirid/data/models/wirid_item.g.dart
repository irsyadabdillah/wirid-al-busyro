// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wirid_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WiridItem _$WiridItemFromJson(Map<String, dynamic> json) => WiridItem(
  id: json['id'] as String,
  order: (json['order'] as num).toInt(),
  title: json['title'] as String,
  titleLatin: json['title_latin'] as String,
  arabic: json['arabic'] as String,
  latin: json['latin'] as String?,
  translation: json['translation'] as String?,
  repeatCount: (json['repeat_count'] as num?)?.toInt(),
  source: json['source'] as String?,
  faidah: json['faidah'] as String?,
  note: json['note'] as String?,
);

Map<String, dynamic> _$WiridItemToJson(WiridItem instance) => <String, dynamic>{
  'id': instance.id,
  'order': instance.order,
  'title': instance.title,
  'title_latin': instance.titleLatin,
  'arabic': instance.arabic,
  'latin': instance.latin,
  'translation': instance.translation,
  'repeat_count': instance.repeatCount,
  'source': instance.source,
  'faidah': instance.faidah,
  'note': instance.note,
};
