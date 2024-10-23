import 'package:asyltas_app/features/cart/presentation/pages/cart_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../core/models/product.dart';
import '../../../../provider/cart_provider.dart';
import '../../../product/presentation/pages/product_page.dart';

class CatalogItem extends StatefulWidget {
  const CatalogItem({
    required this.item,
    this.showCustomSnackBar,
    super.key,
  });

  final ProductModel item;
  final Function(BuildContext, String)? showCustomSnackBar;

  @override
  State<CatalogItem> createState() => _CatalogItemState();
}

class _CatalogItemState extends State<CatalogItem> {
  late TextEditingController itemCount;
  int currentCount = 0;
  @override
  void initState() {
    itemCount = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentCount = widget.item.count ?? 0;
    itemCount.text = currentCount.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () async {
            if (widget.item.itemLeft == null || widget.item.itemLeft == 0) {
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(
                    product: widget.item,
                  ),
                ),
              );
            }
          },
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      fadeInDuration: const Duration(seconds: 0),
                      fadeOutDuration: const Duration(seconds: 0),
                      imageUrl: widget.item.images?[0] ?? '',
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) {
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: newWhite,
                          borderRadius: BorderRadius.circular(8),
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
                            widget.item.itemLeft == null ||
                                    widget.item.itemLeft == 0
                                ? 'Нет в наличии'
                                : "${widget.item.numberLeft ?? 0} шт",
                            maxLines: 1,
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
              widget.item.name ?? '',
              maxLines: 1,
              style: const TextStyle(
                fontFamily: 'Gilroy',
                color: newBlack,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              // overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              "${widget.item.price},00 ₸",
              style: const TextStyle(
                fontFamily: 'Gilroy',
                color: newBlack,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () async {
                if (widget.item.itemLeft == null || widget.item.itemLeft == 0) {
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        product: widget.item,
                      ),
                    ),
                  );
                }
              },
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
            const SizedBox(height: 4),
            // Счетчик с кнопками "+" и "-"
            widget.item.itemLeft == null || widget.item.itemLeft == 0
                ? const Text(
                    'Нет в наличии',
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: newBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    // overflow: TextOverflow.ellipsis,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Кнопка "-"
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: currentCount > 0
                            ? () {
                                context
                                    .read<CartProvider>()
                                    .decrementCount(widget.item);
                                if (currentCount - 1 == 0) {
                                  widget.showCustomSnackBar!(
                                      context, 'Удалено из корзины!');
                                } else {
                                  // widget.showCustomSnackBar!(context,
                                  //     'Количество уменьшено: ${currentCount - 1}');
                                  int totalPrice =
                                      context.read<CartProvider>().totalPrice;
                                  showTotalPriceSnackBar(
                                    context,
                                    totalPrice.toDouble(),
                                  );
                                }
                                setState(() {});
                              }
                            : null,
                        child: Icon(
                          Icons.remove,
                          color: currentCount > 0 ? newBlack : Colors.grey,
                        ),
                      ),
                      // Отображение текущего количества
                      CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          itemCount.text,
                          style: const TextStyle(
                            fontFamily: 'Gilroy',
                            color: newBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          // openBottomSheet(context);
                          openDialog(context);
                        },
                      ),
                      // SizedBox(
                      //   width: 40,
                      //   child: TextFormField(
                      //     maxLines: 1,
                      //     textAlign: TextAlign.center,
                      //     controller: itemCount,
                      //     style: const TextStyle(
                      //       fontFamily: 'Gilroy',
                      //       color: newBlack,
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //     decoration: const InputDecoration(
                      //       border: InputBorder.none,
                      //       labelStyle: TextStyle(
                      //         fontFamily: 'Gilroy',
                      //         color: newBlack,
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //       hintStyle: TextStyle(
                      //         fontFamily: 'Gilroy',
                      //         color: newBlack,
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //     keyboardType: TextInputType.number,
                      //     inputFormatters: <TextInputFormatter>[
                      //       FilteringTextInputFormatter.digitsOnly
                      //     ],
                      //     onFieldSubmitted: (value) async {
                      //       currentCount = int.parse(value);
                      //       widget.item.count = currentCount;
                      //       context
                      //           .read<CartProvider>()
                      //           .updateItem(widget.item);
                      //       int totalPrice =
                      //           context.read<CartProvider>().totalPrice;
                      //       showTotalPriceSnackBar(
                      //         context,
                      //         totalPrice.toDouble(),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12),
                      //   child: Text(
                      //     '$currentCount',
                      //     style: const TextStyle(
                      //       fontFamily: 'Gilroy',
                      //       color: newBlack,
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      // Кнопка "+"
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          context
                              .read<CartProvider>()
                              .incrementCount(widget.item);
                          int totalPrice =
                              context.read<CartProvider>().totalPrice;
                          showTotalPriceSnackBar(
                            context,
                            totalPrice.toDouble(),
                          );
                          setState(() {});
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
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  controller: itemCount,
                  style: const TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    // border: InputBorder.none,
                    labelStyle: TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    hintStyle: TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              const SizedBox(height: 16),
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
                      'Подтвердить',
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
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Введите количество'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  controller: itemCount,
                  style: const TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    hintStyle: TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ],
            ),
          ),
          actions: [
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                currentCount = int.parse(itemCount.text);
                // Assuming widget.item.count is something you want to update
                widget.item.count = currentCount;

                // Assuming you're using a CartProvider to update and fetch data
                context.read<CartProvider>().updateItem(widget.item);
                int totalPrice = context.read<CartProvider>().totalPrice;

                // Function to show total price snack bar
                showTotalPriceSnackBar(
                  context,
                  totalPrice.toDouble(),
                );
                Navigator.pop(context); // Close the bottom sheet
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  color: newMainColor,
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
                    'Подтвердить',
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
              onPressed: () {
                Navigator.pop(context); // Close the dialog without changes
              },
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
                    'Отмена',
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
          ],
        );
      },
    );
  }

  void showTotalPriceSnackBar(BuildContext context, double totalPrice) {
    // Remove any existing SnackBar to prevent stacking
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(
        'Общий: $totalPrice,00 ₸',
        style: const TextStyle(fontWeight: FontWeight.bold, color: newWhite),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: newBlack,
      // Optionally, add an action
      action: SnackBarAction(
        label: 'В корзину',
        textColor: newWhite,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartPage(),
            ),
          );
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
