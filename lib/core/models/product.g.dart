// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['id'] as String?,
      json['name'] as String?,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['category_id'] as String?,
      json['category_name'] as String?,
      json['description'] as String?,
      (json['numberLeft'] as num?)?.toInt(),
      (json['price'] as num?)?.toInt(),
      (json['count'] as num?)?.toInt(),
      (json['itemLeft'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'numberLeft': instance.numberLeft,
      'price': instance.price,
      'images': instance.images,
      'description': instance.description,
      'category_name': instance.category_name,
      'category_id': instance.category_id,
      'count': instance.count,
      'itemLeft': instance.itemLeft,
    };
