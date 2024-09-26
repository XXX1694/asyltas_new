import 'package:flutter/cupertino.dart';

class CategoryProduct {
  const CategoryProduct({
    required this.name,
    required this.id,
  });

  final String name;
  final String id;
}

const List<CategoryProduct> categoryProducts = [
  CategoryProduct(name: 'Все', id: '0000'),
  CategoryProduct(name: 'Хрустал 8мм', id: '0001'),
  CategoryProduct(name: 'Хрустал 6мм', id: '0002'),
  CategoryProduct(name: 'Хрустал 4мм', id: '0003'),
  CategoryProduct(name: 'Хрустал 2мм', id: '0005'),
  CategoryProduct(name: 'Хрустал алмаз 4мм', id: '0007'),
  CategoryProduct(name: 'Стразы капля 6х10', id: '0017'),
  CategoryProduct(name: 'Стразы капля 8х13', id: '0018'),
  CategoryProduct(name: 'Стразы капля 10х14', id: '0019'),
  CategoryProduct(name: 'Поджемчук', id: '0010'),
  CategoryProduct(name: 'Шашбау', id: '0011'),
  CategoryProduct(name: 'Страз на листь', id: '0014'),
];

class CategoryController extends ValueNotifier<CategoryProduct> {
  CategoryController() : super(categoryProducts.first);

  void setCategory(CategoryProduct category) {
    value = category;
  }
}
