import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/features/cart/presentation/pages/cart_page.dart';
import 'package:asyltas_app/features/favorites/presentation/widgets/cart_button.dart';
import 'package:asyltas_app/features/main/presentation/pages/home_page.dart';
import 'package:asyltas_app/features/main/presentation/widgets/home_bottom.dart';
import 'package:asyltas_app/features/menu/presentation/pages/menu_page.dart';
import 'package:asyltas_app/provider/cart_provider.dart';
import 'package:asyltas_app/provider/favorites_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FavoritesMobile extends StatelessWidget {
  const FavoritesMobile({
    super.key,
    required this.fromMain,
  });
  final bool fromMain;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: newWhite,
      body: SafeArea(
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
                      height: 31,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset('assets/back.svg'),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartPage(),
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
                                      'assets/cart1.svg',
                                    ),
                                  ),
                                  Consumer<CartProvider>(
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
                          fromMain
                              ? Navigator.pop(context)
                              : Navigator.pushAndRemoveUntil(
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
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Избранные',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: newMainColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Consumer<FavoritesProvider>(
                builder: (context, favorites, child) {
                  if (favorites.items.isEmpty) {
                    return const Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'Пусто',
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Всего ${favorites.items.length} товаров',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              color: newBlack54,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Flexible(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: favorites.items.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 6,
                                ),
                                height: 150,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          fadeInDuration:
                                              const Duration(seconds: 0),
                                          fadeOutDuration:
                                              const Duration(seconds: 0),
                                          imageUrl: favorites
                                                  .items[index].images?[0] ??
                                              '',
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
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            favorites.items[index].name ??
                                                'Без имени',
                                            style: const TextStyle(
                                              fontFamily: 'Gilroy',
                                              color: newBlack,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'В пачке: ${favorites.items[index].numberLeft ?? 1} шт',
                                            style: const TextStyle(
                                              fontFamily: 'Gilroy',
                                              color: newBlack,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '${favorites.items[index].price} ₸',
                                            style: const TextStyle(
                                              fontFamily: 'Gilroy',
                                              color: newMainColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const Spacer(),
                                          CartButton(
                                            product: favorites.items[index],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const HomeBottom(),
          ],
        ),
      ),
    );
  }
}
