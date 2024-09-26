import 'package:asyltas_app/features/main/presentation/widgets/catalog_item_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MiniCatalogShimmer extends StatelessWidget {
  const MiniCatalogShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
        mainAxisSpacing: 16,
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        children: List.generate(
          6,
          (index) => const CatalogItemShimmer(),
        ));
  }
}
