import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/core/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef FutureCallbackFunction = Future Function({
  required ProductModel product,
  required List<ProductModel> categoryProducts,
});

class OtherProducts extends StatelessWidget {
  const OtherProducts({
    super.key,
    required this.products,
    required this.showProduct,
  });
  final List<ProductModel> products;
  final FutureCallbackFunction showProduct;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Похожие товары',
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: newBlack,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 185,
          child: ListView.builder(
            itemCount: products.length <= 8 ? products.length : 8,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CupertinoButton(
                onPressed: () async {
                  await showProduct(
                    categoryProducts: products,
                    product: products[index],
                  );
                },
                padding: const EdgeInsets.all(0),
                child: Container(
                  margin: EdgeInsets.only(
                      right: index ==
                              (products.length <= 8 ? products.length - 1 : 7)
                          ? 20
                          : 12,
                      left: index == 0 ? 20 : 0),
                  height: double.infinity,
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: products[index].images?[0] ?? '',
                              fit: BoxFit.cover,
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
                      const SizedBox(height: 4),
                      Text(
                        products[index].name ?? 'Без имени',
                        style: const TextStyle(
                          fontFamily: 'Gilroy',
                          color: newBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        products[index].name ?? 'Без категории',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: newBlack54,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text(
                        ' ${products[index].price} ₸',
                        style: const TextStyle(
                          fontFamily: 'Gilroy',
                          color: newBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
