part of 'catalog_bloc.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object> get props => [];
}

class LoadCatalog extends CatalogEvent {
  const LoadCatalog({
    required this.categoryId,
    this.isInitialLoad = true,
  });

  final String categoryId;
  final bool isInitialLoad;

  @override
  List<Object> get props => [categoryId, isInitialLoad];
}