import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class CatalogItemShimmer extends StatelessWidget {
  const CatalogItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {},
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  color: Colors.grey.shade200,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                color: Colors.grey.shade200,
                height: 18,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Container(
                color: Colors.grey.shade200,
                height: 16,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 4),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: newBlack,
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
              onPressed: () {},
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
}
