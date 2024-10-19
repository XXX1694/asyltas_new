import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/core/models/product.dart';
import 'package:asyltas_app/features/catalog/presentation/pages/catalog_page.dart';
import 'package:asyltas_app/features/category/presentation/pages/category_page.dart';
import 'package:asyltas_app/features/main/presentation/widgets/catalog_item_shimmer.dart';
import 'package:asyltas_app/features/product/presentation/pages/product_page.dart';
import 'package:asyltas_app/provider/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

@Deprecated('Use CatalogLayout instead')
class MiniCatalogMobile extends StatefulWidget {
  const MiniCatalogMobile({
    super.key,
  });

  @override
  State<MiniCatalogMobile> createState() => _MiniCatalogMobileState();
}

class _MiniCatalogMobileState extends State<MiniCatalogMobile>
    with TickerProviderStateMixin {
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

  Map<String, String> selected = {'id': '0000', 'name': 'Все'};
  List products = [];
  List<ProductModel> categoryProducts = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Заголовок и кнопка "Посмотреть всё"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Категории',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: newBlack,
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
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
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Слушатель изменений в Firestore
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CatalogItemShimmer();
            }
            if (snapshot.hasError) {
              return const CatalogItemShimmer();
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('Нет доступных товаров.'));
            }
            products = snapshot.data!.docs;
            categoryProducts = [];
            if (selected['id'] == '0000') {
              for (int i = 0; i < 14 && i < products.length; i++) {
                final product = products[i].data() as Map<String, dynamic>;
                categoryProducts.add(ProductModel.fromJson(product));
                categoryProducts.last.id = snapshot.data!.docs[i].id;
              }
            } else {
              List<ProductModel> tempCategoryProducts = [];
              for (int i = 0; i < products.length; i++) {
                final product = products[i].data() as Map<String, dynamic>;
                String productCategoryId =
                    (product['category_id'] ?? '').toString();

                if (productCategoryId == selected['id']) {
                  tempCategoryProducts.add(ProductModel.fromJson(product));
                  tempCategoryProducts.last.id = snapshot.data!.docs[i].id;
                }
              }
              for (int i = 0; i < 14 && i < tempCategoryProducts.length; i++) {
                categoryProducts.add(tempCategoryProducts[i]);
              }
            }

            return StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setStatee) {
                return Column(
                  children: [
                    // Отображение категорий
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: category.map((item) {
                          if (selected['id'] == item['id']) {
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
                                onTap: () {
                                  selected = item;
                                  categoryProducts = [];

                                  if (selected['id'] == '0000') {
                                    for (int i = 0;
                                        i < 14 && i < products.length;
                                        i++) {
                                      final product = products[i].data()
                                          as Map<String, dynamic>;
                                      categoryProducts
                                          .add(ProductModel.fromJson(product));
                                      categoryProducts.last.id =
                                          snapshot.data!.docs[i].id;
                                    }
                                  } else {
                                    List<ProductModel> tempCategoryProducts =
                                        [];
                                    for (int i = 0; i < products.length; i++) {
                                      final product = products[i].data()
                                          as Map<String, dynamic>;
                                      String productCategoryId =
                                          (product['category_id'] ?? '')
                                              .toString();

                                      if (productCategoryId == selected['id']) {
                                        tempCategoryProducts.add(
                                            ProductModel.fromJson(product));
                                        tempCategoryProducts.last.id =
                                            snapshot.data!.docs[i].id;
                                      }
                                    }
                                    for (int i = 0;
                                        i < 14 &&
                                            i < tempCategoryProducts.length;
                                        i++) {
                                      categoryProducts
                                          .add(tempCategoryProducts[i]);
                                    }
                                  }
                                  setStatee(() {});
                                },
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
                    // Отображение товаров
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: StaggeredGrid.count(
                        mainAxisSpacing: 16,
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        children: categoryProducts.map((item) {
                          // Проверяем, есть ли товар в корзине
                          final cartItem =
                              context.watch<CartProvider>().firstWhereOrNull(
                                    (cartItem) => cartItem.id == item.id,
                                  );

                          int currentCount = cartItem?.count ?? 0;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CupertinoButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                        product: item,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                const Duration(seconds: 0),
                                            fadeOutDuration:
                                                const Duration(seconds: 0),
                                            imageUrl: item.images?[0] ?? '',
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder:
                                                (context, url, progress) {
                                              return Container(
                                                color: Colors.grey.shade200,
                                                height: double.infinity,
                                                width: double.infinity,
                                              );
                                            },
                                            errorWidget: (context, url, error) {
                                              return Container(
                                                color: Colors.grey.shade200,
                                                height: double.infinity,
                                                width: double.infinity,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 7,
                                              ),
                                              decoration: BoxDecoration(
                                                color: newWhite,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    offset: Offset(2, 2),
                                                    blurRadius: 15,
                                                    color: Colors.black26,
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${item.numberLeft ?? 0} шт",
                                                  style: const TextStyle(
                                                    color: newBlack,
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    item.name ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Gilroy',
                                      color: newBlack,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${item.price},00 ₸",
                                    style: const TextStyle(
                                      fontFamily: 'Gilroy',
                                      color: newBlack,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Счетчик с кнопками "+" и "-"
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Кнопка "-"
                                      CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: currentCount > 0
                                            ? () {
                                                context
                                                    .read<CartProvider>()
                                                    .decrementCount(item);
                                                if (currentCount - 1 == 0) {
                                                  showCustomSnackBar(context,
                                                      'Удалено из корзины!');
                                                } else {
                                                  showCustomSnackBar(context,
                                                      'Количество уменьшено: ${currentCount - 1}');
                                                }
                                              }
                                            : null,
                                        child: Icon(
                                          Icons.remove,
                                          color: currentCount > 0
                                              ? newBlack
                                              : Colors.grey,
                                        ),
                                      ),
                                      // Отображение текущего количества
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Text(
                                          '$currentCount',
                                          style: const TextStyle(
                                            fontFamily: 'Gilroy',
                                            color: newBlack,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      // Кнопка "+"
                                      CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          context
                                              .read<CartProvider>()
                                              .incrementCount(item);
                                          if (currentCount + 1 == 1) {
                                            showCustomSnackBar(
                                                context, 'Добавлен в корзину!');
                                          } else {
                                            showCustomSnackBar(context,
                                                'Количество увеличено: ${currentCount + 1}');
                                          }
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: newBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Кнопка "Все товары"
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
                        if (selected['id'] == '0000') {
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
                                categoryId: selected['id'].toString(),
                                categoryName: selected['name'].toString(),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16)
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  void showCustomSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    final animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 0,
        bottom: MediaQuery.of(context).size.height * 0.12,
        child: SlideTransition(
          position: animation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: newBlack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: const TextStyle(color: newWhite),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    animationController.forward();

    Future.delayed(const Duration(milliseconds: 1000), () {
      animationController.reverse().then((value) {
        overlayEntry.remove();
        animationController.dispose();
      });
    });
  }
}
