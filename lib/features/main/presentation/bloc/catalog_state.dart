part of 'catalog_bloc.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object> get props => [];
}

class CatalogInitial extends CatalogState {
  const CatalogInitial();
}

class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

class CatalogLoaded extends CatalogState {
  const CatalogLoaded({required this.products});

  final List<ProductModel> products;

  @override
  List<Object> get props => [products];
}

class CatalogError extends CatalogState {
  const CatalogError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
