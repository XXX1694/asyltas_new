import 'package:asyltas_app/core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final List<Map<String, String>> category = [
  {'id': '0000', 'name': 'Все'},
  {'id': '0001', 'name': 'Хрустал 8мм'},
  {'id': '0002', 'name': 'Хрустал 6мм'},
  {'id': '0003', 'name': 'Хрустал 4мм'},
  {'id': '0005', 'name': 'Хрустал 2мм'},
  {'id': '0007', 'name': 'Хрустал алмаз 4мм'},
  {'id': '0017', 'name': "Стразы капля 6х10"},
  {'id': '0018', 'name': "Стразы капля 8х13"},
  {'id': '0019', 'name': "Стразы капля 10х14"},
  {'id': '0010', 'name': "Поджемчук"},
  {'id': '0011', 'name': "Шашбау"},
  {'id': '0014', 'name': "Страз на листь"},
];
Map<String, String> selescted = {'id': '0000', 'name': 'Все'};

class MiniCatalogPlacegolder extends StatelessWidget {
  const MiniCatalogPlacegolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0, // Horizontal spacing between containers
            runSpacing: 8.0, // Vertical spacing between runs
            children: category.map((item) {
              if (selescted['id'] == item['id']) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: secondMain,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['name'] ?? '',
                    style: const TextStyle(
                      fontFamily: 'Gilroy',
                      color: newWhite,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              } else {
                return Opacity(
                  opacity: 0.54,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: newBlack,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item['name'] ?? '',
                        style: const TextStyle(
                          fontFamily: 'Gilroy',
                          color: newBlack,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: StaggeredGrid.count(
            mainAxisSpacing: 16,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            children: category.map((item) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {},
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            color: Colors.grey.shade200,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const Text(
                      //   'Имя товара',
                      //   style: TextStyle(
                      //     fontFamily: 'Gilroy',
                      //     color: newBlack,
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      //   textAlign: TextAlign.center,
                      //   // overflow: TextOverflow.ellipsis,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          color: Colors.grey.shade200,
                          height: 18,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // const Text(
                      //   "999,00 ₸",
                      //   style: TextStyle(
                      //     fontFamily: 'Gilroy',
                      //     color: newBlack,
                      //     fontSize: 13,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: Container(
                          color: Colors.grey.shade200,
                          height: 16,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 4),
                      CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: secondMain,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(5, 5),
                                blurRadius: 15,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ],
                          ),
                          height: 32,
                          width: double.infinity,
                          child: const Center(
                            child: Text(
                              'Подробнее',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                color: newWhite,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: newBlack,
                              width: 1,
                            ),
                          ),
                          height: 32,
                          width: double.infinity,
                          child: const Center(
                            child: Text(
                              'В корзину',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                color: newBlack,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
