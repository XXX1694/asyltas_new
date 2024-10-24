import 'dart:convert';

import 'package:asyltas_app/core/models/product.dart';
import 'package:asyltas_app/core/services/local_storage.dart';
import 'package:flutter/material.dart';

const String _cartKey = 'asyltas.kz.cart';

class CartProvider with ChangeNotifier {
  CartProvider({required this.localStorage}) {
    _loadCart();
  }

  final LocalStorage localStorage;

  List<ProductModel> _items = [];

  List<ProductModel> get items => _items;

  // Метод для добавления товара в корзину
  bool addItem(ProductModel product) {
    final existingProductIndex = _items.indexWhere(
      (item) => item.id == product.id,
    );

    if (existingProductIndex == -1) {
      // Если товара нет в корзине, добавляем его
      _items.add(product);
      _saveCart();
      notifyListeners();
      return true;
    } else {
      // Если товар уже есть, обновляем его количество
      _items[existingProductIndex].count =
          (_items[existingProductIndex].count ?? 1) + (product.count ?? 1);
      _saveCart();
      notifyListeners();
      return false;
    }
  }

  // Метод для удаления товара из корзины
  void removeItem(ProductModel product) {
    _items.removeWhere((item) => item.id == product.id);
    _saveCart();
    notifyListeners();
  }

  // Метод для очистки корзины
  void clearCart() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }

  // Метод для увеличения количества товара
  void incrementCount(ProductModel product) {
    final existingProductIndex = _items.indexWhere(
      (item) => item.id == product.id,
    );

    if (existingProductIndex != -1) {
      // Увеличиваем количество существующего товара
      _items[existingProductIndex].count =
          (_items[existingProductIndex].count ?? 1) + 1;
      _saveCart();
      notifyListeners();
    } else {
      // Если товара нет, добавляем его с количеством 1
      product.count = 1;
      _items.add(product);
      _saveCart();
      notifyListeners();
    }
  }

  // Метод для уменьшения количества товара
  void decrementCount(ProductModel product) {
    final existingProductIndex = _items.indexWhere(
      (item) => item.id == product.id,
    );

    if (existingProductIndex != -1) {
      int currentCount = _items[existingProductIndex].count ?? 1;
      if (currentCount > 1) {
        // Уменьшаем количество товара
        _items[existingProductIndex].count = currentCount - 1;
      } else {
        // Если количество становится 0, удаляем товар из корзины
        _items.removeAt(existingProductIndex);
      }
      _saveCart();
      notifyListeners();
    }
  }

  // Метод для обновления количества товара
  void updateItem(ProductModel product) {
    final existingProductIndex = _items.indexWhere(
      (item) => item.id == product.id,
    );

    if (existingProductIndex != -1) {
      if (product.count != null && product.count! > 0) {
        // Обновляем количество товара
        _items[existingProductIndex].count = product.count;
      } else {
        // Если количество 0 или меньше, удаляем товар из корзины
        _items.removeAt(existingProductIndex);
      }
      _saveCart();
      notifyListeners();
    } else if (product.count != null && product.count! > 0) {
      // Если товара нет в корзине и количество положительное, добавляем его
      _items.add(product);
      _saveCart();
      notifyListeners();
    }
  }

  int get totalItems => _items.length;

  int get totalPrice {
    return _items.fold(0, (sum, item) {
      int count = item.count ?? 1;
      num price = item.price ?? 0;

      // Применение скидок в зависимости от количества
      if (count >= 20) {
        price *= 0.8; // Скидка 20%
      } else if (count >= 10) {
        price *= 0.9; // Скидка 10%
      }

      return sum + (price * count).toInt();
    });
  }

  Future<void> _loadCart() async {
    await localStorage.init();
    final cartData = localStorage.getString(_cartKey);
    if (cartData != null) {
      final List<dynamic> jsonList = json.decode(cartData);
      _items = jsonList.map((json) => ProductModel.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveCart() async {
    final jsonList = _items.map((item) => item.toJson()).toList();
    final cartData = json.encode(jsonList);
    localStorage.putString(_cartKey, cartData);
  }
}
