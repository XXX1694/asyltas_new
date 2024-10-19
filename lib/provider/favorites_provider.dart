import 'dart:convert';
import 'package:asyltas_app/core/models/product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  List<ProductModel> _items = [];

  List<ProductModel> get items => _items;

  FavoritesProvider() {
    _loadCart();
  }

  bool addItem(ProductModel product) {
    // Check if the item already exists in the cart
    final existingProductIndex = _items.indexWhere(
      (item) => item.id == product.id,
    );

    if (existingProductIndex == -1) {
      // If the product does not exist in the cart, add it
      _items.add(product);
      _saveCart();
      notifyListeners();
      return true;
    } else {
      // If the product already exists, update its count
      _items[existingProductIndex].count =
          (_items[existingProductIndex].count ?? 1) + (product.count ?? 1);
      _saveCart();
      notifyListeners();
      return false;
    }
  }

  void removeItem(ProductModel product) {
    _items.removeWhere((item) => item.id == product.id);
    _saveCart();
    notifyListeners();
  }

  void incrementCount(ProductModel product) {
    final existingProduct = _items.firstWhere(
      (item) => item.id == product.id,
      orElse: () => ProductModel(
        product.id,
        product.name,
        product.images,
        product.category_id,
        product.category_name,
        product.description,
        product.numberLeft,
        product.price,
        1, // Default count to 1 if creating a new item
        product.itemLeft,
      ),
    );

    if (existingProduct.id != null) {
      existingProduct.count = (existingProduct.count ?? 1) + 1;
      _saveCart();
      notifyListeners();
    }
  }

  void decrementCount(ProductModel product) {
    final existingProduct = _items.firstWhere(
      (item) => item.id == product.id,
      orElse: () => ProductModel(
        product.id,
        product.name,
        product.images,
        product.category_id,
        product.category_name,
        product.description,
        product.numberLeft,
        product.price,
        1, // Default count to 1 if creating a new item
        product.itemLeft,
      ),
    );

    if (existingProduct.id != null) {
      if ((existingProduct.count ?? 1) > 1) {
        existingProduct.count = (existingProduct.count ?? 1) - 1;
      } else {
        _items.removeWhere((item) => item.id == product.id);
      }
      _saveCart();
      notifyListeners();
    }
  }

  int get totalItems => _items.length;

  int get totalPrice {
    return _items.fold(
        0, (sum, item) => sum + (item.price ?? 0) * (item.count ?? 1));
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('favorites');
    if (cartData != null) {
      final List<dynamic> jsonList = json.decode(cartData);
      _items = jsonList.map((json) => ProductModel.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _items.map((item) => item.toJson()).toList();
    final cartData = json.encode(jsonList);
    prefs.setString('favorites', cartData);
  }
}
