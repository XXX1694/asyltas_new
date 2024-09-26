import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  // int currentCount = 0;
  // @override
  // void initState() {
  //   currentCount = widget.item.count ?? 0;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    int currentCount = widget.item.count ?? 0;
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
                  product: widget.item,
                ),
              ),
            );
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
                            "${widget.item.numberLeft ?? 0} шт",
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(
                      product: widget.item,
                    ),
                  ),
                );
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
                              .decrementCount(widget.item);
                          if (currentCount - 1 == 0) {
                            widget.showCustomSnackBar!(
                                context, 'Удалено из корзины!');
                          } else {
                            widget.showCustomSnackBar!(context,
                                'Количество уменьшено: ${currentCount - 1}');
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                    context.read<CartProvider>().incrementCount(widget.item);
                    if (currentCount + 1 == 1) {
                      widget.showCustomSnackBar!(
                          context, 'Добавлен в корзину!');
                    } else {
                      widget.showCustomSnackBar!(
                          context, 'Количество увеличено: ${currentCount + 1}');
                    }
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
}
