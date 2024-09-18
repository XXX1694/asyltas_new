import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/core/models/product.dart';
import 'package:asyltas_app/provider/favorites_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key, required this.product});
  final ProductModel product;
  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {
  bool like = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        if (like) {
          widget.product.count = 1;
          context.read<FavoritesProvider>().removeItem(
                widget.product,
              );

          showCustomSnackBar(context, 'Удален из избранных!');
        } else {
          widget.product.count = 1;

          bool res = context.read<FavoritesProvider>().addItem(
                widget.product,
              );
          if (res) {
            showCustomSnackBar(context, 'Добавлен в избранные!');
          } else {
            showCustomSnackBar(context, '+1');
          }
        }
        setState(() {
          like = !like;
        });
      },
      child: SvgPicture.asset(
        like ? 'assets/like2_filled.svg' : 'assets/like2.svg',
        height: 28,
        width: 28,
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
