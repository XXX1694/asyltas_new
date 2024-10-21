import 'package:asyltas_app/features/category/presentation/widgets/catalog_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/presentation/bloc/catalog_bloc.dart';

class CatalogCategoryLayout extends StatelessWidget {
  const CatalogCategoryLayout({
    required this.categoryId,
    this.scrollController,
    super.key,
  });

  final String categoryId;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CatalogBloc>(
      create: (_) => CatalogBloc()..add(LoadCatalog(categoryId: categoryId)),
      child: CatalogCategory(
        categoryId: categoryId,
        scrollController: scrollController,
      ),
    );
  }
}
