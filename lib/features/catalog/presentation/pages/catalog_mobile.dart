import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/features/category/presentation/pages/category_page.dart';
import 'package:asyltas_app/features/main/presentation/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CatalogMobile extends StatelessWidget {
  const CatalogMobile({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> category = [
      {
        "main_category": "Хрусталь",
        "data": [
          {'id': '0001', 'name': 'Хрустал 8мм'},
          {'id': '0002', 'name': 'Хрустал 6мм'},
          {'id': '0003', 'name': 'Хрустал 4мм'},
          {'id': '0004', 'name': 'Хрустал 4мм биконус'},
          {'id': '0005', 'name': 'Хрустал 2мм'},
          {'id': '0006', 'name': 'Хрустал 0.8мм'},
          {'id': '0007', 'name': 'Хрустал алмаз 4мм'},
          {'id': '0008', 'name': 'Хрустал капля 8/12мм'},
          {'id': '0009', 'name': 'Хрустал 6/8мм'},
        ]
      },
      {
        "main_category": "Стразы",
        "data": [
          {'id': '0013', 'name': 'Страз лента'},
          {'id': '0014', 'name': 'Страз на листь'},
          {'id': '0022', 'name': 'Стразы клеевые'},
          {'id': '0017', 'name': 'Стразы капля 6х10'},
          {'id': '0018', 'name': 'Стразы капля 8х13'},
          {'id': '0019', 'name': 'Стразы капля 10х14'},
          {'id': '0020', 'name': 'Стразы капля 13х18'},
          {'id': '0030', 'name': 'Стразы капля со стразами 18х25мм'},
          {'id': '0031', 'name': 'Стразы капля со стразами 13х18мм'},
          {'id': '0032', 'name': 'Стразы круглые 8мм'},
          {'id': '0033', 'name': 'Стразы круглые 10мм'},
          {'id': '0034', 'name': 'Стразы круглые 12мм'},
          {'id': '0035', 'name': 'Стразы круглые 14мм'},
          {'id': '0036', 'name': 'Стразы круглые 16мм'},
          {'id': '0037', 'name': 'Стразы в цапах квадратные 8мм'},
          {'id': '0038', 'name': 'Стразы в цапах квадратные 10мм'},
          {'id': '0039', 'name': 'Стразы в цапах квадратные 12мм'},
        ]
      },
      {
        "main_category": "Люкс фурнитура",
        "data": [
          {'id': '0024', 'name': 'Швенза'},
          {'id': '0025', 'name': 'Межбусины'},
          {'id': '0026', 'name': 'Кулоны'},
          {'id': '0027', 'name': 'Кольцо'},
          {'id': '0028', 'name': 'Цепы'},
        ]
      },
      // Other items that are not part of any category
      {
        'id': '0010',
        'name': 'Поджемчук',
      },
      {
        'id': '0011',
        'name': 'Шашбау',
      },
      {
        'id': '0012',
        'name': 'Основа',
      },
      {
        'id': '0015',
        'name': 'Перья',
      },
      {
        'id': '0016',
        'name': 'Расходной материал',
      },
      {
        'id': '0021',
        'name': 'Бусины ежевика',
      },
      {
        'id': '0023',
        'name': 'Бисер Тайвань',
      },
    ];
    return Scaffold(
      backgroundColor: newWhite,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 27),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (context) => false,
                      );
                    },
                    child: const Text(
                      'ASYLTAS',
                      style: TextStyle(
                        color: newBlack,
                        fontSize: 17,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/сlose.svg',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView(
                        children: category.map<Widget>((cat) {
                          if (cat.containsKey('data')) {
                            // This is a category with sub-items
                            return ExpansionTile(
                              tilePadding: const EdgeInsets.all(0),
                              childrenPadding: const EdgeInsets.all(0),
                              title: Text(
                                cat['main_category'],
                                style: const TextStyle(
                                  color: secondMain,
                                  fontSize: 20,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                ),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                              ),
                              children:
                                  (cat['data'] as List<Map<String, String>>)
                                      .map<Widget>((item) {
                                return ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  title: Text(
                                    item['name'] ?? '',
                                    style: const TextStyle(
                                      color: secondMain,
                                      fontSize: 20,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1,
                                    ),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoryPgae(
                                          categoryId: item['id'].toString(),
                                          categoryName: item['name'].toString(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            );
                          } else {
                            // This is an item without a category
                            return CupertinoButton(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryPgae(
                                      categoryId: cat['id'].toString(),
                                      categoryName: cat['name'].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    cat['name'].toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF008676),
                                      fontSize: 20,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1,
                                    ),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          }
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
