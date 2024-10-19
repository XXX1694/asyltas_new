import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/core/models/product.dart';
import 'package:asyltas_app/provider/cart_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartButton extends StatefulWidget {
  const CartButton({super.key, required this.product});
  final ProductModel product;
  @override
  State<CartButton> createState() => _CartButtonState();
}

class ProductViewmodel {}

class _CartButtonState extends State<CartButton> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool res = context.read<CartProvider>().addItem(
              ProductModel(
                widget.product.id,
                widget.product.name,
                widget.product.images,
                widget.product.category_id,
                widget.product.category_name,
                widget.product.description,
                widget.product.numberLeft,
                widget.product.price,
                1,
                null,
              ),
            );
        if (res) {
          showCustomSnackBar(context, 'Добавлен в корзину!');
        } else {
          showCustomSnackBar(context, '+1');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 8,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: newBlack,
            )),
        child: const Center(
          child: Text(
            'В корзину',
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: newBlack,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
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
