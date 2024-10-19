import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/features/category/presentation/pages/category_page.dart';
import 'package:asyltas_app/features/main/presentation/widgets/category_item.dart';
import 'package:flutter/material.dart';

import '../helpres/category_controller.dart';

class CategoriesPanel extends StatefulWidget {
  const CategoriesPanel({
    required this.controller,
    super.key,
  });

  final CategoryController controller;

  @override
  State<CategoriesPanel> createState() => _CategoriesPanelState();
}

late GlobalKey dropdownButtonKey;
void openDropdown() {
  dropdownButtonKey.currentContext?.visitChildElements((element) {
    if (element.widget is Semantics) {
      element.visitChildElements((element) {
        if (element.widget is Actions) {
          element.visitChildElements((element) {
            Actions.invoke(element, const ActivateIntent());
          });
        }
      });
    }
  });
}

class _CategoriesPanelState extends State<CategoriesPanel> {
  CategoryProduct? selectedCategory;
  @override
  void initState() {
    dropdownButtonKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40,
          child: DropdownButton<CategoryProduct>(
            key: dropdownButtonKey,
            alignment: Alignment.center,
            isExpanded: true,
            underline: const SizedBox(),
            menuWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            hint: const Text(
              "Все товары",
              style: TextStyle(
                fontFamily: 'Gilroy',
                color: newBlack,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            value: selectedCategory,
            onChanged: (CategoryProduct? newValue) {
              // setState(() {
              //   selectedCategory = newValue;
              // });
              // widget.controller.setCategory(
              //   selectedCategory ??
              //       CategoryProduct(
              //         name: 'Все',
              //         id: '0000',
              //       ),
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryPgae(
                    categoryId: newValue!.id,
                    categoryName: newValue.name,
                  ),
                ),
              );
            },
            items: categoryProducts.map((CategoryProduct category) {
              return DropdownMenuItem<CategoryProduct>(
                value: category,
                child: CategoryItem(
                  text: category.name,
                  isSelected: category == selectedCategory,
                  onTap: () {
                    // widget.controller.setCategory(category);
                  },
                  count: category.count,
                ),
              );
            }).toList(),
          ),
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     const Text(
        //       'Категории',
        //       style: TextStyle(
        //         fontFamily: 'Gilroy',
        //         color: newBlack,
        //         fontSize: 17,
        //         fontWeight: FontWeight.w600,
        //         letterSpacing: 0,
        //       ),
        //     ),
        //     CupertinoButton(
        //       padding: const EdgeInsets.all(0),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => const CatalogPage(),
        //           ),
        //         );
        //       },
        //       child: const Text(
        //         'Посмотреть всё',
        //         style: TextStyle(
        //           fontFamily: 'Gilroy',
        //           color: newMainColor,
        //           fontSize: 15,
        //           fontWeight: FontWeight.w500,
        //           letterSpacing: 0,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 8),
        // ValueListenableBuilder<CategoryProduct>(
        //   valueListenable: controller,
        //   builder: (context, category, _) {
        //     return ScrollConfiguration(
        //       behavior: HideScrollPanel(),
        //       child: Wrap(
        //           alignment: WrapAlignment.center,
        //           spacing: 8.0,
        //           runSpacing: 8.0,
        //           children: categoryProducts.map((item) {
        //             final e = item;
        //             return CategoryItem(
        //               text: e.name,
        //               isSelected: e == category,
        //               onTap: () {
        //                 controller.setCategory(e);
        //               },
        //               count: e.count,
        //             );
        //           }).toList()),
        //     );
        //   },
        // ),
      ],
    );
  }
}
