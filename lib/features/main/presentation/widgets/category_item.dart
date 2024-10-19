import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.text,
    required this.onTap,
    required this.isSelected,
    required this.count,
    super.key,
  });

  final String text;
  final VoidCallback onTap;
  final bool isSelected;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Gilroy',
            color: isSelected ? newBlack : newBlack.withOpacity(0.54),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        count != null && text != 'Все'
            ? Text(
                count.toString(),
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: isSelected ? newBlack : newBlack.withOpacity(0.54),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              )
            : const SizedBox(),
        count != null && text != 'Все'
            ? Text(
                'шт',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: isSelected ? newBlack : newBlack.withOpacity(0.54),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
