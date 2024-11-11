import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/features/cart/presentation/pages/cart_page.dart';
import 'package:asyltas_app/features/favorites/presentation/pages/favorites_page.dart';
import 'package:asyltas_app/features/main/presentation/pages/home_page.dart';
import 'package:asyltas_app/features/main/presentation/widgets/categories_panel.dart';
import 'package:asyltas_app/features/main/presentation/widgets/home_bottom.dart';
import 'package:asyltas_app/features/menu/presentation/pages/menu_page.dart';
import 'package:asyltas_app/provider/cart_provider.dart';
import 'package:asyltas_app/provider/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../widgets/catalog_category_layout.dart';

class CategoryMobile extends StatefulWidget {
  const CategoryMobile({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });
  final String categoryName;
  final String categoryId;

  @override
  State<CategoryMobile> createState() => _CategoryMobileState();
}

class _CategoryMobileState extends State<CategoryMobile> {
  final mainScrollController = ScrollController();
  @override
  void initState() {
    mainScrollController.addListener(_mainScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    mainScrollController.removeListener(_mainScrollListener);
    super.dispose();
  }

  void _mainScrollListener() {
    if (mainScrollController.offset >= 30) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: newWhite,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 32,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    openDropdown();
                                  },
                                  child: SvgPicture.asset('assets/back.svg'),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const FavoritesPage(
                                          fromMain: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: 31,
                                    height: 31,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: SvgPicture.asset(
                                            'assets/menu_like.svg',
                                          ),
                                        ),
                                        Consumer<FavoritesProvider>(
                                          builder: (context, favorites, child) {
                                            if (favorites.items.isEmpty) {
                                              return const SizedBox();
                                            } else {
                                              return Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  decoration: BoxDecoration(
                                                    color: newMainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      favorites.items.length
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: newWhite,
                                                        fontSize: 11,
                                                        fontFamily: 'Gilroy',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MenuPage(
                                          fromMain: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: SvgPicture.asset('assets/menu.svg'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 31,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (context) => false,
                                );
                                openDropdown();
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Главная / Каталог / ${widget.categoryName}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: newBlack,
                        fontFamily: 'Gilroy',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: CatalogCategoryLayout(
                      categoryId: widget.categoryId,
                      controller: mainScrollController,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const HomeBottom(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(right: 20, bottom: 64),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(5, 5),
                          blurRadius: 15,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ),
                    width: 52,
                    height: 52,
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      width: 31,
                      height: 31,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/cart1.svg',
                            ),
                          ),
                          Consumer<CartProvider>(
                            builder: (context, cart, child) {
                              if (cart.items.isEmpty) {
                                return const SizedBox();
                              } else {
                                return Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                      color: newMainColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Text(
                                        cart.items.length.toString(),
                                        style: const TextStyle(
                                          color: newWhite,
                                          fontSize: 11,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 124,
              right: 20,
              child: GestureDetector(
                onTap: _scrollToTop,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(5, 5),
                        blurRadius: 15,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  width: 52,
                  height: 52,
                  padding: const EdgeInsets.all(5),
                  child: const Icon(Icons.arrow_upward),
                ),
              ),
            ),
            Positioned(
              bottom: 64,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  openDropdown();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(5, 5),
                        blurRadius: 15,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  // width: 52,
                  height: 52,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 8),
                      Text('Назад'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToTop() {
    mainScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
