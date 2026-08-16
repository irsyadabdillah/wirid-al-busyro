// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wirid_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WiridCategory _$WiridCategoryFromJson(Map<String, dynamic> json) =>
    WiridCategory(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      compiler: json['compiler'] as String,
    );

Map<String, dynamic> _$WiridCategoryToJson(WiridCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'compiler': instance.compiler,
    };
