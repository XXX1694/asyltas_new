import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../catalog/presentation/pages/catalog_page.dart';
import '../../../category/presentation/pages/category_page.dart';
import '../bloc/catalog_bloc.dart';
import '../helpres/category_controller.dart';
import 'catalog_screen.dart';
import 'categories_panel.dart';

class CatalogLayout extends StatefulWidget {
  const CatalogLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<CatalogLayout> createState() => _CatalogLayoutState();
}

class _CatalogLayoutState extends State<CatalogLayout> {
  final CategoryController controller = CategoryController();

  CatalogBloc get productBloc => context.read<CatalogBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productBloc.add(LoadCatalog(categoryId: categoryProducts.first.id));
    });

    controller.addListener(() {
      productBloc.add(LoadCatalog(categoryId: controller.value.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CategoriesPanel(controller: controller),
          const SizedBox(height: 20),
          const CatalogScreen(),
          const SizedBox(height: 16),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: Container(
              width: 180,
              padding: const EdgeInsets.symmetric(
                vertical: 11,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: newMainColor,
                ),
              ),
              child: const Center(
                child: Text(
                  'Все товары',
                  style: TextStyle(
                    color: newMainColor,
                    fontFamily: 'Gilroy',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            onPressed: () async {
              if (controller.value.id == categoryProducts.first.id) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CatalogPage(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPgae(
                      categoryId: controller.value.id,
                      categoryName: controller.value.name,
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}
