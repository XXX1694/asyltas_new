// ignore_for_file: use_build_context_synchronously

import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/core/functions/make_order.dart';
import 'package:asyltas_app/features/favorites/presentation/pages/favorites_page.dart';
import 'package:asyltas_app/features/main/presentation/pages/home_page.dart';
import 'package:asyltas_app/features/main/presentation/widgets/home_bottom.dart';
import 'package:asyltas_app/features/menu/presentation/pages/menu_page.dart';
import 'package:asyltas_app/features/payment/presentation/pages/payment_page.dart';
import 'package:asyltas_app/provider/cart_provider.dart';
import 'package:asyltas_app/provider/favorites_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../widgets/comment_field.dart';
import '../widgets/name_field.dart';
import '../widgets/phone_field.dart';

class CartMobile extends StatefulWidget {
  const CartMobile({super.key});

  @override
  State<CartMobile> createState() => _CartMobileState();
}

class _CartMobileState extends State<CartMobile> with TickerProviderStateMixin {
  late TextEditingController commentContrller;
  late TextEditingController phoneController;
  late TextEditingController nameController;
  @override
  void initState() {
    commentContrller = TextEditingController();
    phoneController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    commentContrller.dispose();
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

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
                                  builder: (context) => const FavoritesPage(
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
                    height: 32,
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Корзина',
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
              child: Consumer<CartProvider>(
                builder: (context, cart, child) {
                  if (cart.items.isEmpty) {
                    return const Column(
                      children: [
                        Expanded(child: Center(child: Text('Пусто'))),
                        SizedBox(height: 16),
                        HomeBottom(),
                      ],
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Всего ${cart.items.length} товаров',
                            style: const TextStyle(
                              fontFamily: 'Gilroy',
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cart.items.length,
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
                                          imageUrl:
                                              cart.items[index].images?[0] ??
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
                                            cart.items[index].name ??
                                                'Без имени',
                                            style: const TextStyle(
                                              fontFamily: 'Gilroy',
                                              color: newBlack,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Цена за единицу: ${cart.items[index].price} ₸',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              color: newBlack54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Text(
                                                '${cart.items[index].price! * cart.items[index].count!} ₸ ',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  color: newBlack,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  decoration: cart.items[index]
                                                              .count! >=
                                                          10
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : null,
                                                ),
                                              ),
                                              cart.items[index].count! >= 10
                                                  ? Text(
                                                      '(${(cart.items[index].price! * (cart.items[index].count! >= 20 ? 0.8 : cart.items[index].count! >= 10 ? 0.9 : 1.0)) * cart.items[index].count!} ₸)',
                                                      style: const TextStyle(
                                                        fontFamily: 'Gilroy',
                                                        color: newMainColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  // border: Border.all(
                                                  //     color:
                                                  //         Colors.black45,
                                                  //     width: 1),
                                                  color: newMainColor
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CupertinoButton(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      onPressed: () async {
                                                        cart.decrementCount(
                                                            cart.items[index]);
                                                      },
                                                      child: SvgPicture.asset(
                                                        'assets/minus_mobile.svg',
                                                        width: 13,
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${cart.items[index].count ?? 1}',
                                                        style: const TextStyle(
                                                          fontFamily: 'Gilroy',
                                                          fontSize: 17,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    CupertinoButton(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      onPressed: () {
                                                        cart.incrementCount(
                                                            cart.items[index]);
                                                      },
                                                      child: SvgPicture.asset(
                                                        'assets/plus_mobile.svg',
                                                        width: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              CupertinoButton(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                onPressed: () async {
                                                  context
                                                      .read<CartProvider>()
                                                      .removeItem(
                                                          cart.items[index]);
                                                  showCustomSnackBar(
                                                      context, 'Товар удален!');
                                                },
                                                child: Container(
                                                  height: 28,
                                                  width: 28,
                                                  decoration: BoxDecoration(
                                                    color: newMainColor
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      100,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      'assets/close.svg',
                                                      height: 11,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
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
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Divider(
                            height: 1,
                            color: Colors.black12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        NameFieldMobile(controller: nameController),
                        const SizedBox(height: 12),
                        PhoneField(controller: phoneController),
                        const SizedBox(height: 12),
                        CommentTextField(controller: commentContrller),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              const Spacer(),
                              const Text(
                                'Итого: ',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: newBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${context.read<CartProvider>().totalPrice} ₸",
                                style: const TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: newBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "  (мин 10,000 ₸)",
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: newBlack54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: CupertinoButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () async {
                              int total =
                                  context.read<CartProvider>().totalPrice;
                              if (total < 10000) {
                                showCustomSnackBar(context,
                                    'Минимальная сумма заказа 10,000₸');
                              } else {
                                if (nameController.text.isEmpty) {
                                  showCustomSnackBar(
                                      context, 'Заполните имя заказчика');
                                } else if (phoneController.text.isEmpty) {
                                  showCustomSnackBar(
                                      context, 'Заполните номер телефона');
                                } else {
                                  List<Map<String, dynamic>> sendData = cart
                                      .items
                                      .map((doc) => doc.toJson())
                                      .toList();
                                  bool res = await addDataToOrdersCollection(
                                    sendData,
                                    commentContrller.text.isEmpty
                                        ? "Без комментария к заказу"
                                        : commentContrller.text,
                                    nameController.text,
                                    phoneController.text,
                                    total,
                                  );
                                  if (res) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentPage(price: total),
                                      ),
                                    );
                                    context.read<CartProvider>().clearCart();
                                  }
                                }
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 44,
                              decoration: BoxDecoration(
                                color: newBlack,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  'Оплатить',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    color: newWhite,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const HomeBottom(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 0,
        bottom: MediaQuery.of(context).size.height * 0.12,
        child: SlideTransition(
          position: _slideAnimation(),
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: newBlack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                style: const TextStyle(color: newWhite),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(milliseconds: 1000), () {
      overlayEntry.remove();
    });
  }

  Animation<Offset> _slideAnimation() {
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

    animationController.forward();
    return animation;
  }
}
