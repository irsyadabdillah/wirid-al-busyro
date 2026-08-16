import 'package:json_annotation/json_annotation.dart';

part 'wirid_category.g.dart';

@JsonSerializable()
class WiridCategory {
  const WiridCategory({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.compiler,
  });

  factory WiridCategory.fromJson(Map<String, dynamic> json) =>
      _$WiridCategoryFromJson(json);

  final String id;
  final String title;
  final String subtitle;
  final String compiler;

  Map<String, dynamic> toJson() => _$WiridCategoryToJson(this);
}
