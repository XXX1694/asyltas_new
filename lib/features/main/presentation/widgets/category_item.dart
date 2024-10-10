import 'package:flutter/cupertino.dart';

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
    return Opacity(
      opacity: isSelected ? 1 : 0.54,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: secondMain,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Gilroy',
                  color: newWhite,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              count != null
                  ? const Text(
                      ' - ',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: newWhite,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const SizedBox(),
              count != null
                  ? Text(
                      count.toString(),
                      style: const TextStyle(
                        fontFamily: 'Gilroy',
                        color: newWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
