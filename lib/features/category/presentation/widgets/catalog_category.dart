import 'package:flutter/material.dart';

import '../../../main/presentation/widgets/catalog_screen.dart';

class CatalogCategory extends StatelessWidget {
  const CatalogCategory({
    required this.categoryId,
    this.scrollController,
    super.key,
  });

  final String categoryId;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return CatalogScreen(
      currentCategoryId: categoryId,
      scrollController: scrollController,
    );
  }
}
