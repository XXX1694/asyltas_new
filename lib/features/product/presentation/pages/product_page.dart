import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/core/models/product.dart';
import 'package:asyltas_app/features/cart/presentation/pages/cart_page.dart';
import 'package:asyltas_app/features/favorites/presentation/pages/favorites_page.dart';
import 'package:asyltas_app/features/main/presentation/pages/home_page.dart';
import 'package:asyltas_app/features/menu/presentation/pages/menu_page.dart';
import 'package:asyltas_app/features/product/presentation/widgets/full_screen_image.dart';
import 'package:asyltas_app/features/product/presentation/widgets/like_button.dart';
import 'package:asyltas_app/provider/cart_provider.dart';
import 'package:asyltas_app/provider/favorites_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_button.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    int currentImage = 0;
    return Scaffold(
      backgroundColor: newWhite,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            width: double.infinity,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Главная / Каталог / ${product.category_name}',
                          style: TextStyle(
                            color: newBlack54,
                            fontSize: 15,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        StatefulBuilder(
                          builder: (context, setState) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenImage(
                                        imageUrl:
                                            product.images?[currentImage] ?? '',
                                      ),
                                    ),
                                  );
                                },
                                child: AspectRatio(
                                  aspectRatio: 4 / 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      filterQuality: FilterQuality.high,
                                      fadeInDuration:
                                          const Duration(seconds: 0),
                                      fadeOutDuration:
                                          const Duration(seconds: 0),
                                      imageUrl:
                                          product.images?[currentImage] ?? '',
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Container(
                                        color: Colors.grey.shade200,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
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
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 75,
                                width: double.infinity,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: product.images?.length ?? 0,
                                  itemBuilder: (context, index) => Container(
                                    height: 74,
                                    margin: const EdgeInsets.only(right: 8),
                                    child: CupertinoButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {
                                        setState(() {
                                          currentImage = index;
                                        });
                                      },
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                const Duration(seconds: 0),
                                            fadeOutDuration:
                                                const Duration(seconds: 0),
                                            imageUrl:
                                                product.images?[index] ?? '',
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          product.name ?? '',
                          style: const TextStyle(
                            color: newBlack,
                            fontSize: 20,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'В пачке: ${product.numberLeft} шт',
                          style: TextStyle(
                            color: newBlack54,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${product.price} ₸',
                              style: const TextStyle(
                                color: newMainColor,
                                fontSize: 20,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            LikeButton(
                              product: product,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        CartButton(
                          product: product,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Описание',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            color: newBlack54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description ?? '',
                          style: const TextStyle(
                            fontFamily: 'Gilroy',
                            color: newBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(right: 24, bottom: 28),
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
            )
          ],
        ),
      ),
    );
  }
}
