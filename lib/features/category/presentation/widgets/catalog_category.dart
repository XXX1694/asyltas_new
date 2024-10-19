import 'package:flutter/material.dart';

import '../../../main/presentation/widgets/catalog_screen.dart';

class CatalogCategory extends StatelessWidget {
  const CatalogCategory({
    required this.categoryId,
    required this.controller,
    super.key,
  });

  final String categoryId;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return CatalogScreen(
      currentCategoryId: categoryId,
      parentScrollController: controller,
    );
  }
}
