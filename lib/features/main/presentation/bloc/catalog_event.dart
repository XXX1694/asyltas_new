part of 'catalog_bloc.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object> get props => [];
}

class LoadCatalog extends CatalogEvent {
  const LoadCatalog({required this.categoryId});

  final String categoryId;

  @override
  List<Object> get props => [categoryId];
}
