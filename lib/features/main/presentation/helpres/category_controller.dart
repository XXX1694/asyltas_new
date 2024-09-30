import 'package:flutter/cupertino.dart';

class CategoryProduct {
  CategoryProduct({
    required this.name,
    required this.id,
    this.count = 0,
  });

  final String name;
  final String id;
  int count;
}

List<CategoryProduct> categoryProducts = [
  CategoryProduct(name: 'Все', id: '0000'),
  CategoryProduct(name: 'Хрустал 8мм', id: '0001', count: 47),
  CategoryProduct(name: 'Хрустал 6мм', id: '0002', count: 96),
  CategoryProduct(name: 'Хрустал 4мм', id: '0003', count: 67),
  CategoryProduct(name: 'Хрустал 4мм биконус', id: '0004', count: 76),
  CategoryProduct(name: 'Хрустал 2мм', id: '0005', count: 83),
  CategoryProduct(name: 'Хрустал алмаз 4мм', id: '0007', count: 31),
  CategoryProduct(name: 'Поджемчук', id: '0010', count: 16),
  CategoryProduct(name: 'Шашбау', id: '0011', count: 92),
  CategoryProduct(name: 'Страз лента', id: '0013', count: 6),
  CategoryProduct(name: 'Страз на листь', id: '0014', count: 60),
  CategoryProduct(name: 'Расходной материал', id: '0016', count: 68),
  CategoryProduct(name: 'Стразы капля 6х10', id: '0017', count: 24),
  CategoryProduct(name: 'Стразы капля 8х13', id: '0018', count: 22),
  CategoryProduct(name: 'Стразы капля 10х14', id: '0019', count: 23),
  CategoryProduct(name: 'Стразы капля 13х18', id: '0020', count: 25),
  CategoryProduct(name: 'Бусины ежевика', id: '0021', count: 4),
  CategoryProduct(name: 'Стразы клеевые', id: '0022', count: 42),
  CategoryProduct(name: 'Бисер Тайвань ', id: '0023', count: 60),
];

class CategoryController extends ValueNotifier<CategoryProduct> {
  CategoryController() : super(categoryProducts.first);

  void setCategory(CategoryProduct category) {
    value = category;
  }
}
