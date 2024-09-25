import 'package:flutter/cupertino.dart';

import '../../../../core/constants.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.text,
    required this.onTap,
    required this.isSelected,
    super.key,
  });

  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSelected ? 1 : 0.54,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: isSelected? newBlack: null,
            border: Border.all(
              color: newBlack,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Center(
            child: Text(
              text,
              style:  TextStyle(
                fontFamily: 'Gilroy',
                color: isSelected? newWhite: newBlack,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
