// ignore_for_file: non_constant_identifier_names

// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductModel {
  String? id;
  final String? name;
  final int? numberLeft;
  final int? price;
  final List<String>? images;
  final String? description;
  final String? category_name;
  final String? category_id;
  int? count;
  int? itemLeft;

  ProductModel(
    this.id,
    this.name,
    this.images,
    this.category_id,
    this.category_name,
    this.description,
    this.numberLeft,
    this.price,
    this.count,
    this.itemLeft,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductModel copyWith({
    String? id,
    String? name,
    int? numberLeft,
    int? price,
    List<String>? images,
    String? description,
    String? category_name,
    String? category_id,
    int? count,
    int? itemLeft,
  }) {
    return ProductModel(
      id ?? this.id,
      name ?? this.name,
      images ?? this.images,
      category_id ?? this.category_id,
      category_name ?? this.category_name,
      description ?? this.description,
      numberLeft ?? this.numberLeft,
      price ?? this.price,
      count ?? this.count,
      itemLeft ?? this.itemLeft,
    );
  }
}
