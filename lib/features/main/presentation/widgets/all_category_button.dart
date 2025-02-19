import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../catalog/presentation/pages/catalog_page.dart';

class AllCategoryButton extends StatelessWidget {
  const AllCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(4),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CatalogPage(),
          ),
        );
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Все категории',
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: newBlack,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_down,
            color: newBlack,
          )
        ],
      ),
    );
  }
}
