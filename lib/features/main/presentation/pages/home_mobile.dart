import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/features/cart/presentation/pages/cart_page.dart';
import 'package:asyltas_app/features/favorites/presentation/pages/favorites_page.dart';
import 'package:asyltas_app/features/main/presentation/bloc/catalog_bloc.dart';
import 'package:asyltas_app/features/main/presentation/widgets/catalog_layout.dart';
import 'package:asyltas_app/features/main/presentation/widgets/corusel.dart';
import 'package:asyltas_app/features/main/presentation/widgets/home_bottom.dart';
import 'package:asyltas_app/features/main/presentation/widgets/search_field.dart';
import 'package:asyltas_app/features/main/presentation/widgets/shop_widget.dart';
import 'package:asyltas_app/features/menu/presentation/pages/menu_page.dart';
import 'package:asyltas_app/provider/cart_provider.dart';
import 'package:asyltas_app/provider/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  final catalogScrollController = ScrollController();
  final mainScrollController = ScrollController();
  bool _showBackToTopButton = true;

  @override
  void initState() {
    super.initState();
    mainScrollController.addListener(_mainScrollListener);
    catalogScrollController.addListener(_catalogScrollListener);
  }

  @override
  void dispose() {
    mainScrollController.removeListener(_mainScrollListener);
    catalogScrollController.removeListener(_catalogScrollListener);
    catalogScrollController.dispose();
    super.dispose();
  }

  void _mainScrollListener() {
    if (mainScrollController.offset >= 30) {
      setState(() {
        _showBackToTopButton = true;
      });
    }
  }

  void _catalogScrollListener() {
    if (catalogScrollController.offset >= 30) {
      setState(() {
        _showBackToTopButton = true;
      });
    } else {
      // setState(() {
      //   _showBackToTopButton = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatalogBloc>(
          create: (_) => CatalogBloc(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: newWhite,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: mainScrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        height: 31,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
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
                            const Spacer(),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: SvgPicture.asset(
                            //     'assets/search.svg',
                            //     height: 24,
                            //     width: 24,
                            //   ),
                            // ),
                            // const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FavoritesPage(
                                      fromMain: true,
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
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  favorites.items.length
                                                      .toString(),
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
                                      fromMain: true,
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
                    const SizedBox(height: 4),
                    const SearchField(),
                    const SizedBox(height: 12),
                    const CustomCarousel(),
                    const SizedBox(height: 20),
                    const ShopWidget(),
                    CatalogLayout(
                      parentScrollController: catalogScrollController,
                    ),
                    //const MiniCatalogMobile(),
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
                                        borderRadius:
                                            BorderRadius.circular(100),
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
              if (_showBackToTopButton)
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
            ],
          ),
        ),
      ),
    );
  }

  void _scrollToTop() {
    catalogScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    mainScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
