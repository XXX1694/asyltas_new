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

  DocumentSnapshot? lastDocument;
  bool isFetching = false;

  Future<QuerySnapshot> _querySnapshotByCategoryId(String categoryId,
      {int limit = 20}) {
    Query query = FirebaseFirestore.instance
        .collection(FirebaseDataKeys.products)
        .where(FirebaseDataKeys.categoryId, isEqualTo: categoryId)
        .limit(limit);

    final lastDocument = this.lastDocument;

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.get();
  }

  Future<QuerySnapshot> _querySnapshotAllCatalog({int limit = 20}) {
    Query query = FirebaseFirestore.instance
        .collection(FirebaseDataKeys.products)
        .limit(limit);

    final lastDocument = this.lastDocument;

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.get();
  }

  Future<void> _onLoadProducts(
    LoadCatalog event,
    Emitter<CatalogState> emit,
  ) async {
    if (isFetching) return;
    isFetching = true;

    try {
      if (event.isInitialLoad) {
        emit(const CatalogLoading());
        lastDocument = null;
      }

      final isAll = event.categoryId == categoryProducts.first.id;

      final querySnapshot = isAll
          ? await _querySnapshotAllCatalog()
          : await _querySnapshotByCategoryId(event.categoryId);

      final fetchedProducts = querySnapshot.docs.map<ProductModel>((doc) {
        final data =
            Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
        data[FirebaseDataKeys.id] = doc.id;
        final product = ProductModel.fromJson(data);
        return product;
      }).toList();

      bool hasNext = fetchedProducts.length < 20;

      lastDocument = querySnapshot.docs.isNotEmpty
          ? querySnapshot.docs.last
          : lastDocument;

      if (state is CatalogLoaded && !event.isInitialLoad) {
        final currentState = state as CatalogLoaded;
        final allProducts = List<ProductModel>.from(currentState.products)
          ..addAll(fetchedProducts);
        emit(CatalogLoaded(products: allProducts, hasNext: hasNext));
      } else {
        emit(CatalogLoaded(products: fetchedProducts, hasNext: hasNext));
      }
    } catch (error, stackTrace) {
      log('CatalogBloc: _onLoadProducts', error: error, stackTrace: stackTrace);
      emit(CatalogError(message: 'Ошибка при загрузке продуктов: $error'));
    } finally {
      isFetching = false;
    }
  }
}
