import 'package:flutter/material.dart';

import '../../../main/presentation/widgets/catalog_screen.dart';

class CatalogCategory extends StatelessWidget {
  const CatalogCategory({
    required this.categoryId,
    super.key,
  });

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return const CatalogScreen();
  }
}
