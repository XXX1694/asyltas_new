import 'package:asyltas_app/features/main/presentation/helpres/hide_scroll_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../catalog/presentation/pages/catalog_page.dart';
import '../helpres/category_controller.dart';
import 'category_item.dart';

class CategoriesPanel extends StatelessWidget {
  const CategoriesPanel({
    required this.controller,
    super.key,
  });

  final CategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Категории',
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: newBlack,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CatalogPage(),
                  ),
                );
              },
              child: const Text(
                'Посмотреть всё',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: newMainColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<CategoryProduct>(
          valueListenable: controller,
          builder: (context, category, _) {
            return ScrollConfiguration(
              behavior: HideScrollPanel(),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: categoryProducts.map((item) {
                    final e = item;
                    return CategoryItem(
                      text: e.name,
                      isSelected: e == category,
                      onTap: () {
                        controller.setCategory(e);
                      },
                    );
                  }).toList()),
            );
          },
        ),
      ],
    );
  }
}
