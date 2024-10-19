import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/core/models/product.dart';
import 'package:asyltas_app/features/catalog/presentation/widgets/catalog_placegolder.dart';
import 'package:asyltas_app/provider/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

typedef FutureCallbackFunction = Future Function({
  required ProductModel product,
  required List<ProductModel> categoryProducts,
});

class CatalogMobile extends StatefulWidget {
  const CatalogMobile({
    super.key,
    required this.showProduct,
    required this.categoryId,
    required this.goHome,
    required this.goLogin,
  });
  final FutureCallbackFunction showProduct;
  final String categoryId;
  final Function goLogin;
  final Function goHome;
  @override
  State<CatalogMobile> createState() => _CatalogMobileState();
}

class _CatalogMobileState extends State<CatalogMobile>
    with TickerProviderStateMixin {
  List<ProductModel> categoryProducts = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildPlaceholder();
        }

        if (snapshot.hasError) {
          return _buildPlaceholder(error: true);
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildNoProducts();
        }

        // Extract and filter products
        List products = snapshot.data!.docs;
        categoryProducts = [];

        List<ProductModel> tempCategoryProducts = [];
        for (int i = 0; i < products.length; i++) {
          final product = products[i].data() as Map<String, dynamic>;
          String productCategoryId = (product['category_id'] ?? '').toString();

          if (productCategoryId == widget.categoryId) {
            tempCategoryProducts.add(ProductModel.fromJson(product));
            tempCategoryProducts.last.id = snapshot.data!.docs[i].id;
          }
        }
        for (int i = 0; i < tempCategoryProducts.length; i++) {
          categoryProducts.add(tempCategoryProducts[i]);
        }

        if (categoryProducts.isEmpty) {
          return _buildNoProducts();
        }

        return _buildProductList();
      },
    );
  }

  Widget _buildPlaceholder({bool error = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Представлено 0 товаров',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: newBlack54,
            fontFamily: 'Gilroy',
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 28),
        const CatalogPlacegolder(),
      ],
    );
  }

  Widget _buildNoProducts() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Представлено 0 товаров',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black54,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 280),
        Center(
          child: Text('Нет товаров'),
        ),
        SizedBox(height: 280),
      ],
    );
  }

  Widget _buildProductList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Представлено ${categoryProducts.length} товаров',
          style: const TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black54,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 28),
        StaggeredGrid.count(
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          children: categoryProducts.map((item) {
            return _buildProductItem(item);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildProductItem(ProductModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () async {
            await widget.showProduct(
              product: item,
              categoryProducts: categoryProducts,
            );
          },
          child: AspectRatio(
            aspectRatio: 1 / 1,
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
                  imageUrl: item.images?[0] ?? '',
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
                letterSpacing: 0,
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
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 4),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                widget.showProduct(
                  product: item,
                  categoryProducts: categoryProducts,
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
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                item.count = 1;
                bool res = context.read<CartProvider>().addItem(item);
                if (res) {
                  showCustomSnackBar(context, 'Добавлен в корзину!');
                } else {
                  showCustomSnackBar(context, '+1');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: newBlack,
                    width: 1,
                  ),
                ),
                height: 32,
                width: double.infinity,
                child: const Center(
                  child: Text(
                    'В корзину',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: newBlack,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
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
