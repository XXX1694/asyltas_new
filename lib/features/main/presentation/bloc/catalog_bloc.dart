import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/product.dart';
import '../helpres/category_controller.dart';
import '../helpres/firebase_data_keys.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(const CatalogInitial()) {
    on<LoadCatalog>(_onLoadProducts);
  }

  Future _querySnapshotByCategoryId(String categoryId) {
    return FirebaseFirestore.instance
        .collection(FirebaseDataKeys.products)
        .where(FirebaseDataKeys.categoryId, isEqualTo: categoryId)
        .get();
  }

  Future _querySnapshotAllCatalog() {
    return FirebaseFirestore.instance
        .collection(FirebaseDataKeys.products)
        .limit(100)
        .get();
  }

  Future<void> _onLoadProducts(
    LoadCatalog event,
    Emitter<CatalogState> emit,
  ) async {
    emit(const CatalogLoading());
    try {
      final isAll = event.categoryId == categoryProducts.first.id;

      final querySnapshot = isAll
          ? await _querySnapshotAllCatalog()
          : await _querySnapshotByCategoryId(event.categoryId);

      final List<ProductModel> products =
          querySnapshot.docs.map<ProductModel>((doc) {
        final data =
            Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
        data[FirebaseDataKeys.id] = doc.id;
        final product = ProductModel.fromJson(data);

        return product;
      }).toList();
      emit(CatalogLoaded(products: products));
    } catch (error, stackTrace) {
      log('CatalogBloc: _onLoadProducts', error: error, stackTrace: stackTrace);
      emit(CatalogError(message: 'Ошибка при загрузке продуктов: $error'));
    }
  }
}
